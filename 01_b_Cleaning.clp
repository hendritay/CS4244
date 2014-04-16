(defrule CLEANING::CleaningEligible1
   (object (is-a MODULETAKEN) (moduleid ?moduleid))
   ?instance <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
 =>
   (unmake-instance ?instance)
  )

(defrule CLEANING::CleaningEligible2
   (object (is-a CANDIDATEMODULE) (moduleid ?moduleid))
   ?instance <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
 =>
   (unmake-instance ?instance)
  )
  
  
(defrule CLEANING::CleaningEligible3
   (object (is-a SPECIALPREREQMODULE) (moduleid ?moduleid))
   ?instance <- (object (is-a ELIGIBLEMODULE) (moduleid ?moduleid))
 =>
   (unmake-instance ?instance)
  )