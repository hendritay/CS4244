; Initializing rule
; Only run one time

; If the module is not taken, move it to candidate module
; The copy from modulecandidate will move it to ALLMODULE

; Copy from moduletaken to all module list 
(defrule MODULESELECTION::CopyFromModuleTaken
   (object (is-a MODULETAKEN) (moduleid ?moduleid))
   (object (is-a MODULE) (moduleid ?moduleid) (modulelevel ?level) (mc ?mc))
   ?require <- (object (is-a REQUIREMENT))
 => 
  (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
  (make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
  
  (if (eq ?level 1)  then   
     (bind ?currmc (send ?require get-level1mc))  
	 (bind ?newmc (+ ?currmc  ?mc))
     (send ?require put-level1mc  ?newmc)
	)
  
 )
 
(defrule INITIALIZE::moveRequiredCoreModuleToCandidateModule 
    (object (is-a REQUIREDCOREMODULE) (moduleid ?moduleid))
	(object (is-a MODULE) (moduleid ?moduleid) (moduletagscore ?score))
	(not  (object (is-a MODULETAKEN) (moduleid ?moduleid)))
=>      
    (bind ?instancename (symbol-to-instance-name (sym-cat candidatemodule ?moduleid)))	   
	(make-instance ?instancename of CANDIDATEMODULE (moduleid ?moduleid) (location REQUIREDMODULE) (moduletagscore ?score))	
	
	
)
 
; Rule that matches only based on the module taken 
; ---------------------------------------------------------------


; Interested Module to give higher score
 (defrule INITIALIZE::rule_interestedmodule
   (object (is-a INTERESTEDMODULE) (moduleid ?moduleid))
   (object (is-a SCORE) (interestedmodule ?score))
   ?module <- (object (is-a MODULE) (moduleid ?moduleid))
  =>
    (bind ?currentscore (send ?module get-moduletagscore))   
    (send ?module put-moduletagscore (+ ?currentscore ?score))
 )
 ; not interested module
 (defrule INITIALIZE::notrule_interestedmodule
   (object (is-a NOTINTERESTEDMODULE) (moduleid ?moduleid))
   (object (is-a SCORE) (notinterestedmodule ?score))
   ?module <- (object (is-a MODULE) (moduleid ?moduleid))
  =>
    (bind ?currentscore (send ?module get-moduletagscore))   
    (send ?module put-moduletagscore (- ?currentscore ?score))
 )
  
; Calculate Based On Module tag
(defrule INITIALIZE::moduletagcalculation
  (object (is-a INTERESTEDTAG) (tag ?interestedtag) )  
  (object (is-a MODULETAG) (moduletag ?interestedtag) (moduletagscore ?score) (moduleid ?moduleid))
  ?module <- (object (is-a MODULE) (moduleid ?moduleid))
  =>
  (bind ?currentscore (send ?module get-moduletagscore))   
   (send ?module put-moduletagscore (+ ?currentscore ?score))
)

; Give more marks for Focus Area module
(defrule INITIALIZE::focusareacalculation
  (object (is-a FOCUSAREA) (moduleid ?moduleid) (type SECONDARY))
  (object (is-a SCORE) (focussecondary ?score))
  ?module <- (object (is-a MODULE) (moduleid ?moduleid))
  =>
   (bind ?currentscore (send ?module get-moduletagscore))   
   (send ?module put-moduletagscore (+ ?currentscore ?score))
)


(defrule INITIALIZE::CheckForFocusArea
   (object (is-a MODULETAKEN) (moduleid ?moduleid))   
   (object (is-a FOCUSAREA) (type PRIMARY) (moduleid ?moduleid))
   ?require <- (is-a REQUIREMENT)
 =>
   (bind ?totalmodule (send ?require get-focusareamodule))
   (bind ?newmodule (- ?totalmodule 1))
   (send ?require put-focusareamodule ?newmodule)
)

(defrule INITIALIZE::AssignFocusArea
   ?focusarea <- (object (is-a FOCUSAREA) (moduleid ?moduleid) (type ?focustype) (check NO))   
   ?objectmodule <- (object (is-a MODULE) (moduleid ?moduleid) (moduletype $?type))
 =>
   
   (bind ?totaltype (insert$ ?type 1 ?focustype))
   (send ?objectmodule put-moduletype ?totaltype)
   (send ?focusarea put-check YES)
   
  
   
)


(defrule INITIALIZE::ScoreCalculationForLevel123
   (object (is-a SCORE) (level1additionalscore ?level1score) (level2additionalscore ?level2score) (level3additionalscore ?level3score))
   ?moduleinfo <- (object (is-a MODULE) (moduleid ?module) (modulelevel ?level&:(<= ?level 3)))
   
  =>
    (bind ?score (send ?moduleinfo get-moduletagscore))

(bind ?newscore (+ ?score ?level3score))
    (if (eq ?level 1) then
(bind ?newscore (+ ?score ?level1score))
else
(if (eq ?level 2) then
(bind ?newscore (+ ?score ?level2score))
)
)

(send ?moduleinfo put-moduletagscore ?newscore)

 )
 
 ; Interested Module to give higher score
 (defrule INITIALIZE::rule_cs_score
   
   (object (is-a SCORE) (csscore ?score))
   ?module <- (object (is-a MODULE) (moduletype $? CS $?) (moduleid ?moduleid))
  =>
    (bind ?currentscore (send ?module get-moduletagscore))   
    (send ?module put-moduletagscore (+ ?currentscore ?score))
 )
