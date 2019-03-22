alphabet=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' ']
key1 ={'q':['w','a'],'w':['e','a','s'],'e':['r','s','d'],'r':['t','d','f'],'t':['y','f','g'],'y':['u','g','h'],'u':['i','h','j'],'i':['o','j','k'],'o':['p','k','l'],
'p':['l'],'a':['s','z'],'s':['d','z','x'],'d':['f','x','c'],'f':['g','c','v'],'g':['h','v','b'],'h':['j','b','n'],'j':['k','n','m'],'k':['l','m'],'z':['x'],'x':['c'],'c':['v',' '],'v':['b',' '],'b':['n',' '],'n':['m',' '],'m':[' ']}
cyclic = {alphabet[x]:[alphabet[(x+1)%27]] for x in range(27)}
g=Graph(cyclic)
g.plot(layout='circular')
h=Graph(key1)
h.plot()
