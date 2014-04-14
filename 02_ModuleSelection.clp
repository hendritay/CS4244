(defrule copyfrommoduletaken
   (object (is-a MODULETAKEN) (moduleid ?moduleid))
 => 
  (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
  (make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
 )

(defrule copyfrommodulecandidate
   (object (is-a CANDIDATEMODULE) (moduleid ?moduleid))
 => 
  (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
  (make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
 ) 
 
; Get those module who has no pre req, and it suddenly becomes eligible module 
(defrule getNoPreqModule
  (object (is-a MODULE) (moduleid ?moduleid))
  (not (exists (object (is-a SPECIALPREREQMODULE) (moduleid ?moduleid))))
  (not (exists (object (is-a MODULEPREQ) (moduleid ?moduleid))))
=>   
	(bind ?instancename (symbol-to-instance-name (sym-cat eligiblemodule ?moduleid)))
	(make-instance ?instancename of ELIGIBLEMODULE (moduleid ?moduleid))
   
)
 