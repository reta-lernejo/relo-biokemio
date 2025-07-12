---
layout: laborfolio
title: Malkombino de glukozo
chapter: 4.2
js:
  - folio-0c
  - mathjax/es5/tex-chtml  
  - svg-0d
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

  // kontrolu ĉu mankas molekuloj/proteinoj
  kompleteco();

});

function kompleteco() {
  for (const n of Object.values(modelo.nodoj)) {
    if (n[0] == "sbgn.SimpleChemical") {
      const g = nodo_href(n[1]);
      const text = g.querySelector("text");
      const molekulo = g.textContent.replace(/[\s\n]/g,"");
      if (!molekuloj[molekulo]) {
        console.error(`Mankas molekulo: ${molekulo} (${n[1]})`);
      }
    } else if (n[0] == "sbgn.Macromolecule") {
      const g = nodo_href(n[1]);
      const text = g.querySelector("text");
      const molekulo = g.textContent.replace(/[\s\n]/g,"");
      if (!proteinoj[molekulo]) {
        console.error(`Mankas proteino: ${molekulo} (${n[1]})`);
      }
    }
  }
}

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
    fokuso(jmol_id,g);

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
</script>