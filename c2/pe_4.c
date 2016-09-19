#include <stdio.h>
#include <stdbool.h>
#include <string.h>

void topntail(char *str) {
    size_t len = strlen(str);
    //assert(len >= 2); // or whatever you want to do with short strings
    memmove(str, str+1, len-2);
    str[len-2] = 0;
}

bool palindrome(char *my_int_string) {
  //printf("Start of palindrome function\n");
  //printf("  strlen=%d\n", strlen(my_int_string));
  //printf("  str=%s\n", my_int_string);

  // if len(my_int_string) == 0 or 1, return TRUE
  if (strlen(my_int_string) == 0 || strlen(my_int_string) == 1) {
    return true;

  // else peel off outer two characters:
  //    if EQUAL, recurse on inner
  //    else return FALSE
  } else {
    int len1 = strlen(my_int_string);

    if (my_int_string[0] == my_int_string[len1 - 1])  {
      topntail(my_int_string);
      palindrome(my_int_string);
    } else {
      return false;
    }
  }
}

int main(void) {

  char my_str[50];
  int min = 1000;
  int max = 10000;
  int i, j;
  int largest_num = 0;

  for (i = min; i < max; ++i) {
    for (j = i; j < max; ++j) {
      sprintf(my_str,"%d",i*j); // converts integer to string
      if (palindrome(my_str)) {
        printf("%d = %d * %d\n", i*j, i, j);
        if (i*j > largest_num) {
          largest_num = i*j;
        }
      }
    }
  }

  printf("Largest number = %d\n", largest_num);
  return 0;
}