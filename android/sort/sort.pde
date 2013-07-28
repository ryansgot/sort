// sort.pde

// audio variables
Maxim maxim;
AudioPlayer apSwap_h;
AudioPlayer apSwap_l;

// control variables
int clickPixelSensitivity;         // number of pixels to allow to be a click
int clickTimeSensitivity;          // number of milliseconds to allow to be a click
int pressedTime;                   // the time the mouse was pressed
boolean sorting;
int lastSwapCountL;                // whenever swap count updated, play sound
int lastSwapCountR;                // whenever swap count updated, play sound
Speed s;
int sa1;                           // sorting algorithm for ps1
int sa2;                           // sorting algorithm for ps2
int numPipes;                      // number of pipes in ps1 and ps2
PipeSet ps1;
PipeSet ps2;

// On screen color variables
int pR, pG, pB, pC;
int lRRed, lRGreen, lRBlue, lRCurve;
int rRRed, rRGreen, rRBlue, rRCurve;
int sMRed, sMGreen, sMBlue, sMCurve;

// On screen variables
float xOffset, yOffset;
float xMargin, yMargin, topPadding;
float xLengthSMenu, yLengthSMenu, xLengthVMenu, yLengthVMenu;
ScreenBox lm,                    // left menu box
          rm,                    // right menu box
          bg,                    // main screen background box
          leftBox,               // left box that contains PipeSet ps1
          rightBox,              // right box that contains PipeSet ps2
          cornerBox,             // appears when both xOffset and yOffset are nonzero
          statBoxL,              // shows the stats for sort of PipeSet ps1
          statBoxR,              // shows the stats for sort of PipeSet ps2
          speedSuperBox,         // sets the speed to superfast when clicked, in left menu
          speedFastBox,          // sets the speed to fast when clicked, in left menu
          speedMediumBox,        // sets the speed to medium when clicked, in left menu
          speedSlowBox,          // sets the speed to slow when clicked, in left menu
          lbAlgorithmBox,        // contains the buttons which change the ps1 sorting algorithm
          lbBubbleSortBox,       // sets the left algorithm to bubblesort
          lbSelectionSortBox,    // sets the left algorithm to selectionsort
          lbInsertionSortBox,    // sets the left algorithm to insertionsort
          lbQuickFirstSortBox,   // sets the left algorithm to quicksort first element
          lbQuickRandomSortBox,  // sets the left algorithm to quicksort random pivot
          lbQuickMedian3SortBox, // sets the left algorithm to quicksort median of three pivot
          rbAlgorithmBox,        // contains the buttons which change the ps2 sorting algorithm
          rbBubbleSortBox,       // sets the right algorithm to bubblesort
          rbSelectionSortBox,    // sets the right algorithm to selectionsort
          rbInsertionSortBox,    // sets the right algorithm to insertionsort
          rbQuickFirstSortBox,   // sets the right algorithm to quicksort first element
          rbQuickRandomSortBox,  // sets the right algorithm to quicksort random pivot
          rbQuickMedian3SortBox, // sets the right algorithm to quicksort median of three pivot
          pipeAmountBox,         // contains the buttons that change the number of pipes in ps1 and ps1
          pipe2Box,              // sets the right number of pipes to 2 when clicked
          pipe4Box,              // sets the right number of pipes to 4 when clicked
          pipe8Box,              // sets the right number of pipes to 8 when clicked
          pipe16Box,             // sets the right number of pipes to 16 when clicked
          pipe32Box,             // sets the right number of pipes to 32 when clicked
          pipe64Box,             // sets the right number of pipes to 64 when clicked
          startingSortBox;       // contains the buttons that change the initial sort of the pipes

void setup()
{
  // set sizes
  xOffset = 0;
  yOffset = 0;
  xMargin = 0.1 * width;
  yMargin = 0.1 * height;
  topPadding = 0.1 * height;
  xLengthSMenu = .25 * width;
  yLengthSMenu = height;
  xLengthVMenu = width;
  yLengthVMenu = height * .25;
  
  // set audio variables
  resetSounds();
  
  // set control variables
  clickPixelSensitivity = 5;
  clickTimeSensitivity = 250;    // 1/4 of a second click maximum
  numPipes = 16;
  sa1 = SortStep.BUBBLE;
  sa2 = SortStep.SELECTION;
  sorting = false;
  lastSwapCountL = 0;
  lastSwapCountR = 0;
  s = new Speed(Speed.MEDIUM);
    
  // set background
  background(0);
  
  // set alignment
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  
  // set left and right rectangle color and curvature
  lRRed = 167;
  lRGreen = 25;
  lRBlue = 80;
  lRCurve = 10;
  rRRed = lRRed + 128 % 256;
  rRGreen = lRGreen + 128 % 256;
  rRBlue = lRBlue + 128 % 256;
  rRCurve = 10;
  
  // set side menu color and curvature
  sMRed = 0;
  sMGreen = 0;
  sMBlue = 255;
  sMCurve = 10;
  
  // Set pipe color (maroon) and curvature
  pR = 128;
  pG = 0;
  pB = 0;
  pC = 5;
  
  // initialize all of the screen boxes that can appear
  createScreenBoxes();
  
  // set PipeSet variables and algorithm details
  resetAlgorithms();
}

void draw()
{
  // move to the next step of sorting each PipeSet
  if (sorting && frameCount % s.getFramesPerStep() == 0) {
    ps1.step();
    ps2.step();
  }  // end if
  
  // draw screen elements
  drawMainBox();
  drawMenuBoxes();
  
  // play sounds
  swapSounds();
    
}  // end draw

/*
 * 5 possibilites:
 *  1. Main screen clicked
 *      - toggle sorting when algorithms not yet complete
 *      - reset algorithms when algorithms have already completed
 *  2. Left menu clicked
 *      - change speeds (possibly)
 *  3. Right menu clicked 
 *      - nothing
 *  4. Top menu clicked
 *      - change number of pipes (possibly)
 *  5. Bottom menu clicked
 *      - change one of the algorithms (possibly)
 */
void mouseClicked() {
  
  if (bg.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
    // The main screen was clicked on
    if (ps1.sorted() && ps2.sorted()) {
      // both PipeSet objects are sorted, so reset the algorithms
      resetAlgorithms();
    }  // end if
    else {
      // the pipe sets have not yet been sorted, so toggle sorting
      sorting = !sorting;
    }  // end else
  }  // end if
  
  if (leftMenuOpen()) {
    // the left menu is open, so check whether the user changed the speed
    checkSpeedChange();
  }  // end if
  
  if (bottomMenuOpen()) {
    // the bottom menu is open, so check whether the user clicked the 
    // left or right algorithm box
    if (lbAlgorithmBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
      // the user clicked the left algorithm box, so check whether any of
      // the algorithm button boxes were clicked
      checkAlgorithmChangeLeft();
    }  // end if
    else if (rbAlgorithmBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
      // the user clicked the right algorithm box, so check whether any of
      // the algorithm button boxes were clicked
      checkAlgorithmChangeRight();
    }  // end else if
  }  // end if
  
  if (topMenuOpen()) {
    // the left menu is open, so check whether the user changed the number
    // of pipes
    if (pipeAmountBox.clickedOn(mouseX, mouseY, xOffset, yOffset)) {
      // the pipe number box (top left menu) was clicked, so check if the 
      // user clicked a pipe number button
      checkNumPipesChange();
    }  // end if
  }  // end if
}  // end mouseClicked

/*
 * No matter where the mouse was pressed, slide the screen if dragged
 */
void mouseDragged() {
  // determine which set of menues to show
  if (abs(mouseX - pmouseX) > abs(mouseY - pmouseY)) {
    xOffset += mouseX - pmouseX;
    xOffset = constrain(xOffset, xLengthSMenu * -1, xLengthSMenu);
  }
  else {
    yOffset += mouseY - pmouseY;
    yOffset = constrain(yOffset, yLengthVMenu * -1, yLengthVMenu);
  }
}

/*
 * Control the xOffset and yOffset variables so that the user may slide
 * the screen to one of the side menus.
 */
void mousePressed() {
  pressedTime = millis();
}  // end mouseReleased

/*
 * Control the xOffset and yOffset variables so that the user may slide
 * the screen to one of the side menus.
 */
void mouseReleased() {
  // android devices don't seem to respond to mouseClicked
  if (wasClick()) {
    mouseClicked();
  }  // end if
  else {
    snapMenu();
  }
}  // end mouseReleased

/*
 * determine whether user meant to click or not (drag)
 * Use in mouseReleased() method
 */
boolean wasClick() {
  if (abs(mouseX - pmouseX) < clickPixelSensitivity
      && abs(mouseY - pmouseY) < clickPixelSensitivity
      && millis() - pressedTime < clickTimeSensitivity) {
    return true;
  }
  return false;
}  // end method click

/*
 * void -> void
 * Reset the algorithms given the current values of the control variables
 */
void resetAlgorithms() {
  sorting = false;
  lastSwapCountL = 0;
  lastSwapCountR = 0;
  
  createPipeSets();
  leftBox.setLabel(ps1.getSortName());
  rightBox.setLabel(ps2.getSortName());
  statBoxL.setLabel(ps1.getSortName());
  statBoxR.setLabel(ps2.getSortName());
}  // end method resetAlgorithms

/*
 * Create the pipe sets based upon the current parameters
 */
void createPipeSets() {
  // create the first pipe set with random ordering
  ps1 = new PipeSet(numPipes, 
                    leftBox.getFirstAvailableX(), 
                    leftBox.getFirstAvailableY(), 
                    leftBox.getAvailableLengthX(), 
                    leftBox.getAvailableLengthY() / (float)numPipes, 
                    pR, 
                    pG, 
                    pB, 
                    pC);
  ps1.setSortStep(sa1);
  // create the second pipe set using the ordering from the first pipe set
  ps2 = new PipeSet(ps1.getOrdering(), 
                    rightBox.getFirstAvailableX(), 
                    rightBox.getFirstAvailableY(), 
                    rightBox.getAvailableLengthX(), 
                    rightBox.getAvailableLengthY() / (float)numPipes, 
                    pR, 
                    pG, 
                    pB, 
                    pC);
  ps2.setSortStep(sa2);
}  // end method createPipeSets

/*
 * play sound when swaps occur
 */
void swapSounds() {
    if (lastSwapCountL < ps1.getSwapCount()) {
      lastSwapCountL = ps1.getSwapCount();
      apSwap_h.play();
      apSwap_h.cue(0);
    }  // end if
    if (lastSwapCountR < ps2.getSwapCount()) {
      lastSwapCountR = ps2.getSwapCount();
      apSwap_l.play();
      apSwap_l.cue(0);
    }  // end if
}  // end method playSwapSounds

/*
 * Assigns the left and right swap sounds
 */
void resetSounds() {
  maxim = new Maxim(this);
  apSwap_l = maxim.loadFile("swap_l.wav");
  apSwap_l.setLooping(false);
  apSwap_h = maxim.loadFile("swap_h.wav");
  apSwap_h.setLooping(false);
}  // end method resetSounds
