
% H2O
cc('H2O','O').
% CO2
cc('CO2','C(=O)=O').
% protono (hidrogeniono)
cc('H+','[H+]').

% inorganic phosphate [HPO4]2-, [H2PO4]-
cc('Pi',_).

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
cc('FADH2','CC1=C(C(C(=C(C1O)OC)OC)O)C/C=C(\\C)/CC/C=C(\\C)/CC/C=C(\\C)/CC/C=C(\\C)/CC/C=C(\\C)/CC/C=C(\\C)/CC/C=C(\\C)/CCC=C(C)C').
cc(fumarato,'C(=C/C(=O)O)\\C(=O)O').

% 8 
cc('l_malato','C(C(C(=O)O)O)C(=O)O').
cc(okzalacetato,'O=C(O)C(=O)CC(=O)O').

cc(glukozo,'OC[C@H]1OC(O)[C@H](O)[C@@H](O)[C@@H]1O').
cc('G6P','O[C@H]1[C@H](O)[C@@H](COP(O)(O)=O)OC(O)[C@@H]1O').
cc(fruktozo_6_P,'O=P(O)(O)OC[C@H]1O[C@@](O)(CO)[C@@H](O)[C@@H]1O').
cc(fruktozo_1_6_bP,'C([C@@H]1[C@H]([C@@H]([C@](O1)(COP(=O)(O)O)O)O)O)OP(=O)(O)O').
cc('ADP','O=P(O)(O)OP(=O)(O)OC[C@H]3O[C@@H](n2cnc1c(ncnc12)N)[C@H](O)[C@@H]3O').
cc('ATP','O=P(O)(O)OP(=O)(O)OP(=O)(O)OC[C@H]3O[C@@H](n2cnc1c(ncnc12)N)[C@H](O)[C@@H]3O').

% Glycerinaldehyd-3-phosphat, G3P, G-3-P?
cc('GAP','C([C@H](C=O)O)OP(=O)(O)O').
% Dihydroxyacetone phosphate
cc('DHAP','C(C(=O)COP(=O)(O)O)O').

% 1,3-Bisphosphoglyceric acid
cc('1,3-Bis-P-glicerato','O=C(OP(=O)(O)O)C(O)COP(=O)(O)O').

% 2-Phosphoglyceric acid
cc('2-fosfoglicerato','C(C(C(=O)O)OP(=O)(O)O)O').
% 3-Phosphoglyceric acid
cc('3-fosfoglicerato','C([C@H](C(=O)O)O)OP(=O)(O)O').

% Nicotinamide adenine dinucleotide
cc('NADH','O=C(N)C1CC=C[N](C=1)[C@@H]2O[C@@H]([C@@H](O)[C@H]2O)COP([O-])(=O)OP(=O)([O-])OC[C@H]5O[C@@H](n4cnc3c(ncnc34)N)[C@H](O)[C@@H]5O').
cc('NAD+','O=C(N)c1ccc[n+](c1)[C@@H]2O[C@@H]([C@@H](O)[C@H]2O)COP([O-])(=O)OP(=O)([O-])OC[C@H]5O[C@@H](n4cnc3c(ncnc34)N)[C@H](O)[C@@H]5O').

% Phosphoenolpyruvic acid
cc('PEP','O=C(O)C(OP(=O)(O)O)=C').

% Pyruvic acid
cc(piruvato,'O=C(C(=O)O)C').