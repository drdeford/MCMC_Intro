from matplotlib import pyplot as plt

@interact
def graph_samples(start_word = input_box(default=['a'],label = 'Initial letter: '), 
letter_walk = selector(['Scrabble','Uniform','Keyboard','Cycle','Path' ], label = 'Walk on Individual Letters: '), num_steps = input_box(default=10,label='Number of Steps: '),num_trials = input_box(default=100,label='Number of Trials: '),
 auto_update=False):

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
	
	
	
	if letter_walk == 'Scrabble':
		bag = scrabble_bag
		bvg = 1
		
	elif letter_walk == 'Uniform':
		bag = alphabet
		bvg = 1
		
	elif letter_walk == 'Cycle':
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
			
	
		
	vals = [ ]
	sums = [0]
	means = []
	error = []
	tvt=[]
	tvp=[]
	evt=[]
	evp=[]
	accepts=[]
    
		

	
    
	state = start_word[0]
	
	letters = 1
	
	#expected = letters * mean([scores[x] for x in bag])
	#print(expected)

	alpha_pos = {alphabet[x]:x for x in range(len(alphabet))}

	proposal_vec = [bag.count(x) for x in alphabet]
	#print(alpha_pos)
	proposal_sum = sum(proposal_vec)
    
	proposal_vec = [float(proposal_vec[alpha_pos[x]])/proposal_sum for x in alphabet]
    
	emp_vec = [0 for x in alphabet]
	q_vec = [0 for x in alphabet]
    
    
	for l in range(letters):
		emp_vec[alpha_pos[state[l]]]+=1
    
	for z in range(num_trials):
		state=[start_word[0]]
		#print('start',start_word)
		#print('start',state)

		ll=[state[0]]
		for y in range(num_steps):
			
			k = choice(range(letters))
			old_state = state[k]
			if bvg == 1:
		
				new_state = choice(bag)
            
			elif bvg == 0:
		
				new_state = choice(graph.neighbors(old_state))

			state[k] = new_state
			ll.append(new_state)
		
					
		#print(ll)
        
		for l in range(letters):
			emp_vec[alpha_pos[state[l]]]+=1
            
		emp_s = sum(emp_vec)
		emp_n = [float(emp_vec[alpha_pos[x]])/emp_s for x in alphabet]
        
        
            
                    

	#print(proposal_vec)
	#print(target_vec)
	#print(emp_n)
	plt.figure()
	plt.bar(range(len(alphabet)),proposal_vec)
	plt.title('Long Term Distribution')
	ax = plt.gca()
	ax.set_xticks(range(len(alphabet)))
	ax.set_xticklabels(alphabet)
	plt.xlabel('Letter')
	plt.ylabel('Frequency')
        
    
	plt.show()
	plt.figure()
	plt.bar(range(len(alphabet)),emp_n)
	ax = plt.gca()
	ax.set_xticks(range(len(alphabet)))
	ax.set_xticklabels(alphabet)
	plt.title('Empirical Distribution')
	plt.xlabel('Letter')
	plt.ylabel('Frequency')
    
	plt.show()
