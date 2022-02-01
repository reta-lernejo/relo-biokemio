:- consult(amino).
:- consult(kodon).

genkod('Nitrosopumilus_maritimus.gen').

translate :-
    genkod(File),
    setup_call_cleanup(open(File, read, In),
    (
      stream_line(In, Line),
      trans_line(Line)
    ),
    close(In)).

trans_line(Line) :-
    sub_atom(Line,0,1,_,First),
    once((
        % genkodoj
        memberchk(First,['A','T','U','G','C']),
        atom_codes(Line,Codes),
        dekod(Codes)
        ;
        % kapo a.s.
        writeln(Line)
    )).

dekod([A,B,C|Rest]) :-
    normalize([A,B,C],Triplet),
    kdn(Triplet,Amina),
    format('~w-',[Amina]),
    dekod(Rest).

dekod([]).

normalize([A,B,C],Triplet) :-
   once((A = 0'T, D = 0'U; A = D)),
   once((B = 0'T, E = 0'U; B = E)),
   once((C = 0'T, F = 0'U; C = F)),
   atom_codes(ABC,[D,E,F]),
   downcase_atom(ABC,Triplet).

 
stream_line(In, Line) :-
    repeat,
    (   read_line_to_string(In, Line0),
        Line0 \== end_of_file
    ->  Line0 = Line
    ;   !,
        fail
    ).