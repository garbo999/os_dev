/* Print a char on the screen at col, row, or at cursor position */
void print_char(char character, int col, int row, char attribute_byte) {
  // Create a byte (char) pointer to start of video memory
  unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;

  // If attribute_byte is zero, assume the default style
  if (!attribute_byte) {
    attribute_byte = WHITE_ON_BLACK;
  }

  // Get video memory offset for screen location
  int offset;
  // If col and row and non-negative, use them for offset
  if (col >= 0 && row >= 0) {
    offset = get_screen_offset(col, row);
  // Otherwise, use current cursor position  
  } else {
    offset = get_cursor();
  }

  // If we see a newline character, set offset to end of
  // current row, so it will be advanced to first column of
  // next row.
  if (character == '\n') {
    int rows = offset / (2 * MAX_COLS);
    offset = get_screen_offset(79, rows);
  // Otherwise, write the character and its attribute byte to
  // video memory at our calculated offset
  } else {
    vidmem[offset] = character;
    vidmem[offset + 1] = attribute_byte;
  }

  // Update the offset to the next character cell, which is 
  // two bytes ahead of the current cell
  offset += 2;
  // Make scrolling adjustment for when we reach bottom of screen
  offset = handle_scrolling(offset);
  // Update the cursor position on the screen device
  set_cursor(offset);
}

// Map row and column coordinates to the memory offset of a 
// particular display character cell from the start of video memory
int get_screen_offset(int row, int col) {
  int offset = (row * MAX_COLS + col) * 2;
  return offset;
}

