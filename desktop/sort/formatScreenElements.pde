/*
 * formatScreenElements.pde contains the methods to be called within the setup() method
 * is called in which the screen elements are initialized. The reason for creating another 
 * file is purely organizational. Now, if a method for formatting a screen element should 
 * be added, deleted or changed, you can look here.
 */

/*
 * Initialize the ScreenBox objects for all of the screen box elements (all of them).
 */
void createScreenBoxes() {
  // create background screen box
  bg = new ScreenBox(  0, 
                       0, 
                       width, 
                       height, 
                       0, 
                       0, 
                       0, 
                       10, 
                       "SORT COMPARISON",
                       ""  );
  
  // create side menu screen boxes
  lm = new ScreenBox(  0 - xLengthSMenu, 
                       0, 
                       xLengthSMenu, 
                       yLengthSMenu, 
                       sMRed, 
                       sMGreen, 
                       sMBlue, 
                       sMCurve, 
                       "Speed",
                       ""  );
  rm = new ScreenBox(  width, 
                       0, 
                       xLengthSMenu, 
                       yLengthSMenu, 
                       sMRed, 
                       sMGreen, 
                       sMBlue, 
                       sMCurve, 
                       "Stats",
                       ""  );
                       
  // create middle screen boxes
  leftBox = new ScreenBox(   xMargin, 
                             yMargin + topPadding, 
                             (width - 2 * xMargin) / 2.0, 
                             height - 2 * yMargin - topPadding, 
                             lRRed, 
                             lRGreen, 
                             lRBlue, 
                             lRCurve, 
                             "QuickSortR",
                              ""  );
  rightBox = new ScreenBox(  xMargin + (width - 2 * xMargin) / 2.0, 
                             yMargin + topPadding, 
                             (width - 2 * xMargin) / 2.0, 
                             height - 2 * yMargin - topPadding, 
                             rRRed, 
                             rRGreen, 
                             rRBlue, 
                             rRCurve, 
                             "QuickSortM3",
                             ""  );
                       
  // create stats boxes
  statBoxL = new ScreenBox(  width, 
                             2 * yMargin, 
                             xLengthSMenu, 
                             (height - 3 * yMargin) / 2.0,
                             lRRed, 
                             lRGreen, 
                             lRBlue, 
                             lRCurve, 
                             leftBox.getLabel(),
                             ""  );
  statBoxR = new ScreenBox(  width, 
                             2 * yMargin + (height - 3 * yMargin) / 2.0, 
                             xLengthSMenu, 
                             (height - 3 * yMargin) / 2.0, 
                             rRRed, 
                             rRGreen, 
                             rRBlue, 
                             rRCurve, 
                             rightBox.getLabel(),
                             ""  );
                       
  // create speed boxes
  float speedBoxYLength = (lm.getAvailableLengthY() / 4.0) * 0.8;
  speedSuperBox = new ScreenBox(  lm.getFirstAvailableX(), 
                                  lm.getFirstAvailableY(), 
                                  lm.getAvailableLengthX(), 
                                  speedBoxYLength,
                                  0, 
                                  0, 
                                  0, 
                                  10, 
                                  "",
                                  "SUPERFAST"  );
  speedFastBox = new ScreenBox(  lm.getFirstAvailableX(), 
                                  lm.getFirstAvailableY() + lm.getAvailableLengthY() / 4.0, 
                                  lm.getAvailableLengthX(), 
                                  speedBoxYLength,
                                  0, 
                                  0, 
                                  0, 
                                  10, 
                                  "",
                                  "FAST"  );
  speedMediumBox = new ScreenBox(  lm.getFirstAvailableX(), 
                                  lm.getFirstAvailableY() + lm.getAvailableLengthY() / 2.0, 
                                  lm.getAvailableLengthX(), 
                                  speedBoxYLength,
                                  0, 
                                  0, 
                                  0, 
                                  10, 
                                  "",
                                  "MEDIUM"  );
  speedMediumBox.select();
  speedSlowBox = new ScreenBox(  lm.getFirstAvailableX(), 
                                  lm.getLastAvailableY() - lm.getAvailableLengthY() / 4.0, 
                                  lm.getAvailableLengthX(), 
                                  speedBoxYLength,
                                  0, 
                                  0, 
                                  0, 
                                  10, 
                                  "",
                                  "SLOW"  );
                       
  // create left and right algorithm boxes on the bottom menu
  lbAlgorithmBox = new ScreenBox(  0, 
                                   height, 
                                   width / 2.0, 
                                   yLengthVMenu, 
                                   lRRed, 
                                   lRGreen, 
                                   lRBlue, 
                                   lRCurve, 
                                   "",
                                   ""  );
  rbAlgorithmBox = new ScreenBox(  width / 2.0, 
                                   height, 
                                   width / 2.0, 
                                   yLengthVMenu, 
                                   rRRed, 
                                   rRGreen, 
                                   rRBlue, 
                                   rRCurve, 
                                   "",
                                   ""  );
  
  // create the left and right algorithm selection boxes
  float algButtonBoxWidth = (lbAlgorithmBox.getAvailableLengthX() / 3.0) * 0.8;
  float algButtonBoxHeight = (lbAlgorithmBox.getAvailableLengthY() / 2.0) * 0.8;
  lbBubbleSortBox = new ScreenBox(  lbAlgorithmBox.getFirstAvailableX(), 
                                    lbAlgorithmBox.getFirstAvailableY(), 
                                    algButtonBoxWidth, 
                                    algButtonBoxHeight,
                                    0, 
                                    0, 
                                    0, 
                                    10, 
                                    "",
                                    "BubbleSort"  );
  lbBubbleSortBox.select();         // sets this as the default selected button
  lbSelectionSortBox = new ScreenBox(  lbAlgorithmBox.getFirstAvailableX() + lbAlgorithmBox.getAvailableLengthX() / 3.0, 
                                       lbAlgorithmBox.getFirstAvailableY(), 
                                       algButtonBoxWidth, 
                                       algButtonBoxHeight,
                                       0, 
                                       0, 
                                       0, 
                                       10, 
                                       "",
                                       "SelectionSort"  );
  lbInsertionSortBox = new ScreenBox(  lbAlgorithmBox.getLastAvailableX() - lbAlgorithmBox.getAvailableLengthX() / 3.0, 
                                       lbAlgorithmBox.getFirstAvailableY(), 
                                       algButtonBoxWidth, 
                                       algButtonBoxHeight,
                                       0, 
                                       0, 
                                       0, 
                                       10, 
                                       "",
                                       "InsertionSort"  );
  lbQuickFirstSortBox = new ScreenBox(  lbAlgorithmBox.getFirstAvailableX(), 
                                        lbAlgorithmBox.getFirstAvailableY() + lbAlgorithmBox.getAvailableLengthY() / 2.0, 
                                        algButtonBoxWidth, 
                                        algButtonBoxHeight,
                                        0, 
                                        0, 
                                        0, 
                                        10, 
                                        "",
                                        "QuickSort1st"  );
  lbQuickRandomSortBox = new ScreenBox(  lbAlgorithmBox.getFirstAvailableX() + lbAlgorithmBox.getAvailableLengthX() / 3.0, 
                                         lbAlgorithmBox.getFirstAvailableY() + lbAlgorithmBox.getAvailableLengthY() / 2.0, 
                                         algButtonBoxWidth, 
                                         algButtonBoxHeight,
                                         0, 
                                         0, 
                                         0, 
                                         10, 
                                         "",
                                         "QuickSortR"  );
  lbQuickMedian3SortBox = new ScreenBox(  lbAlgorithmBox.getLastAvailableX() - lbAlgorithmBox.getAvailableLengthX() / 3.0, 
                                          lbAlgorithmBox.getFirstAvailableY() + lbAlgorithmBox.getAvailableLengthY() / 2.0, 
                                          algButtonBoxWidth, 
                                          algButtonBoxHeight,
                                          0, 
                                          0, 
                                          0, 
                                          10, 
                                          "",
                                          "QuickSortM3"  );
  rbBubbleSortBox = new ScreenBox(  rbAlgorithmBox.getFirstAvailableX(), 
                                    rbAlgorithmBox.getFirstAvailableY(), 
                                    algButtonBoxWidth, 
                                    algButtonBoxHeight,
                                    0, 
                                    0, 
                                    0, 
                                    10, 
                                    "",
                                    "BubbleSort"  );
  rbSelectionSortBox = new ScreenBox(  rbAlgorithmBox.getFirstAvailableX() + rbAlgorithmBox.getAvailableLengthX() / 3.0, 
                                       rbAlgorithmBox.getFirstAvailableY(), 
                                       algButtonBoxWidth, 
                                       algButtonBoxHeight,
                                       0, 
                                       0, 
                                       0, 
                                       10, 
                                       "",
                                       "SelectionSort"  );
  rbSelectionSortBox.select();         // sets this as the default selected button
  rbInsertionSortBox = new ScreenBox(  rbAlgorithmBox.getLastAvailableX() - rbAlgorithmBox.getAvailableLengthX() / 3.0, 
                                       rbAlgorithmBox.getFirstAvailableY(), 
                                       algButtonBoxWidth, 
                                       algButtonBoxHeight,
                                       0, 
                                       0, 
                                       0, 
                                       10, 
                                       "",
                                       "InsertionSort"  );
  rbQuickFirstSortBox = new ScreenBox(  rbAlgorithmBox.getFirstAvailableX(), 
                                        rbAlgorithmBox.getFirstAvailableY() + rbAlgorithmBox.getAvailableLengthY() / 2.0, 
                                        algButtonBoxWidth, 
                                        algButtonBoxHeight,
                                        0, 
                                        0, 
                                        0, 
                                        10, 
                                        "",
                                        "QuickSort1st"  );
  rbQuickRandomSortBox = new ScreenBox(  rbAlgorithmBox.getFirstAvailableX() + rbAlgorithmBox.getAvailableLengthX() / 3.0, 
                                         rbAlgorithmBox.getFirstAvailableY() + rbAlgorithmBox.getAvailableLengthY() / 2.0, 
                                         algButtonBoxWidth, 
                                         algButtonBoxHeight,
                                         0, 
                                         0, 
                                         0, 
                                         10, 
                                         "",
                                         "QuickSortR"  );
  rbQuickMedian3SortBox = new ScreenBox(  rbAlgorithmBox.getLastAvailableX() - rbAlgorithmBox.getAvailableLengthX() / 3.0, 
                                          rbAlgorithmBox.getFirstAvailableY() + rbAlgorithmBox.getAvailableLengthY() / 2.0, 
                                          algButtonBoxWidth, 
                                          algButtonBoxHeight,
                                          0, 
                                          0, 
                                          0, 
                                          10, 
                                          "",
                                          "QuickSortM3"  );
  
  // create the options box and its members
  optionsBox = new ScreenBox(  xLengthVMenu / 2.0, 
                                    0 - yLengthVMenu, 
                                    xLengthVMenu / 2.0, 
                                    yLengthVMenu, 
                                    sMRed, 
                                    sMGreen, 
                                    sMBlue, 
                                    sMCurve, 
                                    "Options",
                                    ""  );
  // create boxes for buttons for setting the number of pipes
  float optionsBoxWidth = (optionsBox.getAvailableLengthX() / 3.0) * 0.8;
  float optionsBoxHeight = (optionsBox.getAvailableLengthY() / 2.0) * 0.8;
  nearlySortedBox = new ScreenBox(  optionsBox.getFirstAvailableX(), 
                             optionsBox.getFirstAvailableY(), 
                             optionsBoxWidth, 
                             optionsBoxHeight,
                             0, 
                             0, 
                             0, 
                             10, 
                             "",
                             "Nearly Sorted"  );
  reverseSortedBox = new ScreenBox(  optionsBox.getFirstAvailableX() + optionsBox.getAvailableLengthX() / 3.0, 
                             optionsBox.getFirstAvailableY(), 
                             optionsBoxWidth, 
                             optionsBoxHeight,
                             0, 
                             0, 
                             0, 
                             10, 
                             "",
                             "Reverse Sorted"  );;
  randomSortedBox = new ScreenBox(  optionsBox.getLastAvailableX() - optionsBox.getAvailableLengthX() / 3.0, 
                             optionsBox.getFirstAvailableY(), 
                             optionsBoxWidth, 
                             optionsBoxHeight,
                             0, 
                             0, 
                             0, 
                             10, 
                             "",
                             "Random Sorted"  );
  randomSortedBox.select();
  soundToggleBox = new ScreenBox(  optionsBox.getFirstAvailableX(), 
                              optionsBox.getFirstAvailableY() + optionsBox.getAvailableLengthY() / 2.0, 
                              optionsBoxWidth, 
                              optionsBoxHeight,
                              0, 
                              0, 
                              0, 
                              10, 
                              "",
                              "Sound On"  );
  soundToggleBox.select();
  
  // create the pipe amount box and its members
  pipeAmountBox = new ScreenBox(  0, 
                                  0 - yLengthVMenu, 
                                  xLengthVMenu / 2.0, 
                                  yLengthVMenu, 
                                  sMRed, 
                                  sMGreen, 
                                  sMBlue, 
                                  sMCurve, 
                                  "Number of Pipes",
                                  ""  );
  float pipeNumberBoxWidth = (pipeAmountBox.getAvailableLengthX() / 3.0) * 0.8;
  float pipeNumberBoxHeight = (pipeAmountBox.getAvailableLengthY() / 2.0) * 0.8;
  pipe2Box = new ScreenBox(  pipeAmountBox.getFirstAvailableX(), 
                             pipeAmountBox.getFirstAvailableY(), 
                             pipeNumberBoxWidth, 
                             pipeNumberBoxHeight,
                             0, 
                             0, 
                             0, 
                             10, 
                             "",
                             "2"  );
  pipe4Box = new ScreenBox(  pipeAmountBox.getFirstAvailableX() + pipeAmountBox.getAvailableLengthX() / 3.0, 
                             pipeAmountBox.getFirstAvailableY(), 
                             pipeNumberBoxWidth, 
                             pipeNumberBoxHeight,
                             0, 
                             0, 
                             0, 
                             10, 
                             "",
                             "4"  );;
  pipe8Box = new ScreenBox(  pipeAmountBox.getLastAvailableX() - pipeAmountBox.getAvailableLengthX() / 3.0, 
                             pipeAmountBox.getFirstAvailableY(), 
                             pipeNumberBoxWidth, 
                             pipeNumberBoxHeight,
                             0, 
                             0, 
                             0, 
                             10, 
                             "",
                             "8"  );
  pipe16Box = new ScreenBox(  pipeAmountBox.getFirstAvailableX(), 
                              pipeAmountBox.getFirstAvailableY() + pipeAmountBox.getAvailableLengthY() / 2.0, 
                              pipeNumberBoxWidth, 
                              pipeNumberBoxHeight,
                              0, 
                              0, 
                              0, 
                              10, 
                              "",
                              "16"  );
  pipe16Box.select();         // sets this box as the default selected
  pipe32Box = new ScreenBox(  pipeAmountBox.getFirstAvailableX() + pipeAmountBox.getAvailableLengthX() / 3.0, 
                              pipeAmountBox.getFirstAvailableY() + pipeAmountBox.getAvailableLengthY() / 2.0, 
                              pipeNumberBoxWidth, 
                              pipeNumberBoxHeight,
                              0, 
                              0, 
                              0, 
                              10, 
                              "",
                              "32"  );
  pipe64Box = new ScreenBox(  pipeAmountBox.getLastAvailableX() - pipeAmountBox.getAvailableLengthX() / 3.0, 
                              pipeAmountBox.getFirstAvailableY() + pipeAmountBox.getAvailableLengthY() / 2.0, 
                              pipeNumberBoxWidth, 
                              pipeNumberBoxHeight,
                              0, 
                              0, 
                              0, 
                              10, 
                              "",
                              "64"  );
                             
  // corner box renders in a corner when both xOffset and yOffset are nonzero
  // default position is off the screen to the top left
  cornerBox = new ScreenBox( 0 - xLengthSMenu, 
                             0 - yLengthVMenu, 
                             xLengthSMenu, 
                             yLengthVMenu, 
                             255, 
                             255, 
                             255, 
                             10, 
                             "",
                             ""  );
  
  setCenteredTextSizes();
}  // end createScreenBoxes

/*
 * The boxes which have centered text that appear in menus look a little weird
 * when the centered text has been maximized for each such box. This method
 * Finds the minimum size and changes the centered text size in each of the 
 * associated menus and sets them all to the minimum to ensure a nice appearance.
 */
void setCenteredTextSizes() {
  
  // algorithm box button text sizes
  int algButtonTextSize = min(min(rbBubbleSortBox.getCenteredTextSize(),
                                  rbSelectionSortBox.getCenteredTextSize(),
                                  rbInsertionSortBox.getCenteredTextSize()),
                              min(rbQuickFirstSortBox.getCenteredTextSize(),
                                  rbQuickRandomSortBox.getCenteredTextSize(),
                                  rbQuickMedian3SortBox.getCenteredTextSize()));
  // set all to the minimum
  lbBubbleSortBox.setCenteredTextSize(algButtonTextSize);
  lbSelectionSortBox.setCenteredTextSize(algButtonTextSize);
  lbInsertionSortBox.setCenteredTextSize(algButtonTextSize);
  lbQuickFirstSortBox.setCenteredTextSize(algButtonTextSize);
  lbQuickRandomSortBox.setCenteredTextSize(algButtonTextSize);
  lbQuickMedian3SortBox.setCenteredTextSize(algButtonTextSize);
  rbBubbleSortBox.setCenteredTextSize(algButtonTextSize);
  rbSelectionSortBox.setCenteredTextSize(algButtonTextSize);
  rbInsertionSortBox.setCenteredTextSize(algButtonTextSize);
  rbQuickFirstSortBox.setCenteredTextSize(algButtonTextSize);
  rbQuickRandomSortBox.setCenteredTextSize(algButtonTextSize);
  rbQuickMedian3SortBox.setCenteredTextSize(algButtonTextSize);
  
  // speed box button text sizes
  int speedButtonTextSize = min(min(speedSuperBox.getCenteredTextSize(),
                                    speedFastBox.getCenteredTextSize()),
                                min(speedMediumBox.getCenteredTextSize(),
                                    speedSlowBox.getCenteredTextSize()));
  // set all to the minimum
  speedSuperBox.setCenteredTextSize(speedButtonTextSize);
  speedFastBox.setCenteredTextSize(speedButtonTextSize);
  speedMediumBox.setCenteredTextSize(speedButtonTextSize);
  speedSlowBox.setCenteredTextSize(speedButtonTextSize);
  
  // number button text sizes
  int numberButtonTextSize = min(min(pipe2Box.getCenteredTextSize(),
                                  pipe4Box.getCenteredTextSize(),
                                  pipe8Box.getCenteredTextSize()),
                              min(pipe16Box.getCenteredTextSize(),
                                  pipe32Box.getCenteredTextSize(),
                                  pipe64Box.getCenteredTextSize()));
  // set all to the minimum
  pipe2Box.setCenteredTextSize(numberButtonTextSize);
  pipe4Box.setCenteredTextSize(numberButtonTextSize);
  pipe8Box.setCenteredTextSize(numberButtonTextSize);
  pipe16Box.setCenteredTextSize(numberButtonTextSize);
  pipe32Box.setCenteredTextSize(numberButtonTextSize);
  pipe64Box.setCenteredTextSize(numberButtonTextSize);
}  // end method setCenteredTextSizes

