;Main Rule for module selection
;Main Rule for module selection
; This is little army to sweep any rule from ModulePreq 
; Might need to get higher salience
; Copy from candidate module list

(defrule MODULESELECTION::CopyFromModuleCandidate
   (object (is-a CANDIDATEMODULE) (moduleid ?moduleid))
   (object (is-a MODULE) (moduleid ?moduleid) (modulelevel ?level) (mc ?mc))
   
 => 
  (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
  (make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
  
  (if (eq ?level 1)  then
      
     (bind ?currmc (send ?*requirement* get-level1mc))
	 (bind ?newmc (+ ?currmc  ?mc))
     (send ?*requirement* put-level1mc  ?newmc)
	 
	 (if (>= ?newmc 60) then
	    (do-for-instance ((?indomie MODULE)) 
		   (eq ?indomie:modulelevel 1)
		   (send ?indomie put-desirable NO)
		 )
	 )
   )
	 	  
  
 )

 
 ; Copy from moduletaken to all module list 
(defrule MODULESELECTION::CopyFromModuleTaken
   (object (is-a MODULETAKEN) (moduleid ?moduleid))
 => 
  (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
  (make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
 )


(defrule MODULESELECTION::CheckForFocusArea
   (object (is-a CANDIDATEMODULE) (moduleid ?moduleid))
   (object (is-a FOCUSAREA) (type PRIMARY) (moduleid ?moduleid))
 =>
   (bind ?totalmodule (send ?*requirement* get-focusareamodule))
   (bind ?newmodule (- ?totalmodule 1))
   (send ?*requirement* put-focusareamodule ?newmodule)
) 
