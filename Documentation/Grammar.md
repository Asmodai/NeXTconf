program:        statements
        ;

statements:     statement statements
        |       /* empty */
        ;

statement:      ";"
        |       include_stmt
        |       expr ";"
        |       "print" expr ";"
        |       if_stmt
        |       for_stmt
        |       compound_stmt
        |       error ";"
        ;

include_stmt:   "include" string
        ;

if_stmt:        "if" "(" expr ")" statement        %prec LOWER_THAN_ELSE
        |       "if" "(" expr ")" statement "else" statement
        ;

for_stmt:       "for" identifier "in" "(" expr ")" statement
        ;

compound_stmt:  "{" statements "}"
        ;

expr:           equal_expr
        ;

equal_expr:     expr "==" assign_expr
        ;

assign_expr:    identifier "=" assign_expr
        |       concat_expr
        ;

concat_expr:    concat_expr "+" simple_expr
        |       logical_and_expr
        ;

logical_and_expr: logical_or_expr
        |         logical_and_expr "and" logical_or_expr
        ;

logical_or_expr: logical_xor_expr
        |        logical_or_expr "or" logical_xor_expr
        ;

logical_xor_expr: simple_expr
        |         logical_xor_expr "xor" simple_expr
        ;

simple_expr:    identifier
        |       string
        |       integer
        |       boolean
        |       "(" expr ")"
        |       method_call
        ;

method_call:    "[" class_name method_name "]"
        |       "[" class_name method_name ":" simple_expr "]"
        ;

class_name:     ID
        ;

method_name:    ID
        ;

identifier:     ID
        ;

integer:        INTEGER
        ;

boolean:        BOOLEAN
        ;

string:         STRING
        ;
