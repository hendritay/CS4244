import MySQLdb, MySQLdb.cursors

db = MySQLdb.connect(passwd="python", db="cs4244", host="localhost", user="python", cursorclass = MySQLdb.cursors.DictCursor)

c = db.cursor()

c.execute("SELECT * FROM ModuleExam")
table = c.fetchall()

print "(definstances MODULEEXAMLIST "
i = 0;
OldModuleCode = ""
for row in table:

	ModuleCode = row["ModuleCode"] 
	
	print "([exam" + ModuleCode +"] of EXAM "	
	print "(moduleid  " + row["ModuleCode"] +")"
	print "(exam-time " + row["ExamTime"].replace(" ", "").replace(":", "") +")"
	print "(exam-date " + row["ExamDate"] +")"
	print ")"
	
print ")"
	