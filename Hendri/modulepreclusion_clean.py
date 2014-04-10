f = open('modulePreclusion_Clean.txt');


modulesID = []
duplicateID = False;
moduleCodes = [];
for line in f:    
	if line == "":
		continue
	line = line.strip()
	arrayOfColumn =  line.split(',');
		
	if "/" in arrayOfColumn[0]:
		modulesID = arrayOfColumn[0].split("/")
		duplicateID = True;
		
	if duplicateID:
		duplicateID = False;
		for str in modulesID:
			arrayOfColumn[0] =  str.strip()					
			print ', '.join(arrayOfColumn);
			
	else:
		print line;