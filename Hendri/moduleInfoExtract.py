f = open('moduleInformation.txt');

tableName ='ModuleInformation'
column = ['ModuleCode', 'ModuleName', 'ModuleDepartment', 'ModuleCredit'];
appro  = [0, 1, 2];

start = 'Insert Into ' + tableName + '( ' +  ', '.join(column) + ') VALUES '

missingModes = [
"'EN4232'", 
"'HY4205'", 
"'EU2214'", 
"'PH2302'", 
"'GEK2003'", 
"'PS4218'", 
"'GEK1008'", 
"'SSU2004'", 
"'GEK2003'", 
"'EU2214'", 
"'EU2214'", 
"'PH2302'", 
"'GEK2003'", 
"'GEK1008'"]

modulesID = []
duplicateID = False;
moduleCodes = [];
for line in f:    
	line = line.strip()
	arrayOfColumn =  line.split(',');
	if len(arrayOfColumn) <> 4:
		
		newForm = [];
		newArray = [];
		
		for i in range(1, len(arrayOfColumn) -2):
			newForm.append(arrayOfColumn[i]);
		
		newArray.append(arrayOfColumn[0]);
		newArray.append(''.join(newForm));
		newArray.append(arrayOfColumn[-2]);
		newArray.append(arrayOfColumn[-1]);
		
		arrayOfColumn = newArray;
		
	if "/" in arrayOfColumn[0]:
		modulesID = arrayOfColumn[0].split("/")
		duplicateID = True;
		
	for value in appro:
		arrayOfColumn[value] =  "'" + arrayOfColumn[value].strip().replace("'", "''") + "'";

		
	if duplicateID:
		duplicateID = False;
		for str in modulesID:
			arrayOfColumn[0] = "'" + str.strip() + "'";			
			
			moduleCodes.append(arrayOfColumn[0])
			line =  '(' + ','.join(arrayOfColumn) + ');';		
					
			if arrayOfColumn[0] in missingModes:
			   print start + line;
			
	else:
		line =  '(' + ','.join(arrayOfColumn) + ');';		
		moduleCodes.append(arrayOfColumn[0])
		
		if arrayOfColumn[0] in missingModes:
		   print start + line;
		