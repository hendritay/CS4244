(defclass CURRENTDATA
  (is-a USER)
  (slot current-sem)
  (slot mc))

(defclass CURRENTSELECTION
  (is-a USER)
  (slot moduleid))

(defclass EXAM
  (is-a USER)
  (slot moduleid)
  (slot exam-time))

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
      (exists
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
      (exists
        (CURRENTSELECTION (moduleid ?exammod))
        (EXAM (moduleid ?exammod) (exam-time ?time))
        (EXAM (moduleid ?id) (exam-time ?time))))
; make sure not over mc limit
    (CURRENTMC (mc ?current-mc))
    (< 19 (+ ?mod-mc ?current-mc)))
; if all satisfied add mod to selection
  then 
    (assert (CURRENTSELECTION (moduleid ?id)))
    (retract (CURRENTMC (mc ?current-mc)))
    (assert (CURRENTMC (mc (+ ?mod-mc ?current-mc))))))


(defrule timetable-planning-2
(CANDIDATEMODULE (moduleid ?id))
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
      (exists
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
      (exists
        (CURRENTSELECTION (moduleid ?exammod))
        (EXAM (moduleid ?exammod) (exam-time ?time))
        (EXAM (moduleid ?id) (exam-time ?time))))
; make sure not over mc limit
    (CURRENTMC (mc ?current-mc))
    (< 19 (+ ?mod-mc ?current-mc)))
; if all satisfied add mod to selection
  then 
    (assert (CURRENTSELECTION (moduleid ?id)))
    (retract (CURRENTMC (mc ?current-mc)))
    (assert (CURRENTMC (mc (+ ?mod-mc ?current-mc))))))


