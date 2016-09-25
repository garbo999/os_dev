void main() {
  // create char pointer to 1st cell of video memory // extra comment
  char* video_memory = (char*) 0xb8000;
  // store 'X' in top-left of screen
  *video_memory = 'D';
}