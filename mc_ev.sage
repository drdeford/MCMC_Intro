from matplotlib import pyplot as plt
from operator import lt

@interact
def scrabble_expected(start_word = input_box(default=['a'],label = 'Initial letter: '), 
letter_walk = selector(['Keyboard','Cycle', 'Path' ], label = 'Walk on Individual Letters: '), score_fn = selector(['Scrabble Score','Alphabetical (a=1, etc.)', 'Scrabble Count', 'Uniform', '# Vowels'], label = "Score function on letters:"), num_steps = input_box(default=10,label='Number of Steps: '),
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
    
	vals =[scores[start_word[0]]]
	sums=[scores[start_word[0]]]
	ses=[start_word[0]]
	means=[scores[start_word[0]]]
	target = sum([proposal_vec[x]*scores[alphabet[x]] for x in range(27)])

	error=[scores[start_word[0]]-target]
    
	proposal_vec = [float(proposal_vec[alpha_pos[x]])/proposal_sum for x in alphabet]
    
	emp_vec = [0 for x in alphabet]
	q_vec = [0 for x in alphabet]
    
    
	for l in range(letters):
		emp_vec[alpha_pos[state[l]]]+=1
	
	state=[start_word[0]]
    
	for z in range(num_steps):
			
		k = choice(range(letters))
		old_state = state[k]
		if bvg == 1:
		
			new_state = choice(bag)
            
		elif bvg == 0:
		
			new_state = choice(graph.neighbors(old_state))

		state[k] = new_state
		vals.append(scores[new_state])
		sums.append(sums[-1]+vals[-1])
		means.append(sums[-1]/(z+2))
		error.append(means[-1]-target)
		#ses.append(state[k])
        
        
	#print(ses)
	#print(len(vals))
	plt.figure()
	plt.plot(vals, 'o',markersize=1)
	plt.title('Sample Values')
	plt.xlabel('Step #')
    
	plt.show()
    
	plt.figure()
    
	plt.plot(means,'o',markersize=2)
	plt.axhline(y=target,color='r')
	plt.title('Average of Samples')
	plt.show()
    
	plt.figure()
    
	plt.plot(error,'o',markersize=2)
	plt.axhline(y=0,color='r')
	plt.title('Error: Expected - Empirical')
	plt.show()
        
	plt.figure()		
	pretty_print('Final estimate: ', means[-1].n())
	pretty_print('Actual expected value: ', target)
	pretty_print('Error: ', error[-1])					
