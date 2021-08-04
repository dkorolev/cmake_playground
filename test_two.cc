#include <gtest/gtest.h>

#include "header.h"

TEST(TestTwo, Regression) {
  for (int i = 0; i < 1000; ++i) {
    for (int j = 0; j < 1000; ++j) {
      EXPECT_EQ(i + j, sum(i, j));
      EXPECT_EQ(i * j, mul(i, j));
    }
  }
}
