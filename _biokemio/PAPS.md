---
layout: laborfolio
title: PAPS
js:
  - folio-0c
  - jmol-0a  
  - jsmol/JSmol.min
---

<!-- https://chemapps.stolaf.edu/jmol/docs/ 
https://chemapps.stolaf.edu/jmol/docs/#connect
http://openmopac.net/Manual/Individual%20JSmol%20paths/Animations.html
http://molmovdb.org/

https://wiki.jmol.org/index.php/Jmol_JavaScript_Object/Functions
https://wiki.jmol.org/index.php/Lightweight_JSmol
http://wiki.jmol.org/index.php/Jmol_JavaScript_Object

-->

La adenozinkombinaĵo 3′-fosfoadenozin-5′-fosfosulfato kun du fosfat- kaj unu sulfat-grupoj ludas gravan rolon en
la sintezo de karageno kaj heparino aŭ la malvenenigo de damaĝaj substancoj. Tial PAPS ekzemple troviĝas abunde en la hepato de bestoj.

<script type="text/javascript">

lanĉe(() => {	

    jmol_div("appdiv",
      "inc/PAPS_CID_10214.sdf",
      600,600,
      (app) => { Jmol.script(app,
        'set antialiasDisplay ON'
      )}
    );

});
</script>

<div id="appdiv"></div>

<!--
<script type="text/javascript" src="https://chemapps.stolaf.edu/jmol/jmol.php?model=C1%3DNC2%3DC%28C%28%3DN1%29N%29N%3DCN2%5BC%40H%5D3%5BC%40%40H%5D%28%5BC%40%40H%5D%28%5BC%40H%5D%28O3%29COP%28%3DO%29%28O%29OS%28%3DO%29%28%3DO%29O%29OP%28%3DO%29%28O%29O%29O&inline&height=600&width=800"></script>
-->