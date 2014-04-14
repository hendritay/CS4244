; For every satisfied in the preq, remove it from the modulepreqlist
; until the last one, means that it already satisfy the requirement

(defrule RemoveAndCreateEligibleModuleFromPrereqModule
	  (object (is-a ALLMODULE) (moduleid ?somemodule))
	  
	  ?objmodule <- (object (is-a MODULEPREQ) (modulepreq $? ?somemodule $?) (moduleid ?moduleid))
	  
	=> 		
		(bind ?total (length (find-all-instances ((?indomie MODULEPREQ)) (eq ?indomie:moduleid  ?moduleid))) )
		
		(bind ?instancename (symbol-to-instance-name (sym-cat eligiblemodule ?moduleid)))
		
		(unmake-instance ?objmodule)
		
		
		(if (and (eq ?total 1) 
		        (not (any-instancep ((?preclude ALREADYPRECLUDE)) (eq ?preclude:moduleid ?moduleid)))
			) then		   
		   (make-instance ?instancename of ELIGIBLEMODULE (moduleid ?moduleid))
		) 
	)
	 