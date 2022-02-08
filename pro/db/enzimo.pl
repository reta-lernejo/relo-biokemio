enzimklaso(ec_1,oksidoreduktazo,'katalizas redoks-reagon').
enzimklaso(ec_2,transferazo,'transigas funkcian grupon de substrato al alia').
enzimklaso(ec_3,hidrolazo,'disigas ligojn per uzo de akvo').
enzimklaso(ec_4,liazo,'disigo aŭ sintezo de kompleksaj produktoj el simplaj substratoj sed sen uzo de ATP aŭ alia NTP'). 
enzimklaso(ec_5,izomerazo,'akcelado de izomer-transformado').
enzimklaso(ec_6,ligazo,'katalizas adician reagon uzante ATP aŭ alian NTP').
enzimklaso(ec_6,sintetazo,'katalizas adician reagon uzante ATP aŭ alian NTP').
enzimklaso(ec_7,translokazo,'transporto de substancoj ĉe aŭ tra la ĉelmembrano').

% provizora ĵokero por enzimon mankanta en reago_difino!
enzimo(ex,_,_).


enzimo(citrat_sintazo,_,_).
enzimo(akonitazo,_,_).
enzimo(izocitrat_dehidrogenazo,_,_).
enzimo(alfo_ketoglutarat_dehidrogenazo_komplekso,_,_).
enzimo(sukcinil_CoA_sintetazo,_,sintetazo).
enzimo(sukcinat_dehidrogenazo,_,_).
enzimo(fumarazo,_,_).
enzimo(malatdehidrogenazo,_,_).

% https://en.wikipedia.org/wiki/Pyruvate_kinase
enzimo(piruvatkinazo,'PK',_).
enzimo(fosfofruktokinazo,'PFK-1',_).
enzimo(heksokinazo,_,_).
