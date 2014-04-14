# coding=utf-8
import json
import MySQLdb

f = open('mod_info_sem1.json', 'r')
f1 = open('mod_info_sem2.json', 'r')
data1 = json.load(f)
data2 = json.load(f1)

tableName ='ModuleInformation'
column = ['ModuleCode', 'ModuleName', 'ModuleDepartment', 'ModuleCredit','ModuleLevel'];

start = 'Insert Into ' + tableName + '( ' +  ', '.join(column) + ') VALUES '


def printsql(data):
	data = data['cors']
	for name in data:	
		
		item = data[name]
		ModuleCodeList = item[u'label'].split("/")
		
		for ModuleCode in ModuleCodeList:
		
			ArrayList = []
			
			ArrayList.append("'" + ModuleCode.strip() +"'");		
			
			ArrayList.append("'" + item[u'title'].replace(u"–", "-").replace("'", "''").replace(u"‘", "''").replace(u"’", "''") +"'");			
			
			ArrayList.append("'" + item[u'department'].replace("'", "''").replace(u"‘", "''").replace(u"’", "''") +"'");			
			ArrayList.append(item['mcs']);			
			
			for char in ModuleCode:
				if char in "123456789":
					ArrayList.append(char)
					break;
			
			
			print start +  "(" + ', '.join(ArrayList) + "); "

		
printsql(data1)
printsql(data2)
