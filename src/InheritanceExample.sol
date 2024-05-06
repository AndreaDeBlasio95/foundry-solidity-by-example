// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/* Inheritance Structure
    A
   / \
  B   C
 / \\//
F  D,E
*/

contract A {
    // Base contract A with a virtual function foo().
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

// Contract B inherits from A.
contract B is A {
    // Overrides foo() from A, still marked virtual for further overriding.
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

// Contract C also inherits from A.
contract C is A {
    // Overrides foo() from A, still marked virtual for further overriding.
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

// Contract D inherits from both B and C.
contract D is B, C {
    // Overrides foo(). The right-most parent (C) takes precedence with super.
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo(); // Returns "C" because C is the right-most parent with foo()
    }
}

// Contract E inherits from C and B, opposite of D.
contract E is C, B {
    // Overrides foo(). The right-most parent (B) takes precedence with super.
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo(); // Returns "B" because B is the right-most parent with foo()
    }
}

// Contract F inherits from A and B. Note the correct order of inheritance.
contract F is A, B {
    // Overrides foo(). Here, B as the most derived relevant implementation is called.
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo(); // Returns "B" as B overrides A
    }
}
