
(deffacts MODULESELECTION::the-facts
  (focus MODULESELECTION))


(defrule MODULESELECTION::direct-schedule
=>
(delayed-do-for-all-instances
  ((?module MODULE))
  (not
    (any-instancep
      ((?preq MODULEPREQ))
      (and
        (eq ?preq:moduleid ?module:moduleid)
        (not
          (any-instancep
            ((?taken MODULETAKEN))
            (neq (member$ ?taken:moduleid ?preq:modulepreq) FALSE))))))
  (make-instance (sym-cat ES- ?module:moduleid) of ELIGIBLEMODULECANSCHEDULE
    (moduleid ?module:moduleid))))

