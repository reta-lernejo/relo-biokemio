---
layout: laborfolio
title: Proteino
js:
  - folio-0c
  - svg-0c
  - jmol-0b
  - jsmol/JSmol.min
---

<!-- 

citrasintazo: https://www.rcsb.org/structure/5UZQ 
-->

<script>


  let jmol_ref;
  lanĉe(() => {
    jmol_ref = jmol_div("jmol_proteino",
        "inc/citratsintazo_5uzq.cif.gz",
        200,200,
        (app) => { Jmol.script(app,
        'cartoon only; color cartoon structure; set antialiasDisplay ON'
        )}
    );
  });

</script>

<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 300 300"
width="300" height="300">
  <g>
   <rect x="48" y="48" width="204" height="204" stroke="black" stroke-width="1"/>
   <foreignObject x="49" y="49" width="202" height="202" style="border: 1px solid blue; border-radius: 50%">
     <div xmlns="http://www.w3.org/1999/xhtml" id="jmol_proteino"></div>
  </foreignObject>
  </g>
</svg>  