const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#13122b", /* black   */
  [1] = "#0662B0", /* red     */
  [2] = "#4349A5", /* green   */
  [3] = "#0377C6", /* yellow  */
  [4] = "#9A6DB2", /* blue    */
  [5] = "#059DE3", /* magenta */
  [6] = "#42A4E1", /* cyan    */
  [7] = "#c4c3ca", /* white   */

  /* 8 bright colors */
  [8]  = "#626177",  /* black   */
  [9]  = "#0662B0",  /* red     */
  [10] = "#4349A5", /* green   */
  [11] = "#0377C6", /* yellow  */
  [12] = "#9A6DB2", /* blue    */
  [13] = "#059DE3", /* magenta */
  [14] = "#42A4E1", /* cyan    */
  [15] = "#c4c3ca", /* white   */

  /* special colors */
  [256] = "#13122b", /* background */
  [257] = "#c4c3ca", /* foreground */
  [258] = "#c4c3ca",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
