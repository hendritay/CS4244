import json

f = open('examTimetableRaw.json', 'r')
data = json.load(f)

tableName ='moduleexam'
column = ['ModuleCode', 'ExamDate', 'ExamTime']

start = 'Insert Into ' + tableName + '( ' +  ', '.join(column) + ') VALUES '


for item in data:	

	ModuleCodeList = item[u'Code'].split("/")
	
	for ModuleCode in ModuleCodeList:
	
		ArrayList = []
		
		ArrayList.append("'" + ModuleCode.strip() +"'");		
	
		ArrayList.append("'" + item[u'Date'][:-6] +"'");					
		ArrayList.append("'" + item[u'Time'] +"'");					
		
		
		
		print start +  "(" + ', '.join(ArrayList) + "); "
