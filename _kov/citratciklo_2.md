---
layout: laborfolio
title: Citratciklo
js:
  - folio-0c
  - svg-0d
  - jmol-0b
  - jsmol/JSmol.min
---

<!-- 

citrasintazo: https://www.rcsb.org/structure/5UZQ 
akonitazo: https://www.rcsb.org/structure/1B0J
fumarazo: https://www.rcsb.org/structure/3E04

# el PubChem:
vd. https://pubchem.ncbi.nlm.nih.gov/docs/citation-guidelines#section=Reusing-the-2D-or-3D-structure-image-of-a-compound-or-substance-record

okzalacetato: https://pubchem.ncbi.nlm.nih.gov/compound/970
citrato: https://pubchem.ncbi.nlm.nih.gov/compound/311
izocitrato: https://pubchem.ncbi.nlm.nih.gov/compound/1198
alfoketoglutarato: https://pubchem.ncbi.nlm.nih.gov/compound/51
sukcinil-CoA: https://pubchem.ncbi.nlm.nih.gov/compound/92133 / https://www.ebi.ac.uk/chebi/searchId.do?chebiId=15380
sukcinato: https://pubchem.ncbi.nlm.nih.gov/compound/1110
fumarato: https://pubchem.ncbi.nlm.nih.gov/compound/444972
l-malato: https://pubchem.ncbi.nlm.nih.gov/compound/222656

CoA: https://pubchem.ncbi.nlm.nih.gov/compound/6816 / https://www.kegg.jp/entry/C00010 / https://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:15346
NADH: https://pubchem.ncbi.nlm.nih.gov/compound/439153#section=3D-Conformer

-->

<style>
  foreignObject {
    border: 2px solid cornflowerblue;
    border-radius: 50%;
  }

  g {
    pointer-events: all;
  }
</style>

{% include_relative inc/TCA_SGBN_PD.svg %}

<script>

let jmol_proteino_ref;
const _fo_proteino_gid = "y\\.node\\.2";
const _jmol_proteino = "jmol_proteino";

let jmol_fonto_ref;
const _fo_fonto_gid = "y\\.node\\.45";
const _jmol_fonto = "jmol_fonto";

let jmol_produkto_ref;
const _fo_produkto_gid = "y\\.node\\.46";
const _jmol_produkto = "jmol_produkto";

const molekuloj = {
  "citrasintazo": "citratsintazo_5uzq.cif.gz",
  "okzalacetato": "okzalacetato_CID_970.sdf",
  "citrato": "citrato_CID_311.sdf",
  "izocitrato": "izocitrato_CID_1198.sdf",
  "alfoketo-glutarato": "alfoketoglutarato_CID_51.sdf",
  "sukcinil-CoA": "sukcinilCoA_15380.sdf", // aŭ sukcinilCoA_CID_92133.sdf
  "sukcinato": "sukcinato_CID_1110.sdf",
  "fumarato": "fumarato_CID_444972.sdf",
  "l-malato": "lmalato_CID_222656.sdf",
  "NADH": "NADH_CID_439153.sdf",
  "CoA-SH": "CoASH_ChEBI_15346.sdf", //"CoA.mol",
  "H₂O": "H2O.mol"
}

const proteinoj = {
  "citrat-sintazo": "citratsintazo_5uzq.cif.gz",
  "akonitazo": "akonitazo_1b0j.cif.gz",
  "izocitrat-dehidrogenazo": "",
  "α-ketoglutarat-dehidrogenazo": "",
  "dihidrolipoamid-sukciniltransferazo": "",
  "dihidrolipoamid-dehidrogenazo": "",
  "sukcinil-CoA-sintetazo": "",
  "sukcinat-dehidrogenazo": "",
  "fumarazo": "fumarazo_3e04.cif.gz",
  "malat-dehidrogenazo": ""
}

const "eĝoj" = {
    "n1::e0": ["n1::n0", "n1::n6" ],
    "n1::e1": ["n1::n1", "n1::n6" ],
    "n1::e10": ["n1::n9", "n1::n11" ],
    "n1::e11": ["n1::n9", "n1::n13" ],
    "n1::e12": ["n1::n9", "n1::n12" ],
    "n1::e13": ["n1::n10", "n1::n9" ],
    "n1::e14": ["n1::n14", "n1::n15" ],
    "n1::e15": ["n1::n15", "n1::n19" ],
    "n1::e16": ["n1::n15", "n1::n21" ],
    "n1::e17": ["n1::n15", "n1::n20" ],
    "n1::e18": ["n1::n16", "n1::n15" ],
    "n1::e19": ["n1::n17", "n1::n15" ],
    "n1::e2": ["n1::n2", "n1::n8" ],
    "n1::e20": ["n1::n18", "n1::n15" ],
    "n1::e21": ["n1::n21", "n1::n22" ],
    "n1::e22": ["n1::n22", "n1::n23" ],
    "n1::e23": ["n1::n22", "n1::n25" ],
    "n1::e24": ["n1::n22", "n1::n28" ],
    "n1::e25": ["n1::n24", "n1::n22" ],
    "n1::e26": ["n1::n26", "n1::n22" ],
    "n1::e27": ["n1::n27", "n1::n22" ],
    "n1::e28": ["n1::n28", "n1::n29" ],
    "n1::e29": ["n1::n29", "n1::n31" ],
    "n1::e3": ["n1::n3", "n1::n9" ],
    "n1::e30": ["n1::n29", "n1::n32" ],
    "n1::e31": ["n1::n30", "n1::n29" ],
    "n1::e32": ["n1::n32", "n1::n36" ],
    "n1::e33": ["n1::n33", "n1::n29" ],
    "n1::e34": ["n1::n34", "n1::n36" ],
    "n1::e35": ["n1::n35", "n1::n38" ],
    "n1::e36": ["n1::n36", "n1::n35" ],
    "n1::e37": ["n1::n36", "n1::n37" ],
    "n1::e38": ["n1::n38", "n1::n1" ],
    "n1::e39": ["n1::n38", "n1::n39" ],
    "n1::e4": ["n1::n4", "n1::n8" ],
    "n1::e40": ["n1::n40", "n1::n38" ],
    "n1::e41": ["n1::n41", "n1::n38" ],
    "n1::e5": ["n1::n5", "n1::n6" ],
    "n1::e6": ["n1::n6", "n1::n2" ],
    "n1::e7": ["n1::n6", "n1::n7" ],
    "n1::e8": ["n1::n8", "n1::n3" ],
    "n1::e9": ["n1::n9", "n1::n14" ]
  },
  const "nodoj" = {
    "n0":"citratciklo",
    "n1":"mitoĥondrio",
    "n1::n0":"acetil-CoA",
    "n1::n1":"okzalacetato",
    "n1::n10":"izocitrat- dehidrogenazo",
    "n1::n11":"CO₂",
    "n1::n12":"NAD+",
    "n1::n13":"NADH",
    "n1::n14":"alfoketo- glutarato",
    "n1::n15":"",
    "n1::n16":"",
    "n1::n16::n0":"α-ketoglutarat- dehidrogenazo",
    "n1::n16::n1":"dihidrolipoamid- sukciniltransferazo",
    "n1::n16::n2":"dihidrolipoamid- dehidrogenazo",
    "n1::n17":"NAD+",
    "n1::n18":"CoA-SH",
    "n1::n19":"NADH",
    "n1::n2":"citrato",
    "n1::n20":"CO₂",
    "n1::n21":"sukcinil- CoA",
    "n1::n22":"",
    "n1::n23":"CoA-SH",
    "n1::n24":"GDP",
    "n1::n25":"GTP",
    "n1::n26":"fosfato",
    "n1::n27":"sukcinil-CoA- sintetazo",
    "n1::n28":"sukcinato",
    "n1::n29":"",
    "n1::n3":"izocitrato",
    "n1::n30":"FAD",
    "n1::n31":"FADH₂",
    "n1::n32":"fumarato",
    "n1::n33":"sukcinat- dehidrogenazo",
    "n1::n34":"fumarazo",
    "n1::n35":"l-malato",
    "n1::n36":"",
    "n1::n37":"H₂O",
    "n1::n38":"",
    "n1::n39":"NADH",
    "n1::n4":"akonitazo",
    "n1::n40":"NAD+",
    "n1::n41":"malat- dehidrogenazo",
    "n1::n5":"citrat-sintazo",
    "n1::n6":"",
    "n1::n7":"CoA-SH",
    "n1::n8":"",
    "n1::n9":"",
    "n2":"_fo_proteino",
    "n3":"_fo_fonto",
    "n4":"_fo_produkto"
  }


lanĉe(() => {
  jmol_preparo();

  // klak-reago
  const svg = document.querySelector("svg");
  svg.querySelectorAll("g[id]").forEach((g) => {
      g.addEventListener("click",svg_elekto);
  });
});

function svg_elekto(event) {
  const g = event.currentTarget;
  const text = g.querySelector("text");
  const molekulo = g.textContent.replace(/[\s\n]/g,"")

  console.log("klako: "+g.id+" ("+molekulo+")");

  // montru la molekulon - FARENDA: en kiu fako?
  if (molekuloj[molekulo]) {
    Jmol.script(jmol_produkto_ref, `load "inc/${molekuloj[molekulo]}"; set antialiasDisplay ON`);
  } else if (proteinoj[molekulo]) {
    Jmol.script(jmol_proteino_ref, `load "inc/${proteinoj[molekulo]}"; cartoon only; color cartoon structure; set antialiasDisplay ON`);
  };
}


// anstataŭigas la enhavon de la sVG-grupo gid
// per foreignObject por uzi ĝin kun JsMol
function foreignObject(gid,fid) {
  const g = ĝi("#"+gid);

  // ni devas eltrovi mezurojn kaj transformon
  // de enhavita g, rect

  const fO = SVG.e("foreignObject");

  const tf = g.querySelector("g[transform]").getAttribute("transform");
  const r = g.querySelector("rect");

  SVG.a(fO,{
      transform: tf,
      x: r.getAttribute("x"),
      y: r.getAttribute("y"),
      width: r.getAttribute("width"),
      height: r.getAttribute("height")
  });

  const div = document.createElementNS("http://www.w3.org/1999/xhtml","div")
  div.id = fid;
  fO.append(div);

  // anstataigu enhavon de t per fO
  g.textContent="";
  g.append(fO);

  return div;
}


function jmol_preparo() {
  // anstataŭigu SVG-grupon _fo_proteino per foreignObject/div por
  // tie montri proteinojn per JSMol
  foreignObject(_fo_proteino_gid,_jmol_proteino);
  foreignObject(_fo_fonto_gid,_jmol_fonto);
  foreignObject(_fo_produkto_gid,_jmol_produkto);

  jmol_proteino_ref = jmol_div(_jmol_proteino,
      "inc/citratsintazo_5uzq.cif.gz",
      360,360,
      (app) => { Jmol.script(app,
      'cartoon only; color cartoon structure; set antialiasDisplay ON'
      )}
  );

  jmol_fonto_ref = jmol_div(_jmol_fonto,
      "inc/okzalacetato_CID_970.sdf",
      128,128,
      (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )}
  );

  jmol_produkto_ref = jmol_div(_jmol_produkto,
      "inc/citrato_CID_311.sdf",
      128,128,
      (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )}
  );
}


</script>

<div id="svgujo"></div>
