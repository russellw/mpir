#include <stdio.h>
#include <stdlib.h>

#include <gmp.h>

void err() {
  puts("*** ERROR ***");
  exit(1);
}

void test_int() {
  mpz_t x;
  mpz_init_set_str(x, "1000000000000000000000000000000", 10);

  mpz_t y;
  mpz_init_set_str(y, "2000000000000000000000000000000", 10);

  mpz_t z;
  mpz_init_set_str(z, "3000000000000000000000000000000", 10);

  mpz_t r;
  mpz_init(r);
  mpz_add(r, x, y);

  if (mpz_cmp(r, z))
    err();
}

void test_rat() {
  mpq_t x;
  mpq_init(x);
  mpq_set_str(x, "1000000000000000000000000000000/7", 10);

  mpq_t y;
  mpq_init(y);
  mpq_set_str(y, "2000000000000000000000000000000/7", 10);

  mpq_t z;
  mpq_init(z);
  mpq_set_str(z, "3000000000000000000000000000000/7", 10);

  mpq_t r;
  mpq_init(r);
  mpq_add(r, x, y);

  if (mpq_cmp(r, z))
    err();
}

int main(int argc, const char **argv) {
  test_int();
  test_rat();
  puts("ok");
  return 0;
}
