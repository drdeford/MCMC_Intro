from matplotlib import pyplot as plt
@interact
def scrabble_expected( num_draws = input_box(default=1000,label='Number of Draws (with replacement): '),auto_update=False):
    
    scrabble_bag = ['a','a','a','a','a','a','a','a','a','b','b','c','c','d','d','d','d','e','e','e','e','e','e','e','e','e','e','e','e','f','f','g','g','g','h','h','i','i','i','i','i','i','i','i','i','j','k','l','l','l','l','m','m','n','n','n','n','n','n','o','o','o','o','o','o','o','o','p','p','q','r','r','r','r','r','r','s','s','s','s','t','t','t','t','t','t','u','u','u','u','v','v','w','w','x','y','y','z',' ',' ']
    alphabet=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' ']

    scrabble_points = {' ':0,'a':1,'b':3,'c':3,'d':2,'e':1,'f':4,'g':2,'h':4,'i':1,'j':8,'k':5,'l':1,'m':3,'n':1,'o':1,'p':3,'q':10,'r':1,'s':1,'t':1,'u':1,'v':4,'w':4,'x':8,'y':4,'z':10  }
    vals = []
    sums = [0]
    means = []
    error = []
    letters=[]
    
    expected = mean([scrabble_points[x] for x in scrabble_bag])
    
    for i in range(num_draws):
        newl = choice(scrabble_bag)
        letters.append(newl)
        vals.append(scrabble_points[newl])
        sums.append(sums[-1]+vals[-1])
        means.append(sums[-1]/(i+1))
        error.append(expected - means[-1])
        

    
    plt.figure()
    plt.plot(vals, 'o', markersize=2)
    plt.title('Draw Values')
    plt.xlabel('Roll #')
    
    plt.show()
    
    plt.figure()
    
    plt.plot(means,'o', markersize=2)
    plt.axhline(y=expected,color='r')
    plt.title('Average of Tile Points')
    plt.show()
    
    plt.figure()
    
    plt.plot(error,'o', markersize=2)
    plt.axhline(y=0,color='r')
    plt.title('Error: Expected - Empirical')
    plt.show()
    
    plt.figure()
    plt.bar(range(11), [float(vals.count(x))/num_draws for x in range(11)])
    plt.title('Tile Score Distribution')
    ax = plt.gca()
    ax.set_xticks(range(11))
    ax.set_xticklabels(range(11))
    plt.xlabel('Letter')
    plt.ylabel('Frequency')
    plt.show()
    
    plt.figure()
    plt.bar(range(len(alphabet)), [float(letters.count(x))/num_draws for x in alphabet])
    plt.title('Scrabble Score Distribution')
    ax = plt.gca()
    ax.set_xticks(range(len(alphabet)))
    ax.set_xticklabels(alphabet)
    plt.xlabel('Letter')
    plt.ylabel('Frequency')
    plt.show()


    
    
    pretty_print('Final estimate: ', means[-1].n())
    pretty_print('Actual expected value: ', expected.n())
    pretty_print('Error: ', error[-1].n())
