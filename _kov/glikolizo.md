---
layout: laborfolio
title: Malkombino de glukozo
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
https://en.wikipedia.org/wiki/Glycolysis
https://de.wikipedia.org/wiki/Glykolyse
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

{% include_relative inc/Glikolizo_SGBN_PD.svg %}

<script>

const modelo = {% include_relative inc/Glikolizo_SGBN_PD.mdl %};

let jmol_proteino_ref;
const _jmol_proteino = "jmol_proteino";

let jmol_fonto_ref;
const _jmol_fonto = "jmol_fonto";

let jmol_produkto_ref;
const _jmol_produkto = "jmol_produkto";

const molekuloj = {
};

const proteinoj = {};

let svg;
let sbgn;

lanĉe(() => {  
  // povas esti pluraj SVG en la paĝo, sed nur unu havas y.node.0"
  const eniro = document.getElementById("y.node.0"); // querySelector('a[*|href="#P_citrato"]');
  svg = eniro.closest("svg");

  // yEd ne enmetas viewBox, sed ni bezonos tion
  // por skali la grafikon
  const w = svg.getAttribute("width");
  const h = svg.getAttribute("height");
  svg.setAttribute("viewBox",`0 0 ${w} ${h}`);

  sbgn = new SBGN(svg,modelo,molekuloj,proteinoj);
  jmol_preparo(svg);

  paŝo("#P1");

  svg.querySelectorAll("g[id]").forEach((g) => {
    if (g.querySelector('a[*|href="#sekva_pasho"]')) {
      g.addEventListener("click",() => paŝo());
    } else {
      g.addEventListener("click",svg_elekto);
    }
  });

  // kontrolu ĉu mankas molekuloj/proteinoj
  sgbn.kompleteco();

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
  const procezoj = ["#P1", "#P2", "#P3", "#P4", "#P5", "#P6", "#P7", "#P8", "#P9", "#P10"];

  // kio estas la aktiva procezo?
  const akt_a = svg.querySelector(".proceso.aktiva a");
  const akt_proc = akt_a? akt_a.getAttributeNS(XLINKNS,"href") : undefined;

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

  sbgn.jmol_fokuso("jmol_proteino",sbgn.nodo_href("#heksokinazo"));
  jmol_proteino_ref = jmol_div(_jmol_proteino,
    "", //inc/heksokinazo_....cif.gz",
    400,400,
    (app) => { Jmol.script(app,
      'cartoon only; color cartoon structure; set antialiasDisplay ON'
    )}
    ,
    "postShargo"
  );

  sbgn.jmol_fokuso("jmol_fonto",sbgn.nodo_href("#P1_glukozo"));
  jmol_fonto_ref = jmol_div(_jmol_fonto,
    "", //inc/oglukozo_CID_999.sdf",
    180,180,
    (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )},
    "postShargo"
  );

  sbgn.jmol_fokuso("jmol_produkto",sbgn.nodo_href("#G6P"));
  jmol_produkto_ref = jmol_div(_jmol_produkto,
    "", //inc/G6P_CID_999.sdf",
    180,180,
    (app) => { Jmol.script(app,
      'set antialiasDisplay ON'
    )},
    "postShargo"
  );
}

</script>