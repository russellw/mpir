#include <stdio.h>
#include <stdlib.h>

#include <gmp.h>

void err(){
	puts("*** ERROR ***");
	exit(1);
}

void test_int(){
	mpz_t x,y,z,r;
  mpz_init_set_str(x,"1000000000000000000000000000000",10);
  mpz_init_set_str(y,"2000000000000000000000000000000",10);
  mpz_init_set_str(z,"3000000000000000000000000000000",10);
  mpz_init(r);
  mpz_add(r,x,y);
  if(mpz_cmp(r,z))
  	err();
}

int main(int argc, const char **argv) {
	test_int();
  puts("ok");
  return 0;
}
