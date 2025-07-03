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
  "l-malato": "lmalato_CID_222656.sdf"
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

lanĉe(() => {
  SVG.legu_svg_dokumenton("inc/TCA_SGBN_PD.svg","svgujo").then(svg => {
      jmol_preparo();
      // klak-reago
      svg.querySelectorAll("g[id]").forEach((g) => {
        g.addEventListener("click",svg_elekto);
      });
  })
  .catch(error => {
      console.error("Eraro dum SVG-ŝargo:", error);
  });
});

</script>

<div id="svgujo"></div>
