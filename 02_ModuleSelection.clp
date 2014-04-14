;Main Rule for module selection
; This is little army to sweep any rule from ModulePreq 
; Might need to get higher salience
; Copy from candidate module list

(defrule CopyFromModuleCandidate
   (object (is-a CANDIDATEMODULE) (moduleid ?moduleid))
 => 
  (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
  (make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
 )

 
 ; Copy from moduletaken to all module list 
(defrule CopyFromModuleTaken
   (object (is-a MODULETAKEN) (moduleid ?moduleid))
 => 
  (bind ?instancename (symbol-to-instance-name (sym-cat allmodule ?moduleid)))
  (make-instance ?instancename of ALLMODULE (moduleid ?moduleid))
 )

 
