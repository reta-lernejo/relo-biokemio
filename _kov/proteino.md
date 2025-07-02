---
layout: laborfolio
title: Proteino
js:
  - folio-0c
  - svg-0c
  - jmol-0a
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
        600,600,
        (app) => { Jmol.script(app,
        'cartoon only; color cartoon structure; set antialiasDisplay ON'
        )}
    );
  });

</script>


<div id="jmol_proteino"></div>