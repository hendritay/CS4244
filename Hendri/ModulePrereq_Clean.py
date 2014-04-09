f = open('modulePrereq.txt');
f1 = open('modulePrereq_Clean.txt', 'w');

for line in f:    
	line = line.strip()
	if  not (line[-3:].upper() == 'NIL' or line[-2:].upper() == 'NA' or  line[-4:].upper() == 'NONE'):
		
		f1.write(line);
		f1.write('\n');
		

f1.close();
f.close();
	
f = open('modulePreclusion.txt');
f1 = open('modulePreclusion_Clean.txt', 'w');

for line in f:    
	line = line.strip()
	if  not (line[-3:].upper() == 'NIL' or line[-2:].upper() == 'NA' or  line[-4:].upper() == 'NONE'):
		f1.write(line);
		f1.write('\n');
		

f1.close();
f.close();
	