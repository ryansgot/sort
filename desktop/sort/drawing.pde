/*
 * drawing.pde contains the methods to be called within the draw() method.
 * The reason for creating another file was purely organizational. Now, if a method for
 * drawing should be added, deleted or changed, you can look here.
 */

/*
 * Draws the center boxes and the pipes overlayed
 */
void drawMainBox() {
  // background box
  bg.drawScreenBox(xOffset, yOffset);
  
  // left and right boxes
  leftBox.drawScreenBox(xOffset, yOffset);
  rightBox.drawScreenBox(xOffset, yOffset);
  
  // draw pipes in main box
  ps1.drawPipes(xOffset, yOffset);
  ps2.drawPipes(xOffset, yOffset);
}

/*
 * Depending upon xOffset and yOffset, draw the menu boxes
 */
void drawMenuBoxes() {
  // Draw left or right menu boxes if xOffset is nonzero
  if (xOffset > 0) {
    // only draw left menu if offset is greater than 0
    drawLeftMenu();
  }  // end if
  else if (xOffset < 0) {
    drawRightMenu();
  }
  
  // Draw top or bottom menu boxes if yOffset is nonzero
  if (yOffset > 0) {
    // only draw left menu if offset is greater than 0
    drawTopMenu();
  }  // end if
  else if (yOffset < 0) {
    drawBottomMenu();
  }  // end else if
  
  if (xOffset != 0 && yOffset != 0) {
    drawCornerBox();
  }  // end if
}  // end drawMenuBoxes

/*
 * Draw all elements of the right menu
 */
void drawRightMenu() {
    rm.drawScreenBox(xOffset, yOffset);
    drawStats();
}  // end method drawRightMenu

/*
 * Draw all elements of the right menu
 */
void drawLeftMenu() {
    lm.drawScreenBox(xOffset, yOffset);
    drawSpeedButtons();
}  // end method drawLeftMenu

/*
 * Draw all elements of the top menu
 */
void drawTopMenu() {
  // draw pipe amounts
  pipeAmountBox.drawScreenBox(xOffset, yOffset);
  pipe2Box.drawScreenBox(xOffset, yOffset);
  pipe4Box.drawScreenBox(xOffset, yOffset);
  pipe8Box.drawScreenBox(xOffset, yOffset);
  pipe16Box.drawScreenBox(xOffset, yOffset);
  pipe32Box.drawScreenBox(xOffset, yOffset);
  pipe64Box.drawScreenBox(xOffset, yOffset);
  
  // draw starting sorts
  optionsBox.drawScreenBox(xOffset, yOffset);
  nearlySortedBox.drawScreenBox(xOffset, yOffset);
  reverseSortedBox.drawScreenBox(xOffset, yOffset);
  randomSortedBox.drawScreenBox(xOffset, yOffset);
  soundToggleBox.drawScreenBox(xOffset, yOffset);
}  // end method drawTopMenu

/*
 * Draw all elements of the bottom menu
 */
void drawBottomMenu() {
  // draw boxes for left algorithm
  lbAlgorithmBox.drawScreenBox(xOffset, yOffset);
  lbBubbleSortBox.drawScreenBox(xOffset, yOffset);
  lbSelectionSortBox.drawScreenBox(xOffset, yOffset);
  lbInsertionSortBox.drawScreenBox(xOffset, yOffset);
  lbQuickFirstSortBox.drawScreenBox(xOffset, yOffset);
  lbQuickRandomSortBox.drawScreenBox(xOffset, yOffset);
  lbQuickMedian3SortBox.drawScreenBox(xOffset, yOffset);
  
  // draw boxes for right algorithm
  rbAlgorithmBox.drawScreenBox(xOffset, yOffset);
  rbBubbleSortBox.drawScreenBox(xOffset, yOffset);
  rbSelectionSortBox.drawScreenBox(xOffset, yOffset);
  rbInsertionSortBox.drawScreenBox(xOffset, yOffset);
  rbQuickFirstSortBox.drawScreenBox(xOffset, yOffset);
  rbQuickRandomSortBox.drawScreenBox(xOffset, yOffset);
  rbQuickMedian3SortBox.drawScreenBox(xOffset, yOffset);
  
}  // end method drawBottomMenu

/*
 * Draw all statistical elements
 */
void drawStats() {
  // draw stats boxes
  statBoxL.drawScreenBox(xOffset, yOffset);
  statBoxR.drawScreenBox(xOffset, yOffset);
  
  // draw text  
  fill(0);
  textSize(statBoxL.getLabelTextSize());
  text(ps1.getStats(), 
       statBoxL.getCenterAvailableX() + xOffset, 
       statBoxL.getCenterAvailableY() + yOffset);
  textSize(statBoxR.getLabelTextSize());
  text(ps2.getStats(), 
       statBoxR.getCenterAvailableX() + xOffset, 
       statBoxR.getCenterAvailableY() + yOffset);
}  // end method drawRightMenu


void drawSpeedButtons() {
  speedSuperBox.drawScreenBox(xOffset, yOffset);
  speedFastBox.drawScreenBox(xOffset, yOffset);
  speedMediumBox.drawScreenBox(xOffset, yOffset);
  speedSlowBox.drawScreenBox(xOffset, yOffset);
}  // end method drawSpeedButtons

/*
 * Render the corner box on the screen. This will not end up doing anything when either yOffset or xOffset are nonzero
 */
void drawCornerBox() {
  // nested logic correctly positions the corner box in 1 of 4 cases
  if (xOffset > 0) {
    cornerBox.setX(0 - xLengthSMenu);
    if (yOffset > 0) {
      cornerBox.setY(0 - yLengthVMenu);
    }  // end if yOffset
    else if (yOffset < 0) {
      cornerBox.setY(height);      
    }  // end else if yOffset
  }  // end if xOffset
  else if (xOffset < 0) {
    cornerBox.setX(width);
    if (yOffset > 0) {
      cornerBox.setY(0 - yLengthVMenu);
    }  // end if yOffset
    else if (yOffset < 0) {
      cornerBox.setY(height);      
    }  // end else if yOffset
  }  // end else if xOffset
  
  cornerBox.drawScreenBox(xOffset, yOffset);
}  // end drawCornerBox
