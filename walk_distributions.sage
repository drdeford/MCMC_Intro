from matplotlib import pyplot as plt
from operator import lt

@interact
def scrabble_expected(start_word = input_box(default=['a'],label = 'Initial letter: '), 
letter_walk = selector(['Keyboard','Cycle', 'Path' ], label = 'Walk on Individual Letters: '), num_steps = input_box(default=10,label='Number of Steps: '),
disp = input_box(default = 10, label ='Number of states to display: '), auto_update=False):

	scrabble_bag = ['a','a','a','a','a','a','a','a','a','b','b','c','c','d','d','d','d','e','e','e','e','e','e','e','e','e','e','e','e','f','f','g','g','g','h','h','i','i','i','i','i','i','i','i','i','j','k','l','l','l','l','m','m','n','n','n','n','n','n','o','o','o','o','o','o','o','o','p','p','q','r','r','r','r','r','r','s','s','s','s','t','t','t','t','t','t','u','u','u','u','v','v','w','w','x','y','y','z',' ',' ']

	scrabble_points = {' ':0,'a':1,'b':3,'c':3,'d':2,'e':1,'f':4,'g':2,'h':4,'i':1,'j':8,'k':5,'l':1,'m':3,'n':1,'o':1,'p':3,'q':10,'r':1,'s':1,'t':1,'u':1,'v':4,'w':4,'x':8,'y':4,'z':10 }
	scrabble_count = {' ':2,'a':9,'b':2,'c':2,'d':4,'e':12,'f':2,'g':3,'h':2,'i':9,'j':1,'k':1,'l':4,'m':2,'n':6,'o':8,'p':2,'q':1,
			  'r':6,'s':4,'t':6,'u':4,'v':2,'w':2,'x':1,'y':2,'z':1 }

	alphabet=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' ']
	key1 ={'q':['w','a'],'w':['e','a','s'],'e':['r','s','d'],'r':['t','d','f'],'t':['y','f','g'],'y':['u','g','h'],'u':['i','h','j'],'i':['o','j','k'],'o':['p','k','l'],
	'p':['l'],'a':['s','z'],'s':['d','z','x'],'d':['f','x','c'],'f':['g','c','v'],'g':['h','v','b'],'h':['j','b','n'],'j':['k','n','m'],'k':['l','m'],'z':['x'],'x':['c'],'c':['v',' '],'v':['b',' '],'b':['n',' '],'n':['m',' '],'m':[' ']}
	cyclic = {alphabet[x]:[alphabet[(x+1)%27]] for x in range(27)}
	pathic = {alphabet[x]:[alphabet[x+1]] for x in range(26)}
	g2=Graph(pathic)
	g=Graph(cyclic)
	h=Graph(key1)
	
	
	
	if letter_walk == 'Cycle':
		graph = g
		bag = alphabet
		bvg = 0

	elif letter_walk == 'Path':
		graph = g2
		bag = alphabet
		bag = bag + bag
		bag.pop(0)
		bag.pop(-1)
		bvg = 0
		
	elif letter_walk == 'Keyboard':
		graph = h
		bag = []
		for e in graph.edges():
			bag.append(e[0])
			bag.append(e[1])
		bvg = 0 
	alpha_pos = {alphabet[x]:x for x in range(len(alphabet))}

	N=[]
    
	for le in range(27):
		N.append([])
		for new in range(27):
			if graph.has_edge((alphabet[le],alphabet[new])): 
				N[le].append(1/float(len(graph.neighbors(alphabet[le]))))
			else:
				N[le].append(float(0))
                
	N=Matrix(N)
    
	init_vec =[float(0) for x in alphabet]
	init_vec[alpha_pos[start_word[0]]]=float(1)
    
	vtp = matrix(RR,num_steps,27)
	vtp[0,:] = matrix(init_vec)
    
	#print(vtp)
    
	for z in range(num_steps-1):
		vtp[z+1,:]=vtp[z,:]* N
        
	import pylab
	#print(vtp)
	pylab.imshow(vtp[1:,:],cmap='jet', aspect='auto')#,origin='lower',colorbar=True, colorbar_orientation='vertical')
	#pylab.imshow(N,cmap='jet')
	#matrix_plot(vtp[1:,:],cmap='jet',origin='lower',colorbar=True, colorbar_orientation='vertical',figsize=8)
	ax = plt.gca()
	ax.set_xticks(range(len(alphabet)))
	ax.set_xticklabels(alphabet)
	#ax.set_yticks(range(len(alphabet)))
	#ax.set_yticklabels(alphabet)  
	plt.show()    
