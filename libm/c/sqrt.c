/*
 * https://linux.die.net/man/3/dlvsym
 */
#define _GNU_SOURCE

#include <stdio.h>
#include <dlfcn.h>

int main() {
  char function[] = "sqrt";
  char version[]  = "GLIBC_2.2.5";
  void *h = dlvsym( RTLD_DEFAULT, function, version );
  if (h)
    printf( "SUCCESS: Function <<%s>> present in <<%s>>\n",function,version );
  else
    printf( "FAILURE: Did not find Function <<%s>> in <<%s>>\n",function,version );
  return 0;
}
