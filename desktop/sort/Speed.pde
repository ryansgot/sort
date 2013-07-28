/*
 * Speed.pde holds information about a speed. Use of Speed ensures that the correct number of  
 * frames will update before moving the step method along.
 */
public class Speed {
  
  public static final int SUPERFAST = 1;
  public static final int FAST = 2;
  public static final int MEDIUM = 4;
  public static final int SLOW = 8;
  
  private int framesPerStep;
  
  public Speed(int s) {
    setSpeed(s);
  }  // end constructor
  
  public int getFramesPerStep() { return this.framesPerStep; }
  
  public void setSpeed(int s) { 
    if (s == SUPERFAST || s == FAST || s == MEDIUM || s == SLOW) {
      this.framesPerStep = s;
    }
    else {
      this.framesPerStep = MEDIUM;
    }
  }
}  // end class Speed
