(make-instance [Allmdoule11] of ALLMODULE
   (moduleid ABC)
)

(make-instance [Allmdoule11] of ALLMODULE
   (moduleid ACC1002)
)
(make-instance [ACC10060] of MODULEPREQ 
(moduleid  DEF)
(modulepreq ABC DEF)
)

(make-instance [ACC100601] of MODULEPREQ 
(moduleid  CEG)
(modulepreq ABC )
)

(make-instance [ACC10060] of MODULEPREQ 
(moduleid  CEG)
(modulepreq XYZ)
)

	(defrule getPrereqModule

	  (object (is-a ALLMODULE) (moduleid ?somemodule))
	  (object (is-a MODULEPREQ) (modulepreq $? ?somemodule $?) (moduleid ?moduleid))
	  (forall (object (is-a MODULEPREQ) (moduleid ?moduleid) (modulepreq $? ?prereqmode $?))
			   (exists (object (is-a ALLMODULE) (moduleid ?prereqmode))))	  
	=>   
(printout t "Hello")
	)
	 