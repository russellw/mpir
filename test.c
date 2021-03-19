#include <stdio.h>
#include <gmp.h>

int main(int argc, const char **argv) {
  mpz_t z;
  mpz_init_set_str(z,"123",10);
  mpz_out_str(stdout,10,z);
  putchar('\n');
  return 0;
}
