import MySQLdb, MySQLdb.cursors

db = MySQLdb.connect(passwd="python", db="cs4244", host="localhost", user="python", cursorclass = MySQLdb.cursors.DictCursor)

c = db.cursor()

c.execute("SELECT * FROM ModuleTime")
table = c.fetchall()

print "(definstances TIMETABLE::MODULETIMELIST"
i = 0;
OldModuleCode = ""

for row in table:

	if row["ModuleCode"] == OldModuleCode:
		i = i + 1
	else:
		OldModuleCode = row["ModuleCode"]
		i = 0;
	
	ModuleCode = row["ModuleCode"] + str(i)
	
	print "([time" + ModuleCode +"] of MODULETIME "	
	print "(moduleid  " + row["ModuleCode"] +")"
	print "(day " + row["Day"] +")"
	StartTime = str(row["StartTime"]);
	StartTime = StartTime[:-3]
	EndTime = str(row["EndTime"])
	EndTime = EndTime[:-3]
	
	StartTime = StartTime.replace(":", "")
	EndTime = EndTime.replace(":", "")
	
	print "(starttime " + StartTime +")"
	print "(endtime " + EndTime +")"
	print "(semester " + row["Semester"] +")"
	print "(moduleoption " + row["ModuleOption"] +")"
	print "(lecturetype" + row["LectureType"].strip().replace(" ", "") +")"
	print ")"
	

	
print ")"

c.execute("SELECT Distinct ModuleOption as ModuleOption FROM ModuleTime")
table = c.fetchall()

print "(definstances TIMETABLE::MODULETIMEOPTIONLIST"

for row in table:
	print "([option" +row["ModuleOption"] +"] of MODULEOPTION "	
	print "(option " + row["ModuleOption"] +")"
	print ")"

print ")"

	