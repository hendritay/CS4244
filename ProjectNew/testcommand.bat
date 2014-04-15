(find-all-instances
        ((?selected CURRENTSELECTION))
        (and
          (eq
            [EX-CS1231]:get-exam-date
            (sym-cat [EX- ?selected:moduleid ]):get-exam-date)
          (eq
            (send (sym-cat [EX- CS1231]) get-exam-time)
            (send (sym-cat [EX- ?selected:moduleid ]) get-exam-time))))
