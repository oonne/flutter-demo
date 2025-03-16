import 'dart:math';

/* 
 * 获取n以内的随机整数
 */
int randomWithin(int n) {
  if (n < 0) {
    n = 0;
  }
  if (n > pow(2, 32)) {
    n = pow(2, 32) as int;
  }

  Random random = Random();
  return random.nextInt(n);
}

/*
 * 获取n位的数字随机数
 */
int randomDigits(int digits) {
  if (digits <= 0) {
    return 0;
  }

  int result = 0;
  for (int i = 0; i < digits; i++) {
    int digit = randomWithin(10);
    result = result * 10 + digit;
  }

  return randomWithin(pow(10, digits) as int) + pow(10, digits - 1) as int;
}

/*
 * 获取n位的随机数字或字母
 */
String randomString(int length) {
  String result = '';
  for (int i = 0; i < length; i++) {
    int type = randomWithin(2);
    int digit = randomWithin(10);
    if (type == 0) {
      result += String.fromCharCode(digit + 48);
    } else {
      result += String.fromCharCode(digit + 65);
    }
  }
  return result;
}