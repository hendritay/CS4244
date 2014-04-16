
      (find-instance
        ((?selected CURRENTSELECTION))
        (any-instancep
          ((?selected-time MODULETIME))
          (and
            (eq ?selected:moduleid ?selected-time:moduleid)
            (eq ?selected:moduleoption ?selected-time:moduleoption)
            (any-instancep
              ((?probable-time1 MODULETIME))
              (and
                (eq ?probable-time1:moduleid PC1221)
                (eq ?probable-time1:moduleoption SL1)
                (eq ?probable-time1:day THURSDAY)
                (not
                  (or
                    (and 
                      (< ?probable-time1:starttime ?selected-time:starttime)
                      (<= ?selected-time:starttime ?probable-time1:endtime))
                    (and 
                        (< ?selected-time:starttime ?probable-time1:starttime)
                        (<= ?probable-time1:starttime ?selected-time:endtime)))))))))
