; Get those module who has no pre req, and it suddenly becomes eligible module 
(defrule AFTERINITIALIZE::getNoPreqModule
  (object (is-a MODULE) (moduleid ?moduleid) (moduletagscore  ?score) (moduletype $?moduletype))
  (not (exists (object (is-a MODULEPREQ) (moduleid ?moduleid))))
=>
   (bind ?instancename (symbol-to-instance-name (sym-cat eligiblemodule ?moduleid)))
   (make-instance ?instancename of ELIGIBLEMODULE (moduleid ?moduleid) (moduletagscore ?score) (moduletype ?moduletype))
   
)