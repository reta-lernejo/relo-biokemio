:- use_module(library(sgml)).
:- use_module(library(xpath)).
:- use_module(library(http/json)).

graph('cikloj/fosforciklo-detala').
graph('cikloj/sulfurciklo-detala').
%output('cikloj/fosforciklo-detala.mdl').

go :-
    forall(graph(G),
    (
        atom_concat(G,'.graphml',File),
        load_xml(File,DOM,[]),
        edges(DOM,JSON),
        % skribu rezultojn
        atom_concat(G,'.mdl',OutFile),
        open(OutFile,write,Output),
        json_write(Output,JSON),
        close(Output)
    )).

edges(DOM,JSON) :-
    findall(Edge,xpath(DOM,//edge,Edge),Edges),
    foldl(edge,Edges,_{},JSON),!.

edge(Edge,JIn,JOut) :-
    Edge = element(edge,Attr,_Cnt),
    member(id=Id,Attr),
    member(source=Src,Attr),
    member(target=Trg,Attr),
    JOut = JIn.put(Id,[Src,Trg]).
