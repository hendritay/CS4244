(defrule START::moduletagcalculation
  (object (is-a INTERESTEDTAG) (moduleid ?moduleid) (modulescore ?score)
  ?module <- (object (is-a MODULE) (module ?moduleid)
  =>
   (bind ?currentscore (send ?module get-modulescore))   
   (send ?module put-modulescore (+ ?currentscore ?score))
)

(defrule START::focusareacalculation
  (object (is-a FOCUSAREA) (moduleid ?moduleid) (type SECONDARY)
  (object (is-a SCORE) (focussecondary ?score))
  ?module <- (object (is-a MODULE) (module ?moduleid))
  =>
   (bind ?currentscore (send ?module get-modulescore))   
   (send ?module put-modulescore (+ ?currentscore ?score))
  )
 
 (defrule START::interestedmodule
   (object (is-a INTERESTEDMODULE) (moduleid ?moduleid)
   (object (is-a SCORE) (modulesocre ?score))
   ?module <- (object (is-a MODULE) (module ?moduleid))
  =>
    (bind ?currentscore (send ?module get-modulescore))   
    (send ?module put-modulescore (+ ?currentscore ?score))
  )
  
  
  
  