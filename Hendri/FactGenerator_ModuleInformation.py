import MySQLdb, MySQLdb.cursors

db = MySQLdb.connect(passwd="python", db="cs4244", host="localhost", user="python", cursorclass = MySQLdb.cursors.DictCursor)

c = db.cursor()

c.execute("SELECT * FROM ModuleInformation")
table = c.fetchall()

 
print "(definstances MODULEINFOLIST "
i = 0;
OldModuleCode = ""
for row in table:

	ModuleCode = row["ModuleCode"] 	
	print "([mod" + ModuleCode +"] of MODULE "	
	print "(moduleid  " + row["ModuleCode"] +")"
	print "(MC " + str(row["ModuleCredit"]) +")"
	print ")"
	
print ")"
	