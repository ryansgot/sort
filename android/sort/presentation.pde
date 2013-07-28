/*
 * presentation.pde contains the methods to be called when either actions are made by
 * user that cause the settings of the app to change (and this change must be reflected
 * on the screen), or in order to check whether the menus are currently locked into place.
 * The reason for creating another file is purely organizational. Now, if a method for 
 * causing the presentation to change in response to a user action should be added, 
 * deleted or changed, you can look here.
 */

// SPEED CHANGE

/*
 * Changes the speed based upon the location the user clicked. It is best to call this
 * within the mouseClicked() method as long as the left menu is already open.
 */
void checkSpeedChange() {
    if (speedSlowBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
      deselectSpeedButtons();
      speedSlowBox.select();
      s.setSpeed(Speed.SLOW);
    }
    else if (speedMediumBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
      deselectSpeedButtons();
      speedMediumBox.select();
      s.setSpeed(Speed.MEDIUM);
    }
    else if (speedFastBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
      deselectSpeedButtons();
      speedFastBox.select();
      s.setSpeed(Speed.FAST);
    }
    else if (speedSuperBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
      deselectSpeedButtons();
      speedSuperBox.select();
      s.setSpeed(Speed.SUPERFAST);
    }
}  // end method checkSpeedChange

/*
 * Turns all of the speed box button colors to their default color
 * This is helper for checkSpeedChange.
 */
void deselectSpeedButtons() {
      speedSlowBox.deselect();
      speedMediumBox.deselect();
      speedFastBox.deselect();
      speedSuperBox.deselect();
}  // end method deselectRightAlgorithmButtons

// ALGORITHM CHANGE

/*
 * Changes the sorting algorithm which will be used to sort the left PipeSet (ps1)
 * based upon the location the user clicked. It is best to call this
 * within the mouseClicked() method as long as the bottom menu is already open. If
 * one of the left algorithm buttons was clicked, then both PipeSet objects (ps1 
 * and ps2) will be reset.
 */
void checkAlgorithmChangeLeft() {
  if (lbBubbleSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectLeftAlgorithmButtons();
    lbBubbleSortBox.select();
    sa1 = SortStep.BUBBLE;   // changes sorting algorithm
  }  // end if
  else if (lbSelectionSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectLeftAlgorithmButtons();
    lbSelectionSortBox.select();
    sa1 = SortStep.SELECTION;   // changes sorting algorithm
  }  // end else if
  else if (lbInsertionSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectLeftAlgorithmButtons();
    lbInsertionSortBox.select();
    sa1 = SortStep.INSERTION;   // changes sorting algorithm
  }  // end else if
  else if (lbQuickFirstSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectLeftAlgorithmButtons();
    lbQuickFirstSortBox.select();
    sa1 = SortStep.QUICK_1ST_ELEMENT;
  }  // end else if
  else if (lbQuickRandomSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectLeftAlgorithmButtons();
    lbQuickRandomSortBox.select();
    sa1 = SortStep.QUICK_RANDOM;
  }  // end else if
  else if (lbQuickMedian3SortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectLeftAlgorithmButtons();
    lbQuickMedian3SortBox.select();
    sa1 = SortStep.QUICK_MEDIAN_OF_3;
  }  // end else if
  else {
    return;  // does not return anything--just breaks out before resetAlgorithms is called
  }  // end else
  
  resetAlgorithms();
}  // end method checkAlgorithmChangeLeft

/*
 * Turns all of the left algorithm box button colors to their default color
 * This is helper for checkAlgorithmChangeLeft.
 */
void deselectLeftAlgorithmButtons() {
  lbBubbleSortBox.deselect();
  lbSelectionSortBox.deselect();
  lbInsertionSortBox.deselect();
  lbQuickFirstSortBox.deselect();
  lbQuickRandomSortBox.deselect();
  lbQuickMedian3SortBox.deselect();
}  // end method deselectLeftAlgorithmButtons

/*
 * Changes the sorting algorithm which will be used to sort the right PipeSet (ps2)
 * based upon the location the user clicked. It is best to call this
 * within the mouseClicked() method as long as the bottom menu is already open. If
 * one of the right algorithm buttons was clicked, then both PipeSet objects (ps1 
 * and ps2) will be reset.
 */
void checkAlgorithmChangeRight() {
  if (rbBubbleSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectRightAlgorithmButtons();
    rbBubbleSortBox.select();
    sa2 = SortStep.BUBBLE;
  }  // end if
  else if (rbSelectionSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectRightAlgorithmButtons();
    rbSelectionSortBox.select();
    sa2 = SortStep.SELECTION;
  }  // end else if
  else if (rbInsertionSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectRightAlgorithmButtons();
    rbInsertionSortBox.select();
    sa2 = SortStep.INSERTION;
  }  // end else if
  else if (rbQuickFirstSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectRightAlgorithmButtons();
    rbQuickFirstSortBox.select();
    sa2 = SortStep.QUICK_1ST_ELEMENT;
  }  // end else if
  else if (rbQuickRandomSortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectRightAlgorithmButtons();
    rbQuickRandomSortBox.select();
    sa2 = SortStep.QUICK_RANDOM;
  }  // end else if
  else if (rbQuickMedian3SortBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectRightAlgorithmButtons();
    rbQuickMedian3SortBox.select();
    sa2 = SortStep.QUICK_MEDIAN_OF_3;
  }  // end else if
  else {
    return;  // does not return anything--just breaks out before resetAlgorithms is called
  }  // end else
  
  resetAlgorithms();
}  // end method checkAlgorithmChangeRight

/*
 * Turns all of the right algorithm box button colors to their default color
 * This is helper for checkAlgorithmChangeRight.
 */
void deselectRightAlgorithmButtons() {
  rbBubbleSortBox.deselect();
  rbSelectionSortBox.deselect();
  rbInsertionSortBox.deselect();
  rbQuickFirstSortBox.deselect();
  rbQuickRandomSortBox.deselect();
  rbQuickMedian3SortBox.deselect();
}  // end method deselectRightAlgorithmButtons

// NUMBER OF PIPES CHANGE

/*
 * Changes the number of pipes in each PipeSet (ps1 and ps2) based upon the 
 * location the user clicked. It is best to call this within the mouseClicked()
 * method as long as the top menu is already open. If one of the number buttons
 * was clicked, then both PipeSet objects (ps1 and ps2) will be reset.
 */
void checkNumPipesChange() {
  if (pipe2Box.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectNumPipesButtons();
    pipe2Box.select();
    numPipes = 2;
  }  // end if
  else if (pipe4Box.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectNumPipesButtons();
    pipe4Box.select();
    numPipes = 4;
  }  // end else if
  else if (pipe8Box.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectNumPipesButtons();
    pipe8Box.select();
    numPipes = 8;
  }  // end else if
  else if (pipe16Box.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectNumPipesButtons();
    pipe16Box.select();
    numPipes = 16;
  }  // end else if
  else if (pipe32Box.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectNumPipesButtons();
    pipe32Box.select();
    numPipes = 32;
  }  // end else if
  else if (pipe64Box.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    deselectNumPipesButtons();
    pipe64Box.select();
    numPipes = 64;
  }  // end else if
  else {
    return;  // does not return anything--just breaks out before resetAlgorithms is called
  }  // end else
  
  resetAlgorithms();
}  // end method checkAlgorithmChangeRight

/*
 * Turns all of the pipe number box button colors to their default color
 * This is helper for checkNumPipesChange.
 */
void deselectNumPipesButtons() {
  pipe2Box.deselect();
  pipe4Box.deselect();
  pipe8Box.deselect();
  pipe16Box.deselect();
  pipe32Box.deselect();
  pipe64Box.deselect();
}  // end method deselectRightAlgorithmButtons

// PRESENTATION TRACKER

/*
 * void -> boolean
 * returns true if the left menu is open
 */
boolean leftMenuOpen() {
  if (xOffset != lm.getXLength()) {
      return false;
    }  // end if
  return true;
}  // end method leftMenuOpen

/*
 * void -> boolean
 * returns true if the bottom menu is open
 */
boolean bottomMenuOpen() {
  if (yOffset != -1.0 * yLengthVMenu) {
      return false;
    }  // end if
  return true;
}  // end method bottomMenuOpen

/*
 * void -> boolean
 * returns true if the top menu is open
 */
boolean topMenuOpen() {
  if (yOffset != yLengthVMenu) {
      return false;
    }  // end if
  return true;
}  // end method bottomMenuOpen


/*
 * Should be only used in mouseReleased
 * reset xOffset to 0 if a side menu is not fully in view
 * reset yOffset to 0 if a top or bottom menu is not fully in view
 */
void snapMenu() {
  // If neither the left nor right menus are showing completely,
  // snap back to 0 in the x axis.
  if ((xOffset > 0 && xOffset < xLengthSMenu) 
      || (xOffset < 0 && xOffset > xLengthSMenu * -1)) {
    xOffset = 0;
  }  // end if
  if ((yOffset > 0 && yOffset < yLengthVMenu) 
      || (yOffset < 0 && yOffset > yLengthVMenu * -1)) {
    yOffset = 0;
  }  // end if
}  // end method snapMenu
