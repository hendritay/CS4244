(defclass CURRENTDATA
  (is-a USER)
  (slot current-sem (type NUMBER))
  (slot current-mc (type NUMBER))
  (slot current-stage (type NUMBER)))
  
(defclass SINGLESEM
  (is-a USER)
  (slot moduleid (type SYMBOL)))

(defclass CURRENTSELECTION
  (is-a USER)
  (slot moduleid (type SYMBOL)))
  
(defclass REMOVEDMODULE
  (is-a USER)
  (slot moduleid (type SYMBOL)))

(defclass EXAM
  (is-a USER)
  (slot moduleid (type SYMBOL))
  (slot exam-date (type SYMBOL))
  (slot exam-time (type SYMBOL)))

(defclass TIMETABLECANDIDATE 
  (is-a USER)
  (slot moduleid (type SYMBOL)))

(definstances INITIALISEDATA
  (currentdata of CURRENTDATA (current-mc 0) (current-stage 1) (current-sem 2)))
  
(deftemplate setup-complete-one 
  (slot candidate-moduleid (type SYMBOL))
  (slot candidate-mc (type NUMBER)))

; timetable planning 1 - single sem limitation ;

(defrule timetable-planning-one (declare (salience 10))
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?id))
?single-sem <- (object (is-a SINGLESEM) (moduleid ?id))
?module <- (object (is-a MODULE) (moduleid ?id) (MC ?mod-mc))
?currentdata <-(object (is-a CURRENTDATA) (current-sem ?sem)(current-mc ?mc)(current-stage 1))
=>
(printout t "step 1: checking module " ?id crlf)
(if
; make sure no unmet prereqs ;
  (and 
    (or 
      (not 
        (any-instancep 
          ((?preq MODULEPREQ))
          (not 
            (any-instancep
              ((?taken MODULETAKEN))
              (and 
                (eq ?taken:moduleid ?preq:modulepreq) 
                (eq ?preq:moduleid ?id))))))
       (not
         (any-instancep
           ((?preq MODULEPREQ))
           (eq ?preq:moduleid ?id))))
; make sure no clashing schedule ;
(not 
  (any-instancep 
    ((?othermod CURRENTSELECTION))
      (any-instancep
        ((?time1 MODULETIME)(?time2 MODULETIME))
        (and 
          (eq ?id ?time1:moduleid)
          (eq ?othermod:moduleid ?time2:moduleid)
          (neq ?id ?othermod:moduleid)
          (eq ?sem ?time1:semester)
          (eq ?time1:semester ?time2:semester)
          (eq ?time1:day ?time2:day)
          (or
            (and 
                (< ?time1:starttime ?time2:starttime)
                (<= ?time2:starttime ?time1:endtime))
            (and
                (< ?time2:starttime ?time1:starttime)
                (<= ?time1:starttime ?time2:endtime)))))))
; make sure no clashing exam ;
    (not
      (any-instancep
        ((?exammod CURRENTSELECTION)(?exam1 EXAM)(?exam2 EXAM))
        (and 
          (eq ?id ?exam1:moduleid)
          (eq ?exammod:moduleid ?exam2:moduleid)
          (neq ?id ?exammod:moduleid)
          (eq ?exam1:exam-date ?exam2:exam-date)
          (eq ?exam1:exam-time ?exam2:exam-time))))
; make sure not over mc limit of 20;
    (>= 20 (+ ?mc ?mod-mc)))
; if all satisfied add mod to selection ;
then 
  (printout t "step 1: checking module " ?id " SUCCESS!!"crlf)
  (send [currentdata] put-current-mc (+ ?mc ?mod-mc))
  (make-instance (sym-cat CS- ?id) of CURRENTSELECTION (moduleid ?id))
  (unmake-instance (sym-cat CM- ?id))))
  
; transition from stage 1 to 2 ;

(defrule stage-one-to-two (declare (salience 5))
?currentdata <-(object (is-a CURRENTDATA)(current-stage 1))
=>
(printout t "moving from 1 to 2" crlf)
(send [currentdata] put-current-stage 2))


; timetable planning 2 - no single sem limitation ;

(defrule timetable-planning-two (declare (salience 10))
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?id))
?module <- (object (is-a MODULE) (moduleid ?id) (MC ?mod-mc))
?currentdata <-(object (is-a CURRENTDATA) (current-sem ?sem)(current-mc ?mc)(current-stage 2))
=>
(printout t "step 2: checking module " ?id crlf)
(if
; make sure no unmet prereqs ;
  (and 
    (or 
      (not 
        (any-instancep 
          ((?preq MODULEPREQ))
          (not 
            (any-instancep
              ((?taken MODULETAKEN))
              (and 
                (eq ?taken:moduleid ?preq:modulepreq) 
                (eq ?preq:moduleid ?id))))))
       (not
         (any-instancep
           ((?preq MODULEPREQ))
           (eq ?preq:moduleid ?id))))
; make sure no clashing schedule ;
(not 
  (any-instancep 
    ((?othermod CURRENTSELECTION))
      (any-instancep
        ((?time1 MODULETIME)(?time2 MODULETIME))
        (and 
          (eq ?id ?time1:moduleid)
          (eq ?othermod:moduleid ?time2:moduleid)
          (neq ?id ?othermod:moduleid)
          (eq ?sem ?time1:semester)
          (eq ?time1:semester ?time2:semester)
          (eq ?time1:day ?time2:day)
          (or
            (and 
                (< ?time1:starttime ?time2:starttime)
                (<= ?time2:starttime ?time1:endtime))
            (and
                (< ?time2:starttime ?time1:starttime)
                (<= ?time1:starttime ?time2:endtime)))))))
; make sure no clashing exam ;
    (not
      (any-instancep
        ((?exammod CURRENTSELECTION)(?exam1 EXAM)(?exam2 EXAM))
        (and 
          (eq ?id ?exam1:moduleid)
          (eq ?exammod:moduleid ?exam2:moduleid)
          (neq ?id ?exammod:moduleid)
          (eq ?exam1:exam-date ?exam2:exam-date)
          (eq ?exam1:exam-time ?exam2:exam-time))))
; make sure not over mc limit of 20;
    (>= 20 (+ ?mc ?mod-mc)))
; if all satisfied add mod to selection ;
then 
  (printout t "step 2: checking module " ?id " SUCCESS!!"crlf)
  (send [currentdata] put-current-mc (+ ?mc ?mod-mc))
  (make-instance (sym-cat CS- ?id) of CURRENTSELECTION (moduleid ?id))
  (unmake-instance (sym-cat CM- ?id))))
  

; transition from stage 2 to 3 ;

(defrule stage-two-to-three (declare (salience 6))
?currentdata <-(object (is-a CURRENTDATA)(current-stage 2))
=>
(printout t "moving from 2 to 3" crlf)
(send [currentdata] put-current-stage 3))


; timetable planning 3 - converting candidate to timetable-candidate ;

(defrule candidate-to-timetable-candidate (declare (salience 10))
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?id))
?currentdata <- (object (is-a CURRENTDATA) (current-stage 3))
=>
(printout t "step 3: converting module " ?id crlf)
(make-instance (sym-cat TC- ?id) of TIMETABLECANDIDATE (moduleid ?id)))

; transition from stage 3 to 4 ;

(defrule stage-three-to-four (declare (salience 7))
?currentdata <-(object (is-a CURRENTDATA)(current-stage 3))
=>
(printout t "moving from 3 to 4" crlf)
(send [currentdata] put-current-stage 4))


; timetable planning 4 - remove clashing modules from selection ;

(defrule remove-clash-examdate (declare (salience 10))
?candidate <- (object (is-a TIMETABLECANDIDATE) (moduleid ?candidate-id))
?selected <- (object (is-a CURRENTSELECTION) (moduleid ?selected-id))
?exam1 <- (object (is-a EXAM) (moduleid ?candidate-id) (exam-date ?date)(exam-time ?time))
?exam2 <- (object (is-a EXAM) (moduleid ?selected-id) (exam-date ?date)(exam-time ?time))
?currentdata <- (object (is-a CURRENTDATA) (current-stage 4))
=>
(printout t "step 4: removing module " ?selected-id " due to clashing exam" crlf)
(make-instance (sym-cat RM- ?selected-id) of REMOVEDMODULE (moduleid ?selected-id))
(unmake-instance (sym-cat CS- ?selected-id))
(send [currentdata] put-current-stage 2))


(defrule remove-clash-moduleschedule (declare (salience 10))
?candidate <- (object (is-a TIMETABLECANDIDATE) (moduleid ?candidate-id))
?selected <- (object (is-a CURRENTSELECTION) (moduleid ?selected-id))
?currentdata <- (object (is-a CURRENTDATA) (current-sem ?sem)(current-stage 4))
?time1 <- (object (is-a MODULETIME)(moduleid ?candidate-id) (day ?mod-day)(semester ?sem)(starttime ?start1)(endtime ?end1))
?time2 <- (object (is-a MODULETIME)(moduleid ?selected-id) (day ?mod-day)(semester ?sem)(starttime ?start2)(endtime ?end2))
(test 
  (or 
    (and (< ?start1 ?start2)
         (<= ?start2 ?end1))
    (and (< ?start2 ?start1)
         (<= ?start1 ?end2))))
=>
(printout t "step 4: removing module " ?selected-id " due to clashing schedule"crlf)
(make-instance (sym-cat RM- ?selected-id) of REMOVEDMODULE (moduleid ?selected-id))
(unmake-instance (sym-cat CS- ?selected-id) )
(send [currentdata] put-current-stage 2))

; transition from stage 4 to 5 ;

(defrule stage-four-to-five (declare (salience 8))
?currentdata <-(object (is-a CURRENTDATA)(current-stage 4))
=>
(printout t "moving from 4 to 5" crlf)
(send [currentdata] put-current-stage 5))


; timetable planning 5 - remove lowest scoring candidate ;

(defrule remove-lowest-scoring-candidate (declare (salience 10))
?currentdata <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-mc ?mc) (current-stage 5))
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?selected-id) (moduletagtotalscore ?selected-score))
?module <- (object (is-a MODULE) (moduleid ?selected-id) (MC ?selected-mc))
(test 
  (not 
    (any-instancep
      ((?othercandidate CANDIDATEMODULE))
      (< ?othercandidate:moduletagtotalscore ?selected-score))))
=>
(printout t "step 5: removing module " ?selected-id crlf)
(send [currentdata] put-current-mc (- ?mc ?selected-mc))
(unmake-instance (sym-cat CM- ?selected-id))
(make-instance (sym-cat TC- ?selected-id) of TIMETABLECANDIDATE (moduleid ?selected-id))
(unmake-instance (sym-cat TC- ?selected-id))
(make-instance (sym-cat RM- ?selected-id) of REMOVEDMODULE (moduleid ?selected-id))
(unmake-instance (sym-cat RM- ?selected-id)))

(defrule restore-removed (declare (salience 8))
?removed <- (object (is-a REMOVEDMODULE) (moduleid ?removed-id))
?currentdata <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-mc ?mc) (current-stage 5))
=>
(printout t "restoring removed module " ?removed-id crlf)
(make-instance (sym-cat CM- ?removed-id) of CANDIDATEMODULE (moduleid ?removed-id))
(unmake-instance (sym-cat RM- ?removed-id))
(send [currentdata] put-current-stage 1))
