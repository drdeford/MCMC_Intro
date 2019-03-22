from matplotlib import pyplot as plt
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
        

    
    plt.figure()
    plt.plot(vals, 'o')
    plt.title('Roll Values')
    plt.xlabel('Roll #')
    
    plt.show()
    
    plt.figure()
    
    plt.plot(means,'o')
    plt.axhline(y=expected,color='r')
    plt.title('Average of Rolls')
    plt.show()
    
    plt.figure()
    
    plt.plot(error,'o')
    plt.axhline(y=0,color='r')
    plt.title('Error: Expected - Empirical')
    plt.show()
    
    
    pretty_print('Final estimate: ', means[-1].n())
    pretty_print('Actual expected value: ', expected.n())
    pretty_print('Error: ', error[-1].n())
    

    
    
