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

graph('modeloj/procezoj/TCA_SGBN_PD').

%output('cikloj/fosforciklo-detala.mdl').

go :-
    forall(graph(G),
    (
        atom_concat(G,'.graphml',File),
        format('~w...~n',[File]),
        load_xml(File,DOM,[]),
        nodes(DOM,JSON1),
        edges(DOM,JSON2),
        % put_dict(JSON1,JSON2,JSON),
        % skribu rezultojn
        atom_concat(G,'.mdl',OutFile),
        open(OutFile,write,Output),
        json_write(Output,_{nodoj: JSON1, eĝoj: JSON2}),
        close(Output)
    )).

/*
    <node id="n1" yfiles.foldertype="group">
    <data key="d6">
      <y:ProxyAutoBoundsNode>
        <y:Realizers active="0">
          <y:GroupNode>
            <y:Geometry height="898.1713321493626" width="967.981943111052" x="260.7179767432283" y="-232.96875"/>
            <y:Fill hasColor="false" transparent="false"/>
            <y:BorderStyle color="#000000" type="line" width="3.0"/>
            <y:NodeLabel alignment="center" autoSizePolicy="content" borderDistance="0.0" fontFamily="Dialog" fontSize="12" fontStyle="plain" hasBackgroundColor="false" hasLineColor="false" height="17.96875" horizontalTextPosition="center" iconTextGap="4" modelName="internal" modelPosition="t" textColor="#000000" verticalTextPosition="bottom" visible="true" width="76.849609375" x="445.566166868026" xml:space="preserve" y="0.0">mitoĥondrio</y:NodeLabel>
*/

/*
    <node id="n1::n6">
      <data key="d6">
        <y:GenericNode configuration="com.yworks.sbgn.Process">
*/

nodes(DOM,JSON) :-
    findall(Node,xpath(DOM,//node,Node),Nodes),
    foldl(node,Nodes,_{},JSON),!.

node(Node,JIn,JOut) :-
    Node = element(node,Attr,_Cnt),
    member(id=Id,Attr),
    print(Id),
    %member(yfiles.foldertype=Type,Attr),
    % print(Node),
    once((
        xpath(Node,//'y:NodeLabel'(normalize_space),Label),
        Label \= '', print(Label),nl,
        JOut = JIn.put(Id,Label)
        ;
        xpath(Node,//'y:GenericNode'(@configuration),T),
        atomic_list_concat([com,yworks|T1],'.',T),
        atomic_list_concat(T1,'.',Type),
        print(Type),nl,
        JOut = JIn.put(Id,Type)
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
