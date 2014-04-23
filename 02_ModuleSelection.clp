;Main Rule for module selection
;Main Rule for module selection
; This is little army to sweep any rule from ModulePreq 
; Might need to get higher salience
; Copy from candidate module list

(defrule MODULESELECTION::CopyFromModuleCandidate
	(declare (salience 5))
   (object (is-a CANDIDATEMODULE) (moduleid ?moduleid))
   (object (is-a MODULE) (moduleid ?moduleid) (modulelevel ?level) (mc ?mc) (desirable ?desire))
   ?require <- (object (is-a REQUIREMENT))
 => 
  (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
  (make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
       
; if 60 mc rules has not kicked in
  (if (and (eq ?level 1) (eq ?desire YES)) then    
     (bind ?currmc (send ?require get-level1mc))  
	 (bind ?newmc (+ ?currmc  ?mc))
     (send ?require put-level1mc  ?newmc)
	 
	 (if (>= ?newmc 60) then
	    (do-for-all-instances ((?indomie MODULE)) 
		   (eq ?indomie:modulelevel 1)
		   (send ?indomie put-desirable NO)
		 )
		 (do-for-all-instances ((?indomie ELIGIBLEMODULE)) 
		   (eq ?indomie:modulelevel 1)
		   (send ?indomie put-desirable NO)
		 )
	 )
   )
	 	  
 )


(defrule MODULESELECTION::CheckForFocusArea
(declare (salience 5))
   (object (is-a CANDIDATEMODULE) (moduleid ?moduleid) (location ?location&:(neq ?location FocusAreaPrimary)))
   (object (is-a FOCUSAREA) (type PRIMARY) (moduleid ?moduleid))
   ?require <- (object (is-a REQUIREMENT))
 =>
   (bind ?totalmodule (send ?require get-focusareamodule))
   (bind ?newmodule (- ?totalmodule 1))
   (send ?require put-focusareamodule ?newmodule)
) 
