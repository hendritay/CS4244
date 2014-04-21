f = open('modulepreclude_cleanlatest.txt');

tableName ='ModulePreclusion'
column = ['ModuleCode', 'Preclude'];
appro  = [0, 1];

start = 'Insert Into ' + tableName + '( ' +  ', '.join(column) + ') VALUES '

for line in f:    
	if line.strip() == "":
		continue
		
	line = line.strip()
	arrayOfColumn =  line.split(',');	
	strHead = "'" + arrayOfColumn[0].strip() + "'"
	for preclude in arrayOfColumn[1:]:
		preclude = "'" + preclude.strip() + "'"
		line =  '(' + strHead +", " + preclude + "); "	
		print start + line;

