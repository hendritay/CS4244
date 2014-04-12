f = open('modulerequisite_done.txt');

f1 = open('modulerequisite_done_1.txt', 'w');
f2 = open('modulerequisite_done_2.txt', 'w');
f3 = open('modulerequisite_done_3.txt', 'w');
f4 = open('modulerequisite_done_4.txt', 'w');
fother = open('modulerequisite_done_other.txt', 'w');

for line in f:    
	if line.strip() == "":
		continue
	arrayOfColumn = line.split(",");
	
	if len(arrayOfColumn) == 2:
		rightSide = arrayOfColumn[1].strip().replace("OR", "or")
		
		if " " not in  rightSide and "/" not in rightSide:
			''' Single module only 
			'''			
			f1.write(line) 				
		elif "and" not in rightSide and "&" not in rightSide:
			f1.write(line.replace("or", ", ").replace("/", ", "))
		elif "and" in rightSide and "or" not in rightSide and "/" not in rightSide:		   
			
			for str in rightSide.split("and"):
				f1.write(arrayOfColumn[0] +", " + str.strip())
				f1.write("\n")
			
		else:
			f4.write(line);
			
		continue
	
	
	fother.write(line)

		