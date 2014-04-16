
(deffacts MAIN::control-execution
	(phase-sequence INITIALIZE MODULESELECTION TIMETABLE)
)

(defrule MAIN::change-phase
	?list <- (phase-sequence  ?next-phase  $?other-phases)
=>
	(focus ?next-phase)
	(retract ?list)
	(assert (phase-sequence  ?other-phases  ?next-phase))

)


(defmodule INITIALIZE
  (export defclass MODULE)
  (export defclass MODULEPREQ)
  (export defclass MODULETAKEN)
  (export defclass REQUIREMENT)
  (export defclass ELIGIBLEMODULE)
  (export defclass ALLMODULE)
 )

(defmodule MODULESELECTION
   (import INITIALIZE defclass ?ALL)
   (export defclass CANDIDATEMODULE)  
)
 
(defmodule TIMETABLE
  (import INITIALIZE defclass ?ALL)
  (import MODULESELECTION defclass ?ALL)
)



(defclass INITIALIZE::INTERESTEDTAG
   (is-a USER)
   (slot  tag(create-accessor read-write))
)

(defclass INITIALIZE::INTERESTEDMODULE
   (is-a USER)
   (slot  moduleid )
)

(defclass INITIALIZE::REQUIREDCOREMODULE
   (is-a USER)
   (slot  moduleid )
)

(defclass INITIALIZE::NOTINTERESTEDMODULE
   (is-a USER)
   (slot  moduleid )
)

; Combination of ModuleTaken and CandidateModule
(defclass INITIALIZE::ALLMODULE
	(is-a USER)
   (slot moduleid (create-accessor read-write))
 )
 
 ; intermediate staging area before selection to candidate module
(defclass INITIALIZE::ELIGIBLEMODULE
    (is-a USER)
	(slot moduleid )	
	(slot moduletagtotalscore (type NUMBER))
	(slot sacrificable)
 )
 
 ; pre-requisite that cannot be done using normal rule matching
 (defclass INITIALIZE::SPECIALPREREQMODULE
   (is-a USER)
   (slot moduleid)
   )
 
(defclass INITIALIZE::MODULETAKEN 
   (is-a USER)
   (slot moduleid (create-accessor read-write))
 )
 
 (defclass MODULESELECTION::CANDIDATEMODULE
    (is-a USER)
	(slot moduleid )
	(slot moduletagtotalscore (type NUMBER))
	(slot location)
	
 )
 
 (defclass INITIALIZE::MODULE
    (is-a USER)
	(slot moduleid)
	(slot moduledescription)
	(slot mc (type NUMBER))
	(slot modulepriority)
	(slot modulelevel)
	(multislot moduletype)
	(slot desirable (default YES) (create-accessor read-write))
	
	(slot moduletagscore  (type NUMBER)(default 0) (create-accessor read-write) )
 )

(defclass INITIALIZE::MODULEPREQ
  (is-a USER)
  (slot moduleid)
  (multislot modulepreq)
 )

(defclass INITIALIZE::MODULEPRECLUDE
  (is-a USER)
  (slot moduleid)
  (slot moduleidpreclusion)
)

; to store preclude list so that it won't be taken during eligible module
(defclass INITIALIZE::ALREADYPRECLUDE
  (is-a USER)
  (slot moduleid)
 )

(defclass INITIALIZE::MODULETAG
  (is-a USER)
  (slot moduleid)
  (slot moduletag)
  (slot moduletagscore  (type NUMBER))
 )
 
 (defclass TIMETABLE::MODULETIME
  (is-a USER)
  (slot moduleid)
  (slot day)
  (slot starttime (type NUMBER))
  (slot endtime (type NUMBER))
  (slot semester (type NUMBER)
  (slot moduleoption )
 )
 
 (defclass INITIALIZE::REQUIREMENT
    (is-a USER)
	(slot username)
	(slot UE (create-accessor read-write))
	(slot SS (create-accessor read-write))
	(slot breadth (create-accessor read-write))
	(slot GEM (create-accessor read-write))
	(slot focusarea (create-accessor read-write))
	(slot focusareamodule (default 3))
	(slot focusarealevel4 (default 3))
	(slot focusareamc (default 24))
	(slot modulepersem (create-accessor read-write))
	(slot graduatefrom (create-accessor read-write)) 
	(slot cohort (create-accessor read-write))
	(slot science (default 12)(create-accessor read-write))
	(slot takeFYP (create-accessor read-write))	
	(slot takeFYPlevel4 (default 3) (create-accessor read-write))	
	(slot level1mc (create-accessor read-write))
  )
  
  (defclass INITIALIZE::FOCUSAREA
      (is-a USER)
	  (slot moduleid)
	  (slot type)
   )
   
  
  
 (defclass INITIALIZE::SCORE
   (is-a USER)
   (slot focusscoreprimary)
   (slot focussecondary)
   (slot interestedmodule)
   (slot notinterestedmodule (default 50))
   (slot level1additionalscore (default 20))
   (slot level2additionalscore (default 15))
   (slot level3additionalscore (default 10))   
  )
     
  
 (defglobal ?*requirement* = (make-instance [john] of REQUIREMENT (level1mc 0) (SS 8)))


(defclass TIMETABLE::EXAM
  (is-a USER)
  (slot moduleid)
  (slot exam-date)
  (slot exam-time)
  )
