f = open('moduleTime.txt');

tableName ='ModuleTime'
column = ['ModuleCode', 'Day', 'StartTime', 'EndTime', 'Venue', 'Semester',  'ModuleOption'];
appro  = [0, 1, 2, 3, 4,6];

start = 'Insert Into ' + tableName + '( ' +  ', '.join(column) + ') VALUES '

startTimeIndex = 2;
endTimeIndex = 3;
for line in f:    
	line = line.strip()
	
	arrayOfColumn =  line.split(',');
	arrayOfColumn[startTimeIndex] = arrayOfColumn[startTimeIndex][:-2] + ':' + arrayOfColumn[startTimeIndex][-2:];
	arrayOfColumn[endTimeIndex] = arrayOfColumn[endTimeIndex][:-2] + ':' + arrayOfColumn[endTimeIndex][-2:];
	
	for value in appro:
		arrayOfColumn[value] =  "'" + arrayOfColumn[value].strip() + "'";

		
	line =  '(' + ','.join(arrayOfColumn) + ');';
	
	print start + line;
	