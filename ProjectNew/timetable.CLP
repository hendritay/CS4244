(defclass CURRENTDATA
  (is-a USER)
  (slot current-sem (type NUMBER))
  (slot current-mc (type NUMBER))
  (slot current-stage (type NUMBER))
  (slot current-max (type NUMBER)))

(defclass SINGLESEM
  (is-a USER)
  (slot moduleid (type SYMBOL)))

(defclass CURRENTSELECTION
  (is-a USER)
  (slot moduleid)
  (slot moduletagtotalscore (type NUMBER))
  (slot day)
  (slot starttime (type NUMBER))
  (slot endtime (type NUMBER))
  (slot semester (type NUMBER)))

(defclass PROBABLEMODULE
  (is-a USER)
  (slot moduleid)
  (slot moduletagtotalscore (type NUMBER))
  (slot mc (type NUMBER))
  (slot is-checked (default unchecked)))

(definstances INITIALISEDATA
  (currentdata of CURRENTDATA (current-mc 0) (current-stage 1) (current-sem 2)))

; step 0: if at any time we have a min of 18MC, we exit successfully ;

(defrule satisfied-mc-requirements
?current-data <- (object (is-a CURRENTDATA)(current-mc ?mc))
(test
  (>= ?mc 18))
=>
(printout t "success, we have " ?mc "MC, exit!" crlf)
(send ?current-data put-current-stage -1))


; step 1: filter to get candidate modules who don't have unmet prereqs ;

(defrule filter-by-prereqs
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 1))
=>
(delayed-do-for-all-instances
  ((?candidate CANDIDATEMODULE)(?module MODULE))
  (and
    (eq ?candidate:moduleid ?module:moduleid)
    (not
      (any-instancep
        ((?preq MODULEPREQ))
        (and
          (eq ?preq:moduleid ?candidate:moduleid)
          (not
            (any-instancep
              ((?taken MODULETAKEN))
              (neq (member$ ?taken:moduleid ?preq:modulepreq) FALSE)))))))
  (make-instance (sym-cat PM- ?candidate:moduleid) of PROBABLEMODULE
    (moduleid ?candidate:moduleid)
    (moduletagtotalscore ?candidate:moduletagtotalscore)
    (mc ?module:mc)))
(send ?current-data put-current-stage 2))

; step 2: get max score module ;

(defrule update-max-score 
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 2)(current-max ?max))
?probable <- (object (is-a PROBABLEMODULE) (moduletagtotalscore ?score)(is-checked unchecked))
(test
  (not
    (any-instancep
      ((?othermod PROBABLEMODULE))
      (and
        (eq ?othermod:is-checked unchecked)
        (> ?othermod:moduletagtotalscore ?score)))))
=>
(send ?current-data put-current-max ?score)
(send ?current-data put-current-stage 3))

; step 3: try to add max score module ;

(defrule check-max-score-module (declare (salience 1))
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 3)(current-max ?max)(current-mc ?mc))
?probable <- (object (is-a PROBABLEMODULE) (moduleid ?probable-id) (moduletagtotalscore ?max)(is-checked unchecked)(mc ?mod-mc))
?probable-time <- (object (is-a MODULETIME) (moduleid ?probable-id) (semester ?sem) (day ?probable-day) (starttime ?probable-start) (endtime ?probable-end))
(test
  (not
    (any-instancep
      ((?selected CURRENTSELECTION))
      (eq ?selected:moduleid ?probable-id)))) 
=>
; check against selected modules for exam and schedule clashes ;
(if 
  (and
; no exam clash ;
    (not
      (any-instancep
        ((?selected CURRENTSELECTION)(?probable-exam EXAM)(?selected-exam EXAM))
        (and
          (eq ?probable-exam:moduleid ?probable-id)
          (eq ?selected-exam:moduleid ?selected:moduleid)
          (eq ?selected-exam:exam-date ?probable-exam:exam-date)
          (eq ?selected-exam:exam-time ?probable-exam:exam-time))))
; no schedule clash ;
    (not
      (any-instancep
        ((?selected CURRENTSELECTION))
          (and
            (neq ?selected:moduleid ?probable-id)
            (eq ?selected:day ?probable-day)
            (not
              (or
                (and 
                    (< ?probable-start ?selected:starttime)
                    (<= ?selected:starttime ?probable-end))
                (and 
                    (< ?selected:starttime ?probable-start)
                    (<= ?probable-start ?selected:endtime)))))))
; not over mc limit (currently set to 20);
    (>= 20 (+ ?mc ?mod-mc)))
then
; if successful then add module to selection ;
  (printout t "step 2: successfully added module " ?probable-id crlf)
  (make-instance (sym-cat CS- ?probable-id) of CURRENTSELECTION
    (moduleid ?probable-id)
    (moduletagtotalscore ?max)
    (day ?probable-day)
    (starttime ?probable-start)
    (endtime ?probable-end)
    (semester ?sem))
  (send ?current-data put-current-max 0)
  (send ?probable put-is-checked checked)
  (send ?current-data put-current-stage 2)
  (send ?current-data put-current-mc (+ ?mc ?mod-mc))))

; if all matches for one module were unsuccessful, we set it as checked and move back to step 2 ;

(defrule no-matches
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 3)(current-max ?max))
?probable <- (object (is-a PROBABLEMODULE) (moduleid ?probable-id) (moduletagtotalscore ?max)(is-checked unchecked))
=>
(send ?probable put-is-checked checked)
(send ?current-data put-current-max 0)
(send ?current-data put-current-stage 2))
  
; if all modules have been checked and we still can't assign enough modules we move to stage 4 ;

(defrule stage-two-to-four
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 2)(current-max ?max))
(test
  (not
    (any-instancep
      ((?probable PROBABLEMODULE))
      (eq ?probable:is-checked unchecked))))
=>
(send ?current-data put-current-stage 4))

; step 4: we try to find a selected module which, when removed, will allow at least one module to be added ;

(defrule remove-selected-module (declare (salience 1))
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 4)(current-max ?max)(current-mc ?mc))
?removalcandidate <- (object (is-a CURRENTSELECTION)(moduleid ?candidate-id))
?candidate <- (object (is-a PROBABLEMODULE)(moduleid ?candidate-id)(mc ?mod-mc))
?probable1 <- (object (is-a PROBABLEMODULE)(moduleid ?probable1-id)(mc ?mod1-mc)(is-checked ?probable1-is-checked))
?probable1-time <- (object (is-a MODULETIME) (moduleid ?probable1-id) (semester ?sem) (day ?probable1-day) (starttime ?probable1-start) (endtime ?probable1-end))
(test
  (and
    (neq ?candidate-id ?probable1-id)
    (neq ?probable1-is-checked removed)))
=>
(if
  (and
; no exam clash ;
    (not
      (any-instancep
        ((?selected CURRENTSELECTION)(?probable1-exam EXAM)(?selected-exam EXAM))
        (and
          (neq ?selected:moduleid ?candidate-id)
          (eq ?probable1-exam:moduleid ?probable1-id)
          (eq ?selected-exam:moduleid ?selected:moduleid)
          (and
            (eq ?selected-exam:exam-date ?probable1-exam:exam-date)
            (eq ?selected-exam:exam-time ?probable1-exam:exam-time)))))
; no schedule clash ;
    (not
      (any-instancep
        ((?selected CURRENTSELECTION))
          (and
            (eq ?selected:semester ?sem)
            (neq ?selected:moduleid ?candidate-id)
            (not
              (or 
                (neq ?probable1-day ?selected:day)
                (and 
                    (< ?probable1-start ?selected:starttime)
                    (<= ?selected:starttime ?probable1-end))
                (and 
                    (< ?selected:starttime ?probable1-start)
                    (<= ?probable1-start ?selected:endtime)))))))
; not over mc limit (currently set to 20);
    (>= 20 (- (+ ?mc ?mod1-mc) ?mod-mc)))
then
; if successful, we remove this module, reset is-checked for all non-chosen non-removed modules and go back to step 2 ;
  (delayed-do-for-all-instances
    ((?nonchosen PROBABLEMODULE))
    (and
      (neq ?nonchosen:is-checked removed) 
      (not
        (any-instancep
          ((?selected CURRENTSELECTION))
          (eq ?selected:moduleid ?nonchosen:moduleid))))
    (send ?nonchosen put-is-checked unchecked))
  (unmake-instance ?removalcandidate)
  (send ?candidate put-is-checked removed)
  (send ?current-data put-current-stage 2)
  (send ?current-data put-current-mc (- ?mc ?mod-mc))))
  
; if still cannot assign fully, we try to remove lowest scoring selected module and try again ;

; if all fails, display fail message and exit ;

(defrule unsatisfied-mc-requirements
?current-data <- (object (is-a CURRENTDATA)(current-mc ?mc)(current-stage 4))
(test
  (> 18 ?mc))
=>
(printout t "failure, we have " ?mc "MC, exit!" crlf)
(send ?current-data put-current-stage -1))
