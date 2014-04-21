f = open('03_prereq_tobehandled.txt');

tableName ='ModulePrereq'
column = ['ModuleCode', 'Prereqcode'];
appro  = [0, 1];

start = 'Insert Into ' + tableName + '( ' +  ', '.join(column) + ') VALUES '

for line in f:    
	if line.strip() == "":
		continue
		
		
	
	line = line.strip()
	arrayOfColumn =  line.split(',');	
	strHead = "'" + arrayOfColumn[0].strip() + "'"
	
	arrayOfColumn.pop(0);
	newArray = [];
	for str in arrayOfColumn:
		newArray.append(str.strip())
	
	line = "(" + strHead + ", '" + ','.join(newArray) + "');"
	
	print start + line + "\n";
	

