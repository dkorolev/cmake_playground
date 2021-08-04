#include <gtest/gtest.h>

#include "header.h"

TEST(TestOne, Smoke) {
  EXPECT_EQ(4, sum(2, 2));
  EXPECT_EQ(4, mul(2, 2));
}
