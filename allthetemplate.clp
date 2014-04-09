(defclass interestedtag
   (is-a OBJECT)
   (slot  tag(create-accessor read-write))
)

(defclass moduletaken 
   (is-a OBJECT)
   (slot moduleid (create-accessor read-write))
 )
 
 (defclass candidatemodule
    (is-a OBJECT)
	(slot moduleid )
	(slot moduletagtotalscore)
	(slot sacrificable)
 )
 
 (defclass module
    (is-a OBJECT)
	(slot moduleid)
	(slot moduledescription)
	(slot MC)
	(slot modulepriority)
	(slot moduletagscore)
 )

(defclass modulepreq
  (is-a OBJECT)
  (slot moduleid)
  (multislot modulepreq)
 )

(defclass modulepreclude
  (is-a OBJECT)
  (slot moduleid)
  (slot moduleidpreclusion)
)

(defclass moduletag
  (is-a OBJECT)
  (slot moduleid)
  (slot moduletag)
  (slot moduletagscore)
 )
 
 (defclass moduletime
  (is-a OBJECT)
  (slot moduleid)
  (slot day)
  (slot starttime)
  (slot endtime)
  (slot semester)  
 )
 
 (defclass requirement)
    (is-a OBJECT)
	(slot UE)
	(slot SS)
	(slot breadth)
	(slot GEM)
 )
 