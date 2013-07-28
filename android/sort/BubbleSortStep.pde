/*
 * BubbleSortStep.pde contains the methods for stepping through the bubble sort algorithm.
 * As with all classes extending SortStep, the step and moveCursor methods will be slightly
 * different.
 */
public class BubbleSortStep extends SortStep {
  
  // CONSTRUCTORS
  
  public BubbleSortStep() {
    super();
  }  // end constructor
  
  // OVERRIDES
  
  public String getAlgorithmName() { return "BubbleSort"; }
  
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
    this.c2Position++;    // move c2Position to the next unchecked element
    
    // Guard against out-of-bounds index
    if (this.c2Position == ps.length) {
      // reset the cursors to their next positions and check whether the algorithm is complete
      this.resetCursors();
      if (this.c1Position == ps.length - 1) {
        this.done = true;
      }  // end if
    }  // end if
    else {
      // compare the pipe at c1Position with the pipe at c2Position
      this.compareCount++;  // whenever a compare occurs, must increment compare count
      if (ps[c1Position].compareTo(ps[this.c2Position]) == 1) {
        // the pipe at c1Position is greater than the pipe at c2position
        this.doHighlight = true;
      }  // end compareTo
    }  // end else
  }  // end method moveCursor
    
  // PRIVATE METHODS
  
  /*
   * void -> void
   * put cursors back to the correct locations
   * call this after c2Position is the length of the array
   */
  private void resetCursors() {
    this.c2Position = ++this.c1Position;
  }  // end method resetCursors
  
}  // end class BubbleSortStep
