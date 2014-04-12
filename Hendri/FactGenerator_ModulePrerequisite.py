import MySQLdb, MySQLdb.cursors

db = MySQLdb.connect(passwd="python", db="cs4244", host="localhost", user="python", cursorclass = MySQLdb.cursors.DictCursor)

c = db.cursor()

c.execute("SELECT * FROM ModulePrereq ORDER BY ModuleCode")
table = c.fetchall()

print "(definstances MODULEPREQUISITELIST "
i = 0;
OldModuleCode = ""

for row in table:

	if row["ModuleCode"] == OldModuleCode:
		i = i + 1
	else:
		OldModuleCode = row["ModuleCode"]
		i = 0;
	
	ModuleCode = row["ModuleCode"] + str(i)
	
	print "([" + ModuleCode +"] of MODULEPREQ "	
	print "(moduleid  " + row["ModuleCode"] +")"
	print "(modulepreq " + row["PrereqCode"].replace(",", " ") +")"
	print ")"
	
print ")"
	