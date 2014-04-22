(defrule CLEANING::CleaningEligible1
   (object (is-a MODULETAKEN) (moduleid ?moduleid))
   ?instance <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
 =>
   (unmake-instance ?instance)
  )

(defrule CLEANING::CleaningEligible2
   (object (is-a CANDIDATEMODULE) (moduleid ?moduleid))
   ?instance <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
 =>
   (unmake-instance ?instance)
  )
  
  
(defrule CLEANING::CleaningEligible3
   (object (is-a REQUIREDCOREMODULE) (moduleid ?moduleid))
   ?instance <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
 =>
   (unmake-instance ?instance)
 )
 
; For every preclusion it has, it can no longer become eligible module
; and there is 


(defrule CLEANING::CleanPreclusionFromModuleTaken
      (declare (salience 5))
	  (object (is-a MODULETAKEN) (moduleid ?somemodule))
	  ?preclude <- (object (is-a MODULEPRECLUDE)   (moduleidpreclusion ?somemodule) (moduleid ?moduleid))	  
	  ?can <- (object (is-a CANDIDATEMODULE) (moduleid ?moduleid))	  	 
	=>  
	
		(unmake-instance ?can)
		(unmake-instance ?preclude	)
		(bind ?precludeinstance (symbol-to-instance-name (sym-cat alreadypreclude ?moduleid)))
		(make-instance ?precludeinstance of ALREADYPRECLUDE (moduleid ?moduleid))
		
		; Preclude has the meaning of saying equivalent, so it's precluded 
		; it's the same as already taken it. 
		(bind ?instancename (symbol-to-instance-name (sym-cat modtaken ?moduleid)))
		(make-instance ?instancename of MODULETAKEN (moduleid ?moduleid))
		
		(bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
		(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))						
	)

	
	