/*
 * ScreenBox.pde contains a class that holds information about a box on the screen.
 * I'm incredibly dissatisfied with this object, as it serves too many purposes. This is a prime
 * candidate for refactoring.
 */
public class ScreenBox {
  
  public static final float X_MARGIN_MULTIPLIER = 0.1;
  public static final float Y_MARGIN_MULTIPLIER = 0.1;
  public static final float TOP_PADDING_MULTIPLIER = 0.1;
  public static final float TEXT_SIZE_MULTIPLIER = .4;
  public static final int LABEL_BOX_RED = 100;
  public static final int LABEL_BOX_GREEN = 100;
  public static final int LABEL_BOX_BLUE = 100;
  public static final int TEXT_RED = 128;
  public static final int TEXT_GREEN = 0;
  public static final int TEXT_BLUE = 0;
  
  private float x,
                y,
                xLength,
                yLength,
                xMargin,
                yMargin,
                topPadding,
                xLabelBox,
                yLabelBox,
                xLabelBoxLength,
                yLabelBoxLength,
                xLabelBoxMargin,
                yLabelBoxMargin;
  private int red,
              green,
              blue,
              curve,
              labelTextSize,
              centeredTextSize;
  private String label, centeredText;
  private boolean isSelected;
  
  // CONSTRUCTOR
  
  public ScreenBox(  float x, 
                     float y, 
                     float xLength, 
                     float yLength, 
                     int red, 
                     int green, 
                     int blue, 
                     int curve, 
                     String label,
                     String centeredText) {
    this.x = x;
    this.y = y;
    this.xLength = xLength;
    this.yLength = yLength;
    this.red = red % 256;
    this.green = green % 256;
    this.blue = blue % 256;
    this.curve = curve % 11;
    this.isSelected = false;
    
    // calculate margins based upon defaults
    this.xMargin = X_MARGIN_MULTIPLIER * xLength;
    this.yMargin = Y_MARGIN_MULTIPLIER * yLength;
    this.topPadding = TOP_PADDING_MULTIPLIER * yLength;
    
    // If this box has a label, set the label box parameters
    if (!label.equals("")) {
      this.label = label;
      this.labelTextSize = constrain(round(TEXT_SIZE_MULTIPLIER * (this.yMargin + this.topPadding)), 8, 40);
      this.xLabelBox = this.x + this.xLength / 4.0;
      this.yLabelBox = this.y + (this.yMargin + this.topPadding) / 3;
      this.xLabelBoxLength = this.xLength / 2.0;
      this.yLabelBoxLength = (this.yMargin + this.topPadding) / 2;
      this.xLabelBoxMargin = X_MARGIN_MULTIPLIER * this.xLabelBoxLength;
      this.yLabelBoxMargin = Y_MARGIN_MULTIPLIER * this.yLabelBoxLength;
    }  // end if
    
    // if the box has centered text, then set the max centered text size
    if (!centeredText.equals("")) {
      this.centeredText = centeredText;
      this.centeredTextSize = this.getMaxCenteredTextSize();
    }  // end if
  }  // end constructor
  
  // ACCESSOR METHODS
  public float getX() { return this.x; }
  public float getY() { return this.y; }
  public float getXLength() { return this.xLength; }
  public float getYLength() { return this.yLength; }
  public String getLabel() { return this.label; }
  public int getLabelTextSize() { return this.labelTextSize; }
  public int getCenteredTextSize() { return this.centeredTextSize; }
  
  // MUTATOR METHODS
  public void setX(float x) { this.x = x; }
  public void setY(float y) { this.y = y; }
  public void setLabel(String label) { this.label = label; }
  public void setCenteredText(String centeredText) { 
    this.centeredText = centeredText;
    this.centeredTextSize = this.getMaxCenteredTextSize();
  }  // end setCenteredText
  public void setCenteredTextSize(int centeredTextSize) { this.centeredTextSize = centeredTextSize; }
  
  // PUBLIC METHODS
  
  
  public void drawScreenBox(float xOffset, float yOffset) {
    if (this.isSelected) {
      fill(255, 255, 0);
    }
    else {
      fill(this.red, this.green, this.blue);
    }
    rect(this.x + xOffset, this.y + yOffset, this.xLength, this.yLength, this.curve);
    
    if (this.label != null) {
      // draw label box
      fill(LABEL_BOX_RED, LABEL_BOX_GREEN, LABEL_BOX_BLUE);
      rect(this.xLabelBox + xOffset, this.yLabelBox + yOffset, this.xLabelBoxLength, this.yLabelBoxLength, this.curve);
      // draw text
      textSize(this.labelTextSize);
      fill(TEXT_RED, TEXT_GREEN, TEXT_BLUE);
      text(this.label, this.xLabelBox + this.xLabelBoxLength / 2.0 + xOffset, this.yLabelBox + this.yLabelBoxLength / 2.0 + yOffset);      
    }  // end if
    
    if (this.centeredText != null) {
      this.drawCenteredText(xOffset, yOffset);
    }  // end if
  }  // end method drawScreenBox
  
  public float getFirstAvailableX() { return this.x + this.xMargin; }
  public float getFirstAvailableY() { return this.y + this.topPadding + this.yMargin; }
  public float getLastAvailableX() { return this.x + this.xLength - this.xMargin; }
  public float getLastAvailableY() { return this.y + this.yLength - this.yMargin; }
  public float getCenterAvailableX() { return this.x + this.xLength / 2.0; }
  public float getCenterAvailableY() { return this.y + this.yLength / 2.0; }
  public float getAvailableLengthX() { return this.getLastAvailableX() - this.getFirstAvailableX(); }
  public float getAvailableLengthY() { return this.getLastAvailableY() - this.getFirstAvailableY(); }
  public float getCenterX() { return this.xLength / 2.0 + this.x; }
  public float getCenterY() { return this.yLength / 2.0 + this.y; }
  
  /*
   * float float float float -> boolean
   * input the mouse x, mouse y, x offset, and y offset position and return true if the click was on this screen box
   */
  public boolean clickedOn(float mx, float my, float xOffset, float yOffset) {  
    // correct for offset
    mx = mx - xOffset;
    my = my - yOffset;
    
    return (mx > this.x
            && mx < this.x + this.xLength
            && my > this.y
            && my < this.y + this.yLength);
  }  // end method clickedOn
  
  public void select() {
    this.isSelected = true;
  }  // end method select
  
  public void deselect() {
    this.isSelected = false;
  }  // end method deselect
  
  
  // PRIVATE METHODS
  
  /*
   * void -> void
   * Draw text in the center of the screen box at its maximum size
   */
  private void drawCenteredText(float xOffset, float yOffset) {
    fill(0, 0, 255);
    textSize(this.centeredTextSize);
    text(this.centeredText, this.getCenterX() + xOffset, this.getCenterY() + yOffset);
  }  // end method drawCenteredText
  
  /*
   * String -> float
   * Returns the maximum text size that can be centered on the ScreenBox without 
   * going over any edge.
   */
  private int getMaxCenteredTextSize() {
    int ts = floor(this.xLength);
    int margin = 2;
    textSize(ts);
    while (this.xLength - textWidth(this.centeredText) < margin || this.yLength - ts < margin) {
      // there must be at least margin / 2 pixels of margin on either side
      ts -= margin;
      textSize(ts);
    }  // end while
    return ts;
  }  // end method getMaxTextSize
}  // end class ScreenBox
