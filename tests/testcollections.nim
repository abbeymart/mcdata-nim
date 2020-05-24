# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import mcdata

echo "Collections (Array) Filtering"
    
const 
    myArray = @[10, 20, 31, 40, 51, 63, 70, 80, 95, 105, 110, 121, 150]
    myArray2 = @["Abiodun", "Olawale", "Abi", "Ola", "Akindele", "Olayemi", "Vic"]
    
# ***Implementation - examples***

# IPredicate implementation
proc myFilterFunc(val: int): bool =
  val mod 2 == 0

# StringPredicate implementation
proc myFilterFunc(val: string): bool =
  len(val) > 5

proc myFilterStringFunc(val: string): bool =
  len(val) > 5

test "Filter: specific and generic functions: ":
  check $(filterFunc(myArray, myFilterFunc)) == "@[10, 20, 40, 70, 80, 110, 150]"
  check filterFunc(myArray, myFilterFunc) == @[10, 20, 40, 70, 80, 110, 150]
  check filterFunc(myArray2, myFilterStringFunc) == @["Abiodun", "Olawale", "Akindele", "Olayemi"]
  check filterFunc[int, IPredicate](myArray, myFilterFunc) == @[10, 20, 40, 70, 80, 110, 150]
  check filterFunc[string, StringPredicate](myArray2, myFilterStringFunc) == @["Abiodun", "Olawale", "Akindele", "Olayemi"]
  check filterFunc[int, Predicate[int]](myArray, myFilterFunc) == @[10, 20, 40, 70, 80, 110, 150]
  check filterFunc[string, Predicate[string]](myArray2, myFilterStringFunc) == @["Abiodun", "Olawale", "Akindele", "Olayemi"]


test "generic filter and specific action functions: ":
  check filterFunc[int, IPredicate](myArray, myFilterFunc) == @[10, 20, 40, 70, 80, 110, 150]
  check filterFunc[string, StringPredicate](myArray2, myFilterStringFunc) == @["Abiodun", "Olawale", "Akindele", "Olayemi"]
  
test "generic filter and action functions: ":
  check filterFunc[int, Predicate[int]](myArray, myFilterFunc) == @[10, 20, 40, 70, 80, 110, 150]
  check filterFunc[string, Predicate[string]](myArray2, myFilterStringFunc) == @["Abiodun", "Olawale", "Akindele", "Olayemi"]

# test "can add":
#   check add(5, 5) == 10