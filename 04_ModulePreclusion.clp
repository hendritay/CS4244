; For every preclusion it has, it can no longer become eligible module
; and there is 

(defrule MODULESELECTION::ModulePreclusionRule
      (declare (salience 3))
	  (object (is-a ALLMODULE) (moduleid ?somemodule))
	  ?objmodule <- (object (is-a MODULEPRECLUDE)  (moduleidpreclusion ?somemodule))
	  
	=>   
		
		(bind ?moduleid (send ?objmodule get-moduleid))
		
		; include in alreadypreclude list 
		
		(unmake-instance ?objmodule)
		
		(bind ?precludeinstance (symbol-to-instance-name (sym-cat alreadypreclude ?moduleid)))
		(make-instance ?precludeinstance of ALREADYPRECLUDE (moduleid ?moduleid))
		
		; Preclude has the meaning of saying equivalent, so it's precluded 
		; it's the same as already taken it. 
		(bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
		(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
			 		
		; if you've been precluded, so it cant be in the eligible module 
		(do-for-instance ((?eligible ELIGIBLEMODULE)) (eq ?eligible:moduleid ?moduleid)
		   (unmake-instance ?eligible)
		)
	)

	
	