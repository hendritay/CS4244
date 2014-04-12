(defclass CURRENTDATA
  (is-a USER)
  (slot current-sem)
  (slot current-mc))

(defclass CURRENTSELECTION
  (is-a USER)
  (slot moduleid))

(defclass EXAM
  (is-a USER)
  (slot moduleid)
  (slot exam-date)
  (slot exam-time))

(defclass TIMETABLE-CANDIDATE 
  (is-a USER)
  (slot moduleid))

(defrule timetable-planning-1
(CANDIDATEMODULE (moduleid ?id))
(SINGLESEM (moduleid ?id))
(MODULE (moduleid ?id) (MC ?mod-mc))
=>
(if
  (and 
; make sure no unmet prereqs
    (not 
      (not (MODULEPREQ (moduleid ?id) (modulepreq ?preq))
           (MODULETAKEN (moduleid ?preq))))
; make sure no clashing schedule
    (not 
      (CURRENTDATA (current-sem ?sem))
      (CURRENTSELECTION (moduleid ?othermod))
      (MODULETIME 
        (moduleid ?id) 
        (day ?mod-day)
        (semester ?sem)
        (starttime ?start1)
        (endtime ?end2))
      (MODULETIME 
        (moduleid ?othermod) 
        (day ?mod-day)
        (semester ?sem)
        (starttime ?start2)
        (endtime ?end2))
      (or 
        (and (?start1 < ?start2)
             (?start2 < ?end1))
        (and (?start2 < ?start1)
             (?start1 < !end2)))))
; make sure no clashing exam
    (not
      (CURRENTSELECTION (moduleid ?exammod))
      (EXAM (moduleid ?exammod) (exam-date ?date)(exam-time ?time))
      (EXAM (moduleid ?id) (exam-date ?date)(exam-time ?time))))
; make sure not over mc limit
    (CURRENTDATA (current-mc ?mc))
    (< 19 (+ ?mod-mc ?mc)))
; if all satisfied add mod to selection
  then 
    (assert (CURRENTSELECTION (moduleid ?id)))
    (retract (CURRENTDATA (current-sem ?sem)(current-mc ?mc)))
    (assert (CURRENTDATA (current-sem ?sem)(current-mc (+ ?mod-mc ?mc))))))


(defrule timetable-planning-2
(CANDIDATEMODULE (moduleid ?id))
(SINGLESEM (moduleid ?id))
(MODULE (moduleid ?id) (MC ?mod-mc))
=>
(if
  (and 
; make sure no unmet prereqs
    (not 
      (not (MODULEPREQ (moduleid ?id) (modulepreq ?preq))
           (MODULETAKEN (moduleid ?preq))))
; make sure no clashing schedule
    (not 
      (CURRENTDATA (current-sem ?sem))
      (CURRENTSELECTION (moduleid ?othermod))
      (MODULETIME 
        (moduleid ?id) 
        (day ?mod-day)
        (semester ?sem)
        (starttime ?start1)
        (endtime ?end2))
      (MODULETIME 
        (moduleid ?othermod) 
        (day ?mod-day)
        (semester ?sem)
        (starttime ?start2)
        (endtime ?end2))
      (or 
        (and (?start1 < ?start2)
             (?start2 < ?end1))
        (and (?start2 < ?start1)
             (?start1 < !end2)))))
; make sure no clashing exam
    (not
      (CURRENTSELECTION (moduleid ?exammod))
      (EXAM (moduleid ?exammod) (exam-date ?date)(exam-time ?time))
      (EXAM (moduleid ?id) (exam-date ?date)(exam-time ?time))))
; make sure not over mc limit
    (CURRENTDATA (current-mc ?mc))
    (< 19 (+ ?mod-mc ?mc)))
; if all satisfied add mod to selection
  then 
    (assert (CURRENTSELECTION (moduleid ?id)))
    (retract (CURRENTDATA (current-sem ?sem)(current-mc ?mc)))
    (assert (CURRENTDATA (current-sem ?sem)(current-mc (+ ?mod-mc ?mc))))))

(defrule candidate-to-timetable-candidate
(CANDIDATEMODULE (moduleid ?id))
=>
(assert (TIMETABLECANDIDATE (moduleid ?id))))

(defrule remove-clash-examdate
(TIMETABLECANDIDATE (moduleid ?candidate-id))
(CURRENTSELECTION (moduleid ?selected-id))
(EXAM (moduleid ?candidate-id) (exam-day ?day)(exam-time ?time))
(EXAM (moduleid ?selected-id) (exam-day ?day)(exam-time ?time))
=>
(retract (CURRENTSELECTION (moduleid ?selected-id)))
(assert (CANDIDATEMODULE (moduleid ?selected-id))))

(defrule remove-clash-moduleschedule
(TIMETABLECANDIDATE (moduleid ?candidate-id))
(CURRENTSELECTION (moduleid ?selected-id))
(CURRENTDATA (current-sem ?sem))
(MODULETIME 
  (moduleid ?candidate-id) 
  (day ?mod-day)
  (semester ?sem)
  (starttime ?start1)
  (endtime ?end2))
(MODULETIME 
  (moduleid ?selected-id) 
  (day ?mod-day)
  (semester ?sem)
  (starttime ?start2)
  (endtime ?end2))
(or 
  (and (?start1 < ?start2)
       (?start2 < ?end1))
  (and (?start2 < ?start1)
       (?start1 < !end2)))
=>
(retract (CURRENTSELECTION (moduleid ?selected-id)))
(assert (CANDIDATEMODULE (moduleid ?selected-id))))

(defrule remove-lowest-scoring-candidate
(CANDIDATEMODULE (moduleid ?selected-id) (moduletagtotalscore ?selected-score)
(not 
  (CANDIDATEMODULE 
    (moduleid ?another-id) 
    (moduletagtotalscore ?another-score&:(< ?another-score ?selected-score))))
=>
(retract (CANDIDATEMODULE (moduleid ?selected-id))))

