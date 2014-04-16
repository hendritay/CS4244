 
 
(defrule MODULESELECTION::SelectFocusAreaRule1_ThreePrimary
	
    ?requirement <- (object (is-a REQUIREMENT) (focusareamodule ?nomodule&:(> ?module 0)))
	(object (is-a FOCUSAREA) (type PRIMARY) (moduleid ?moduleid))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
	
	(object (is-a MODULE) (moduleid ?moduleid) (mc ?mc) (moduletagscore ?score)  (desirable YES) (modulelevel ?level))
	
	(forall (object (is-a FOCUSAREA) (type PRIMARY) (moduleid ?focusprimary&:(neq ?focusprimary)))
			(object (is-a ELIGIBLEMODULE) (moduleid ?focusprimary))
	        (object (is-a MODULE) (moduleid ?focusprimary) (moduletagscore ?anyscore&:(<= ?anyscore ?score)))
	)
		   
	
 =>
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newnomodule (- ?nomodule 1))
	(send ?requirement put-focusareamodule ?newnomodule)
	
	(bind ?focusareamc (send ?requirement get-focusareamc))
	(bind ?newfocusareamc (- ?focusareamc ?mc))
	(send ?requirement put-focusareamc ?newfocusareamc)
	
	
	(bind ?level4mc (send ?requirement get-focusarealevel4))
	(bind ?newlevel4 10)
	(if (>= ?level 4)	
		
	    (send ?requirement put-focusarealevel4 ?newlevel4)
	)
	; If all the 3 modules satisfied and there is a requirement to take 4 modules 
	(if (and (<= newnomdule 0 )
             (and (> ?newlevel4 0) (> ?level4mc 0))
		)	
	    (assert (FOCUSAREA 3Level4))
	   else 
	   (
	      (assert (FOCUSAREA remaining))
	   )
	   
	)
		
	      
)


(defrule MODULESELECTION::SelectFocusArea_3Level4
	(FOCUSAREA 3Level4)
    ?requirement <- (object (is-a REQUIREMENT) (focusarealevel4 ?level4&:(> ?level4 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
	(object (is-a MODULE) (moduleid ?moduleid) (moduletype $? FOCUSAREA $?) (mc ?mc) (moduletagscore ?score) (desirable YES))
	
	(not (exists (object (is-a MODULE) (moduletype $? FOCUSAREA $?) (moduletagscore ?anyscore&:(> ?anyscore ?score)))))
	
 =>
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (location FocusArea_3Level4))		
   
   
    (unmake-instance ?eligiblemodule)
	
	
	(bind ?focusareamc (send ?requirement get-focusareamc))
	(bind ?newfocusareamc (- ?focusareamc ?mc))
	(send ?requirement put-focusareamc ?newfocusareamc)
	
	(bind ?newlevel4 (- ?level4 1))
	(send ?requirement put-SS ?newlevel4)
	(if (eq ?newlevel4 0) then 
	    (assert (FOCUSAREA remaining))
	)
 )
 

 (defrule MODULESELECTION::SelectFocusAreaRemaining
	(FOCUSAREA remaining)
    ?requirement <- (object (is-a REQUIREMENT) (focusareamc  ?focusmc&:(> ?focusmc 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
	(object (is-a MODULE) (moduleid ?moduleid) (moduletype $? CS $?) (mc ?mc) (moduletagscore ?score) (desirable YES))
	
	(not (exists (object (is-a MODULE) (moduletype $? CS $?) (moduletagscore ?anyscore&:(> ?anyscore ?score)))))
	
 =>
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (location FocusAreaRemaining))		
   
   
    (unmake-instance ?eligiblemodule)
	
	
	(bind ?focusareamc (send ?requirement get-focusareamc))
	(bind ?newfocusareamc (- ?focusareamc ?mc))
	(send ?requirement put-focusareamc ?newfocusareamc)
	
 )