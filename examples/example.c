#include <stdio.h>

int hoge(int x)
{
  printf("hoge %d\n", x);
  return x+1;
}

int main(int argc, char *argv[])
{
int i;
printf("hoge %d\n", hoge(1));
printf("hello world\n");
}

flo
