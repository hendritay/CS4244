; Main Rule for Module selection
; For every satisfied in the preq, remove it from the modulepreqlist
; if that's the last one, means that it already satisfy the requirement
; the not exists is to guard any modules that's not catered by this rule 
; The alreadyprecludelist means that we can not take already. 

(defrule MODULESELECTION::RemoveAndCreateEligibleModuleFromPrereqModule
	  (declare (salience 5))
	  (object (is-a ALLMODULE) (moduleid ?somemodule) )	  
	  ?objmodule <- (object (is-a MODULEPREQ) (modulepreq $? ?somemodule $?) (moduleid ?moduleid))
	   (object (is-a MODULE) (moduleid ?moduleid) (moduletagscore ?score) (moduletype $?moduletype) (modulelevel ?level))	  
	  (not (exists (object (is-a SPECIALPREREQMODULE) (moduleid ?moduleid)))) 
	  
	=> 		
		
		(bind ?total (length (find-all-instances ((?indomie MODULEPREQ)) (eq ?indomie:moduleid  ?moduleid))) )
		
		(bind ?instancename (symbol-to-instance-name (sym-cat eligiblemodule ?moduleid)))
		
		(unmake-instance ?objmodule)
				
		(if (and (eq ?total 1) 
		        (not (any-instancep ((?preclude ALREADYPRECLUDE)) (eq ?preclude:moduleid ?moduleid)))
				(not (any-instancep ((?taken MODULETAKEN)) (eq ?taken:moduleid ?moduleid)))
			) then		   			

		   (make-instance ?instancename of ELIGIBLEMODULE (moduleid ?moduleid) (moduletagscore ?score) (modulelevel ?level)(moduletype $?moduletype) )		   
		) 		
)