/*
 * SortStep.pde contains a class definition that holds state information about a sorting algorithm.
 * On its own, this class is no good. However, it is a means of sharing code all subclasses will
 * use. It also allows the PipeSet object (of which SortStep is a member) to not care which 
 * sorting algorithm is being used to sort the pipes.
 */
public abstract class SortStep implements PipeSorting {

  protected int c1Position;
  protected int c2Position;
  protected int compareCount;             // the number of comparisons made
  protected int swapCount;                // the number of swaps made
  protected boolean done;                 // whether sorted or not
  protected boolean doHighlight;          // next step should be a highlighting step
  protected boolean doSwap;               // next step should be a swap step
  
  // Allow for selection of sorting algorithm.
  public static final int BUBBLE = 1;
  public static final int SELECTION = 2;
  public static final int INSERTION = 3;
  public static final int QUICK_1ST_ELEMENT = 4;
  public static final int QUICK_MEDIAN_OF_3 = 5;
  public static final int QUICK_RANDOM = 6;
  
  public SortStep() {
    // set cursors
    this.c1Position = 0;
    this.c2Position = 0;
    
    // set statistics
    this.compareCount = 0;
    this.swapCount = 0;
    
    // set state
    this.done = false;
  }
  
  // ACCESSOR METHODS
  public int getCursor1Position() { return this.c1Position; }
  public int getCursor2Position() { return this.c2Position; }
  public int getCompareCount() { return this.compareCount; }
  public int getSwapCount() { return this.swapCount; }
  public boolean isDone() { return this.done; }
  
  // MUTATOR METHODS
  public void setCursor1Position(int c1Position) { this.c1Position = c1Position; }
  public void setCursor2Position(int c2Position) { this.c2Position = c2Position; }
  
  // OTHER PUBLIC METHODS  
  
  /*
   * void -> String
   * allow for access to the counting stats as the algorithm progresses
   */
  public String getStats() {
    return "Compares: " + this.compareCount + "\nSwaps: " + this.swapCount;
  }
  
  public String getAlgorithmName() { return "The base SortStep class has no name."; }
  
  // OVERRIDES
  
  /*
   * void -> void
   * Swap the pipes at the location of two of the cursors
   * In order to correctly demonstrate an algorithm, prior to swapping, the pipes to swap must be highlighted.
   */
  public void swapPipes(Pipe[] ps) {
    this.swapCount++;
    // this implementation does not actually swap the pipes--rather it swaps their xLength members
    float dummyLength = ps[c1Position].getXLength();
    ps[c1Position].setXLength(ps[c2Position].getXLength());
    ps[c2Position].setXLength(dummyLength);
  }  // end method swapPipes
  
  /*
   * void -> void
   * Highlight the correct pipes based upon the particular sorting algorithm
   * In order to correctly demonstrate an algorithm, prior to swapping, the pipes to swap must be highlighted.
   */
  public void highlightPipes(Pipe[] ps) {
    ps[this.c1Position].select();
    ps[this.c2Position].select();
  }  // end method highlightPipes
  
  /*
   * void -> void
   * Unhighligt the correct pipes based upon the particular sorting algorithm
   * after being swapped, pipes must be unhighlighted
   */
  public void unhighlightPipes(Pipe[] ps) {
    ps[this.c1Position].deselect();
    ps[this.c2Position].deselect();
  }  // end method unhighlightPipes
}  // end class SortStep
