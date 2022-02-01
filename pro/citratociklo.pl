
%! reago(+Nomo,+Produkto,+Substrato,+Enzimo,+Koenzimoj,+ReagTipo)

% H2O
cc(akvo,'O').
% CO2
cc(karbondioksido,'C(=O)=O').
% protono (hidrogeniono)
cc('H+','[H+]').

% PO4^3-
% fosfato-formuloj, kiu estas la ĝusta tie ci?
%cc(fosfato,'[O-]P([O-])([O-])=O'). % PO43-
%    [O-]P(=O)([O-])[O-]
%    O=P([O-])([O-])[O-]
cc(fosfato,'[O-][P+]([O-])([O-])[O-]').

% cc 1
cc(citrato,'O=C(O)C(=O)CC(=O)O').
cc(acetil_CoA,'O=C(SCCNC(=O)CCNC(=O)[C@H](O)C(C)(C)COP(=O)(O)OP(=O)(O)OC[C@H]3O[C@@H](n2cnc1c(ncnc12)N)[C@H](O)[C@@H]3OP(=O)(O)O)C').

cc(citrato,'OC(=O)CC(O)(C(=O)O)CC(=O)O').

% laŭ Vikipedio CoA kaj CoA-SH estas la sama?
cc('CoA','O=C(NCCS)CCNC(=O)C(O)C(C)(C)COP(=O)(O)OP(=O)(O)OC[C@H]3O[C@@H](n2cnc1c(ncnc12)N)[C@H](O)[C@@H]3OP(=O)(O)O').
cc('CoA-SH','CC(C)(COP(=O)(O)OP(=O)(O)OCC1C(C(C(O1)N2C=NC3=C(N=CN=C32)N)O)OP(=O)(O)O)C(C(=O)NCCC(=O)NCCS)O').

% cc 2
cc(cis_akonitato,'C(C(=CC(=O)O)C(=O)O)C(=O)O').
cc(izocitrato,'O=C(O)C(CC(=O)O)C(O)C(=O)O').

% cc 3
cc('NAD+','O=C(N)c1ccc[n+](c1)[C@@H]2O[C@@H]([C@@H](O)[C@H]2O)COP([O-])(=O)OP(=O)([O-])OC[C@H]5O[C@@H](n4cnc3c(ncnc34)N)[C@H](O)[C@@H]5O').
cc('NADH','O=C(N)C1CC=C[N](C=1)[C@@H]2O[C@@H]([C@@H](O)[C@H]2O)COP([O-])(=O)OP(=O)([O-])OC[C@H]5O[C@@H](n4cnc3c(ncnc34)N)[C@H](O)[C@@H]5O').

% 4
cc(okzalsukcinato,'C(C(C(=O)C(=O)O)C(=O)O)C(=O)O').

% 5
cc(alfo_ketoglutarato,'O=C(O)C(=O)CCC(=O)O').
cc(sukcinilo_CoA,'O=C(O)CCC(=O)SCCNC(=O)CCNC(=O)[C@H](O)C(C)(C)COP(=O)(O)OP(=O)(O)OC[C@H]3O[C@@H](n2cnc1c(ncnc12)N)[C@H](O)[C@@H]3OP(=O)(O)O').

% cc 6
cc('GDP','C1=NC2=C(N1C3C(C(C(O3)COP(=O)(O)OP(=O)(O)O)O)O)NC(=NC2=O)N').
cc(sukcinato,'C(CC(=O)O)C(=O)O').

cc('GTP','c1nc2c(n1[C@H]3[C@@H]([C@@H]([C@H](O3)CO[P@@](=O)(O)O[P@](=O)(O)OP(=O)(O)O)O)O)[nH]c(nc2=O)N').

% 7
% ubikvinono (Q)
cc('FAD','CC1=CC2=C(C=C1C)N(C3=NC(=O)NC(=O)C3=N2)C[C@@H]([C@@H]([C@@H](COP(=O)(O)OP(=O)(O)OC[C@@H]4[C@H]([C@H]([C@@H](O4)N5C=NC6=C(N=CN=C65)N)O)O)O)O)O').
% ubikvinolo (QH2)
cc('FADH2','CC1=C(C(C(=C(C1O)OC)OC)O)C/C=C(\C)/CC/C=C(\C)/CC/C=C(\C)/CC/C=C(\C)/CC/C=C(\C)/CC/C=C(\C)/CC/C=C(\C)/CCC=C(C)C').
cc(fumarato,'C(=C/C(=O)O)\C(=O)O').

% 8 
cc('l_malato','C(C(C(=O)O)O)C(=O)O').
cc(okzaloacetato,'O=C(O)C(=O)CC(=O)O').





reago(cc_1,[citrato],
    okzalacetato,
    citrat_sintazo,
    [acetil_CoA,akvo],
    kondensado).
reago(cc_2a,[cis_akonitato,akvo],
    citrato,
    akonitazo,
    [],
    malhidratigo
    ).
reago(cc_2b,[izocitrato],
    cis_akonitato,
    akonitazo,
    [akvo],
    hidratigo).
reago(cc3a,[okzalsukcinato,'NADH'],
    izocitrato,
    izocitrat_dehidrogenazo,
    ['NAD+'],
    oksidigo
    ).
reago(cc_3b,[alfo_ketoglutarato,'CO2'],
    okzalsukcinato,
    izocitrat_dehidrogenazo,
    ['H+'],
    senkarboksiligo).
reago(cc_4,[sukcinilo_CoA,'NADH','CO2'],
    alfo_ketoglutarato,
    alfo_ketoglutarat_dehidrogenazo_komplekso,
    ['NAD+','CoA-SH'],
    senkarboksiligo
    ).
reago(cc_5,[sukcinato,'GTP','CoA-SH'],
    sukcinilo_CoA,
    sukcinil_CoA_sintetazo,
    ['GDP',fosfato],
    oksidiga_senkarboksiligo).
reago(cc_6,[fumarato,'FADH2'],
    sukcinato,
    sukcinat_dehidrogenazo,
    ['FAD'],
    fosfattransigo).
reago(cc_7,[l_malato],
    fumarato,
    fumarazo,
    [akvo],
    hidratigo).
reago(cc_8,[okzalacetato,'NADH'],
    l_malato,
    malatdehidrogenazo,
    ['NAD+'],
    oksidigo).

