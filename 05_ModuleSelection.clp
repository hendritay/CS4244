;SS, GEM, SCIENCE, FYP

; Module taken won't be in ELIGIBLE module 
;==================================================================

(defrule MODULESELECTION::SelectSS
    ?requirement <- (object (is-a REQUIREMENT) (SS ?sscredit&:(> ?sscredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? SS $?) (moduleid ?moduleid) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid) (desirable YES) (mc ?mc) )	
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? SS $?) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?score) (location SelectSS))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?sscredit ?mc))
	(send ?requirement put-SS ?newcredit)
	(printout t "SelectSS")
 )
 
 
(defrule MODULESELECTION::SelectGEM
    ?requirement <- (object (is-a REQUIREMENT) (GEM ?gemcredit&:(> ?gemcredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? GEM $?) (moduleid ?moduleid) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid) (desirable YES) (mc ?mc) )
	
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? GEM $?) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
	
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?score) (location SelectGEM))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?gemcredit ?mc))
	(send ?requirement put-GEM ?newcredit)
	(printout t "SelectGEM")
 )
 
 
 (defrule MODULESELECTION::SelectScience
    ?requirement <- (object (is-a REQUIREMENT) (science ?sciencecredit&:(> ?sciencecredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $?a SCIENCE $?b) (moduleid ?moduleid) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid) (desirable YES) (mc ?mc) )
	(not (object (is-a ELIGIBLEMODULE) (moduletype $? SCIENCE $?) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
	
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?score) (location SelectScience))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?sciencecredit ?mc))
	(send ?requirement put-science ?newcredit)
	(printout t "SelectScience")
 )

 (defrule MODULESELECTION::SelectUE
    ?requirement <- (object (is-a REQUIREMENT)  (UE ?ue&:(> ?ue 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? UE $?) (moduleid ?moduleid) (moduletagscore ?tagscore))	
	(object (is-a MODULE) (moduleid ?moduleid) (desirable YES) (mc ?mc) )
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? UE $?)  (moduletagscore ?score&:(> ?score ?tagscore))))
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?tagscore) (location SelectUE))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?ue ?mc))
	(send ?requirement put-UE ?newcredit)
	(printout t "SelectUE")
 )
 
 (defrule MODULESELECTION::SelectFYP
    ?requirement <- (object (is-a REQUIREMENT) (takeFYP NO) (takeFYPlevel4 ?fyp&:(> ?fyp 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? FYP $?) (moduleid ?moduleid) (moduletagscore ?tagscore))	
	(object (is-a MODULE) (moduleid ?moduleid) (desirable YES) (mc ?mc) )
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? FYP $?)  (moduletagscore ?score&:(> ?score ?tagscore))))
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?tagscore) (location SelectFYP))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?fyp 1))
	(send ?requirement put-takeFYPlevel4 ?newcredit)
	(printout t "SelectFYP")
 )