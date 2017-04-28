Definitions.

INT = [0-9]+
DICE_OP = [Dd]
WHITESPACE = [\s\t]

Rules.

{INT} : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
\+ : {token, {'+', TokenLine}}.
\- : {token, {'-', TokenLine}}.
\* : {token, {'*', TokenLine}}.
\/ : {token, {'/', TokenLine}}.
\( : {token, {'(', TokenLine}}.
\) : {token, {')', TokenLine}}.
{DICE_OP} : {token, {dice_op, TokenLine}}.
{WHITESPACE}+ : skip_token.

Erlang code.
