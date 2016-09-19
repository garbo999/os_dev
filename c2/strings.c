#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

void topntail(char *str) {
    size_t len = strlen(str);
    //assert(len >= 2); // or whatever you want to do with short strings
    memmove(str, str+1, len-2);
    str[len-2] = 0;
}

int main() {

  char str1[50] = "hzllo this is a text";
  char *str2;

  str2 = malloc(sizeof(*str2) * 50);

  str2[0] = '1';
  str2[1] = '2';
  str2[2] = '3';
  str2[3] = '\0';

  //char c1[1];

  printf("str1=%s\nstr2=%#010x\n", str1, str2);
  printf("str2=%s\n", str2);

  topntail(str1);
  printf("str1=%s\n", str1);

  printf("char1=%c\n", str1[0]);
  printf("char2=%c\n", str1[strlen(str1) - 1]);

  printf("New test\n");
  topntail(str2);
  printf("%s\n", str2 );
  return 0;
}