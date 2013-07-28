/*
 * QSortRandomStep.pde contains the class that does the quicksort using the random pivot selection.
 * Of note is that the median-of-three pivot selection appears on the screen in the same amount of time as 
 * the random pivot selection. In practice, this is probably not true, however, my observation is that when
 * the sorts are shown side-by-side, the median-of-three quicksort is (in general) faster than the random pivot
 * quicksort. Sicne that is what I wanted to show, I don't see much of a reason to change this. 
 */
public class QSortRandomStep extends QSortStep {

  // CONSTRUCTOR
  
  public QSortRandomStep(int len) {
    super(len);
  }  // end constructor
  
  // OVERRIDES
  
  public String getAlgorithmName() { return "QuickSortR"; }
  
  /*
   * Pipe[] -> void
   * selects the pivot element in the subset of the array being sorted
   */
  protected void selectPivot(Pipe[] ps) {
    this.pivotIndex = int(random(this.lowIndex, this.highIndex));        // choose a random pivot
    this.pivot = new Pipe(ps[this.pivotIndex]);
  }  // end method selectPivot
}  // end class QSortRandomStep
