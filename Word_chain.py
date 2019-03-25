from matplotlib import pyplot as plt

@interact
def scrabble_expected(start_word = input_box(default=['a','a','a','a','a'],label = 'Initial word: '), 
let_step = slider([1..10],label="Letters to change per step: "),
letter_walk = selector(['Scrabble','Uniform','Keyboard','Cycle' ], label = 'Walk on Individual Letters: '), 
score_fn = selector(['Scrabble','Alphabetical (a=1, etc.)'], label = "Score function on letters:"), num_steps = input_box(default=100,label='Number of Steps: '),auto_update=False):

	scrabble_bag = ['a','a','a','a','a','a','a','a','a','b','b','c','c','d','d','d','d','e','e','e','e','e','e','e','e','e','e','e','e','f','f','g','g','g','h','h','i','i','i','i','i','i','i','i','i','j','k','l','l','l','l','m','m','n','n','n','n','n','n','o','o','o','o','o','o','o','o','p','p','q','r','r','r','r','r','r','s','s','s','s','t','t','t','t','t','t','u','u','u','u','v','v','w','w','x','y','y','z',' ',' ']

	scrabble_points = {' ':0,'a':1,'b':3,'c':3,'d':2,'e':1,'f':4,'g':2,'h':4,'i':1,'j':8,'k':5,'l':1,'m':3,'n':1,'o':1,'p':3,'q':10,'r':1,'s':1,'t':1,'u':1,'v':4,'w':4,'x':8,'y':4,'z':10 }
	
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
	
	if score_fn == 'Scrabble':
		scores = scrabble_points
		
	if score_fn == 'Alphabetical (a=1, etc.)':
		scores = {alphabet[i]: i for i in range(27)}
		
	vals = [ ]
	sums = [0]
	means = []
	error = []
    
	
	
	
    
	state = start_word
	
	letters = len(state)
	
	expected = letters * mean([scores[x] for x in bag])
	print(expected)
	
	
	for z in range(num_steps):
		if bvg == 1:
			
			for j in range(let_step):
				state[choice(range(letters))] = choice(bag)
						
			vals.append(sum([scores[state[i]] for i in range(letters)]))
			#print(state)
			#print(vals[-1])
		elif bvg == 0:
			for j in range(let_step):
				k=choice(range(letters))
				state[k]=choice(graph.neighbors(state[k]))
				
			vals.append(sum([scores[state[i]] for i in range(letters)]))
	
	
	
	
		sums.append(sums[-1]+vals[-1])
		#print(sums)
		means.append(sums[-1]/((z+1)))
		#print(means)
		error.append(expected - means[-1])
        

    
	plt.figure()
	plt.plot(vals, 'o')
	plt.title('Draw Values')
	plt.xlabel('Roll #')
    
	plt.show()
    
	plt.figure()
    
	plt.plot(means,'o')
	plt.axhline(y=expected,color='r')
	plt.title('Average of Tile Points')
	plt.show()

	plt.figure()
    
	plt.plot(error,'o')
	plt.axhline(y=0,color='r')
	plt.title('Error: Expected - Empirical')
	plt.show()
    
    
	pretty_print('Final estimate: ', means[-1].n())
	pretty_print('Actual expected value: ', expected.n())
	pretty_print('Error: ', error[-1].n())	
		
	