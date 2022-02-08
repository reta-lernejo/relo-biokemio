
%! reago(+Nomo,+Produkto,+Substrato,+Enzimo,+Koenzimoj,+ReagTipo)

:- dynamic enzimo/3.



% https://de.wikipedia.org/wiki/Glykolyse

reago(gg_1,['G6P','ADP'],
    glukozo,
    heksokinazo,
    ['ATP'],
    fosfattransigo).

reago(gg_2,[fruktozo_6_P],
    'G6P',
    ex,
    [],_).

reago(gg_3,[fruktozo_1_6_bP,'ADP'],
    fruktozo_6_P,
    fosfofruktokinazo,
    ['ATP'],
    fosfattransigo).
    
reago(gg_4,['GAP','DHAP'],
    fruktozo_1_6_bP,
    ex,
    [],_).

reago(gg_5,['GAP'],
    'DHAP',
    ex,
    [],_).

reago(gg_6,['1,3-Bis-P-glicerato','NADH','H+'],
    'GAP',
    ex,
    ['Pi','NAD+'],_).

reago(gg_7,['3-fosfoglicerato','ATP'],
    '1,3-Bis-P-glicerato',
    ex,
    ['ADP'],_).

reago(gg_8,['2-fosfoglicerato'],
    '3-fosfoglicerato',
    ex,
    [],_).

reago(gg_9,['PEP','H2O'],
    '2-fosfoglicerato',
    ex,
    [],_).

reago(gg_10,[piruvato,'ATP'],
    'PEP',
    piruvatkinazo,
    ['ADP'],_).

