#
#            mconnect collections package
#        (c) Copyright 2020 Abi Akindele (mconnect.biz)
#
#    See the file "LICENSE.md", included in this
#    distribution, for details about the copyright / license.
#

import sequtils, sugar

##[The collections interface/types for handling various collection tasks:
  Predicate, Function, Operation, Consumer, Supplier etc.
  ]##
type
    IPredicate* = proc(val: int): bool {.closure.} # {.closure.} is default to proc type
    StringPredicate* = proc(val: string): bool {.closure.} 
    Predicate*[T] = proc(val: T): bool {.closure.} 
    BinaryPredicate*[T, U] = proc(val1: T, val2: U ): bool {.closure.} 
    UnaryOperator*[T] = proc(val: T): T {.closure.} 
    BinaryOperator*[T] = proc(val1, val2: T): T {.closure.} 
    Function*[T, R] = proc(val: T): R {.closure.} 
    BiFunction*[T, U, R] = proc(val1: T, val2: U): R {.closure.} 
    Consumer*[T] = proc(val: T) {.closure.} 
    BiConsumer*[T, U] = proc(val1: T, val2: U) {.closure.} 
    Supplier*[R] = proc(): R {.closure.} 
    Comparator*[T] = proc(val1: T, val2: T): int {.closure.} 

# Collection procedures/functions - overloaded procedures

# Generic filter function - using Predicate type
proc filterFunc*[T, U](arr: seq[T], filterFn: U): seq[T] =
    # functional style
    # result = arr.filter((x:T)->bool => filterFn(x))
    result = arr.filter(it => filterFn(it))

# Integer filter function - using IPredicate type
proc filterFunc*(arr: seq[int], filterFn: IPredicate): seq[int] =
    var myResult: seq[int] = @[]
    
    for i in arr:
        if(filterFn(i)):
            myResult.add(i)
    result = myResult

# String filter function - using StringPredicate type
proc filterFunc*(arr: seq[string], filterFn: StringPredicate): seq[string] =
        var myResult: seq[string] = @[]
        # echo "arr-result, start: ", myResult
        
        for i in arr:
            if(filterFn(i)):
                myResult.add(i)
        result = myResult
        # echo "arr-result, final: ", myResult    

# TODO: define other collection types: BinaryPredicate, UnaryOperator, BinaryOperator,
# TODO: Function, BiFunction, Consumer, BiConsumer, Supplier, Comparator...

# Run the following test, if mainModule
when isMainModule:
    # ***Implementation - examples***
    const 
        myArray = @[10, 20, 31, 40, 51, 63, 70, 80, 95, 105, 110, 121, 150]
        myArray2 = @["Abiodun", "Olawale", "Abi", "Ola", "Akindele", "Olayemi", "Vic"]
  
    # IPredicate implementation
    proc myFilterFunc(val: int): bool =
            val mod 2 == 0

    # StringPredicate implementation
    proc myFilterStringFunc(val: string): bool =
        len(val) > 5

    echo "specific type filter and action functions"
    echo "******************************"
    echo filterFunc(myArray, myFilterFunc)
    echo $(filterFunc(myArray, myFilterFunc)) == "@[10, 20, 40, 70, 80, 110, 150]"
    echo filterFunc(myArray, myFilterFunc) == @[10, 20, 40, 70, 80, 110, 150]
    doAssert filterFunc(myArray, myFilterFunc) == @[10, 20, 40, 70, 80, 110, 150]
    echo filterFunc(myArray2, myFilterStringFunc)
    echo filterFunc(myArray2, myFilterStringFunc) == @["Abiodun", "Olawale", "Akindele", "Olayemi"]
    # echo $(filterFunc(myArray2, myFilterStringFunc) == "@['Abiodun', 'Olawale', 'Akindele', 'Olayemi']"
    doAssert filterFunc(myArray2, myFilterStringFunc) == @["Abiodun", "Olawale", "Akindele", "Olayemi"]
    echo ""
    echo "generic filter and specific action functions"
    echo "******************************"
    echo filterFunc[int, IPredicate](myArray, myFilterFunc)
    echo filterFunc[string, StringPredicate](myArray2, myFilterStringFunc)
    echo ""
    echo "generic filter and action functions"
    echo "******************************"
    echo filterFunc[int, Predicate[int]](myArray, myFilterFunc)
    echo filterFunc[string, Predicate[string]](myArray2, myFilterStringFunc)
    echo ""
