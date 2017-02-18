# Opcode

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
