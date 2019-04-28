    
	g.show()
	g2.show()    
    
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
    
    
    
	vskdvh
