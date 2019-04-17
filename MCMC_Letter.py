from matplotlib import pyplot as plt

@interact
def scrabble_expected(start_word = input_box(default=['a'],label = 'Initial letter: '), 
letter_walk = selector(['Scrabble','Uniform','Keyboard','Cycle' ], label = 'Walk on Individual Letters: '), 
score_fn = selector(['Scrabble Score','Alphabetical (a=1, etc.)', 'Scrabble Count', 'Uniform', '# Vowels'], label = "Score function on letters:"), num_steps = input_box(default=1000,label='Number of Steps: '),
disp = input_box(default = 10, label ='Number of states to display: '), auto_update=False):

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
		
	elif letter_walk == 'Keyboard':
		graph = h
		bag = []
		for e in graph.edges():
			bag.append(e[0])
			bag.append(e[1])
		bvg = 0 
	
	if score_fn == 'Scrabble Score':
		scores = scrabble_points
		
	if score_fn == 'Scrabble Count':
		scores = scrabble_count

	if score_fn == 'Uniform':
		scores = {x:1 for x in alphabet}
		
	if score_fn == '# Vowels':
		scores = {x:1 for x in alphabet}
		scores['a'] = 100
		scores['e'] = 100
		scores['i'] = 100
		scores['o'] = 100
		scores['u'] = 100
		scores['y'] = 50
		
	
		
	if score_fn == 'Alphabetical (a=1, etc.)':
		scores = {alphabet[i]: i+1 for i in range(27)}
		
	vals = [ ]
	sums = [0]
	means = []
	error = []
	tvt=[]
	tvp=[]
	evt=[]
	evp=[]
    
		

	
    
	state = start_word
	
	letters = len(state)
	
	#expected = letters * mean([scores[x] for x in bag])
	#print(expected)

	alpha_pos = {alphabet[x]:x for x in range(len(alphabet))}

	proposal_vec = [bag.count(x) for x in alphabet]
	#print(alpha_pos)
	proposal_sum = sum(proposal_vec)
    
	proposal_vec = [float(proposal_vec[alpha_pos[x]])/proposal_sum for x in alphabet]
	#print(proposal_vec)	
	target_vec = [scores[x] for x in alphabet]
    
	target_sum = sum(target_vec)
	
	target_vec = [float(target_vec[alpha_pos[x]])/target_sum for x in alphabet]
    
	emp_vec = [0 for x in alphabet]
	q_vec = [0 for x in alphabet]
    
    
	evts = sum(scores[x]*target_vec[alpha_pos[x]] for x in alphabet)
	evps = sum(scores[x]*proposal_vec[alpha_pos[x]] for x in alphabet)
    
	#print(evts)
	#print(evps)
	for l in range(letters):
		emp_vec[alpha_pos[state[l]]]+=1
    
	for z in range(num_steps):
	
		k = choice(range(letters))
		old_state = state[k]
		if bvg == 1:
		
			new_state = choice(bag)
            
			for l in range(1):
				q_vec[alpha_pos[new_state]]+=1
            
			
			q = min(1,(float(scores[new_state])/float(scores[old_state]))*(float(bag.count(old_state))/float(bag.count(new_state))))
			#print(old_state,new_state,q,scores[new_state],scores[old_state],bag.count(old_state),bag.count(new_state))
			
				
				
			#print(state)
			#print(vals[-1])
		elif bvg == 0:
		
			new_state = choice(graph.neighbors(old_state))
            
			for l in range(1):
				q_vec[alpha_pos[new_state]]+=1

			
			q = min(1, (float(scores[new_state])/float(scores[old_state]))*((1/float(len(graph.neighbors(new_state)))/(1/float(len(graph.neighbors(old_state)))))))

		
		alpha = random()
		if alpha < q:
			state[k] = new_state
		
					
		if z %int(num_steps/disp) == 0:
			print(state)
	    
        
		for l in range(letters):
			emp_vec[alpha_pos[state[l]]]+=1
            
		emp_s = sum(emp_vec)
		emp_n = [float(emp_vec[alpha_pos[x]])/emp_s for x in alphabet]
        
		tvt.append(sum([abs(emp_n[x]-target_vec[x]) for x in range(len(alphabet))]))
		tvp.append(sum([abs(emp_n[x]-proposal_vec[x]) for x in range(len(alphabet))]))
        
		val = sum([scores[state[i]] for i in range(letters)])
        
		#print(val)
		#evt.append(evts - val) #sum(scores[x]*emp_n[alpha_pos[x]] for x in alphabet))
		#evp.append(evps - val) #sum(scores[x]*emp_n[alpha_pos[x]] for x in alphabet))
		#print(evt)
            
            
		vals.append(val)

		sums.append(sums[-1]+vals[-1])
		#print(sums)
		means.append(sums[-1]/((z+1)))
		#print(means)
		#error.append(expected - means[-1])
		evt.append(evts - means[-1]) #sum(scores[x]*emp_n[alpha_pos[x]] for x in alphabet))
		evp.append(evps - means[-1]) #sum(scores[x]*emp_n[alpha_pos[x]] for x in alphabet))
        

	#print(proposal_vec)
	#print(target_vec)
	#print(emp_n)
	plt.figure()
	plt.bar(range(len(alphabet)),proposal_vec)
	plt.title('Proposal Distribution')
	plt.xlabel('Letter')
	plt.ylabel('Frequency')
    
	plt.show()
    
	plt.figure()
	plt.bar(range(len(alphabet)),target_vec)
	plt.title('Target Distribution')
	plt.xlabel('Letter')
	plt.ylabel('Frequency')
    
	plt.show()
    
	q_s = sum(q_vec)
    
	q_n = [q_vec[alpha_pos[x]]/q_s for x in alphabet]

	plt.figure()
	plt.bar(range(len(alphabet)),q_n)
	plt.title('Proposed Distribution')
	plt.xlabel('Letter')
	plt.ylabel('Frequency')
    
	plt.show()
	plt.figure()
	plt.bar(range(len(alphabet)),emp_n)
	plt.title('MCMC Distribution')
	plt.xlabel('Letter')
	plt.ylabel('Frequency')
    
	plt.show()

	plt.figure()
    
	plt.plot(tvp,'o',markersize=3,color='blue',label='Proposal')
	plt.plot(tvt,'o',markersize=3,color='green', label="Target")
	plt.axhline(y=0,color='r')
	plt.axhline(y=sum([abs(target_vec[x]-proposal_vec[x]) for x in range(len(alphabet))]),color='y')

	plt.title('Total Variation Distance')
	plt.legend()
	plt.show()
    
	#print(evp)

	plt.figure()
    
	#plt.plot(evp,'o',markersize=3,color='blue',label='Proposal')
	plt.plot(evt,'o',markersize=3,color='green', label="Target")
	plt.axhline(y=0,color='r')
	plt.title('Expected Value Distance')
	plt.legend()
	plt.show()

	#plt.figure()
	#plt.plot(vals,'o',markersize=3,color='red',label='Proposal')
	#plt.axhline(y=evps,color='blue',label='Proposal')
	#plt.axhline(y=evts,color='green',label='Target')
	#plt.title('Expected Score Comparison')
	#plt.legend()
	#plt.show()    

	#plt.figure()
    
	#plt.plot(error,'o',markersize=3)
	#plt.axhline(y=0,color='r')
	#plt.title('Error: Expected - Empirical')
	#plt.show()
    
    
	#pretty_print('Final estimate: ', means[-1].n())
	#pretty_print('Actual expected value: ', expected.n())
	#pretty_print('Error: ', error[-1].n()) 
    
    
	plt.figure()
	plt.plot(vals, 'o',markersize=2)
	plt.title('Observed Values')
	plt.xlabel('Step #')
    
	plt.show()
