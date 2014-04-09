f = open('modulePreclusion_Clean.txt');

tableName ='ModulePreclusion'
column = ['ModuleCode', 'Preclude'];
appro  = [0, 1];

start = 'Insert Into ' + tableName + '( ' +  ', '.join(column) + ') VALUES '
for line in f:    
	line = line.strip()
	arrayOfColumn =  line.split(',');
	for value in appro:
		arrayOfColumn[value] =  "'" + arrayOfColumn[value].strip() + "'";
	
	line =  '(' + ','.join(arrayOfColumn) + ') ';
	
	print start + line;
	