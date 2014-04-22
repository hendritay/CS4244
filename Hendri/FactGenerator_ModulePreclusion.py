import MySQLdb, MySQLdb.cursors

db = MySQLdb.connect(passwd="python", db="cs4244", host="localhost", user="python", cursorclass = MySQLdb.cursors.DictCursor)

c = db.cursor()

c.execute("SELECT * FROM ModulePreclusion ORDER BY ModuleCode")
table = c.fetchall()

print "(definstances INITALIZE::MODULEPRECLUDELIST "
i = 0;
OldModuleCode = ""

for row in table:

	if row["ModuleCode"] == OldModuleCode:
		i = i + 1
	else:
		OldModuleCode = row["ModuleCode"]
		i = 0;
	
	ModuleCode = row["ModuleCode"] + str(i)
	
	print "([prec" + ModuleCode +"] of MODULEPRECLUDE "	
	print "(moduleid  " + row["ModuleCode"] +")"
	print "(moduleidpreclusion " + row["Preclude"] +")"
	print ")"
	
print ")"
	