#ifndef SAPHIRE_H
#define SAPHIRE_H

#include <string>
#include <vector>
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

class Integer : id {
public:
  long val;
};

class Real {
public:
  double val;
};

class Array {
  std::vector<id> vec;
public:
  id& operator[](long i) {
    return vec[i];
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