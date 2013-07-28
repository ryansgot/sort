/*
 * PipeSorting.pde contians an interface that allows for a step-through sorting of pipe arrays.
 * Because of the complexities of creating a good step-through visualization of the comparison-based 
 * sorting algorithms, this interface was created to guide the creation of the classes which would
 * carry out the sorting in this manner.
 */
public interface PipeSorting {
  
  /*
   * Pipe[] -> void
   * Perform the next step in the sorting sequence.
   * Because each sorting step must be displayed on the screen, the step method must move the sorting algorithm
   * forward to display the next step in the algorithm
   */
  public void step(Pipe[] p);
  
  /*
   * void -> void
   * Move the cursor(s) to their next location in the set
   * Because each comparison-based sorting algorithm will have two cursors, work on the two (or perhaps more)
   * cursors to put them into the correct position
   */
  public void moveCursor(Pipe[] ps);
  
  /*
   * void -> void
   * Highlight the correct pipes based upon the particular sorting algorithm
   * In order to correctly demonstrate an algorithm, prior to swapping, the pipes to swap must be highlighted.
   */
  public void highlightPipes(Pipe[] ps);
  
  /*
   * void -> void
   * Unhighligt the correct pipes based upon the particular sorting algorithm
   * after being swapped, pipes must be unhighlighted
   */
  public void unhighlightPipes(Pipe[] ps);
  
  /*
   * void -> void
   * Swap the pipes at the location of two of the cursors (some sorting algorithms may have more)
   * In order to correctly demonstrate an algorithm, prior to swapping, the pipes to swap must be highlighted.
   */
  public void swapPipes(Pipe[] ps);
}  // end interface PipeSorting
