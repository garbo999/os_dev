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
  //offset = handle_scrolling(offset);
  // Update the cursor position on the screen device
  set_cursor(offset);
}

// Map row and column coordinates to the memory offset of a 
// particular display character cell from the start of video memory
int get_screen_offset(int row, int col) {
  int offset = (row * MAX_COLS + col) * 2;
  return offset;
}

int get_cursor() {
  // The device uses its control register as an index 
  // to select its internal registers, of which we are
  // interested in:
  // reg 14: high byte of cursor offset
  // reg 15: low byte of cursor offset
  // Once the internal register has been selected, we may read of
  // write a byte on the data register.
  port_byte_out(REG_SCREEN_CTRL, 14);
  int offset = port_byte_in(REG_SCREEN_DATA) << 8; // left-shift by bits (multiply by 256)
  port_byte_out(REG_SCREEN_CTRL, 15);
  offset += port_byte_in(REG_SCREEN_DATA);
  // Since the cursor offset reported by the VGA hardware is the
  // number of characters, we multiply by two to convert to 
  // a character cell offset.
  return offset * 2;
}

void set_cursor(int offset) {
  offset /= 2; // Convert from cell offset to char offset.
  // This is similar to get_cursor(), only now we write
  // bytes to those internal device registers.
  port_byte_out(REG_SCREEN_CTRL, 14);
  port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
  port_byte_out(REG_SCREEN_CTRL, 15);

  cursor_offset -= 2 * MAX_COLS;

  // Return updated cursor position ???
  // return cursor_offset;
}