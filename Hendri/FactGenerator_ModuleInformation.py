import MySQLdb, MySQLdb.cursors

db = MySQLdb.connect(passwd="python", db="cs4244", host="localhost", user="python", cursorclass = MySQLdb.cursors.DictCursor)

c = db.cursor()

c.execute("SELECT * FROM ModuleInformation")
table = c.fetchall()

ScienceModule = ['CM1121', 'CM1131', 'CM1417', 'LSM1301', 'LSM1302', 'PC1141', 'PC1142', 'PC1143', 'PC1144', 'PC1221', 'PC1222', 'PC1432', 'MA2213', 'MA2214', 
'CM1101', 'CM1111', 'CM1161', 'CM1191', 'CM1401', 
'CM1402', 'CM1501', 'CM1502', 'LSM1303', 'PC1421', 'PC1431', 'PC1433'
'MA1104','MA2101','MA2108','MA2501','ST2132','ST2137']

 
print "(definstances INITIALIZE::MODULEINFOLIST "
i = 0;
OldModuleCode = ""
for row in table:

	ModuleCode = row["ModuleCode"] 	
	print "([mod" + ModuleCode +"] of MODULE "	
	print "(moduleid  " + row["ModuleCode"] +")"
	print "(mc " + str(row["ModuleCredit"]) +")"
	print "(modulelevel " + str(row["ModuleLevel"]) +")"
	print "(moduletype " 
	
	if ModuleCode[0:2].upper() == "GE":
		print "GEM"
		
	if ModuleCode[0:2].upper() == "SS":
	    print "SS"
		
	if ModuleCode[0:2].upper() != "SS" and ModuleCode[0:2].upper() != "GE":
		print "UE"
		if ModuleCode[0:2].upper() != "CS":
			print "breadth"
	
	if ModuleCode[0:2].upper() == "CS":
		print "CS"
		if row["ModuleLevel"] >= 4:
			print "FYP"
			print "FOCUSAREA"
	else:
		print "NONCS"
	
	if ModuleCode in ScienceModule:
		print "SCIENCE"
		
	print ")"
	
	print ")"
	
print ")"
	