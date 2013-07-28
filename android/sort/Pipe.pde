/*
 * Pipe.pde holds information about a pipe and the methods necessary to compare two pipes and draw a  pipe 
 * on the screen.
 */
public class Pipe implements Comparable<Pipe> {
  
  private int red, green, blue, curve;
  private float xLength, yLength;
  private float x, y;
  private boolean isSelected, isPivot;
  
  // CONSTRUCTORS
  
  public Pipe(float x, float y, float xLength, float yLength, int red, int green, int blue, int curve) {
    this.x = x;
    this.y = y;
    this.xLength = xLength;
    this.yLength = yLength;
    this.red = red % 256;
    this.green = green % 256;
    this.blue = blue % 256;
    this.curve = curve % 11;  // curvature does not seem to make a difference above 10
    this.isSelected = false;
    this.isPivot = false;
  }
  
  public Pipe(Pipe p) {
    this.x = p.getX();
    this.y = p.getY();
    this.xLength = p.getXLength();
    this.yLength = p.getYLength();
    this.red = p.getRed();
    this.green = p.getGreen();
    this.blue = p.getBlue();
    this.curve = p.getCurve();
    this.isSelected = p.selected();
    this.isPivot = p.pivot();
  }
  
  // ACCESSOR
  
  public float getX() {return this.x; }
  public float getY() {return this.y; }
  public float getXLength() { return this.xLength; }
  public float getYLength() { return this.yLength; }
  public int getRed() { return this.red; }
  public int getGreen() { return this.green; }
  public int getBlue() { return this.blue; }
  public int getCurve() { return this.curve; }
  public boolean selected() { return this.isSelected; }
  public boolean pivot() { return this.isPivot; }
  
  // MUTATOR
  
  public void setXLength(float xLength) { this.xLength = xLength; }
  public void setColor(int red, int green, int blue) {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }
  
  // OTHER PUBLIC METHODS
  
  public void drawPipe(float xOffset, float yOffset) {
    // selected status should produce a different color fill and change curvature
    if (this.isSelected) {
      fill(255, 255, 0);
    }  // end if
    else if (this.isPivot) {
      fill(0, 0, 255);
    }  // end if
    else {
      fill(this.red, this.green, this.blue);
    }  // end else
    rect(this.x + xOffset, y + yOffset, this.xLength, this.yLength, this.curve);
  }  // end method drawPipe
  
  public void markPivot() {
    this.isPivot = true;
  }  // end method select
  
  public void select() {
    this.isSelected = true;
  }  // end method select
  
  public void deselect() {
    this.isSelected = false;
  }  // end method deselect
  
  // OVERRIDES
  
  // Necessary for performing the swap-based sorting algorithms
  @Override
  public int compareTo(Pipe p) {
    if (p.xLength > this.xLength) {
      return -1;
    }  // end if
    else if (p.xLength < this.xLength) {
      return 1;
    }  // end else if
    else {
      return 0;
    }  // end else
  }  // end compareTo method
}  // end class Pipe
