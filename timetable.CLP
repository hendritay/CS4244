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
(send ?current-data put-current-stage -1))

(defglobal 
  ?*final-url* = ""
  ?*final-module-list* = "")

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
; not over mc limit (currently set to 22);
    (>= 22 (- (+ ?mc ?mod1-mc) ?mod-mc)))
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

; if all fails, move on to generate url for what has been selected ;

(defrule TIMETABLE::unsatisfied-mc-requirements
?current-data <- (object (is-a CURRENTDATA)(current-mc ?mc)(current-stage 4))
(test
  (> 18 ?mc))
=>
(send ?current-data put-current-stage -1))

; generate the URL string for timetable display ;

(defrule TIMETABLE::generate-url
?current-data <- (object (is-a CURRENTDATA) (current-stage -1))
?selected <- (object (is-a CURRENTSELECTION) (moduleid ?selected-id) (moduleoption ?selected-moduleoption))
?selected-time <- (object (is-a MODULETIME)(moduleid ?selected-id)(moduleoption ?selected-moduleoption)(lecturetype ?ltype))
=>
(if (eq ?ltype LECTURE)
then (send ?current-data put-url (sym-cat (send ?current-data get-url) ?selected-id "=2" ?selected-moduleoption)))
(if (eq ?ltype SEMINAR-STYLEMODULECLASS)
then (send ?current-data put-url (sym-cat (send ?current-data get-url) ?selected-id "=7" ?selected-moduleoption)))
(if (eq ?ltype SECTIONALTEACHING)
then (send ?current-data put-url (sym-cat (send ?current-data get-url) ?selected-id "=6" ?selected-moduleoption)))
(if (eq ?ltype PACKAGEDLECTURE)
then (send ?current-data put-url (sym-cat (send ?current-data get-url) ?selected-id "=3" ?selected-moduleoption)))
(if (eq ?ltype DESIGNLECTURE)
then (send ?current-data put-url (sym-cat (send ?current-data get-url) ?selected-id "=0" ?selected-moduleoption)))
(send ?current-data put-current-stage -2)
; we convert the module from SELECTEDMODULE to FINALCHOSEN ;
(make-instance (sym-cat FC- ?selected-id) of FINALCHOSEN (moduleid ?selected-id))
(unmake-instance ?selected))

(defrule TIMETABLE::generate-and (declare (salience 1))
?current-data <- (object (is-a CURRENTDATA) (current-stage -2))
?selected <- (object (is-a CURRENTSELECTION))
=>
(send ?current-data put-url (sym-cat (send ?current-data get-url) "&"))
(send ?current-data put-current-stage -1))

(defrule TIMETABLE::generate-finished-url
?current-data <- (object (is-a CURRENTDATA) (current-stage -2)(url ?current-url))
=>
(send ?current-data put-current-stage -3)
(bind ?*final-url* ?current-url))

; generate list of candidate modules ;

(defrule TIMETABLE::generate-candidate-module-list (declare (salience 1))
?current-data <- (object (is-a CURRENTDATA) (current-stage -3))
?candidate <- (object (is-a CANDIDATEMODULE) (moduleid ?candidate-id))
(test
  (not
    (any-instancep
      ((?printed PRINTEDMODULE))
      (eq ?printed:moduleid ?candidate-id))))
=>
(send ?current-data put-module-list (sym-cat (send ?current-data get-module-list) ?candidate-id))
(send ?current-data put-current-stage -4)
(make-instance (sym-cat PP- ?candidate-id) of PRINTEDMODULE (moduleid ?candidate-id)))

(defrule TIMETABLE::generate-comma (declare (salience 1))
?current-data <- (object (is-a CURRENTDATA) (current-stage -4))
?candidate <- (object (is-a CANDIDATEMODULE)(moduleid ?candidate-id))
(test
  (not
    (any-instancep
      ((?printed PRINTEDMODULE))
      (eq ?printed:moduleid ?candidate-id))))
=>
(send ?current-data put-module-list (sym-cat (send ?current-data get-module-list) ","))
(send ?current-data put-current-stage -3))

(defrule TIMETABLE::generate-finished-module-list
?current-data <- (object (is-a CURRENTDATA) (current-stage -3)(module-list ?current-module-list))
=>
(send ?current-data put-current-stage -5)
(bind ?*final-module-list* ?current-module-list)
(halt))

(deffunction TIMETABLE::print-out-url ()
(printout t ?*final-url* crlf))
  
(deffunction TIMETABLE::find-all-candidate-module ()
(printout t ?*final-module-list* crlf))
  
    
