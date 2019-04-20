@interact
def war(n=input_box(label='Number of deals: ',default=1000),cards=input_box(label='Number of cards to win: ',default=3), deck=input_box(label='Size of deck: ',default=52),auto_update=False):	

	wins=0
	winp=[]

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
		winp.append(wins/(i+1))
               
	list_plot(winp).show()
	pretty_print('Current Win Percentage:', (wins/n).n())
