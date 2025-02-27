#!/bin/bash

if [ $# != "1" ]; then
    echo "CPPClassMaker <class name>"
fi

writeHPP() {
    cat $HOME/CPPClassMaker/Template.hpp.txt | sed -e "s/Template/$ClassName/g" > includes/$ClassHeaderName
}

writeCPP() {
    cat $HOME/CPPClassMaker/Template.cpp.txt | sed -e "s/Template/$ClassName/g" > src/$ClassSourceName
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
