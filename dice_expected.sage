from matplotlib import pyplot as plt
from collections import Counter

@interact
def dice_expected(faces=input_box([1,2,3,4,5,6],label='Faces: '), num_rolls = input_box(default=1000,label='Number of Rolls: '),auto_update=False):
    vals = []
    sums = [0]
    means = []
    error = []
    expected = mean(faces)
    for i in range(num_rolls):
        vals.append(choice(faces))
        sums.append(sums[-1]+vals[-1])
        means.append(sums[-1]/(i+1))
        error.append(expected - means[-1])
        
    empirical = Counter(vals)  
    eL = list(empirical)
    eL.sort()

    
    plt.figure()
    plt.plot(vals, 'o',markersize=1)
    plt.title('Roll Values')
    plt.xlabel('Roll #')
    
    plt.show()
    
    plt.figure()
    
    plt.plot(means,'o',markersize=2)
    plt.axhline(y=expected,color='r')
    plt.title('Average of Rolls')
    plt.show()
    
    plt.figure()
    
    plt.plot(error,'o',markersize=2)
    plt.axhline(y=0,color='r')
    plt.title('Error: Expected - Empirical')
    plt.show()
        
    plt.figure()
    
    plt.bar(range(len(faces)), [float(empirical[x])/len(vals) for x in eL], align = 'center')
    plt.xticks(range(len(eL)), eL)
    plt.ylabel('Frequency')
    plt.title('Empirical Dice Distribution')
    plt.show()
    
    pretty_print('Final estimate: ', means[-1].n())
    pretty_print('Actual expected value: ', expected.n())
    pretty_print('Error: ', error[-1].n())
