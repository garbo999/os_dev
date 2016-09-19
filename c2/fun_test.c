// header
//void topntail(char *str);

char * fun_2(char *str2) {
  return str2;
}

int fun_1(char *str1) {
  char *str3;
  str3 = fun_2("hello");
}

/*void topntail(char *str) {
    size_t len = strlen(str);
    //assert(len >= 2); // or whatever you want to do with short strings
    memmove(str, str+1, len-2);
    str[len-2] = 0;
}
*/