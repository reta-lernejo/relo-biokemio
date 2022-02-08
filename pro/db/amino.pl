
%! amina(+Eo,+Mlg3,+Mlg1,+SumFrm,+SmileFrm).
% https://commonchemistry.cas.org
% https://pubchem.ncbi.nlm.nih.gov
% canonical proteinogen
amina(alanino,'Ala','A').
amina(arginino,'Arg','R').
amina(asparagino,'Asn','N').
amina(asparaginacido,'Asp','D').
amina(cisteino,'Cys','C').
amina(glutamino,'Gln','Q').
amina('glutaminacido','glu','e').
amina('glycin','gly','g').
amina('histidin','his','h').
amina('isoleucin','ile','i').
amina('leucin','leu','l').
amina('lysin','lys','k').
amina('methionin','met','m').
amina('phenylalanin','phe','f').
amina('prolin','pro','p').
amina('serin','ser','s').
amina('threonin','thr','t').
amina('tryptophan','trp','w').
amina('tyrosin','tyr','y').
amina('valin','val','v').

% noncanonical proteinogen
amina('pyrrolysin','pyl','o').
amina('selenocystein','sec','u'). 

%! c_id(+Eo,+Katalogo,+Kodo)
c_id(alanino,angle,'L-alanine').
c_id(alanino,'EC','200-273-8').
c_id(arginino,'IUPAC','(2S)-2-aminopropanoic acid').

c_id(arginino,anlge,'DL-arginine').
c_id(arginino,'EC','230-571-3').
c_id(arginino,'IUPAC','2-amino-5-(diaminomethylideneamino)pentanoic acid').

c_id(asparagino,angle,'DL-asparagine').
c_id(asparagino,'EC','221-521-1').
c_id(asparagino,'IUPAC','2,4-diamino-4-oxobutanoic acid').

c_id(asparaginacido,angle,'L-aspartic acid').
c_id(asparaginacido,'EC','200-291-6').
c_id(asparaginacido,'IUPAC','(2S)-2-aminobutanedioic acid').

c_id(cisteino,angle,'L-cysteine').
c_id(cisteino,'EC','200-158-2').
c_id(cisteino,'IUPAC','(2R)-2-amino-3-sulfanylpropanoic acid').

c_id(glutamino,angle,'L-glutamine').
c_id(glutamino,'EC','200-292-1').
c_id(glutamino,'IUPAC','(2S)-2,5-diamino-5-oxopentanoic acid').

frm(alanino,'C3H7NO2','CC(C(=O)O)N').
frm(arginino,'C6H14N4O2','C(CC(C(=O)O)N)CN=C(N)N').
frm(asparagino,'C4H8N2O3','C(C(C(=O)O)N)C(=O)N').
frm(asparaginacido,'C4H7NO4','C(C(C(=O)O)N)C(=O)O').
frm(cisteino,'C3H7NO2S','C(C(C(=O)O)N)S').
frm(glutamino,'C5H10N2O3','C(CC(=O)N)C(C(=O)O)N').



