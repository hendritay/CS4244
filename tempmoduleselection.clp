(defrule MODULESELECTION::SelectUE
    ?requirement <- (object (is-a REQUIREMENT) (UE ?ue&:(> ?ue 0)))
	?eligiblemodule <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid) (moduletagscore ?tagscore))	
	(object (is-a MODULE) (moduleid ?moduleid) (desirable YES) (mc ?mc) )
	(not  (object (is-a ELIGIBLEMODULE)   (moduletagscore ?score&:(> ?score ?tagscore))))
 =>
    
	(bind ?candidatemodule (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?candidatemodule of CANDIDATEMODULE (moduleid ?moduleid) (moduletagscore ?tagscore) (location SelectUE))		
   
    (unmake-instance ?eligiblemodule)
	
	(bind ?newcredit (- ?ue ?mc))
	(send ?requirement put-UE ?newcredit)
	(printout t "Hello ")
	(printout t ?newcredit)
	
 )