:- use_module(library(sgml)).
:- use_module(library(xpath)).
:- use_module(library(http/json)).

/**
 * extrakti la nodojn kaj eĝojn inter nodoj
 * el graphml-dosiero (kreita de yEd)
 * 
 * Ni bezonas tiujn rilatojn, ĉar ili en sVG-eksporto malestas,
 * sed ni volas uzi la modelon per Javoskripto en la paĝoj
 * por ŝanĝi la staton de la model, ekz- transiri de unu
 * aktiva nodo al alia ks.
 */

% graph('modeloj/elementcikloj/fosforciklo-detala').
% graph('modeloj/elementcikloj/sulfurciklo-detala').

% graph('modeloj/procezoj/TCA_SGBN_PD').
graph('modeloj/procezoj/Glikolizo_SGBN_PD').

%output('cikloj/fosforciklo-detala.mdl').

:- dynamic node/3, edge/2.

go :-
    forall(graph(G),
    (
        parse_graph(G),
        make_json(Json),
        % put_dict(JSON1,JSON2,JSON),
        % skribu rezultojn
        atom_concat(G,'.mdl',OutFile),
        open(OutFile,write,Output),
        json_write(Output,Json),
        close(Output)
    )).

parse_graph(Graph) :-
    atom_concat(Graph,'.graphml',File),
    format('~w...~n',[File]),
    load_xml(File,DOM,[]),
    retractall(node(_,_,_)),
    retractall(edge(_,_)),
    nodes(DOM), edges(DOM).

make_json(json([
    nodes=json(NodeList),
    edges=EdgeList
    ])) :-
    findall(
        Name=Type,
        node(_,Name,Type),
        NodeList
        ),
    findall(
        [N0,N1],
        (
            edge(Id0,Id1),
            node(Id0,N0,_),
            node(Id1,N1,_)
        ),
        EdgeList
    ).


/*
    <node id="n1" yfiles.foldertype="group">
    <data key="d6">
      <y:ProxyAutoBoundsNode>
        <y:Realizers active="0">
          <y:GroupNode>
            <y:Geometry height="898.1713321493626" width="967.981943111052" x="260.7179767432283" y="-232.96875"/>
            <y:Fill hasColor="false" transparent="false"/>
            <y:BorderStyle color="#000000" type="line" width="3.0"/>
            <y:NodeLabel ... y="0.0">mitoĥondrio</y:NodeLabel>
*/

/*

  <key attr.name="url" attr.type="string" for="node" id="d5"/>

  <node id="n1::n15">
    <data key="d4" xml:space="preserve"><![CDATA[P_sCOA]]></data>
    <data key="d5" xml:space="preserve"><![CDATA[#P_sCOA]]></data>    

  <node id="n1::n6">
    <data key="d6">
      <y:GenericNode configuration="com.yworks.sbgn.Process">

*/

nodes(DOM) :-
    findall(Node,xpath(DOM,//node,Node),Nodes),
    maplist(node,Nodes),!.


% provizore ni ignoras grup-nodojn, ĉar tiam
% la unuan nodon el la grupo ni duoibligus...
%node(Node,JIn,JIn) :-
%    Node = element(node,Attr,_Cnt),
%    member(id=Id,Attr),
%    print(Id),
%    member('yfiles.foldertype'='group',Attr),!.

node(Node) :-
    Node = element(node,Attr,_Cnt),
    member(id=Id,Attr),
    print(Id),
    %member(yfiles.foldertype=Type,Attr),
    % print(Node),

    % provizore ni ne traktas grup-nodojn, ĉar tiam
    % la unuan nodon el la grupo ni duoibligus...
    %\+ member('yfiles.foldertype'='group',Attr),

    once((
        xpath(Node,data/'y:GenericNode'(@configuration),T),
        atomic_list_concat([com,yworks|T1],'.',T),
        atomic_list_concat(T1,'.',Type),
        print(Type),nl
    ;
        Type = ''
    )),

    once((
        xpath(Node,data(normalize_space),Data),
        sub_atom(Data,0,1,_,'#'),
        print(Data),nl,
        %JOut = JIn.put(Id,[Type,Data])
        assertz(node(Id,Data,Type))
        ;
        xpath(Node,data/'y:GenericNode'/'y:NodeLabel'(normalize_space),Label),
        Label \= '', print(Label),nl,
        %JOut = JIn.put(Id,[Type,Label])
        assertz(node(Id,Label,Type))
        ;
        %JOut = JIn.put(Id,[Type])
        assertz(node(Id,Id,Type))
    )).


edges(DOM) :-
    findall(Edge,xpath(DOM,//edge,Edge),Edges),
    maplist(edge,Edges),!.

edge(Edge) :-
    Edge = element(edge,Attr,_Cnt),
    member(id=_Id,Attr),
    member(source=Src,Attr),
    member(target=Trg,Attr),
    %JOut = JIn.put(Id,[Src,Trg]).
    assertz(edge(Src,Trg)).
