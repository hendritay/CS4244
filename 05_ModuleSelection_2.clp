 
 
(defrule MODULESELECTION::SelectFocusAreaRule1_ThreePrimary
    ?requirement <- (object (is-a REQUIREMENT) (focusareamodule ?nomodule&:(> ?nomodule 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $?a PRIMARY $?b) (moduleid ?moduleid) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid) (desirable YES) (mc ?mc) (modulelevel ?level))
	(not (object (is-a ELIGIBLEMODULE) (moduletype $? PRIMARY $?) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
 =>
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (location FocusAreaPrimary ) (moduletagscore ?score))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newnomodule (- ?nomodule 1))
	(send ?requirement put-focusareamodule ?newnomodule)
	
	(bind ?focusareamc (send ?requirement get-focusareamc))
	(bind ?newfocusareamc (- ?focusareamc ?mc))
	(send ?requirement put-focusareamc ?newfocusareamc)
	
	
	(bind ?remaininglevel4 (send ?requirement get-focusarealevel4))
	(bind ?newlevel4 10) ; bind first for the use of below
	
	(if (>= ?level 4)	 then
			
		(bind ?newlevel4 (- ?remaininglevel4 1))
	    (send ?requirement put-focusarealevel4 ?newlevel4)
	)
	; If all the 3 modules satisfied and there is a requirement to take level 4 modules 
	(if  (<= ?newnomodule 0 ) then 
          (if (and (> ?newlevel4 0) (> ?remaininglevel4 0)) then	
			
				(assert (FOCUSAREACOMMAND 3Level4))
		else 	   
			
	        (assert (FOCUSAREACOMMAND remaining))	   	   
			)
	)		     
)

(defrule MODULESELECTION::SelectFocusArea_3Level4
	(FOCUSAREACOMMAND 3Level4)
    ?requirement <- (object (is-a REQUIREMENT) (focusarealevel4 ?level4&:(> ?level4 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid) (moduletype $? FOCUSAREA $?) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid)  (mc ?mc) (desirable YES))
	
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? FOCUSAREA $?) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
	
 =>
    
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (location FocusAreaPrimaryLevel4 ) (moduletagscore ?score))		
   
   
    (unmake-instance ?eligiblemodule)
	
	
	(bind ?focusareamc (send ?requirement get-focusareamc))
	(bind ?newfocusareamc (- ?focusareamc ?mc))
	(send ?requirement put-focusareamc ?newfocusareamc)
	
	(bind ?newlevel4 (- ?level4 1))
	(send ?requirement put-focusarealevel4 ?newlevel4)
	(if (eq ?newlevel4 0) then 	     
	    (assert (FOCUSAREACOMMAND remaining))		
	)
	
 )
 

 (defrule MODULESELECTION::SelectFocusAreaRemaining
	(FOCUSAREACOMMAND remaining)
    ?requirement <- (object (is-a REQUIREMENT) (focusareamc  ?focusmc&:(> ?focusmc 0)))	
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid) (moduletype $? CS $?) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid)  (mc ?mc) )
	
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? CS $?) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
	
 =>
	
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (location FocusAreaRemaining) (moduletagscore ?score))		
   
   
    (unmake-instance ?eligiblemodule)
	
	
	(bind ?focusareamc (send ?requirement get-focusareamc))
	(bind ?newfocusareamc (- ?focusareamc ?mc))
	(send ?requirement put-focusareamc ?newfocusareamc)
	
 )
