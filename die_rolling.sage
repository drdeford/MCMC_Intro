from collections import Counter
from matplotlib import pyplot as plt

@interact
def dice_distribution(faces=input_box([1,2,3,4,5,6],label='Faces: '), num_rolls = input_box(default=1000,label='Number of Rolls: '),auto_update=False):
    vals = []
    for i in range(num_rolls):
        vals.append(choice(faces))
        
    original = Counter(faces)
    oL = list(original)
    oL.sort() 
    empirical = Counter(vals)  
    eL = list(empirical)
    eL.sort()
    plt.figure()
    
    plt.bar(range(len(oL)), [original[x] for x in oL], align = 'center')
    plt.xticks(range(len(oL)), oL)
    plt.ylabel('Frequency')
    plt.title('Actual Dice Distribution')
    plt.show()
    
    plt.figure()
    
    plt.bar(range(len(eL)), [empirical[x] for x in eL], align = 'center')
    plt.xticks(range(len(eL)), eL)
    plt.ylabel('Frequency')
    plt.title('Empirical Dice Distribution')
    plt.show()

    
    plt.show()
    
    pretty_print('Roll values: ', vals)
    
scrabble_bag = ['a','a','a','a','a','a','a','a','a','b','b','c','c','d','d','d','d','e','e','e','e','e','e','e','e','e','e','e','e','f','f','g','g','g','h','h','i','i','i','i','i','i','i','i','i','j','k','l','l','l','l','m','m','n','n','n','n','n','n','o','o','o','o','o','o','o','o','p','p','q','r','r','r','r','r','r','s','s','s','s','t','t','t','t','t','t','u','u','u','u','v','v','w','w','x','y','y','z',' ',' ']

scrabble_points = {' ':0,'a':1,'b':3,'c':3,'d':2,'e':1,'f':4,'g':2,'h':4,'i':1,'j':8,'k':5,'l':1,'m':3,'n':1,'o':1,'p':3,'q':10,'r':1,'s':1,'t':1,'u':1,'v':4,'w':4,'x':8,'y':4,'z':10  }
