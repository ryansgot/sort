/*
 * InsertionSort.pde is currently a placeholder for the class containing the methods to
 * step through the insertion sort algorithm. As with all classes extending SortStep, 
 * the step and moveCursor methods will be slightly different.
 */
public class InsertionSortStep extends SortStep {
  
  // OVERRIDES
  
  public String getAlgorithmName() { return "InsertionSort"; }
  
/*
   * Pipe[] -> void
   * Perform the next step in the sorting sequence.
   * Because each sorting step must be displayed on the screen, the step method must move the sorting algorithm
   * forward to display the next step in the algorithm
   */
  public void step(Pipe[] ps) {
  }  // end method step
  
  /*
   * void -> void
   * Move the cursor(s) to their next location in the set
   * Because each comparison-based sorting algorithm will have two cursors, work on the two 
   * cursors to put them into the correct position
   */
  public void moveCursor(Pipe[] ps) {
  }  // end method moveCursor
    
  // PRIVATE METHODS
  
  /*
   * void -> void
   * put cursors back to the correct locations
   * call this after c2Position is the length of the array
   */
  private void resetCursors() {
  }  // end method resetCursors
}  // end class InsertionSortStep
