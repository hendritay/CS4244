(definstances TIMETABLE::INITIALISEDATA
  (currentdata of CURRENTDATA (current-mc 0) (current-stage 1) (current-sem 2)))
  
(deffacts TIMETABLE::the-facts
  (focus TIMETABLE))

; step 0: if at any time we have a min of 18MC, we exit successfully ;

(defrule TIMETABLE::satisfied-mc-requirements (declare (salience 2))
?current-data <- (object (is-a CURRENTDATA)(current-mc ?mc))
(test
  (>= ?mc 18))
=>
(printout t "success, we have " ?mc "MC, exit!" crlf)
(send ?current-data put-current-stage -1)
(halt))


; step 1: filter to get candidate modules who don't have unmet prereqs ;

(defrule TIMETABLE::filter-by-prereqs
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

(defrule TIMETABLE::update-max-score 
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

(defrule TIMETABLE::check-max-score-module (declare (salience 1))
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 3)(current-max ?max)(current-mc ?mc))
?probable <- (object (is-a PROBABLEMODULE) (moduleid ?probable-id) (moduletagtotalscore ?max)(is-checked unchecked)(mc ?mod-mc))
?probable-exam <- (object (is-a EXAM) (moduleid ?probable-id) (exam-date ?probable-exam-date)(exam-time ?probable-exam-time))
?probable-option-test <- (object (is-a MODULETIME)(moduleid ?probable-id)(moduleoption ?probable-module-option))
?probable-option <- (object (is-a MODULEOPTION)(option ?probable-module-option))
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
        ((?selected CURRENTSELECTION))
        (and
          (eq ?selected:exam-date ?probable-exam-date)
          (eq ?selected:exam-time ?probable-exam-time))))
; moduleoption chosen doesn't clash with anything ;
    (not
      (any-instancep
        ((?selected CURRENTSELECTION))
        (any-instancep
          ((?selected-time MODULETIME))
          (and
            (eq ?selected:moduleid ?selected-time:moduleid)
            (eq ?selected:moduleoption ?selected-time:moduleoption)
            (any-instancep
              ((?probable-time1 MODULETIME))
              (and
                (eq ?probable-time1:moduleid ?probable-id)
                (eq ?probable-time1:moduleoption ?probable-module-option)
                (eq ?probable-time1:day ?selected-time:day)
                (not
                  (or
                    (and 
                      (< ?probable-time1:starttime ?selected-time:starttime)
                      (<= ?selected-time:starttime ?probable-time1:endtime))
                    (and 
                        (< ?selected-time:starttime ?probable-time1:starttime)
                        (<= ?probable-time1:starttime ?selected-time:endtime))))))))))
; not over mc limit (currently set to 20);
    (>= 20 (+ ?mc ?mod-mc)))
then
; if successful then add module to selection ;
  (printout t "step 2: successfully added module " ?probable-id crlf)
  (make-instance (sym-cat CS- ?probable-id) of CURRENTSELECTION
    (moduleid ?probable-id)
    (moduletagtotalscore ?max)
    (semester ?sem)
    (exam-date ?probable-exam-date)
    (exam-time ?probable-exam-time)
    (moduleoption ?probable-module-option))
  (send ?current-data put-current-max 0)
  (send ?probable put-is-checked checked)
  (send ?current-data put-current-stage 2)
  (send ?current-data put-current-mc (+ ?mc ?mod-mc))))

; if all matches for one module were unsuccessful, we set it as checked and move back to step 2 ;

(defrule TIMETABLE::no-matches
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 3)(current-max ?max))
?probable <- (object (is-a PROBABLEMODULE) (moduleid ?probable-id) (moduletagtotalscore ?max)(is-checked unchecked))
=>
(send ?probable put-is-checked checked)
(send ?current-data put-current-max 0)
(send ?current-data put-current-stage 2))
  
; if all modules have been checked and we still can't assign enough modules we move to stage 4 ;

(defrule TIMETABLE::stage-two-to-four
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 2)(current-max ?max))
(test
  (not
    (any-instancep
      ((?probable PROBABLEMODULE))
      (eq ?probable:is-checked unchecked))))
=>
(send ?current-data put-current-stage 4))

; step 4: we try to find a selected module which, when removed, will allow at least one module to be added ;

(defrule TIMETABLE::remove-selected-module (declare (salience 1))
?current-data <- (object (is-a CURRENTDATA) (current-sem ?sem) (current-stage 4)(current-max ?max)(current-mc ?mc))
?removalcandidate <- (object (is-a CURRENTSELECTION)(moduleid ?candidate-id))
?candidate <- (object (is-a PROBABLEMODULE)(moduleid ?candidate-id)(mc ?mod-mc))
?probable1 <- (object (is-a PROBABLEMODULE)(moduleid ?probable1-id)(mc ?mod1-mc)(is-checked ?probable1-is-checked))
?probable1-exam <- (object (is-a EXAM) (moduleid ?probable1-id) (exam-date ?probable1-exam-date)(exam-time ?probable1-exam-time))
?probable-option-test <- (object (is-a MODULETIME)(moduleid ?probable1-id)(moduleoption ?probable1-module-option))
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
        ((?selected CURRENTSELECTION))
        (and
          (neq ?selected:moduleid ?candidate-id)
          (eq ?selected:exam-date ?probable1-exam-date)
          (eq ?selected:exam-time ?probable1-exam-time))))
; moduleoption chosen doesn't clash with anything ;
    (not
      (any-instancep
        ((?selected CURRENTSELECTION))
        (and
          (neq ?selected:moduleid ?candidate-id)
          (any-instancep
            ((?selected-time MODULETIME))
            (and
              (eq ?selected:moduleid ?selected-time:moduleid)
              (eq ?selected:moduleoption ?selected-time:moduleoption)
              (any-instancep
                ((?probable-time1 MODULETIME))
                (and
                  (eq ?probable-time1:moduleid ?probable1-id)
                  (eq ?probable-time1:moduleoption ?probable1-module-option)
                  (eq ?probable-time1:day ?selected-time:day)
                  (not
                    (or
                      (and 
                        (< ?probable-time1:starttime ?selected-time:starttime)
                        (<= ?selected-time:starttime ?probable-time1:endtime))
                      (and 
                          (< ?selected-time:starttime ?probable-time1:starttime)
                          (<= ?probable-time1:starttime ?selected-time:endtime)))))))))))
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

; if all fails, display fail message and exit ;

(defrule TIMETABLE::unsatisfied-mc-requirements
?current-data <- (object (is-a CURRENTDATA)(current-mc ?mc)(current-stage 4))
(test
  (> 18 ?mc))
=>
(printout t "failure, we have " ?mc "MC, exit!" crlf)
(send ?current-data put-current-stage -1)
(halt))
