(defclass INTERESTEDTAG
   (is-a USER)
   (slot  tag(create-accessor read-write))
)

(defclass INTERESTEDMODULE
   (is-a USER)
   (slot  moduleid )
)

(defclass REQUIREDCOREMODULE
   (is-a USER)
   (slot  moduleid )
)

(defclass NOTINTERESTEDMODULE
   (is-a USER)
   (slot  moduleid )
)

; Combination of ModuleTaken and CandidateModule
(defclass ALLMODULE
	(is-a USER)
   (slot moduleid (create-accessor read-write))
 )
 
 ; intermediate staging area before selection to candidate module
(defclass ELIGIBLEMODULE
    (is-a USER)
	(slot moduleid )	
	(slot moduletagtotalscore (type NUMBER))
	(slot sacrificable)
 )
 
 ; pre-requisite that cannot be done using normal rule matching
 (defclass SPECIALPREREQMODULE
   (is-a USER)
   (slot moduleid)
   )
 
(defclass MODULETAKEN 
   (is-a USER)
   (slot moduleid (create-accessor read-write))
 )
 
 (defclass CANDIDATEMODULE
    (is-a USER)
	(slot moduleid )
	(slot moduletagtotalscore (type NUMBER))
	(slot sacrificable)
 )
 
 (defclass MODULE
    (is-a USER)
	(slot moduleid)
	(slot moduledescription)
	(slot MC (type NUMBER))
	(slot modulepriority)
	(slot moduletagscore  (type NUMBER)(default 0) (create-accessor read-write))
 )

(defclass MODULEPREQ
  (is-a USER)
  (slot moduleid)
  (multislot modulepreq)
 )

(defclass MODULEPRECLUDE
  (is-a USER)
  (slot moduleid)
  (slot moduleidpreclusion)
)

; to store preclude list so that it won't be taken during eligible module
(defclass ALREADYPRECLUDE
  (is-a USER)
  (slot moduleid)
 )

(defclass MODULETAG
  (is-a USER)
  (slot moduleid)
  (slot moduletag)
  (slot moduletagscore  (type NUMBER))
 )
 
 (defclass MODULETIME
  (is-a USER)
  (slot moduleid)
  (slot day)
  (slot starttime (type NUMBER))
  (slot endtime (type NUMBER))
  (slot semester (type NUMBER))
 )
 
 (defclass REQUIREMENT
    (is-a USER)
	(slot username)
	(slot UE)
	(slot SS)
	(slot breadth)
	(slot GEM)
	(slot focusarea)
	(slot modulepersem)
	(slot graduatefrom) 
	(slot cohort)
	(slot science (default 12))
	(slot takeFYP)	
  )
  
  (defmessagehandler REQUIREMENT (
  
  (defclass FOCUSAREA
      (is-a USER)
	  (slot moduleid)
	  (slot type)
   )
   
  
  
 (defclass SCORE
   (is-a USER)
   (slot focusscoreprimary)
   (slot focussecondary)
   (slot interestedmodule)
  )
  
  
  
  
