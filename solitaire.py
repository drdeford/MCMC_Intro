import matplotlib.pyplot as plt
@interact
def war(n=input_box(label='Number of deals: ',default=1000),cards=input_box(label='Number of cards to win: ',default=3), deck=input_box(label='Size of deck: ',default=52),auto_update=False):	

	wins=0
	winp=[]
	game=[]

	for i in range(n):
		#print(i)
		D=list(Permutations(deck).random_element())
		a=D[:cards]
		b=a[:]
		a.sort()
		#print(i)
		if b==a:
			#print('yay')
			wins+=1
			game.append(1)
		else:
			game.append(0)
		winp.append(wins/(i+1))
               
	list_plot(winp).show()
	plt.figure()
	ax = plt.gca()
	ax.set_yticks([0,1])
	ax.set_yticklabels([':(',':)'])
	plt.plot(game,'o',markersize=2)
	plt.title('Win?')
	plt.xlabel('Game #')
    
	plt.show()
	pretty_print('Current Win Percentage:', (wins/n).n())
