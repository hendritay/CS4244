;SS, GEM, SCIENCE, FYP

; Module taken won't be in ELIGIBLE module 
;==================================================================

(defrule MODULESELECTION::SelectSS
    ?requirement <- (object (is-a REQUIREMENT) (SS ?sscredit&:(> ?sscredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? SS $?) (moduleid ?moduleid) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid) (mc ?mc) )	
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? SS $?) (desirable YES)  (moduletagscore ?anyscore&:(> ?anyscore ?score))))
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?score) (location SS))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?sscredit ?mc))
	(send ?requirement put-SS ?newcredit)
	
 )
 
 
(defrule MODULESELECTION::SelectGEM
    ?requirement <- (object (is-a REQUIREMENT) (GEM ?gemcredit&:(> ?gemcredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? GEM $?) (moduleid ?moduleid) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid) (mc ?mc) )
	
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? GEM $?) (desirable YES) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
	
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?score) (location GEM))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?gemcredit ?mc))
	(send ?requirement put-GEM ?newcredit)

 )
 
 
 (defrule MODULESELECTION::SelectScience
    ?requirement <- (object (is-a REQUIREMENT) (science ?sciencecredit&:(> ?sciencecredit 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $?a SCIENCE $?b) (moduleid ?moduleid) (moduletagscore ?score))
	(object (is-a MODULE) (moduleid ?moduleid)  (mc ?mc) )
	(not (object (is-a ELIGIBLEMODULE) (moduletype $? SCIENCE $?) (desirable YES) (moduletagscore ?anyscore&:(> ?anyscore ?score))))
	
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?score) (location Science))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?sciencecredit ?mc))
	(send ?requirement put-science ?newcredit)	
 )

 (defrule MODULESELECTION::SelectUE
    ?requirement <- (object (is-a REQUIREMENT)  (UE ?ue&:(> ?ue 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? UE $?) (moduleid ?moduleid) (moduletagscore ?tagscore))	
	(object (is-a MODULE) (moduleid ?moduleid) (mc ?mc) )
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? UE $?)   (desirable YES) (moduletagscore ?score&:(> ?score ?tagscore))))
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?tagscore) (location UE))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?ue ?mc))
	(send ?requirement put-UE ?newcredit)

 )
 
 (defrule MODULESELECTION::SelectFYP
    ?requirement <- (object (is-a REQUIREMENT) (takeFYP NO) (takeFYPlevel4 ?fyp&:(> ?fyp 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? FYP $?) (moduleid ?moduleid) (moduletagscore ?tagscore))	
	(object (is-a MODULE) (moduleid ?moduleid) (mc ?mc) )
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? FYP $?)  (desirable YES) (moduletagscore ?score&:(> ?score ?tagscore))))
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?tagscore) (location FYP))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?fyp 1))
	(send ?requirement put-takeFYPlevel4 ?newcredit)
	
 )
 
 (defrule MODULESELECTION::Selectbreadth
    ?requirement <- (object (is-a REQUIREMENT) (takeFYP NO) (breadth ?breadth&:(> ?breadth 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduletype $? breadth $?) (moduleid ?moduleid) (moduletagscore ?tagscore))	
	(object (is-a MODULE) (moduleid ?moduleid) (mc ?mc) )
	(not  (object (is-a ELIGIBLEMODULE) (moduletype $? breadth $?)  (desirable YES) (moduletagscore ?score&:(> ?score ?tagscore))))
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?tagscore) (location Breadth))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?breadth ?mc))
	(send ?requirement put-breadth ?newcredit)
	
 )