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
    /*width: 800px;*/
    height: auto;
  }

/*
  foreignObject {
    box-sizing: content-box;
    border: 2px solid cornflowerblue;
    border-radius: 50%;
  }*/

  foreignObject>div {
    border: 2px solid cornflowerblue;
    border-radius: 50%;
    overflow: hidden;
  }

  .fokuso {
    stroke: silver;
    stroke-width: 3;
    stroke-dasharray: 1 6;
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

  .proceso.aktiva rect {
    fill: #444;
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
  // povas esti pluraj SVG en la paĝo, sed nur unu havas
  // "#P_citrato"
  const eniro = document.getElementById("y.node.0"); // querySelector('a[*|href="#P_citrato"]');
  svg = eniro.closest("svg");

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
      svg.style.cursor = "wait";
      const jmol_ref = g.classList.contains("celo")? jmol_produkto_ref : jmol_fonto_ref;
      const jmol_id = g.classList.contains("celo")? "jmol_produkto" : "jmol_fonto";
      fokuso(jmol_id,g);
      Jmol.script(jmol_ref, `load "inc/${molekuloj[molekulo]}"; set antialiasDisplay ON`);
    } else if (proteinoj[molekulo]) {
      svg.style.cursor = "wait";
      fokuso("jmol_proteino",g);
      Jmol.script(jmol_proteino_ref, `load "inc/${proteinoj[molekulo]}"; cartoon only; color cartoon structure; set antialiasDisplay ON`);
    };
  }
}

/**
 * Kalkulas la punkton de la fokuslinio sur la rando
 * de cirklo (flanko = 1|-1) 
 */
function radipunkto(ax,ay,cx,cy,r,flanko=1) {
  // longo de la kateto a_c
  const dx = ax-cx;
  const dy = ay-cy;
  const A = Math.sqrt(dx*dx + dy*dy);

  const bx = cx + r*(dy/A)*flanko;
  const by = cy + r*(-dx/A)*flanko;

  return[bx,by];
}

function fokuso(jmol_id,g) {
  // ŝanĝu la eliron de fokuslinoj al la elektita molekulo
  const l1 = svg.querySelector("#"+jmol_id+"_fokus_1");
  const l2 = svg.querySelector("#"+jmol_id+"_fokus_2");
  const jm = svg.querySelector("#"+jmol_id);

  const bb1 = g.getBBox();
  const bb2 = jm.parentElement.getBBox();

  const ax = bb1.x+bb1.width/2;
  const ay = bb1.y+bb1.height/2;

  const cx = bb2.x+bb2.width/2;
  const cy = bb2.y+bb2.height/2;

  const fp1 = radipunkto(ax,ay,cx,cy,bb2.width/2,1);
  const fp2 = radipunkto(ax,ay,cx,cy,bb2.width/2,-1);

  // tio estas la ŝoviĝo, kiun yEd aplikas
  // al ĉiuj grupoj, pro simpleco ni metas tie
  // ĉi fikse, sed:
  // PLIBONIGU: eltrovu tion prepare unufoje!
  const tx = -249;
  const ty = +192;

  SVG.a(l1,{
    x1: ax-tx,
    y1: ay-ty,
    x2: fp1[0]-tx,
    y2: fp1[1]-ty
  });
  SVG.a(l2,{
    x1: ax-tx,
    y1: ay-ty,
    x2: fp2[0]-tx,
    y2: fp2[1]-ty
  });
}

/*
    <g id="y.node.47">
      <a xlink:href="#fo_proteino">
*/

/**
 * redonas g-elementon de nodo identigitan per xlink:href
 */
function nodo_href(href) {
  const a = svg.querySelector(`a[*|href="${href}"`);
  if (a) return a.parentElement;
}

function nodo_klaso(href,...klasoj) {
  const g = nodo_href(href);
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
    // kaj forigu la molekulojn el JsMol-rigardoj
    Jmol.script(jmol_proteino_ref, "zap;");
    Jmol.script(jmol_fonto_ref, "zap;");
    Jmol.script(jmol_produkto_ref, "zap;");
  }

  // antaŭ ŝanĝo malaktivigu ĉiujn aliajn
  if (proceso != akt_proc) {
    svg.querySelectorAll("g.aktiva").forEach((g) => {
      g.classList.remove("aktiva");
      g.classList.remove("celo");
      g.classList.remove("fonto");
    });
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
  const re_mx = /matrix\(1,0,0,1,(.*)\)/

  const a = svg.querySelector(`a[*|href="${gid}"`);
  const g = a.parentElement;

  // ni devas eltrovi mezurojn kaj transformon
  // de enhavita g, rect

  const fO = SVG.e("foreignObject");

  const tf = g.querySelector("g[transform]").getAttribute("transform");
  const r = g.querySelector("rect");

  // matrix(1,0,0,1,-249,192)
  let x = parseFloat(r.getAttribute("x"));
  let y = parseFloat(r.getAttribute("y"));
  let width = parseFloat(r.getAttribute("width"));
  let height = parseFloat(r.getAttribute("height"));
  let dx = 0;
  let dy = 0;

  const m = tf.match(re_mx);
  if (m) {
    const coord = m[1].split(',');
    dx = parseFloat(coord[0]);
    dy = parseFloat(coord[1]);
  } else {
    g.setAttribute("transform",tf);
  }

  // ni kreas fokusliniojn por montri de la
  // molekulo en la ciklo al al JMol-rigardo
  const fono = svg.querySelector('g[fill="white"][stroke="white"]');
  // PLIBONIGU: ni supozas ke estas la sama transformo kiel de fO
  // sed pli bone estus forigi la transformon de la fono
  // kaj ĝustigi la koordinatojn de ĝia rektangulo
  //const fono_tf = fono.getAttribute("transform");
  const l1 = SVG.e("line",{
    id: fid+"_fokus_1",
    class: "fokuso",
    //transform: fono_tf,
    x1: -dx, y1: -dy,
    x2: x+width/2,
    y2: y+height/2
  });
  const l2 = SVG.e("line",{
    id: fid+"_fokus_2",
    class: "fokuso",
    //transform: fono_tf,
    x1: -dx, y1: -dy,
    x2: x+width/2,
    y2: y+height/2
  });
  fono.append(l1,l2);

  // aldonu 3 pikselojn por la rando
  // CSS box-sizing: content-box ne funkcias tie ĉi
  SVG.a(fO,{
      //transform: tf,
      x: x+dx,
      y: y+dy,
      width: width+3,
      height: height+3
  });

  const div = document.createElementNS("http://www.w3.org/1999/xhtml","div")
  div.id = fid;
  fO.append(div);

  // anstataŭgu enhavon de t per fO
  g.textContent="";
  g.append(fO);

  return div;
}

function postShargo() {
  console.log("post ŝargo"); svg.style.cursor = "auto";
}

function jmol_preparo() {
  // anstataŭigu SVG-grupon _fo_proteino per foreignObject/div por
  // tie montri proteinojn per JSMol
  foreignObject("#fo_proteino",_jmol_proteino);
  foreignObject("#fo_fonto",_jmol_fonto);
  foreignObject("#fo_produkto",_jmol_produkto);

  fokuso("jmol_proteino",nodo_href("#citratsintazo"));
  jmol_proteino_ref = jmol_div(_jmol_proteino,
    "inc/citratsintazo_5uzq.cif.gz",
    400,400,
    (app) => { Jmol.script(app,
      'cartoon only; color cartoon structure; set antialiasDisplay ON'
    )},
    "postShargo"
  );

  fokuso("jmol_fonto",nodo_href("#okzalacetato"));
  jmol_fonto_ref = jmol_div(_jmol_fonto,
    "inc/okzalacetato_CID_970.sdf",
    180,180,
    (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )},
    "postShargo"
  );

  fokuso("jmol_produkto",nodo_href("#citrato"));
  jmol_produkto_ref = jmol_div(_jmol_produkto,
    "inc/citrato_CID_311.sdf",
    180,180,
    (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )},
    "postShargo"
  );
}


</script>

<div id="svgujo"></div>
