f = open('01_preclude_tobeprocess.txt');

for line in f:    
	if line.strip() == "":
		continue
	a = line.split(",")
	
	print "'" +  a[0] + "', "
