Release 0.93  Copyleft (c)2017 by Paul Ward.  All Rights Reserved.

# Opcode

## Virtual machine

NeXTconf utilises a stack-based virtual machine to interpret opcode.

You can view the opcode of any script by invoking NeXTconf with the `-c` option.

For example, let's say the file `example` has the code:
```objc
thePlat = [Platform platform];
theArch = [Architecture currentArchitecture];
theProc = [Architecture currentProcessor];
theVers = [Platform versionString];

print "Platform:     " + thePlat;
print "Architecture: " + theArch;
print "Processor:    " + theProc;

if ([Platform isOpenStep] == true) {
  print "We are OpenStep " + theVers;
} else {
  print "We are NOT OpenStep.";

  if ([Platform majorVersion] != 4) {
    print "Hello, NeXTSTEP 3 user!";
  } else {
    print "Wow, what are you using?";
  }
}
```
The result of executing `nextconf -cf example` will be
```
Intermediate code <IntInstr:0x10143c>
         1: OP_CALL     platform            ; Invoke `platform` method.
         2: OP_POP      thePlat             ; Pop returned value into `thePlat`.
         3: OP_CALL     currentArchitecture
         4: OP_POP      theArch
         5: OP_CALL     currentProcessor
         6: OP_POP      theProc
         7: OP_CALL     versionString
         8: OP_POP      theVers
         9: OP_PUSH     strconst1           ; Push `strconst1` symbol to stack.
        10: OP_PUSH     thePlat             ; Push `thePlat` object to stack.
        11: OP_CONCAT                       ; Concatenate from stack and push new value.
        12: OP_PRINT                        ; Pop from stack and print. 
        13: OP_PUSH     strconst2
        14: OP_PUSH     theArch
        15: OP_CONCAT
        16: OP_PRINT
        17: OP_PUSH     strconst3
        18: OP_PUSH     theProc
        19: OP_CONCAT
        20: OP_PRINT
        21: OP_CALL     isOpenStep          ; Invoke `isOpenStep` method.
        22: OP_PUSH     immedval1           ; Push `immedval1` symbol to stack.
        23: OP_EQL                          ; Test if they are equal and push result.
        24: OP_JMPF     31                  ; Pop result, compare to `false`, jump to 31 if so.
        25: OP_PUSH     strconst4
        26: OP_PUSH     theVers
        27: OP_CONCAT
        28: OP_PRINT
        29: OP_NOP
        30: OP_JMP      48                  ; Jump to 48.
        31: JMPTGT      24                  ; Jump target from `OP_JMPF' on line 24.
        32: OP_PUSH     strconst5
        33: OP_PRINT
        34: OP_CALL     majorVersion        ; Invoke `majorVersion` method.
        35: OP_PUSH     immedval2           ; Push `immedval2` symbol to stack.
        36: OP_NEQ                          ; Test if they are not equal and push result.
        37: OP_JMPF     42                  ; Pop result, compare to `false`, jump to 42 if so.
        38: OP_PUSH     strconst6
        39: OP_PRINT
        40: OP_NOP
        41: OP_JMP      46
        42: JMPTGT      37
        43: OP_PUSH     strconst7
        44: OP_PRINT
        45: OP_NOP
        46: JMPTGT      41
        47: OP_NOP
        48: JMPTGT      30
        49: OP_NOP

Platform:     OPENSTEP
Architecture: I386
Processor:    Intel 486
We are OpenStep 4.2
```

Comments have been added by me to this document to highlight some opcode patterns.

## Opcode table

| Opcode       | Operation                                                             |
|:-------------|:----------------------------------------------------------------------|
| `OP_NOP`     | No operation.                                                         |
| `OP_PUSH`    | Push to the stack.                                                    |
| `OP_POP`     | Pop from the stack.                                                   |
| `OP_PRINT`   | Print something to standard output.                                   |
| `OP_JMP`     | Jump to a jump target.                                                |
| `OP_JMPF`    | Jump to a jump target if `false` is popped from the stack.            |
| `OP_EQL`     | Generic equality test.                                                |
| `OP_NEQ`     | Generic non-equality test.                                            |
| `OP_ADD`     | Numeric addition.                                                     |
| `OP_SUB`     | Numeric subtraction.                                                  |
| `OP_MUL`     | Numeric multiplication.                                               |
| `OP_DIV`     | Numeric division.                                                     |
| `OP_LAND`    | Logical `AND` test.                                                   |
| `OP_LOR`     | Logical _inclusive_ `OR` test.                                        |
| `OP_LXOR`    | Logical _exclusive_ `OR` test.                                        |
| `OP_CONCAT`  | Concatenate two things.                                               |
| `OP_CALL`    | Calls an object's method.                                             |
| `OP_CALLA`   | Calls an object's method with an argument.                            |
| `OP_BLN2STR` | Convert a boolean to a string.                                        |
| `JMPTGT`     | A label for jumps. Is never evaluated.                                |

## Opcode descriptions

### `OP_NOP`
This opcode does absolutely nothing.

### `OP_PUSH`
This opcode pushes an object to the stack.

### `OP_POP`
This opcode pops an object from the stack.

### `OP_PRINT`
This opcode pops an object from the stack and then prints it out to standard
output.

### `OP_JMP`
This opcode jumps to specific instruction line number.

### `OP_JMPF`
This opcode pops an object from the stack and compares it to `false`.  If the
object is `false`, then it jumps to the specific instruction line number.

### `OP_EQL`
This opcode pops two objects from the stack and compares them for equality.  If
the objects are equal, then `true` is pushed to the stack; otherwise `false` is
pushed instead.

### `OP_NEQ`
This opcode is the inverse of `OP_EQL`, pushing `true` if the two objects are
not equal, and pushing `false` if they are equal.

### OP_ADD
This opcode pops two objects from the stack and attempts to add them together,
pushing the result back to the stack.

### OP_SUB
This opcode pops two objects from the stack and attempts to subtract them,
pushing the result back to the stack.

### OP_MUL
This opcode pops two objects from the stack and attempts to multiply them,
pushing the result back to the stack.

### OP_DIV
This opcode pops two objects from the stack and attempts to divide them,
pushing the result back to the stack.

### `OP_LAND`
This opcode pops two objects from the stack and performs a logical `AND` on
them, such at `object1 AND object2`.  The results of the test are pushed to the
stack.

### `OP_LOR`
This opcode pops two objects from the stack and performs a logical inclusive
`OR` on them, such that `object1 OR object2`.  The results of the test are
pushed to the stack.

### `OP_LXOR`
This opcode pops two objects from the stack and performs a logical inclusive
`OR` on them, such that `object1 XOR object2`.  The results of the test are
pushed to the stack.

### `OP_CONCAT`
This opcode pops two objects from the stack and concatenates them, pushing the
result to the stack.

### `OP_CALL`
This opcode calls the method named in its immediate value, pushing the result of
the call to the stack.

### `OP_CALLA`
This opcode pops an object from the stack and then calls the method named in its
immediate value using the object as an argument.  The result of the call is
pushed to the stack.

### `OP_BLN2STR`
This opcode pops an object from the stack, converts it to a boolean value, and
then pushes the boolean to the stack.

### `JMPTGT`
The virtual machine treats this as an `OP_NOP` instruction.
