;SS, GEM, SCIENCE, FYP, FocusArea

; Module taken won't be in ELIGIBLE module 
;==================================================================

(defrule MODULESELECTION::SelectSS
    ?requirement <- (object (is-a REQUIREMENT) (SS ?sscredit&:(> ?sscredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
	(object (is-a MODULE) (moduleid ?moduleid) (moduletype $? SS $?) (mc ?mc) (moduletagscore ?score) (desirable YES))
	
	(not (exists (object (is-a MODULE) (moduletype $? SS $?) (moduletagscore ?anyscore&:(> ?anyscore ?score)))))
	
 =>
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (location SelectSS))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?sscredit ?mc))
	(send ?requirement put-SS ?newcredit)
 )
 
 
(defrule MODULESELECTION::SelectGEM
    ?requirement <- (object (is-a REQUIREMENT) (GEM ?gemcredit&:(> ?gemcredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
	(object (is-a MODULE) (moduleid ?moduleid) (moduletype $? GEM $?) (mc ?mc) (moduletagscore ?score) (desirable YES))
	
	(not (exists (object (is-a MODULE) (moduletype $? GEM $?) (moduletagscore ?anyscore&:(> ?anyscore ?score)))))
	
 =>
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (location SelectGEM))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?gemcredit ?mc))
	(send ?requirement put-GEM ?newcredit)
 )
 
 
 (defrule MODULESELECTION::SelectScience
    ?requirement <- (object (is-a REQUIREMENT) (science ?sciencecredit&:(> ?sciencecredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
	(object (is-a MODULE) (moduleid ?moduleid) (moduletype $? SCIENCE $?) (mc ?mc) (moduletagscore ?score) (desirable YES))
	
	(not (exists (object (is-a MODULE) (moduletype $? SCIENCE $?) (moduletagscore ?anyscore&:(> ?anyscore ?score)))))
	
 =>
    (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))	   
	(make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
	
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (location SelectScience))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?sciencecredit ?mc))
	(send ?requirement put-science ?newcredit)
 )
