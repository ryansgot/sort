/*
 * PipeSet.pde creates a class that contains an array of pipes and a step-through sorting algorithm (a SortStep object)
 * for sorting the pipes. It also contains the methods necessary to draw the pipes on the screen and accessing  
 * information about the progress of the sorting algorithm.
 */
public class PipeSet {
  
  private Pipe[] p;          // Holds the pipe objects. The order matters, as this is the order they will be printed to the screen.
  private float maxXLength;  // holds max X length so that you can easily get the ordering of the pipes.
  private float maxYLength;  // holds max Y length so that the cursor triangle may be drawn
  private float xFirst;
  private float yFirst;
  private SortStep sortStep; // holds the step-through sorting algorithm object which operates on the Pipe array
  
  // CONSTRUCTORS
    
  // The resulting pipe order will be random.
  public PipeSet(int numPipes, float xFirst, float yFirst, float maxXLength, float maxYLength, int red, int green, int blue, int curve) {
    
    // allocate the space for the pipes
    p = new Pipe[numPipes];
    
    // Initialize the pipes in ascending order
    for (int i = 0; i < numPipes; i++) {
      p[i] = new Pipe(  xFirst, 
                        i * maxYLength + yFirst, 
                        ((float)(i + 1) / (float)numPipes) * maxXLength, 
                        maxYLength, 
                        red, 
                        green, 
                        blue, 
                        curve);
    }  // end for
    
    this.maxXLength = maxXLength;
    this.maxYLength = maxYLength;
    this.xFirst = xFirst;
    this.yFirst = yFirst;
    this.sortStep = new BubbleSortStep();  // default to BubbleSortStep
    
    // randomize the pipe order
    this.randomizeOrder();
  }
  
  // This constructor allows for a specific ordering to be imposed upon the pipe set
  // There will be as many pipes as entries in ordering.
  // ordering is assumed to contain integers from 1 to ordering.length with no duplicates.
  // Use this constructor when a pipe set must match the ordering of another pipe set.
  // So for example, if ps1's ordering must be imposed upon ps2, then call this constructor
  // as follows:
  // new PipeSet(ps1.getOrdering(), ...)
  public PipeSet(int[] ordering, float xFirst, float yFirst, float maxXLength, float maxYLength, int red, int green, int blue, int curve) {
    
    // allocate the space for the pipes
    p = new Pipe[numPipes];
    
    // Initialize the pipes in ascending order
    for (int i = 0; i < ordering.length; i++) {
      p[i] = new Pipe(  xFirst, 
                        i * maxYLength + yFirst, 
                        (float)ordering[i] / ordering.length * maxXLength,  //  ordering array sets the pipe lengths.
                        maxYLength, 
                        red, 
                        green, 
                        blue, 
                        curve);
    }  // end for
    
    this.maxXLength = maxXLength;
    this.maxYLength = maxYLength;
    this.xFirst = xFirst;
    this.yFirst = yFirst;
    this.sortStep = new BubbleSortStep();
  }
  
  // ACCESSOR METHODS
  
  // MUTATOR METHODS
  
  /*
   * Initializes the desired SortStep object.
   */
  public void setSortStep(int s) {
    switch (s) {
      case SortStep.BUBBLE:            this.sortStep = new BubbleSortStep();
                                       break;
      case SortStep.SELECTION:         this.sortStep = new SelectionSortStep();
                                       break;
      case SortStep.INSERTION:         this.sortStep = new InsertionSortStep();
                                       break;
      case SortStep.QUICK_1ST_ELEMENT: this.sortStep = new QSortStep(this.p.length);
                                       break;
      case SortStep.QUICK_MEDIAN_OF_3: this.sortStep = new QSortMedian3Step(this.p.length);
                                       break;
      case SortStep.QUICK_RANDOM:      this.sortStep = new QSortRandomStep(this.p.length);
                                       break;
      default:                         println("Sort type not found.");
                                       break;
    }  // end switch
  }  // end method setSortStep

  // PUBLIC METHODS
  
  /*
   * Provide access to information about the state of the sort
   */
  public String getStats() { return this.sortStep.getStats(); }
  public int getSwapCount() { return this.sortStep.getSwapCount(); }
  public int getCompareCount() { return this.sortStep.getCompareCount(); }
  public boolean sorted() { return this.sortStep.isDone(); }
  public String getSortName() { return this.sortStep.getAlgorithmName(); }
  
  // shuffles the popes by performing 1000 * the number of pipes in the array swaps.
  public void randomizeOrder() {
    int numSwaps = p.length * 1000;
    int index1;
    int index2;
    for (int i = 0; i < numSwaps; i++) {
      index1 = this.getRandomPipeIndex();
      index2 = this.getRandomPipeIndex();
      swapPipes(index1, index2);
    }  // end for
  }  // end method randomizeOrder
  
  // draws each of the pipes in the array on the screen at the correct position.
  public void drawPipes(float xOffset, float yOffset) {
    
    this.drawCursor(sortStep.getCursor1Position(), xOffset, yOffset);
    this.drawCursor(sortStep.getCursor2Position(), xOffset, yOffset);
    
    for (int i = 0; i < p.length; i++) {
      p[i].drawPipe(xOffset, yOffset);
    }  // end for
  }  // end method drawPipes
  
  // Return the current ordering of this pipe set.
  // this is possible because the maxXLength variable is stored in this object.
  public int[] getOrdering() {
    // allocate and instatiate (there will be as many members of ordering as p)
    int[] ordering = new int[p.length];
    for (int i = 0; i < p.length; i++) {
      ordering[i] = round(p[i].getXLength() / this.maxXLength * p.length);
    }  // end for
    
    return ordering;
  }  // end method getOrdering
  
  /*
   * Provide access to the controlling application to move the algorithm forward one step.
   */
  public void step() {
    if (!sortStep.isDone()) {
      this.sortStep.step(this.p);
    }  // end check for whether sort is done
  }  // end method step
  
  // PRIVATE METHODS
  
  private void drawCursor(int cp, float xOffset, float yOffset) {
    float tWidth = 5;
    float tHeight = this.maxYLength;
    float x = this.xFirst - 6 + xOffset;
    float y = this.yFirst + this.maxYLength * (float)cp + yOffset;
    fill(0);
    triangle(x, y, x, y + tHeight, x + tWidth, y + tHeight / 2);
  }  // end method drawCursor
  
  // returns a random pipe index that is not out of bounds
  private int getRandomPipeIndex() {
    return int(random(this.p.length));
  }  // end method getRandomPipeIndex
  
  // changes the "positions" of two pipes by swapping the pipe length
  // this allows the pipes to be shuffled.
  private void swapPipes(int index1, int index2) {
    float dummyLength = this.p[index1].getXLength();
    this.p[index1].setXLength(this.p[index2].getXLength());
    this.p[index2].setXLength(dummyLength);
  }  // end method swapPipes
}  // end class PipeSet
