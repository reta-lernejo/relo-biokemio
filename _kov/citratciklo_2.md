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
  svg {
    width: 800px;
    height: auto;
  }

  foreignObject {
    border: 2px solid cornflowerblue;
    border-radius: 50%;
  }

  g.aktiva, #sekva_pasho {
    cursor: pointer;
    pointer-events: all;
  }

  .aktiva rect, .aktiva path {
    stroke: #800;
    stroke-width: 2;
    stroke-dasharray: 3 3;
  }
</style>

{% include_relative inc/TCA_SGBN_PD.svg %}

<script>

const modelo = {% include_relative inc/TCA_SGBN_PD.mdl %};

let jmol_proteino_ref;
const _jmol_proteino = "jmol_proteino";

let jmol_fonto_ref;
const _jmol_fonto = "jmol_fonto";

let jmol_produkto_ref;
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
};

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
};

let svg;

lanĉe(() => {
  // klak-reago
  svg = document.querySelector("svg");

  // yEd ne enmetas viewBox, sed ni bezonos tion
  // por skali la grafikon
  const w = svg.getAttribute("width");
  const h = svg.getAttribute("height");
  svg.setAttribute("viewBox",`0 0 ${w} ${h}`);

  jmol_preparo(svg);

  paŝo("#P_citrato");

  svg.querySelectorAll("g[id]").forEach((g) => {
    if (g.querySelector('a[*|href="#sekva_pasho"]')) {
      g.addEventListener("click",() => paŝo());
    } else {
      g.addEventListener("click",svg_elekto);
    }
  });

});

function svg_elekto(event) {
  const g = event.currentTarget;

  if (g.classList.contains("aktiva")) {
    const text = g.querySelector("text");
    const molekulo = g.textContent.replace(/[\s\n]/g,"")

    console.log("klako: "+g.id+" ("+molekulo+")");

    // montru la molekulon - fontoj en maldekstra fenestreto, celoj en dekstra
    if (molekuloj[molekulo]) {
      const jmol_ref = g.classList.contains("celo")? jmol_produkto_ref : jmol_fonto_ref;
      Jmol.script(jmol_ref, `load "inc/${molekuloj[molekulo]}"; set antialiasDisplay ON`);
    } else if (proteinoj[molekulo]) {
      Jmol.script(jmol_proteino_ref, `load "inc/${proteinoj[molekulo]}"; cartoon only; color cartoon structure; set antialiasDisplay ON`);
    };
  }
}

/*
    <g id="y.node.47">
      <a xlink:href="#fo_proteino">
*/

function nodo_klaso(ref,...klasoj) {
  const a = svg.querySelector(`a[*|href="${ref}"`);
  const g = a.parentElement;
  if (g) {
    if (klasoj)
      g.classList.add(...klasoj);
    else
      g.className = "";
  }
}

function paŝo(proceso) {

  // por eviti akrobataĵojn per la modelaj eĝoj
  // ni uzas ordigitan liston de la procezoj por
  // ekscii la sekvan
  const procezoj = [
    "#P_citrato",
    "#P_izocitrato",
    "#P_glutarato",
    "#P_sCOA",
    "#P_sukcinato",
    "#P_fumarato",
    "#P_malato",
    "#P_okzalacetato"
  ]

  // kio estas la aktiva procezo?
  const akt_a = svg.querySelector(".proceso.aktiva a");
  const akt_proc = akt_a? akt_a.getAttributeNS("http://www.w3.org/1999/xlink","href") : undefined;

  if (! proceso) {
    // eltrovu la sekvan paŝon
    proceso = procezoj[(procezoj.indexOf(akt_proc) + 1) % procezoj.length];
  }

  // antaŭ ŝanĝo malaktivigu ĉiujn aliajn
  if (proceso != akt_proc) {
    svg.querySelectorAll("g.aktiva").forEach((g) => {
      g.classList.remove("aktiva");
      g.classList.remove("celo");
      g.classList.remove("fonto");
    });
    // kaj forigu la molekulojn el JsMol-rigardoj
    Jmol.script(jmol_proteino_ref, "zap;");
    Jmol.script(jmol_fonto_ref, "zap;");
    Jmol.script(jmol_produkto_ref, "zap;");
  }

  // aktivigu la koncernan proceson
  nodo_klaso(proceso,"proceso","aktiva");

  // kiu nodo tiu proceso estas en la modelo?
  for (const [n,nv] of Object.entries(modelo.nodoj)) {
    if (nv[1] == proceso) {
      // sekvu ĉiujn eĝojn de tie kaj aktivigu ilin kaj la
      // aliflankajn nodojn
      for (const [e,ev] of Object.entries(modelo.eĝoj)) {
        if (ev[0] == n) {
          const n2 = modelo.nodoj[ev[1]];
          nodo_klaso(n2[1],"celo","aktiva");
        } else if (ev[1] == n) {
          const n2 = modelo.nodoj[ev[0]];
          // PLIBONIGU:
          // se estas sgbn.Macromolecule ni povus
          // uzi klason "proteino","aktiva" a.s.
          nodo_klaso(n2[1],"fonto","aktiva");
        }
      }

      return;
    }
  }
}


// anstataŭigas la enhavon de la sVG-grupo gid
// per foreignObject por uzi ĝin kun JsMol
function foreignObject(gid,fid) {

  const a = svg.querySelector(`a[*|href="${gid}"`);
  const g = a.parentElement;

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
  foreignObject("#fo_proteino",_jmol_proteino);
  foreignObject("#fo_fonto",_jmol_fonto);
  foreignObject("#fo_produkto",_jmol_produkto);

  jmol_proteino_ref = jmol_div(_jmol_proteino,
      "inc/citratsintazo_5uzq.cif.gz",
      400,400,
      (app) => { Jmol.script(app,
      'cartoon only; color cartoon structure; set antialiasDisplay ON'
      )}
  );

  jmol_fonto_ref = jmol_div(_jmol_fonto,
      "inc/okzalacetato_CID_970.sdf",
      180,180,
      (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )}
  );

  jmol_produkto_ref = jmol_div(_jmol_produkto,
      "inc/citrato_CID_311.sdf",
      180,180,
      (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )}
  );
}


</script>

<div id="svgujo"></div>
