/*
 * QSortMedian3Step.pde contains the class that does the quicksort using the median of three pivot selection.
 * Of note is that the median-of-three pivot selection appears on the screen in the same amount of time as 
 * the random pivot selection. In practice, this is probably not true, however, my observation is that when
 * the sorts are shown side-by-side, the median-of-three quicksort is (in general) faster than the random pivot
 * quicksort. Sicne that is what I wanted to show, I don't see much of a reason to change this. 
 */
public class QSortMedian3Step extends QSortStep {

  // CONSTRUCTOR
  
  public QSortMedian3Step(int len) {
    super(len);
  }  // end constructor
    
  // OVERRIDES
  
  public String getAlgorithmName() { return "QuickSortM3"; }
  
  /*
   * Pipe[] -> void
   * selects the pivot element in the subset of the array being sorted
   */
  protected void selectPivot(Pipe[] ps) {
    
    this.pivotIndex = medianIndex(ps);        // choose the median_of_3 pivot
    this.pivot = new Pipe(ps[this.pivotIndex]);
  }  // end method selectPivot
  
  // PRIVATE METHODS
  
  /*
   * Pipe[] -> int
   * returns the index of the median of the first, middle, and last entry of the subarray of the input array 
   */
  private int medianIndex(Pipe[] ps) {
    // set find the middle index
    int middleIndex = (int)((this.lowIndex + this.highIndex) / 2.0);
    
    // find max and min length
    float maxLength = max(ps[this.lowIndex].getXLength(), ps[middleIndex].getXLength(), ps[this.highIndex].getXLength());
    float minLength = min(ps[this.lowIndex].getXLength(), ps[middleIndex].getXLength(), ps[this.highIndex].getXLength());
    
    // handle cases with the understanding that middleIndex will be the default return 
    if (minLength == ps[middleIndex].getXLength()) {
      if (maxLength == ps[this.lowIndex].getXLength()) {
        return this.highIndex;
      }  // end if
      else {
        return this.lowIndex;
      }  // end else
    }  // end if
    else if (maxLength == ps[middleIndex].getXLength()) {
      if (minLength == ps[this.lowIndex].getXLength()) {
        return this.highIndex;
      }  // end if
      else {
        return this.lowIndex;
      }  // end else
    }  // end else if
    
    return middleIndex;
  }  // end method medianIndex
}  // end class QSortMedian3Step
