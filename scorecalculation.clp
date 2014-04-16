(definstances INITIALIZE::abc
([CustomScore] of SCORE 
   (interestedmodule 10)
   (focussecondary 15)   
)
([InterestedCS3230] of INTERESTEDMODULE 
   (moduleid CS3230)
)

( [ModuleTakenCS3230] of MODULETAKEN
   (moduleid CS3230)
)

( [InterestedFocusCS1020] of FOCUSAREA
   (moduleid CS2010)
   (type SECONDARY)
)

 ( [InterestedCS2010] of INTERESTEDMODULE
    (moduleid CS2010)
 )
 
 ( [InterestedTagCompScience] of INTERESTEDTAG
    (tag COMPUTER_SCIENCE)
 )
 )