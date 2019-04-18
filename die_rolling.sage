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
    
    plt.bar(range(len(oL)), [float(original[x])/len(oL) for x in oL], align = 'center')
    plt.xticks(range(len(oL)), oL)
    plt.ylabel('Frequency')
    plt.title('Expected Dice Distribution')
    plt.show()
    
    plt.figure()
    
    plt.bar(range(len(eL)), [float(empirical[x])/len(vals) for x in eL], align = 'center')
    plt.xticks(range(len(eL)), eL)
    plt.ylabel('Frequency')
    plt.title('Empirical Dice Distribution')
    plt.show()

    
    plt.show()
    
    pretty_print('Roll values: ', vals)
    
