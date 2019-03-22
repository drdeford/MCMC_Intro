h.graphplot(save_pos=True)
z=h.get_pos()
anim=[]
vcolors={'green':['a'],'orange':[x for x in h.vertices() if x != 'a']}
ecolors={'blue':list(h.edges()),'green':[]}

state='a'

anim.append(h.plot(pos=z,vertex_colors=vcolors,edge_colors = ecolors))
for i in range(100): 
    new = choice(h.neighbors(state))
    if (state,new,None) in h.edges():
        ecolors['green'] = [(state,new,None)]
        ecolors['blue'].remove((state,new,None))
        
    else:
        ecolors['green'] = [(new,state,None)]
        ecolors['blue'].remove((new,state,None))
        
        
    anim.append(h.plot(pos=z,vertex_colors=vcolors,edge_colors = ecolors))
    
    vcolors['green']=[new]
    vcolors['orange'].remove(new)
    vcolors['orange'].append(state)
    
    anim.append(h.plot(pos=z,vertex_colors=vcolors,edge_colors = ecolors))
    
    ecolors['green'] = []
    ecolors['blue'] = h.edges()
    
    anim.append(h.plot(pos=z,vertex_colors=vcolors,edge_colors = ecolors))
    
    state = new
    
    
        

final=animate(anim)

final.show(delay=20)    
        
