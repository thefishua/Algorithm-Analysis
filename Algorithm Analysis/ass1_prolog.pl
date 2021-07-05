% Joshua Fish, z5311886, ass1_prolog

:- set_prolog_flag(answer_write_options, [max_depth(0)]).

% Question 1.1 List Processing

% Base Case
% List is an empty list then the sum is equal to zero
sumsq_even([], 0).
% If the list is not empty then all even numbers within the list are squared n * n
% To deduce an even number using the N mod 2, which should = 0 for even numbers
% Then the function should provide a true/false statement depending on the outcome
sumsq_even([H | T], S) :-
    sumsq_even(T, S1), % Traverses the list
    Even is ((H + 1) mod 2) * H * H, % Finding even values when H + 1 mod 2 is used even values will equal 1
    S is Even + S1. % Sum

% Tests for sumsq_even()

% Test 1 sumsq_even() for input of an empty list
% Expected output is a 0
test_sumsq_even_1(S) :- sumsq_even([],S).
% Test 2 sumsq_even() for input of only even numbers
% Expected output is 56
test_sumsq_even_2(S) :- sumsq_even([1, 2, 3, 4, 5, 6],S).
% Test 3 sumsq_even() for input of only negative numbers
% Expected output is 56
test_sumsq_even_3(S) :- sumsq_even([-1, -2, -3, -4, -5, -6],S).
% Test 4 sumsq_even() for input of a mix of negative and positive numbers
% Expected output is 120
test_sumsq_even_4(S) :- sumsq_even([1, 3, 5, 2, -4, 6, 8, -7],S).
% test 5 sumsq_even() for input of the value zero
% Expected output is 0
test_sumsq_even_5(S) :- sumsq_even([0],S).

% Question 1.2 List Processing
% Base Case
% List is an empty list meaning no response from the user
% The response X will be a list being set as "sorry, I didn't understand that."
eliza1([], []).
% If the list is a non-empty list then eliza will respond with
% a list prepended with "what makes you say" then
% If list X contains a word you then delete you and replace with i
% If list X contains a word me then delete me and replace with you
% If list X contains a word my then delete my and replace with your
% Then with the new list concatenate it with a prepended list to create the response
eliza1(User, Response) :-  
    removeYou(you, User, Added_i),
    removeMe(me, Added_i, Added_You),
    removeMy(my, Added_You, Added_Your),
    conc([what, makes, you, say], Added_Your, Response).

% concanating the lists
conc([], L, L).
conc([X | L1], L2, [X | L3]) :-
    conc(L1, L2, L3).

% Want to use a list of facts rather than repeating code
%swap(you, i).
%swap(me, you).
%swap(my, your).

% deleting the word(s) and replacing with a new word
% List is empty there is nothing to remove or X is not an element
removeYou(_, [], []).
% For an element X that is in the list at the head then remove that element and insert the responding word
removeYou(X, [X|T], L):- removeYou(X, [i|T], L), !.
% If the element X is not at the start of the list then recursive till X is found
removeYou(X, [H|T], [H|L]):- removeYou(X, T, L).

removeMe(_, [], []).
% For an element X that is in the list at the head then remove that element and insert the responding word
removeMe(X, [X|T], L):- removeMe(X, [you|T], L), !.
% If the element X is not at the start of the list then recursive till X is found
removeMe(X, [H|T], [H|L]):- removeMe(X, T, L).

removeMy(_, [], []).
% For an element X that is in the list at the head then remove that element and insert the responding word
removeMy(X, [X|T], L):- removeMy(X, [your|T], L), !.
% If the element X is not at the start of the list then recursive till X is found
removeMy(X, [H|T], [H|L]):- removeMy(X, T, L).


% Tests for eliza1()

% Test 1 user has no response/empty list is given
% Expected output is an empty list
test_eliza1_1(N) :- eliza1([], N).
% Rest of tests is with user having a simple response with the word "you" being the first element of the list
% Expected output is a response of " what makes you say" with a response depended on the user input

% Test 2 eliza1()
% input: [you, do, not, like, me]
% output: [what, makes, you, say, i, do, not, like, you]
test_eliza1_2(N) :- eliza1([you, do, not, like, me], N).

% Test 3 eliza1()
% input: [you, do, not, understand, my feelings]
% output: [what, makes, you, say, i, do, not, understand, your, feelings]
test_eliza1_3(N) :- eliza1([you, do, not, understand, my, feelings], N).

% Test 4 eliza1()
% input: [you, do, not, want, me to be my best]
% output: [what, makes, you, say, i, do, not, want, you, to, be, your, best]
test_eliza1_4(N) :- eliza1([you, do, not, want, me, to, be, my, best], N).

% Test 5 eliza1()
% input: [you, do, not, like, me, and, you, do, not, understand, me]
% output: [what, makes, you, say, i, do, not, like, you, and, i, do, not, understand, you]
test_eliza1_5(N) :- eliza1([you, do, not, like, me, and, you, do, not, understand, me], N).

% Test 6 eliza1()
% input: [you, do, not, like, my, hair, my, eye, my, nose, my, ears]
% output: [what, makes, you, say, i, do, not, like, your, hair, your, eye, your, nose, your, ears]
test_eliza1_6(N) :- eliza1([you, do, not, like, my, hair, my, eye, my, nose, my, ears], N).

% Question 1.3 List Processing
% Write a predicate eliza2 (don’t forget the “2”) that takes a list of words:
% [ …, you, <some words>, me, …]
% and creates a new list of the form:
% [what, makes, you, think, i, <some words>, you]

splitYou(List, Before, After) :-
    append(Before, [you | After], List).
splitMe(List, Before, After) :-
    append(Before, [me | After], List).
     

eliza2([], []).

eliza2(User, Response) :-
    splitYou(User, _, Y),
    conc([what, makes, you, think, i], Y, Ans),
    splitMe(Ans, X, _),
    conc(X, [you], Response).

% Tests for eliza2()

% Test 1 user has no response/empty list is given
% Expected output is an empty list
test_eliza2_1(N) :- eliza2([], N).
% Rest of tests is with user having a simple response
% Expected output is a response of "what makes you think i" then a concatenation of words from their response ending with "you"

% Test 2 eliza2()
% input: [i, wonder, if, you, would, help, me, learn, prolog]
% output: [what, makes, you, think, i, would, help, you]
test_eliza2_2(N) :- eliza2([i, wonder, if, you, would, help, me, learn, prolog], N).

% Test 3 eliza2()
% input: [you, do, not, like, me]
% output: [what, makes, you, think, i, do, not, like, you]
test_eliza2_3(N) :- eliza2([you, do, not, like, me], N).

% Test 4 eliza2()
% input: [are, you, going, to, help, me]
% output: [what, makes, you, think, i, going, to, help, you]
test_eliza2_4(N) :- eliza2([are, you, going, to, help, me], N).

% Test 5 eliza2()
% This test will fail as there is two or more instances of the word you
% input: [if, you, do, not help, is, there, a, reason, you, are, not, going, to, help, me]
% output: [what, makes, you, think, i, do, not, help, is, there, a, reason, you, are, not, going, to, help, you]
test_eliza2_5(N) :- eliza2([if, you, do, not, help, is, there, a, reason, you, are, not, going, to, help, me], N).

% Test 6 eliza2()
% input: [i, am, thinking, that, we, are, not, getting, along, you, and, me]
% output: [what, makes, you, think, i, and, you]
test_eliza2_6(N) :- eliza2([i, am, thinking, that, we, are, not, getting, along, you, and, me], N).

% Test 7 eliza2()
% input: [why, are, you, doing, this, as, i, think, i, do, not, need, help, and, i, understand, me]
% output: [what, makes, you, think, i, doing, this, as, i, think, i, do, not, need, help, and, i, understand, you]
test_eliza2_7(N) :- eliza2([why, are, you, doing, this, as, i, think, i, do, not, need, help, and, i, understand, me], N).

% Question 1.4 Prolog Terms

% Base Case
% The expression is a number then return the number
eval(Number, Number) :-
    number(Number).
% If the expression includes add() then add each result
eval(add(X, Y), R) :-
    eval(X, R1),
    eval(Y, R2),
    R is R1 + R2.
% The expression includes sub() then subtract each result
eval(sub(X, Y), R) :-
    eval(X, R1),
    eval(Y, R2),
    R is R1 - R2.
% The expression includes div() then divide each result
eval(div(X, Y), R) :-
    eval(X, R1),
    eval(Y, R2),
    R is R1 / R2.
% The expression includes mul() then multiply each result
eval(mul(X, Y), R) :-
    eval(X, R1),
    eval(Y, R2),
    R is R1 * R2.

% Tests for eval()

% Test 1 eval() for input of a number
% Expected output is 5
test_eval_1(N) :- eval(5, N).
% Test 2 eval() for an expression of adding two numbers
% Expected output is 7
test_eval_2(N) :- eval(add(5, 2), N).
% Test 3 eval() for an expression of subtracting two numbers
% Expected output is 3
test_eval_3(N) :- eval(sub(5, 2), N).
% Test 4 eval() for for an expression of dividing two numbers
% Expected output is 5
test_eval_4(N) :- eval(div(15,3), N).
% Test 5 eval() for for an expression of multilplying two numbers
% Expected output is 15
test_eval_5(N) :- eval(mul(5, 3), N).
% Test 6 eval() for for multiple expressions with a float result
% Expected output is 3.5
test_eval_6(N) :- eval(div(add(1, mul(2, 3)), 2), N).


