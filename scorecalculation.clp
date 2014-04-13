(make-instance [CustomScore] of SCORE 
   (interestedmodule 10)
   (focussecondary 15)   
)
(make-instance [InterestedCS3230] of INTERESTEDMODULE 
   (moduleid CS3230)
)

(make-instance [ModuleTakenCS3230] of MODULETAKEN
   (moduleid CS3230)
)

(make-instance [InterestedFocusCS1020] of FOCUSAREA
   (moduleid CS2010)
   (type SECONDARY)
)

 (make-instance [InterestedCS2010] of INTERESTEDMODULE
    (moduleid CS2010)
 )
 
 (make-instance [InterestedTagCompScience] of INTERESTEDTAG
    (tag COMPUTER_SCIENCE)
 )


 
 (defrule rule_interestedmodule
   (object (is-a INTERESTEDMODULE) (moduleid ?moduleid))
   (object (is-a SCORE) (interestedmodule ?score))
   ?module <- (object (is-a MODULE) (moduleid ?moduleid))
  =>
    (bind ?currentscore (send ?module get-moduletagscore))   
    (send ?module put-moduletagscore (+ ?currentscore ?score))
  )
 
  

(defrule moduletagcalculation
  (object (is-a INTERESTEDTAG) (tag ?interestedtag) )  
  (object (is-a MODULETAG) (moduletag ?interestedtag) (moduletagscore ?score) (moduleid ?moduleid))
  ?module <- (object (is-a MODULE) (moduleid ?moduleid))
  =>
  (bind ?currentscore (send ?module get-moduletagscore))   
   (send ?module put-moduletagscore (+ ?currentscore ?score))
)

(defrule focusareacalculation
  (object (is-a FOCUSAREA) (moduleid ?moduleid) (type SECONDARY))
  (object (is-a SCORE) (focussecondary ?score))
  ?module <- (object (is-a MODULE) (moduleid ?moduleid))
  =>
   (bind ?currentscore (send ?module get-modulescore))   
   (send ?module put-modulescore (+ ?currentscore ?score))
)

