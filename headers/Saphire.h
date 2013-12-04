#ifndef SAPHIRE_H
#define SAPHIRE_H

#include <string>
#include <exception>

class id {
public:
  std::string description() {
    return "#<id>";
  }
};

class String : id {
  std::string str;
public:
  std::string description() {
    return "\""+str+"\"";
  }
};

class Number : id {
  bool _is_int;
  union {
    long integer;
    double real;
  } val;
public:
  class InvalidAccessException : std::exception {};
  bool is_int() {
    return _is_int;
  }
  void set_long(long i) {
    val.integer = i;
    _is_int = true;
  }
  void set_double(double d) {
    val.real = d;
    _is_int = false;
  }
  long get_long() {
    if (_is_int) {
      return val.integer;
    } else {
      throw(new InvalidAccessException);
    }
  }
  double get_double() {
    if (!_is_int) {
      return val.real;
    } else {
      throw(new InvalidAccessException);
    }
  }
};

class NilClass : id {
public:
  std::string description() {
    return "nil";
  }
};

extern NilClass nil;

#endif