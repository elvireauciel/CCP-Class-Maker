#!/bin/bash

if [ $# != "1" ]; then
    echo "CPPClassMaker <class name>"
fi

writeHPP() {
    echo "
#pragma once
#include <iostream>

class $ClassName
{
private:
    
public:
    $ClassName();
    $ClassName(const $ClassName &copy);
    virtual ~$ClassName();

    $ClassName &operator=(const $ClassName &other);
};" >includes/$ClassHeaderName
}

writeCPP()
{
    echo "
#include \"$ClassName.hpp\"

///////////////////////////////////////////////////////////////////
///                  CONSTRUCTORS | DESTRUCTORS                  //
///////////////////////////////////////////////////////////////////

$ClassName::$ClassName()
{
    std::cout << \"$ClassName Constructor called\" << std::endl;
}

$ClassName::~$ClassName()
{
    std::cout << \"$ClassName Destructor called\" << std::endl;
}

$ClassName::$ClassName(const $ClassName &copy)
{
    std::cout << \"$ClassName copy Constructor called\" << std::endl;
    *this = copy;
}

///////////////////////////////////////////////////////////////////
///                        OPERATORS                             //
///////////////////////////////////////////////////////////////////

$ClassName &$ClassName::operator=(const $ClassName &other)
{
    // code
    return (*this);
}

///////////////////////////////////////////////////////////////////
///                    GETTERS | SETTERS                         //
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////
///                     MEMBER FUNCTIONS                         //
///////////////////////////////////////////////////////////////////
    "  > src/$ClassSourceName
}

ClassName=$1
ClassHeaderName=$1.hpp
ClassSourceName=$1.cpp

if [ $# = "1" ]; then
    test -d includes
    if [ $? != 0 ]; then
        mkdir includes
    fi
    writeHPP
    test -d src
    if [ $? != 0 ]; then
        mkdir src
    fi
    writeCPP
fi
