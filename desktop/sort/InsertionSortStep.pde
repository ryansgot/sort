/*
 * InsertionSort.pde is currently a placeholder for the class containing the methods to
 * step through the insertion sort algorithm. As with all classes extending SortStep, 
 * the step and moveCursor methods will be slightly different.
 */
public class InsertionSortStep extends SortStep {
  
  private int nextUnsortedIndex;     // keeps track of the next unsorted postion
  private boolean doRetreatCursors;  // tells the moveCursor method that the cursors should be retreated by 1
  
  public InsertionSortStep() {
    super();
    this.doRetreatCursors = false;                 // do not retreat cursors as first cursor move
    this.c2Position = this.nextUnsortedIndex = 1;  // initial position of c2 is index 1
  }
  
  // OVERRIDES
  
  public String getAlgorithmName() { return "InsertionSort"; }
  
/*
   * Pipe[] -> void
   * Perform the next step in the sorting sequence.
   * Because each sorting step must be displayed on the screen, the step method must move the sorting algorithm
   * forward to display the next step in the algorithm
   */
  public void step(Pipe[] ps) {
    // 1. Highlight any pipes that are about to be swapped
    if (this.doHighlight) {
      this.highlightPipes(ps);
      this.doHighlight = false;
      this.doSwap = true;
    }  // end if
    // 2. Swap any highlighted pipes and unhighlight them
    else if (this.doSwap) {
      this.swapPipes(ps);
      this.unhighlightPipes(ps);
      this.doSwap = false;
      this.doRetreatCursors = true;
    }  // end else if
    // 3. Move the cursors to their next position
    else {
      this.moveCursor(ps);
    }  // end else
  }  // end method step
  
  /*
   * void -> void
   * Move the cursor(s) to their next location in the set
   * Because each comparison-based sorting algorithm will have two cursors, work on the two 
   * cursors to put them into the correct position
   */
  public void moveCursor(Pipe[] ps) {
    
    // check whether the algorithm is done
    if (this.nextUnsortedIndex == ps.length) {
      // set to done and return early
      this.done = true;
      return;
    }  // end 
    
    if (this.c1Position < 0) {
      // protects against a negative index reference 
      this.resetCursors();  // take cursors to their next position
    }  // end if
    else if (this.doRetreatCursors) {
      this.retreatCursors();
    }  // end else if
    // Check whether previous element is less than the element at c2
    else if (ps[this.c2Position].compareTo(ps[this.c1Position]) == -1) {
      // a swap needs to be made
      this.doHighlight = true;
      this.compareCount++;
    }  // end else if
    else {
      // no swap needs to be made the element is now in position
      this.resetCursors();  // take cursors to their next position
      this.compareCount++;
    }
    
    
  }  // end method moveCursor
    
  // PRIVATE METHODS
  
  /*
   * void -> void
   * put cursors back to the correct locations
   * call this after c2Position is the length of the array
   */
  private void resetCursors() {
    this.c1Position = nextUnsortedIndex;
    this.c2Position = nextUnsortedIndex = this.c1Position + 1;
  }  // end method resetCursors
  
  /*
   * void -> void
   * put both cursors back one index
   * call this after a swap has occurred
   */
  private void retreatCursors() {
    this.c1Position--;
    this.c2Position--;
    this.doRetreatCursors = false;
  }  // end method retreatCursors
}  // end class InsertionSortStep

/*
 * March up the array, checking each element. If larger (than what's in previous position checked), 
 * leave it (as happens with the 8). If smaller than march back down, shifting larger elements up 
 * until encounter a smaller element. Insert there.
 */
