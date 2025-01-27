import json

f = open('corsRaw.json', 'r')
data = json.load(f)

tableName ='ModuleTime'
column = ['ModuleCode', 'Day', 'StartTime', 'EndTime', 'Venue', 'Semester',  'ModuleOption', 'LectureType'];
appro  = [0, 1, 2, 3, 4,6];

start = 'Insert Into ' + tableName + '( ' +  ', '.join(column) + ') VALUES '

LectureTypeDict = {};
for item in data:
	time = item[u'Timetable']
	for element in time:
		LectureTypeDict[element[u'LessonType']] = 1

Allowed =['SECTIONAL TEACHING', 'SEMINAR-STYLE MODULE CLASS', 'PACKAGED LECTURE', 'DESIGN LECTURE', 'LECTURE']

for item in data:
	time = item[u'Timetable']
	for element in time:
		
		LessonType = element[u'LessonType'];
		ModuleCodeList = item[u'ModuleCode'].split("/")
		for ModuleCode in ModuleCodeList:
			if LessonType in Allowed:
				ArrayList = []
				
				ArrayList.append("'" + ModuleCode.strip() +"'");		
				ArrayList.append("'" + element[u'DayText'] +"'");
				
				StartTime = element[u'StartTime'];
				StartTime = StartTime[:-2]+ ':' +StartTime[-2:]
				EndTime = element[u'EndTime'];
				EndTime = EndTime[:-2] +':' +EndTime[-2:]
				
				ArrayList.append("'" + StartTime +"'");
				ArrayList.append("'" + EndTime +"'");
				ArrayList.append("'" + element[u'Venue'] +"'");
				
				ArrayList.append('2');
				ArrayList.append("'" + element[u'ClassNo'] +"'");
				ArrayList.append("'" + LessonType +"'");
				
				print start +  "(" + ', '.join(ArrayList) + "); "
		