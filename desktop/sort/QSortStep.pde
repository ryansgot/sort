/*
 * QSortStep.pde contains the superclass for implementing the quicksort in a step-through manner.
 * If an object of type QSortStep is created, then the first element pivot selector will be chosen.
 * However, subclasses of QSortStep should override the selectPivot method. Otherwise, the algorithm
 * remains the same for all quicksorts.
 * As with all classes extending SortStep, the step and moveCursor methods will be slightly
 * different. However, additional methods pivotSelect and swapPivot are provided (not all SortStep
 * objects are partition-based, so they do not each use pivots).
 *
 * The priority queue was chosen to hold the collection of bounds under which the partitioning 
 * algorithm should be run because the common implementation of quicksort would probably partition
 * the lower ranges first. However, it would have been just as valid to use a queue. The reason for 
 * this distinction is that recursivity on a step-through algorithm like this is difficult to
 * conceive.
 */
import java.util.PriorityQueue;
import java.util.Comparator;

public class QSortStep extends SortStep {
  
  protected Pipe pivot;                           // stores the element of the array that will serve as the pivot
  protected int pivotIndex;                       // stores the rightful index of the pivot element when partitioning complete
  protected int lowIndex;                         // stores the lower index of the subarray being sorted
  protected int highIndex;                        // stores the upper index of the subarray being sorted
  protected int countLess;                        // stores the number of elements less than pivot element
  protected int countGreaterOrEqual;              // stores the number of elements greater or equal to pivot element
  protected int partitionCount;                   // stores the count of repartitions
  protected PriorityQueue<PartitionBound> bounds; // stores the bounds for which the algorithm must run
  protected boolean pivotSwappedBack = false;     // track whether the pivot has been swapped to its rightful location or not
  
  
  // CONSTRUCTOR
  
  public QSortStep(int len) {
    super();
    
    this.partitionCount = 0;
    
    // initialize the partition state
    this.setPartitionState(new PartitionBound(0, max(0, len - 1)));
    
    // Comparator ensures that the lowest paritition in the set is worked on first
    this.bounds = 
      new PriorityQueue<PartitionBound>(maxPartitions(len), 
                                        new Comparator<PartitionBound>() {
                                          public int compare(PartitionBound pb1, PartitionBound pb2) {
                                            return pb1.compareTo(pb2);
                                          }
                                        });
    
  }  // end constructor
  
  // PROTECTED METHODS
  
  /*
   * Pipe[] -> void
   * selects the pivot element in the subset of the array being sorted
   */
  protected void selectPivot(Pipe[] p) {
    this.pivotIndex = this.lowIndex;          // this is the method for first-element pivot selection
    this.pivot = new Pipe(p[this.pivotIndex]);
  }  // end method selectPivot
  
  /*
   * void -> void
   * lets further steps move the pivot to the first position when called just after selecting the pivot
   * lets further steps move the pivot back to its rightful position when called after rightful pivot position 
   * found.
   * SUBCLASSES of QSortStep SHOULD OVERRIDE THIS METHOD!
   */
  protected void swapPivot() {
    this.c1Position = this.lowIndex;
    this.c2Position = this.pivotIndex;
    this.doHighlight = true;
  }  // end method swapPivotFirst
  
  /*
   * void -> boolean
   * return true if all of the elements of the subarray have been accounted for in the algorithm
   * In other words, if the count of elements less than pivot plus the count of elements >= the pivot
   * is equal to the number of elements between the high and low index (inclusive) 
   */
  protected boolean subarrayEndReached() {
    return (this.highIndex - this.lowIndex) == (this.countGreaterOrEqual + this.countLess);
  }  // end method subarrayEndReached
  
  /*
   * void -> void
   * put cursors back to the correct locations
   * call this after a swap has occurred.
   */
  protected void resetCursors() {
    this.c1Position = this.lowIndex + this.countLess;
    this.c2Position = this.c1Position + this.countGreaterOrEqual;
  }  // end method subarrayEndReached
  
  /*
   * PartitionBound -> void
   * this initializes the variables for one trip through the partitioning algorithm
   */
  protected void setPartitionState(PartitionBound pb) {
    // set state controls
    this.doHighlight = false;
    this.doSwap = false;
    this.pivotSwappedBack = false;
    this.pivot = null;
    
    // set bounds
    this.lowIndex = pb.getLowBound();
    this.highIndex = pb.getHighBound();
    
    // set cursor positions
    this.c1Position = this.lowIndex;
    this.c2Position = this.lowIndex;
    
    // set partition-scope counting variables
    this.countLess = 0;
    this.countGreaterOrEqual = 0;
  }  // end method setPartitionState
  
  protected int maxPartitions(int len) {
    if (len == 1) {
      return 1;
    }
    return ceil(log(len) / log(2));
  }  // end method getMostPossiblePartitions
  
  /*
   * void -> void
   * Adds between 0 and 2 new bounds to the bounds priority queue depending upon whether there are is more 
   * than one element between the partitionIndex and the lowIndex and the partitionIndex and the highIndex.
   */
  protected void addBounds() {
    if (this.pivotIndex - 1 > this.lowIndex) {
      this.bounds.add(new PartitionBound(this.lowIndex, this.pivotIndex - 1));
    }
    if (this.pivotIndex + 1 < this.highIndex) {
      this.bounds.add(new PartitionBound(this.pivotIndex + 1, this.highIndex));
    }
  }  // end method addBounds
  
  protected void finishPartitionAlgorithm(Pipe[] ps) {
    // the algorithm can only truly finish when the pivot has been swapped to its rightful position
    if (this.pivotSwappedBack) {
      this.partitionCount++;  // each time the partition algorithm ends, one partition was made
      // mark that pivot was swapped back
      this.pivotSwappedBack = false;
      // could add no bounds
      this.addBounds();
      
      // if there are no more bounds left in the list, then the quicksort is done
      if (bounds.isEmpty()) {
        this.done = true;
      }  // end if
      else {
        // reset the partition state using the next PartitionBounds in the bounds list
        // removal ensures that base case will finally be reached
        this.setPartitionState(this.bounds.remove());
      }  // end else
    }  // end if
    else {
      // swaps the pivot back to its rightful position
      this.pivotIndex = lowIndex + this.countLess;
      this.swapPivot();
      this.pivotSwappedBack = true;
      
      // highlight the pivot in blue
      ps[pivotIndex].markPivot();
    }  // end else
  }  // end method finishPartitionAlgorithm
  
  // OVERRIDES
  
  public String getAlgorithmName() { return "QuickSort1st"; }
  
  /*
   * Pipe[] -> void
   * Perform the next step in the sorting sequence.
   * Because each sorting step must be displayed on the screen, the step method must move the sorting algorithm
   * forward to display the next step in the algorithm
   */
  public void step(Pipe[] ps) {
    // 1. Select a pivot element (if unselected)
    if (null == pivot) {
      this.selectPivot(ps);
    }  // end if
    // 2. Swap that pivot element to the first position in the subarray (if not already there)
    else if (!this.doHighlight && !this.doSwap && !this.pivotSwappedBack && pivot.compareTo(ps[lowIndex]) != 0) {
      // if doHighlight or doSwap are true, then the pivot is being swapped into the low index or is
      // already in the low index
      // if pivot.compareTo(p[lowIndex]) == 0 then the pivot is in the lowIndex already
      this.swapPivot();
    }  // end else if
    // 3. Highlight any pipes that are about to be swapped
    else if (this.doHighlight) {
      this.highlightPipes(ps);
      this.doHighlight = false;
      this.doSwap = true;
    }  // end else if
    // 4. Swap any highlighted pipes and unhighlight them
    else if (this.doSwap) {
      this.swapPipes(ps);
      this.unhighlightPipes(ps);
      this.doSwap = false;
      this.resetCursors();
    }  // end else if
    // 5. Move the cursors to their next position
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
    // If the end of the subarray has been reached, then swap the pivot element to its rightful position
    // and then declare that that the algorithm is done.
    if (this.subarrayEndReached()) {
      // the base case of the "recursion" is carried out in finishPartitionAlgorithm
      finishPartitionAlgorithm(ps);
    }  // end if subarray end reached
    else {
      // the partition routine must continue by checking the next element
      this.c2Position++;    // move c2Position to the next unchecked element
      this.compareCount++;  // whenever a compare occurs, must increment compare count
      if (pivot.compareTo(ps[this.c2Position]) == 1) {
        // the pivot is greater than the element at c2position
        this.countLess++;
        this.c1Position = this.lowIndex + this.countLess;
        this.doHighlight = true;
      }  // end compareTo
      else {
        // the element at c2Position was greater than or equal to the pivot
        this.countGreaterOrEqual++;
      }  // end else
    }  // end else
  }  // end method moveCursor
  
  // OTHER PUBLIC METHODS
  
  /*
   * void -> String
   * allow for access to the counting stats as the algorithm progresses
   */
  public String getStats() {
    return super.getStats() + "\nPartitions: " + this.partitionCount;
  }
  
  // PROTECTED CLASS FOR BOUNDS
  
  /*
   * Store the lower and upper indices in a class.
   * This class exists so the step-through algorithm can show the recursion
   * without actually being recursive itself.
   */
  protected class PartitionBound implements Comparable<PartitionBound> {
    
    private int lowBound;
    private int highBound;
    
    // CONSTRUCTOR
    public PartitionBound(int lowBound, int highBound) {
      this.lowBound = lowBound;
      this.highBound = highBound;
    }
    
    // ACCESSOR
    public int getLowBound() { return this.lowBound; }
    public int getHighBound() { return this.highBound; }
    
    // OVERRIDES
    @Override
    public int compareTo(PartitionBound pb) {
      if (pb.getLowBound() < this.lowBound) {
        return 1;
      }  // end if
      else if (pb.getLowBound() > this.lowBound) {
        return -1;
      }  // end if
      return 0;
    }  // end method compareTo
  }  // end inner class PartitionBound
  
}  // end class QSortStep
