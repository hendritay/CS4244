(defclass CURRENTDATA
  (is-a USER)
  (slot current-sem)
  (slot current-mc)
  (slot current-stage))
  
(defclass SINGLESEM
  (is-a USER)
  (slot moduleid))

(defclass CURRENTSELECTION
  (is-a USER)
  (slot moduleid))

(defclass EXAM
  (is-a USER)
  (slot moduleid)
  (slot exam-date)
  (slot exam-time))

(defclass TIMETABLECANDIDATE 
  (is-a USER)
  (slot moduleid))

(definstances INITIALISEDATA
  (currentdata of CURRENTDATA (current-mc 0) (current-stage 1)))

; timetable planning 1 - single sem limitation ;

(defrule timetable-planning-one
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?id))
?single-sem <- (object (is-a SINGLESEM) (moduleid ?id))
?module <- (object (is-a MODULE) (moduleid ?id) (MC ?mod-mc))
?currentdata <-(object (is-a CURRENTDATA) (current-sem ?sem)(current-mc ?mc)(current-stage 1))
=>
(if
; make sure no unmet prereqs ;
  (and 
    (not 
      (any-instancep 
        ((?preq MODULEPREQ))
        (not 
          (any-instancep
            ((?taken MODULETAKEN))
            (and 
              (= ?preq:modulepreq ?taken:moduleid) 
              (= ?preq:moduleid ?id))))))
; make sure no clashing schedule ;
    (not
      (any-instancep
        ((?othermod CURRENTSELECTION)(?time1 MODULETIME)(?time2 MODULETIME))
        (and 
          (= ?id ?time1:moduleid)
          (= ?othermod:moduleid ?time2:moduleid)
          (neq ?id ?othermod:moduleid)
          (= ?sem ?time1:semester)
          (= ?time1:semester ?time2:semester)
          (= ?time1:day ?time2:day)
          (or 
            (and 
              (< ?time1:starttime ?time2:starttime)
              (< ?time2:starttime ?time1:endtime))
            (and
              (< ?time2:starttime ?time1:starttime)
              (< ?time1:starttime ?time2:endtime))))))  
; make sure no clashing exam ;
    (not
      (any-instancep
        ((?exammod CURRENTSELECTION)(?exam1 EXAM)(?exam2 EXAM))
        (and 
          (= ?id ?exam1:moduleid)
          (= ?exammod:moduleid ?exam2:moduleid)
          (neq ?id ?exammod:moduleid)
          (= ?exam1:exam-date ?exam2:exam-date)
          (= ?exam1:exam-time ?exam2:exam-time))))
; make sure not over mc limit of 20;
    (<= 20 (+ ?mc ?mod-mc)))
; if all satisfied add mod to selection ;
then 
  (send [currentdata] put-current-mc (+ ?mc ?mod-mc))
  (make-instance [?id] of CURRENTSELECTION (moduleid ?id))
  (unmake-instance [?id] of CANDIDATEMODULE)))
  
; transition from stage 1 to 2 ;

(defrule stage-one-to-two
?currentdata <-(object (is-a CURRENTDATA)(current-stage 1))
=>
(send [currentdata] put-stage 2))


; timetable planning 2 - no single sem limitation ;

(defrule timetable-planning-two
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?id))
?module <- (object (is-a MODULE) (moduleid ?id) (MC ?mod-mc))
?currentdata <-(object (is-a CURRENTDATA) (current-sem ?sem)(current-mc ?mc)(current-stage 1))
=>
(if
; make sure no unmet prereqs ;
  (and 
    (not 
      (any-instancep 
        ((?preq MODULEPREQ))
        (not 
          (any-instancep
            ((?taken MODULETAKEN))
            (and 
              (= ?preq:modulepreq ?taken:moduleid) 
              (= ?preq:moduleid ?id))))))
; make sure no clashing schedule ;
    (not
      (any-instancep
        ((?othermod CURRENTSELECTION)(?time1 MODULETIME)(?time2 MODULETIME))
        (and 
          (= ?id ?time1:moduleid)
          (= ?othermod:moduleid ?time2:moduleid)
          (neq ?id ?othermod:moduleid)
          (= ?sem ?time1:semester)
          (= ?time1:semester ?time2:semester)
          (= ?time1:day ?time2:day)
          (or 
            (and 
              (< ?time1:starttime ?time2:starttime)
              (< ?time2:starttime ?time1:endtime))
            (and
              (< ?time2:starttime ?time1:starttime)
              (< ?time1:starttime ?time2:endtime))))))  
; make sure no clashing exam ;
    (not
      (any-instancep
        ((?exammod CURRENTSELECTION)(?exam1 EXAM)(?exam2 EXAM))
        (and 
          (= ?id ?exam1:moduleid)
          (= ?exammod:moduleid ?exam2:moduleid)
          (neq ?id ?exammod:moduleid)
          (= ?exam1:exam-date ?exam2:exam-date)
          (= ?exam1:exam-time ?exam2:exam-time))))
; make sure not over mc limit of 20;
    (<= 20 (+ ?mc ?mod-mc)))
; if all satisfied add mod to selection ;
then 
  (send [currentdata] put-current-mc (+ ?mc ?mod-mc))
  (make-instance [?id] of CURRENTSELECTION (moduleid ?id))
  (unmake-instance [?id] of CANDIDATEMODULE)))


; transition from stage 2 to 3 ;

(defrule stage-two-to-three
?currentdata <-(object (is-a CURRENTDATA)(current-stage 2))
=>
(send [currentdata] put-stage 3))


; timetable planning 3 - converting candidate to timetable-candidate ;

(defrule candidate-to-timetable-candidate
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?id))
?currentdata <- (object (is-a CURRENTDATA) (current-stage 3))
=>
(make-instance [?id] of TIMETABLECANDIDATE (moduleid ?id)))

; transition from stage 3 to 4 ;

(defrule stage-three-to-four
?currentdata <-(object (is-a CURRENTDATA)(current-stage 3))
=>
(send [currentdata] put-stage 4))


; timetable planning 4 - remove clashing modules from selection ;

(defrule remove-clash-examdate
?candidate <- (object (is-a TIMETABLECANDIDATE) (moduleid ?candidate-id))
?selected <- (object (is-a CURRENTSELECTION) (moduleid ?selected-id))
?exam1 <- (object (is-a EXAM) (moduleid ?candidate-id) (exam-date ?date)(exam-time ?time))
?exam2 <- (object (is-a EXAM) (moduleid ?selected-id) (exam-date ?date)(exam-time ?time))
?currentdata <- (object (is-a CURRENTDATA) (current-stage 4))
=>
(make-instance [?selected-id] of CANDIDATEMODULE (moduleid ?selected-id))
(unmake-instance [?selected] of CURRENTSELECTION)
(send [currentdata] put-current-stage 2))


(defrule remove-clash-moduleschedule
?candidate <- (object (is-a TIMETABLECANDIDATE) (moduleid ?candidate-id))
?selected <- (object (is-a CURRENTSELECTION) (moduleid ?selected-id))
?currentdata <- (object (is-a CURRENTDATA) (current-sem ?sem)(current-stage 4))
?time1 <- (object (is-a MODULETIME)(moduleid ?candidate-id) (day ?mod-day)(semester ?sem)(starttime ?start1)(endtime ?end1))
?time2 <- (object (is-a MODULETIME)(moduleid ?selected-id) (day ?mod-day)(semester ?sem)(starttime ?start2)(endtime ?end2))
(test 
  (or 
    (and (< ?start1 ?start2)
         (< ?start2 ?end1))
    (and (< ?start2 ?start1)
         (< ?start1 ?end2))))
=>
(make-instance [?selected-id] of CANDIDATEMODULE (moduleid ?selected-id))
(unmake-instance [?selected] of CURRENTSELECTION)
(send [currentdata] put-current-stage 2))

; transition from stage 4 to 5 ;

(defrule stage-four-to-five
?currentdata <-(object (is-a CURRENTDATA)(current-stage 4))
=>
(send [currentdata] put-stage 5))


; timetable planning 5 - remove lowest scoring candidate ;

(defrule remove-lowest-scoring-candidate
?currentdata <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-mc ?mc) (current-stage 5))
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?selected-id) (moduletagtotalscore ?selected-score))
?module <- (object (is-a MODULE) (moduleid ?selected-id) (MC ?selected-mc))
(test 
  (not 
    (any-instancep
      ((?othercandidate CANDIDATEMODULE))
      (< ?othercandidate:moduletagtotalscore ?selected-score))))
=>
(send [currentdata] put-current-mc (- ?mc ?selected-mc))
(send [currentdata] put-current-stage 1)
(unmake-instance [?candidate] of CANDIDATEMODULE))

