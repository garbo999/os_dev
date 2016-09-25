#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int main(int argc, char *argv[]) {

/*  for (int i = 0; i < argc; i++)
  {
    printf("argv[%i]='%s'\n", i, argv[i]);
  }
*/

  int count = atoi(argv[1]);
  int num = count;

  printf("count=%i\n", count);

  while (true) {
    //printf("num=%i\n", num);
    int flag_divide = 0;
    for (int i = 2; i < count; i++) // only up to count - 1 (since num is multiple of count)
    {
      //printf("i=%i\n", i);
      if (num % i != 0) {
        flag_divide = 1;
        break; // break from for loop
      }
    }
    if (flag_divide == 0) {
      // success
      printf("RESULT=%i\n", num);
      break; // break from infinite while loop
    }
    num += count; // increment by count (10 or 20)
  }
  return 0;
}
