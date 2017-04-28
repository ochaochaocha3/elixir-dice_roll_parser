Nonterminals
command expression dice_roll uminus.

Terminals
integer dice_op
'(' ')' '+' '-' '*' '/'.

Unary 1000 uminus.
Left 300 dice_roll.
Left 200 '*' '/'.
Left 100 '+' '-'.

Rootsymbol command.

command -> expression : '$1'.

expression -> expression '+' expression : {add, '$1', '$3'}.
expression -> expression '-' expression : {sub, '$1', '$3'}.
expression -> expression '*' expression : {mul, '$1', '$3'}.
expression -> expression '/' expression : {div_node, '$1', '$3'}.
expression -> '(' expression ')' : '$2'.
expression -> integer : to_integer('$1').
expression -> dice_roll : '$1'.
expression -> uminus : '$1'.

uminus -> '-' expression : {unary_op, '-', '-', '$2'}.

dice_roll -> integer dice_op integer : {dice_roll, to_integer('$1'), to_integer('$3')}.

Erlang code.

to_integer({integer, _, N}) -> N.
