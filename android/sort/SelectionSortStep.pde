/*
 * BubbleSortStep.pde contains the methods for stepping through the selection sort algorithm.
 * As with all classes extending SortStep, the step and moveCursor methods will be slightly
 * different.
 */
public class SelectionSortStep extends SortStep {
  
  private int minIndex;  // stores index of the minimum seen so far in this algorithm
  private boolean doResetCursors;
  
  // CONSTRUCTORS
  
  public SelectionSortStep() {
    super();
    
    // set the state variables
    this.doResetCursors = false;
    this.minIndex = 0;
  }  // end constructor
  
  // OVERRIDES
  
  public String getAlgorithmName() { return "SelectionSort"; }
  
  /*
   * Pipe[] -> void
   * Perform the next step in the sorting sequence.
   * Because each sorting step must be displayed on the screen, the step method must move the sorting algorithm
   * forward to display the next step in the algorithm
   */
  public void step(Pipe[] ps) {
    // 1. Reset cursors when c2Position reaches the end of the array and check whether finished.
    if (this.doResetCursors) {
      this.resetCursors();
      if (this.c1Position == ps.length - 1) {
        this.done = true;
      }  // end if
      this.doResetCursors = false;
    }   // end if
    // 2. Highlight any pipes that are about to be swapped
    else if (this.doHighlight) {
      this.highlightPipes(ps);
      this.doHighlight = false;
      this.doSwap = true;
    }  // end else if
    // 3. Swap any highlighted pipes and unhighlight them
    else if (this.doSwap) {
      this.swapPipes(ps);
      this.unhighlightPipes(ps);
      this.doSwap = false;
      this.doResetCursors = true;
    }  // end else if
    // 4. Move the cursors to their next position
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
    
    // only allow swaps when the last element has been seen
    if (this.c2Position == ps.length) {
      this.c2Position = this.minIndex;  // move c2Position to the pipe to highlight
      this.doHighlight = true;
    }  // end if
    else {
      this.compareCount++;  // whenever a compare occurs, must increment compare count
      if (ps[minIndex].compareTo(ps[this.c2Position]) == 1) {
        // the pipe at previously thought minimal index is greater than the pipe at c2position
        ps[minIndex].deselect();
        this.minIndex = c2Position;
        ps[minIndex].select();
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
    this.minIndex = this.c2Position = ++this.c1Position;
  }  // end method resetCursors
  
}  // end class BubbleSortStep
