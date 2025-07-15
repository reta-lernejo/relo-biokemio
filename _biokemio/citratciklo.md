---
layout: laborfolio
title: Citratciklo
chapter: 4.2
js:
  - folio-0c
  - mathjax/es5/tex-chtml  
  - sbgn-0a
  - jmol-0b
  - jsmol/JSmol.min
---

(paĝo en preparo)

<!-- 

citrasintazo: https://www.rcsb.org/structure/5UZQ 
akonitazo: https://www.rcsb.org/structure/1B0J
fumarazo: https://www.rcsb.org/structure/3E04
izocitrat-dehidgrogenazo (IDH): https://www.rcsb.org/structure/1IKA

oksoglutarato-dehidrogenazo-komplekso
- https://www.rcsb.org/structure/7WGR
- https://en.wikipedia.org/wiki/Oxoglutarate_dehydrogenase_complex
  E1: α-ketoglutarat-dehidrogenazo (ODGH): https://www.ebi.ac.uk/thornton-srv/databases/cgi-bin/enzymes/GetPage.pl?ec_number=1.2.4.2

sukcinil-CoA-sintetazo: (SCS) https://www.rcsb.org/structure/6WCV
sukcinat-dehidrgonezao (SDH): https://www.rcsb.org/structure/1NEK
malat-dehidrogenazo (MDH): https://www.rcsb.org/structure/1IE3


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
acetil-CoA: ttps://pubchem.ncbi.nlm.nih.gov/compound/444493
NAD: https://pubchem.ncbi.nlm.nih.gov/compound/925
NADH: https://pubchem.ncbi.nlm.nih.gov/compound/439153#section=3D-Conformer
CO2: https://pubchem.ncbi.nlm.nih.gov/compound/280#section=3D-Conformer
GDP: https://pubchem.ncbi.nlm.nih.gov/compound/730
GTP: https://pubchem.ncbi.nlm.nih.gov/compound/6830
FAD: https://pubchem.ncbi.nlm.nih.gov/compound/643975
FADH2: https://pubchem.ncbi.nlm.nih.gov/compound/446013
H+: https://pubchem.ncbi.nlm.nih.gov/compound/1038
fostfato: https://pubchem.ncbi.nlm.nih.gov/compound/1061

-->

La citratciklo eluzas bioĥemiajn reakciojn por provizi energion al oksigenspiraj ĉeloj. En ĝi ankaŭ estiĝas
molekuloj por sintezo de organikaj kombinaĵoj.

Ĉe la digesto de grasoj, sukeroj, alkoholo kaj aminacidoj estiĝas acetil-konezimo A, kiu malkombiniĝas en la citratciklo
al karbondioksido kaj hidrogeno (protonoj) laŭ la resuma, simpligita, formulo:

$$
\begin{align*}
&\ce{O}\\
&||\\
\ce{CH3-&C-S-KoA + 3H2O -> 2CO2 + 8H + KoA-SH}
\end{align*}
$$

<!--
pli ekzakta:

Acetyl-CoA + 3 NAD+ + FAD + GDP + Pi ​+ 2 H2​O  →  2 CO2 ​+ 3 NADH + 3H+ + FADH2 ​+ GTP + CoA-SH
-->

Ĉe eŭkariotaj organismoj (vegetaĵoj, fungoj, bestoj), la ciklo okazas en la mitoĥondrioj, ĉe prokariotaj organismoj (bakterioj) ĝi okazas 
en la ĉelplasmo. En iuj bakterioj la ciklo okazas en inversa direkto por asimili karbondioksidon.

Pli preciza formulo cetere estas:

$$\ce {CH_3CO-S-KoA + 3NAD+ + FAD + GDP + P_i + 2H2O  ->  2CO2 + 3NADH + 3H+ + FADH2 + GTP + KoA-SH}$$


<!--

Pi = [HPO4]2−
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

  .fokuso.fonto, .fokuso.produkto {
    stroke: #fc9;
  }

  g.aktiva, #sekva_pasho {
    cursor: pointer;
    pointer-events: all;
  }

  .aktiva rect, .aktiva path {
    stroke: #800;
    stroke-width: 2;
    /*stroke-dasharray: 3 3;*/
  }

  .proceso.aktiva rect {
    fill: #f88;
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
  "acetil-KoA": "aCoA_CID_444493.sdf",
  "sukcinil-KoA": "sukcinilCoA_15380.sdf", // aŭ sukcinilCoA_CID_92133.sdf
  "sukcinato": "sukcinato_CID_1110.sdf",
  "fumarato": "fumarato_CID_444972.sdf",
  "l-malato": "lmalato_CID_222656.sdf",
  "NAD⁺": "NAD_CID_925.sdf",
  "NADH": "NADH_CID_439153.sdf",
  "KoA-SH": "CoASH_ChEBI_15346.sdf", //"CoA.mol",
  "GDP": "GDP_CID_730.sdf",
  "GTP": "GTP_CID_6830.sdf",
  "H⁺": "H.sdf", //.pdb", //H_CID_5362549.sdf", // H_CID_5460653.sdf", //H_CID_1038.sdf",
  "H₂O": "H2O.mol",
  "CO₂": "CO2_CID_280.sdf",
  "fosfato": "fosfato_CID_1061.sdf",
  "FAD": "FAD_CID_643975.sdf",
  "FADH₂": "FADH2_CID_446013.sdf"
};

const proteinoj = {
  "citrat-sintazo": "citratsintazo_5uzq.cif.gz",
  "akonitazo": "akonitazo_1b0j.cif.gz",
  "izocitrat-dehidrogenazo": "IDH_1ika.cif.gz",
  "α-ketoglutarat-dehidrogenazo": "ODGH_7wgr.cif.gz",
  "dihidrolipoamid-sukciniltransferazo": "-",
  "dihidrolipoamid-dehidrogenazo": "-",
  "sukcinil-KoA-sintetazo": "SCS_6wcv.cif.gz",
  "sukcinat-dehidrogenazo": "SDH_1nek.cif.gz",
  "fumarazo": "fumarazo_3e04.cif.gz",
  "malat-dehidrogenazo": "MDH_1ie3.cif.gz"
};

let svg;
let sbgn;

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

  sbgn = new SBGN(svg,modelo,molekuloj,proteinoj);

  jmol_preparo(svg);

  paŝo("#P_citrato");

  svg.querySelectorAll("g[id]").forEach((g) => {
    if (g.querySelector('a[*|href="#sekva_pasho"]')) {
      g.addEventListener("click",() => paŝo());
    } else {
      g.addEventListener("click",svg_elekto);
    }
  });

  // kontrolu ĉu mankas molekuloj/proteinoj
  // eraroj/avertoj estas skribataj al la konsolo
  sbgn.kompleteco();

});

function svg_elekto(event) {
  const g = event.currentTarget;
  console.log("klako: "+g.id);
  if (g.classList.contains("aktiva")) {
    ŝargu_molekulon(g);
  }
};


function ŝargu_molekulon(g) {
    const text = g.querySelector("text");
    const molekulo = g.textContent.replace(/[\s\n]/g,"")
    // montru la molekulon - fontoj en maldekstra fenestreto, celoj en dekstra
    if (molekuloj[molekulo]) {
      const jmol_id = g.classList.contains("celo")? "jmol_produkto" : "jmol_fonto";
      jmol_ŝargu(jmol_id,molekuloj[molekulo],g);
    } else if (proteinoj[molekulo]) {
      jmol_ŝargu("jmol_proteino",proteinoj[molekulo],g);
    };
}

function jmol_ŝargu(jmol_id,dosiero,g) {
    svg.style.cursor = "wait";
    sbgn.jmol_fokuso(jmol_id,g);

    switch (jmol_id) {
      case "jmol_proteino": 
        Jmol.script(jmol_proteino_ref, `load "inc/${dosiero}"; cartoon only; color cartoon structure; set antialiasDisplay ON`);
        break;
      case "jmol_fonto":
        Jmol.script(jmol_fonto_ref, `load "inc/${dosiero}"; set antialiasDisplay ON`);
        break;
      case "jmol_produkto":
        Jmol.script(jmol_produkto_ref, `load "inc/${dosiero}"; set antialiasDisplay ON`);
        break;
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
  sbgn.nodo_klaso(proceso,"proceso","aktiva");

  // ni trovu tiun proceso-nodon en la modelo?
  for (const [n,nv] of Object.entries(modelo.nodoj)) {
    if (nv[1] == proceso) {
      // sekvu ĉiujn eĝojn de tie kaj aktivigu ilin kaj la
      // aliflankajn nodojn
      for (const [e,ev] of Object.entries(modelo.eĝoj)) {
        if (ev[0] == n) {
          const n2 = modelo.nodoj[ev[1]];
          sbgn.nodo_klaso(n2[1],"celo","aktiva");
          // se la celo estas fonto de alia proceso, ni
          // scias ke ĝi estas en la ciklo la sekva produkto
          // kaj montras ĝin per JMol
          if (sbgn.fonto_de_procezo(n2[1])) {
            ŝargu_molekulon(sbgn.nodo_href(n2[1]));
          }
        } else if (ev[1] == n) {
          const n2 = modelo.nodoj[ev[0]];
          // se estas sgbn.Macromolecule ni povus
          // donas klason "proteino","aktiva" kaj montras en la centra JMol-rigardo
          if (n2[0] == "sbgn.Macromolecule") {
            sbgn.nodo_klaso(n2[1],"proteino","aktiva");
            ŝargu_molekulon(sbgn.nodo_href(n2[1]));
          } else {
            sbgn.nodo_klaso(n2[1],"fonto","aktiva");
            // se la fonto estas celo de alia proceso, ni
            // scias ke ĝi estas en la ciklo la elira molekulo
            // de la aktuala proceso kaj montras ĝin per JMol
            if (sbgn.produkto_de_procezo(n2[1])) {
              ŝargu_molekulon(sbgn.nodo_href(n2[1]));
            }
          }
        }
      }

      return;
    }
  }
}


function postShargo() {
  console.log("post ŝargo"); svg.style.cursor = "auto";
}

function jmol_preparo() {
  // anstataŭigu SVG-grupon _fo_proteino per foreignObject/div por
  // tie montri proteinojn per JSMol
  sbgn.foreignObject("#fo_proteino",_jmol_proteino);
  sbgn.foreignObject("#fo_fonto",_jmol_fonto);
  sbgn.foreignObject("#fo_produkto",_jmol_produkto);

  sbgn.jmol_fokuso("jmol_proteino",sbgn.nodo_href("#citratsintazo"));
  jmol_proteino_ref = jmol_div(_jmol_proteino,
    "", //inc/citratsintazo_5uzq.cif.gz",
    400,400,
    (app) => { Jmol.script(app,
      'cartoon only; color cartoon structure; set antialiasDisplay ON'
    )}
    ,
    "postShargo"
  );

  sbgn.jmol_fokuso("jmol_fonto",sbgn.nodo_href("#okzalacetato"));
  jmol_fonto_ref = jmol_div(_jmol_fonto,
    "", //inc/okzalacetato_CID_970.sdf",
    180,180,
    (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )},
    "postShargo"
  );

  sbgn.jmol_fokuso("jmol_produkto",sbgn.nodo_href("#citrato"));
  jmol_produkto_ref = jmol_div(_jmol_produkto,
    "", //inc/citrato_CID_311.sdf",
    180,180,
    (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )},
    "postShargo"
  );
}


</script>

## fontoj
{: .fontoj}

[^F1]: [Proteindaumbazo - RCSB PDB](https://www.rcsb.org)
[^F2]: [PubChem de Usona Nacia Centro por Bioteĥnologia Informoj - NCBI](https://pubchem.ncbi.nlm.nih.gov)
[^W1]: [(en) Wikipdedia - Citric acid cycle](https://en.wikipedia.org/wiki/Citric_acid_cycle)

<!-- fontoj:

Wikipedia:...

https://www.pathwayz.org/Tree/Plain/AEROBIC+RESPIRATION

https://chem.libretexts.org/Bookshelves/General_Chemistry/Book%3A_Structure_and_Reactivity_in_Organic_Biological_and_Inorganic_Chemistry_(Schaller)/III%3A_Reactivity_in_Organic_Biological_and_Inorganic_Chemistry_1/09%3A_Mechanisms_of_the_Tricarboxylic_Acid_Cycle/9.03%3A_Catalysis_in_the_TCA_Cycle

https://www.khanacademy.org/science/biology/cellular-respiration-and-fermentation/pyruvate-oxidation-and-the-citric-acid-cycle/a/the-citric-acid-cycle

https://basicmedicalkey.com/tricarboxylic-acid-cycle/

https://researchtweet.com/tca-cycle-definition-function-mechanism-location/

-->