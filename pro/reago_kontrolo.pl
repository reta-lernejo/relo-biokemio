:- ensure_loaded('db/amino.pl').
:- ensure_loaded('db/enzimo.pl').
:- ensure_loaded('db/reagtipo.pl').
:- ensure_loaded('db/kombino.pl').

reago_dif(RId) :-
    (reago(RId,Produktoj,Substrato,Enzimo,Partneroj,RTipo) -> true
    ; throw(reago_ne_difinita(RId))),
    cc_dif(Substrato),
    cc_dif(Produktoj),
    cc_dif(Partneroj),
    enzim_dif(Enzimo),
    reagtipo(RTipo).

cc_dif(CC) :-
    atom(CC),
    (cc(CC,_) -> true
    ; throw(cc_ne_difinita(CC))).

cc_dif([]).
cc_dif([CC|Rest]) :-
    cc_dif(CC),
    cc_dif(Rest).


enzim_dif(Enzimo) :-
    enzimo(Enzimo,_,_) -> true
    ; throw(enzimo_ne_difinita(Enzimo)).
    

