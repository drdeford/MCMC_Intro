
	scrabble_bag = ['a','a','a','a','a','a','a','a','a','b','b','c','c','d','d','d','d','e','e','e','e','e','e','e','e','e','e','e','e','f','f','g','g','g','h','h','i','i','i','i','i','i','i','i','i','j','k','l','l','l','l','m','m','n','n','n','n','n','n','o','o','o','o','o','o','o','o','p','p','q','r','r','r','r','r','r','s','s','s','s','t','t','t','t','t','t','u','u','u','u','v','v','w','w','x','y','y','z',' ',' ']

	scrabble_points = {' ':0,'a':1,'b':3,'c':3,'d':2,'e':1,'f':4,'g':2,'h':4,'i':1,'j':8,'k':5,'l':1,'m':3,'n':1,'o':1,'p':3,'q':10,'r':1,'s':1,'t':1,'u':1,'v':4,'w':4,'x':8,'y':4,'z':10 }
	scrabble_count = {' ':2,'a':9,'b':2,'c':2,'d':4,'e':12,'f':2,'g':3,'h':2,'i':9,'j':1,'k':1,'l':4,'m':2,'n':6,'o':8,'p':2,'q':1,
			  'r':6,'s':4,'t':6,'u':4,'v':2,'w':2,'x':1,'y':2,'z':1 }

	alphabet=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' ']
	key1 ={'q':['w','a'],'w':['e','a','s'],'e':['r','s','d'],'r':['t','d','f'],'t':['y','f','g'],'y':['u','g','h'],'u':['i','h','j'],'i':['o','j','k'],'o':['p','k','l'],
	'p':['l'],'a':['s','z'],'s':['d','z','x'],'d':['f','x','c'],'f':['g','c','v'],'g':['h','v','b'],'h':['j','b','n'],'j':['k','n','m'],'k':['l','m'],'z':['x'],'x':['c'],'c':['v',' '],'v':['b',' '],'b':['n',' '],'n':['m',' '],'m':[' ']}
	cyclic = {alphabet[x]:[alphabet[(x+1)%27]] for x in range(27)}
	g=Graph(cyclic)
	h=Graph(key1)
    
	M=h.adjacency_matrix()
	print(M[0])
	print(sum(M[0]))
    
	N=[]
   
	for le in range(27):
		N.append([])
		for new in range(27):        
			N[le].append( M[le][new]/float(sum(M[le])))
            
	N=[]
    
	for le in range(27):
		N.append([])
		for new in range(27):
			if h.has_edge((alphabet[le],alphabet[new])): 
				N[le].append(1/float(len(h.neighbors(alphabet[le]))))
			else:
				N[le].append(0)
        
        
        
	print(N)    
	import pylab
	pylab.imshow(N,cmap='jet')
	#matrix_plot(M)
	ax = plt.gca()
	ax.set_xticks(range(len(alphabet)))
	ax.set_xticklabels(alphabet)
	ax.set_yticks(range(len(alphabet)))
	ax.set_yticklabels(alphabet)  
	plt.show()
