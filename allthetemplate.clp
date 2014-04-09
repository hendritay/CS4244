(defclass INTERESTEDTAG
   (is-a USER)
   (slot  tag(create-accessor read-write))
)

(defclass MODULETAKEN 
   (is-a USER)
   (slot moduleid (create-accessor read-write))
 )
 
 (defclass CANDIDATEMODULE
    (is-a USER)
	(slot moduleid )
	(slot moduletagtotalscore)
	(slot sacrificable)
 )
 
 (defclass MODULE
    (is-a USER)
	(slot moduleid)
	(slot moduledescription)
	(slot MC)
	(slot modulepriority)
	(slot moduletagscore (create-accessor read-write)
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

(defclass MODULETAG
  (is-a USER)
  (slot moduleid)
  (slot moduletag)
  (slot moduletagscore)
 )
 
 (defclass MODULETIME
  (is-a USER)
  (slot moduleid)
  (slot day)
  (slot starttime)
  (slot endtime)
  (slot semester)  
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
	
  )
  
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
  
 
  
  
  
  
 