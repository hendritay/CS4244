(defclass TIMETABLE::CURRENTDATA
  (is-a USER)
  (slot current-sem (type NUMBER))
  (slot current-mc (type NUMBER))
  (slot current-stage (type NUMBER))
  (slot current-max (type NUMBER))
  (slot module-list (type STRING) (default ""))
  (slot url (type STRING) (default "http://nusmods.com/2013-2014/sem2/v1/#")))

(defclass TIMETABLE::SINGLESEM
  (is-a USER)
  (slot moduleid))

(defclass TIMETABLE::CURRENTSELECTION
  (is-a USER)
  (slot moduleid)
  (slot moduletagtotalscore (type NUMBER))
  (slot semester (type NUMBER))
  (slot moduleoption)
  (slot exam-date)
  (slot exam-time))

(defclass TIMETABLE::PROBABLEMODULE
  (is-a USER)
  (slot moduleid)
  (slot moduletagtotalscore (type NUMBER))
  (slot mc (type NUMBER))
  (slot is-checked (default unchecked)))
  
(defclass TIMETABLE::MODULEOPTION
  (is-a USER)
  (slot option))

(defclass TIMETABLE::FINALCHOSEN
  (is-a USER)
  (slot moduleid))
  
(defclass TIMETABLE::PRINTEDMODULE
  (is-a USER)
  (slot moduleid))
