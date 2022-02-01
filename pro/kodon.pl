% https://en.wikipedia.org/wiki/DNA_and_RNA_codon_tables

kdn(uag,stop).
kdn(uga,stop).
kdn(uaa,stop).
kdn(aug,start).

% esceptoj: 
% asn, asp povas havi samajn kodonojn
% gln, glu povas havis la samajn kodonojn
kdn(uuu,phe).
kdn(uuc,phe).
kdn(uua,leu).
kdn(uug,leu).
kdn(cuu,leu).
kdn(cuc,leu).
kdn(cua,leu).
kdn(cug,leu).
kdn(auu,ile).
kdn(auc,ile).
kdn(aua,ile).
kdn(aug,met).
kdn(guu,val).
kdn(guc,val).
kdn(gua,val).
kdn(gug,val).

kdn(ucu,ser).
kdn(ucc,ser).
kdn(uca,ser).
kdn(ucg,ser).
kdn(ccu,pro).
kdn(ccc,pro).
kdn(cca,pro).
kdn(ccg,pro).
kdn(acu,thr).
kdn(acc,thr).
kdn(aca,thr).
kdn(acg,thr).
kdn(gcu,ala).
kdn(gcc,ala).
kdn(gca,ala).
kdn(gcg,ala).

kdn(uau,tyr).
kdn(uac,tyr).
kdn(cau,his).
kdn(cac,his).
kdn(caa,gln).
kdn(cag,gln).
kdn(aau,asn).
kdn(aac,asn).
kdn(aaa,lys).
kdn(aag,lys).
kdn(gau,asp).
kdn(gac,asp).
kdn(gaa,glu).
kdn(gag,glu).

kdn(ugu,cys).
kdn(ugc,cys).
kdn(ugg,trp).
kdn(cgu,arg).
kdn(cgc,arg).
kdn(cga,arg).
kdn(cgg,arg).
kdn(agu,ser).
kdn(agc,ser).
kdn(aga,arg).
kdn(agg,arg).
kdn(ggu,gly).
kdn(ggc,gly).
kdn(gga,gly).
kdn(ggg,gly).