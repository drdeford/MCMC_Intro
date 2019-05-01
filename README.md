# MCMC_Intro (Under Development!)

Friendly and interactive introduction to discrete MCMC

These Sage interact programs accompany my notes introducing discrete MCMC to non-mathematical audiences using Scrabble. Polished and embedded versions of these are organized <a href="https://people.csail.mit.edu/ddeford/mcmc_intro.php">here</a> with some additional details. 

![alt text](https://github.com/drdeford/MCMC_Intro/blob/master/keyboard_walk.gif "Ant walking on a Keyboard")

You can run the versions here by copying the code into my Sage cell terminal <a href="https://people.csail.mit.edu/ddeford/sage_cell.html">here</a>.

<h2>Introduction</h2>
<p>As MCMC sampling has become an increasingly popular tool for evaluating districting plans, people from a diverse set of backgrounds are encountering these methods for the first time. These notes 
and Sage Widgets represent my attempt at explaining the underlying ideas in a concrete and friendly fashion, with lots of opportunity for interaction and exploration. Throughout the <a href="MCMC_Intro.pdf">
.pdf document</a>
there are many links to individual interactive tools for exploring the ideas further. These tools and brief descriptions of their purposes are linked below. The organizational structure of 
this page follows that of the accompanying text. </p>
<p>

If you are interested in building your own Sage @interact modules, I have prepared some notes and examples at the bottom of <a href="ethics.php"> this page</a>. I frequently use these tools
for both teaching and research and highly recommend them.
</p>

<h4> Scrabble </h4> 
<p>
I have always thought that Scrabble tiles are a great tool for teaching Markov chains and MCMC. They are familiar to many people, the tiles themselves come in a non-uniform distribution, and each
tile has an associated point value that leads to an entirely separate distribution. The table below shows the frequency and point distributions for the American English tileset. </p>


<table border="1" cellpadding="5" cellspacing="5">
<tr><td>Letter </td>  <td> A</td><td>B</td><td>C</td><td>D</td><td>E</td><td>F</td><td>G</td><td>H</td><td>I</td><td>J</td><td>K</td><td>L</td><td>M</td><td>N </td><td>O</td><td>P</td><td>Q</td><td>R</td><td>S</td><td>T</td><td>U</td><td>V</td><td>W</td><td>X</td><td>Y</td><td>Z</td><td> </td></tr>
     
 <tr><td>     Frequency</td>  <td> 9</td><td>2</td><td>2</td><td>4</td><td>12</td><td>2</td><td>3</td><td>2</td><td>9</td><td>1</td><td>1</td><td>4</td><td>2</td><td>6 </td><td>8</td><td>2</td><td>1</td><td>6</td><td>4</td><td>6</td><td>4</td><td>2</td><td>2</td><td>1</td><td>2</td><td>1</td><td>2</td></tr>
     
<tr><td>	 Score </td>   <td> 1</td><td>3</td><td>3</td><td>2</td><td>1</td><td>4</td><td>2</td><td>4</td><td>1</td><td>8</td><td>5</td><td>1</td><td>3</td><td>1 </td><td> 1</td><td>3</td><td>10</td><td>1</td><td>1</td><td>1</td><td>1</td><td>4</td><td>4</td><td>8</td><td>4</td><td>10</td><td>0</td></tr>
</table>

<p> Throughout these interactive programs, we make use of a few specific Markov chains and score functions that are worth highlighting in advance (full descriptions and plots are also in the .pdf):</p>
<ul>
<li> Markov Chains</li>
<ul>
<li> <b>Uniform</b>: Each state is drawn from the uniform distribution over the alphabet.  </li>
<li> <b>Scrabble Count</b>: Each state is drawn proportionally to the number of occurences in the Scrabble tileset (with replacement). </li>
<li> <b>Letter Path</b>: A random walk on the path graph with each letter connected to the adjacenct letters in the alphabet with [space] after z (<a href="https://github.com/drdeford/MCMC_Intro/blob/master/alpha_path.png">Example Figure</a>).</li>
<li> <b>Letter Cycle</b>: A random walk on the cycle  graph with each letter connected to the adjacenct letters in the alphabet with [space] after z and [space] connected to a (<a href="https://github.com/drdeford/MCMC_Intro/blob/master/alpha_cycle.png">Example Figure</a>). </li>
<li> <b>Keyboard</b>: A random walk on adjacent keys of a standard QWERTY keyboard (<a href="https://github.com/drdeford/MCMC_Intro/blob/master/keyboard_walk.gif">Example Figure</a>).  </li>
</ul>
<li>Score Function</li>
<ul>
<li> <b>Uniform</b>: Each letter has a score of 1.  </li>
<li> <b>Number of Vowels</b>: Consonants have score 1, vowels have score 100, and y has score 50. </li>
<li> <b>Scrabble Points</b>: The point value of the corresponding Scrabble tile. </li>
<li> <b>Scrabble Count</b>: The number of times the Scrabble tile appears in the full tileset. </li>
<li> <b>Alphabetical</b>: a=1, b=2, ... ,z=26, [space]=27. </li>
</ul>

</ul>
<h2>Probability Background</h2>
This section introduces the ideas of distributions, random variables, and expected values using examples like rolling a die or drawing a Scrabble tile.

<ul>
<li> <a href="die_rolling.html">Die Rolling</a>
<ul>
<li> This tool simulates rolling a die repeatedly as an example of draws from a probability distribution. You can adjust the number of faces and labels on the die as well as the number
of times it is rolled. The output is a plot showing the theoretical distribution as well as one showing the distribution of actual rolls. The individual rolls themselves are also reported.  </li>
</ul>
 </li>

<li> <a href="die_expected.html">Dice Expectations</a>
<ul>
<li> This tool attempts to estimate the expected value of a die roll by averaging the values of many rolls. As above, you can change the properties of the die in each experiment. The output 
shows the convergence of the expected value as well as the final estimate, distribution, and error. </li>
</ul>
</li>


<li> <a href="scrabble_expected.html">Scrabble Expectations</a>
<ul>
<li> This tool attempts to estimate the expected point value of a Scrabble tile drawn from a full bag (with replacement).The output 
shows the convergence of the expected value as well as the final estimate, distribution, and error.  </li>
</ul>
</li>


</ul>

<h2>Monte Carlo Sampling</h2>
This section introduces the idea of Monte Carlo sampling as an efficient way to estimate numerical values when we can evaluate random samples easily. 
<ul>

<li> <a href="solitaire.html">Deterministic Solitaire</a>
<ul>
<li> This tool uses Monte Carlo to evaluate the likelihood of winning a simple, deterministic solitaire game. You can vary the parameters of the game to see how the trace and win percentage evolve.   </li>
</ul>
</li>


<li> <a href="war.html">Deterministic War</a>
<ul>
<li> This is a simulation of multiplayer deterministic game whose success rate can be evaluated with Monte Carlo sampling. Game rules are provided in <a href="http://people.csail.mit.edu/ddeford/Intro_MCMC.pdf">these slides</a>.  </li>
</ul>
</li>


<li> <a href="https://math.dartmouth.edu/~doyle/docs/four/four.pdf">Pan Galactic Solitaire</a>
<ul>
<li> This isn't mentioned in the text but my first experiences with Monte Carlo sampling occurred while trying to analyze the game of Pan Galactic Solitaire with Peter Doyle. 
The <a href="PGS1.zip"> Python source</a> and a <a href="PGS_32bit.zip">Windows version</a> for my implementation of the game are freely available.   </li>
</ul>
</li>


<li> <a href="cube_dist.html">Distances in a cube</a>
<ul>
<li> This tool uses Monte Carlo to estimate the expected distance between two points drawn uniformly in a cube.  </li>
</ul>
</li>


<li> <a href="pi_simple.html">Simple Pi Estimator</a>
<ul>
<li> This tool estimate pi as the area under a circular arc using Monte Carlo sampling of points in the unit square.  </li>
</ul>
</li>



</ul>


<h2>Markov Chains</h2>
This section introduces Markov chains and the related concept of walks on graphs. 

<ul>
<li> <a href="https://github.com/drdeford/MCMC_Intro/blob/master/keyboard_walk.gif">Ant-on-a-keyboard</a>
<ul>
<li> This is not interactive, just a .gif showing the ant walking on a keyboard Markov chain.  </li>
</ul>
</li>


<li> <a href="graph_sampling.html">Walks on Graphs</a>
<ul>
<li> This tool simulates many walks on a given Markov chain in order to approximate the steady state distribution empirically. You select the chain, number of steps, and number of trials and 
then the output compares the sampled values to the true steady state distribution. </li>
</ul>
</li>

<li> <a href="walk_distributions.html">Markov Distributions</a>
<ul>
<li>   This visualization shows how the distribution over states evolves as a Markov chain progresses. You select the chain and an initial state and the output shows a heatmap of the probabilities
of being in a particular state over time. </li>
</ul>
</li>

<li> <a href="mc_ev.html">Markov Chain Expected Values</a>
<ul>
<li>  This tool calculates uses samples drawn from a Markov chain to estimate the expected value
of a specified score distribution over the steady state distribution. You select an initial state, the Markov chain, and a score function and the output shows the convergence and error of
the estimated expected value to the true answer. </li>
</ul>
</li>

</ul>

<h2>Markov Chain Monte Carlo</h2>

Finally, we reach the main topic of this discussion, actual MCMC sampling. This section introduces the Metropolis--Hastings variant of MCMC and gives several examples, making use of the 
previously introduced Markov chains and score functions.  There is only one widget in this section but it incorporates many of the previous tools. 
<ul> 
<li> <a href="mcmc_letter.html">MCMC Sampling</a>
<ul><li> This widget allows you to select an initial ``word'', proposal distribution, score distribution, and chain length and then performs MCMC with the chosen parameters. The outputs 
show the theoretical proposal and score steady state distributions as well as the distributions of states that were actually proposed and accepted in the run. The total variation distance
between the empirical and theoretical distributions is also plotted along with the convergence of the expected value under the score distribution. Finally, the traces and accepted states are
reported.  </li> </ul> </li>
</ul>
