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

class Integer : id {
public:
  long val;
};

class Real {
public:
  double val;
};

class NilClass : id {
public:
  std::string description() {
    return "nil";
  }
};

extern NilClass nil;

#endif