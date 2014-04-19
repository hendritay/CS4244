 
 
(defrule MODULESELECTION::SelectFocusAreaRule1_ThreePrimary
	
    ?requirement <- (object (is-a REQUIREMENT) (focusareamodule ?nomodule&:(> ?nomodule 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $?a PRIMARY $?b) (moduleid ?moduleid) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid) (desirable YES) (mc ?mc) (modulelevel ?level))
	(not (object (is-a ELIGIBLEMODULE) (moduletype $? PRIMARY $?) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
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
	(bind ?newlevel4 10) ; bind first for the use of below
	(if (>= ?level 4)	 then
		
	    (send ?requirement put-focusarealevel4 ?newlevel4)
	)
	; If all the 3 modules satisfied and there is a requirement to take 4 modules 
	(if (and (<= ?newnomodule 0 )
             (and (> ?newlevel4 0) (> ?level4mc 0))
		)	then
	    (assert (FOCUSAREACOMMAND 3Level4))
	   else 	   
	      (assert (FOCUSAREACOMMAND remaining))	   	   
	)		     
)


(defrule MODULESELECTION::SelectFocusArea_3Level4
	(FOCUSAREACOMMAND 3Level4)
    ?requirement <- (object (is-a REQUIREMENT) (focusarealevel4 ?level4&:(> ?level4 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid) (moduletype $? FOCUSAREA $?) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid)  (mc ?mc) (desirable YES))
	
	(not (exists (object (is-a ELIGIBLEMODULE) (moduletype $? FOCUSAREA $?) (moduletagscore ?anyscore&:(> ?anyscore ?score)))))
	
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
	(FOCUSAREACOMMAND remaining)
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