import MySQLdb, MySQLdb.cursors

db = MySQLdb.connect(passwd="python", db="cs4244", host="localhost", user="python", cursorclass = MySQLdb.cursors.DictCursor)

c = db.cursor()

c.execute("SELECT * FROM ModuleTag order by modulecode")
table = c.fetchall()

print "(definstances MODULETAGLIST "
i = 0;
OldModuleCode = ""
for row in table:

	if row["ModuleCode"] == OldModuleCode:
		i = i + 1
	else:
		OldModuleCode = row["ModuleCode"]
		i = 0;
	
	ModuleCode = row["ModuleCode"] + str(i)
	
	print "([tag" + ModuleCode +"] of MODULETAG "	
	print "(moduleid  " + row["ModuleCode"] +")"
	
	print "(moduletag " + row["ModuleTag"] + ")"
	print "(moduletagscore " + str(row["Score"]) +")"
	print ")"
	
print ")"
	