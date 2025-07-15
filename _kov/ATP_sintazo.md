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

filmoj pri ATP-sintezado:
https://www.youtube.com/watch?v=lUrEewYLIQg
https://www.youtube.com/watch?v=OT5AXGS1aL8
https://www.youtube.com/watch?v=kXpzp4RDGJI



https://pdb101.rcsb.org/motm/72

stato 1b: https://www.rcsb.org/structure/5ARE
stato 2b: https://www.rcsb.org/structure/5ARI
sato 3b: https://www.rcsb.org/structure/5FIL

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


</style>


<script>

const jmol_script = [
  "set antialiasDisplay",
  "background black",
  "frank off", // branding off
  "load FILES 'inc/5are.cif.gz' 'inc/5ari.cif.gz' 'inc/5fil.cif.gz'",
  "model *",
  "select all",
  "wireframe off",
  "cpk off", // Corey-Pauling-Koltun space-filling off
  "cartoon off",
  "select protein", // setup for protein
  "cpk 3.", // Corey-Pauling-Koltun space-filling 3.0
  "select *:A or *:B or *:C",
  "color [255,150,150]",
  "select *:D or *:E or *:F",
  "color [255,100,100]",
  "select *:J",
  "color [50,250,255]",
  "select *:K",
  "color [100,250,255]",
  "select *:L",
  "color [50,230,255]",
  "select *:M",
  "color [100,250,255]",
  "select *:N",
  "color [50,230,255]",
  "select *:O",
  "color [200,250,255]",
  "select *:P",
  "color [50,230,255]",
  "select *:Q",
  "color [100,250,255]",
  "select *:G",
  "color [100,100,255]",
  "select *:H ",
  "color [150,150,255]",
  "select *:I",
  "color [120,120,255]",
  "select *:T ",
  "color [235,180,100]",
  "select *:S",
  "color [235,180,150]",
  "select *:U or *:V",
  "color [235,200,130]",
  "select *:W ",
  "color [255,100,200]",
  "rotate z 83.",
  "rotate y 96.",
  "rotate z 89.",
  "background black",
  "set zshade", // depth shading
  "set zshadepower 1",
  "message _start", // loop through all three states
  "display */1",
  "delay 0.5",
  "display */2",
  "delay 0.5",
  "display */3",
  "delay 0.5",
  "goto _start"
];

  let jmol_ref;
  lanĉe(() => {
    jmol_ref = jmol_div("jmol_proteino",
        "",
        200,200,
        (app) => { Jmol.script(app,
        jmol_script.join(";")
        )}
    );
  });

</script>

<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 300 300"
width="300" height="300">
  <g>
   <rect x="48" y="48" width="204" height="204" stroke="black" stroke-width="1"/>
   <foreignObject x="49" y="49" width="202" height="202" style="border: 1px solid blue; border-radius: 50%">
     <div xmlns="http://www.w3.org/1999/xhtml" id="jmol_proteino" style="border: 1px solid green; border-radius: 50%"></div>
  </foreignObject>
  </g>
</svg> 