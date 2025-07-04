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
const _fo_proteino_gid = "y\\.node\\.47";
const _jmol_proteino = "jmol_proteino";

let jmol_fonto_ref;
const _fo_fonto_gid = "y\\.node\\.48";
const _jmol_fonto = "jmol_fonto";

let jmol_produkto_ref;
const _fo_produkto_gid = "y\\.node\\.49";
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

lanĉe(() => {
  const svg = ĝi("#svg_citratciklo");
  svg.querySelectorAll("g[id]").forEach((g) => {
    g.addEventListener("click",svg_elekto);
  });

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

  

});

</script>

<svg id="svg_citratciklo" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill-opacity="1" color-rendering="auto" color-interpolation="auto" text-rendering="auto" stroke="black" stroke-linecap="square" width="999" stroke-miterlimit="10" shape-rendering="auto" stroke-opacity="1" fill="black" stroke-dasharray="none" font-weight="normal" stroke-width="1" height="929" font-family="'Dialog'" font-style="normal" stroke-linejoin="miter" font-size="12px" stroke-dashoffset="0" image-rendering="auto">
  <!--Generated by ySVG 2.5-->
  <defs id="genericDefs"/>
  <g>
    <defs id="defs1">
      <clipPath clipPathUnits="userSpaceOnUse" id="clipPath1">
        <path d="M0 0 L999 0 L999 929 L0 929 L0 0 Z"/>
      </clipPath>
      <clipPath clipPathUnits="userSpaceOnUse" id="clipPath2">
        <path d="M245 -248 L1244 -248 L1244 681 L245 681 L245 -248 Z"/>
      </clipPath>
      <clipPath clipPathUnits="userSpaceOnUse" id="clipPath3">
        <path d="M0 0 L0 17 L78 17 L78 0 Z"/>
      </clipPath>
      <script type="text/ecmascript">
        <![CDATA[      var SVGDocument = null;
      var SVGRoot = null;
      var TrueCoords = null;
      var lastElement = null;
      var initialized = null;
      var tipGroup;
      function Init(evt)
      {
         SVGDocument = evt.target.ownerDocument;
         SVGRoot = SVGDocument.documentElement;
         TrueCoords = SVGRoot.createSVGPoint();
         initialized = evt;
      };
      function GetTrueCoords(evt)
      {
         var newScale = SVGRoot.currentScale;
         var translation = SVGRoot.currentTranslate;
         TrueCoords.x = (evt.clientX - translation.x)/newScale;
         TrueCoords.y = (evt.clientY - translation.y)/newScale;
      };
      function HideTooltip( evt )
      {
         if(initialized == null) {
           Init(evt);
         }
         if(tipGroup != null) {
           tipGroup.setAttributeNS(null, 'visibility', 'hidden');
         }
      };
      function ShowTooltip( evt )
      {
         if(initialized == null) {
           Init(evt);
         }
         GetTrueCoords( evt );
         var tipScale = 1/SVGRoot.currentScale;
         var targetElement = evt.currentTarget;
         if ( lastElement != targetElement )
         {
            var targetId = targetElement.getAttributeNS(null, 'id');
            var tipId = 'tooltip.' + targetId;
            tipGroup = SVGDocument.getElementById(tipId);
            var xPos = TrueCoords.x + (10 * tipScale);
            var yPos = TrueCoords.y + (10 * tipScale);
            tipGroup.setAttributeNS(null, 'transform', 'translate(' + xPos + ',' + yPos + ') scale(' + tipScale + ')');
            tipGroup.setAttributeNS(null, 'visibility', 'visible');
         }
      };
]]>
      </script>
    </defs>
    <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="translate(-245,248)" stroke="white">
      <rect x="245" width="999" height="929" y="-248" clip-path="url(#clipPath2)" stroke="none"/>
    </g>
    <g id="y.node.0">
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="706.5105" xml:space="preserve" y="256.5876" stroke="none">citratciklo</text>
        </g>
      </g>
    </g>
    <g id="y.node.1">
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="708.2841" xml:space="preserve" y="-219.8301" stroke="none">mitoĥondrio</text>
        </g>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" stroke-width="3" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="260.718" y="-232.9688" fill="none" width="967.9819" rx="4" ry="4" height="898.1713"/>
      </g>
    </g>
    <g id="y.node.2">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="621.8" y="-124.2326" width="73" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="621.8" y="-124.2326" fill="none" width="73" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="627.8166" xml:space="preserve" y="-100.0783" stroke="none">acetil-CoA</text>
        </g>
      </g>
    </g>
    <g id="y.node.3">
      <g fill="rgb(255,204,153)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,153)">
        <rect x="569.1852" y="-61.0667" width="80" rx="15.5101" ry="15.5101" height="31.0201" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="569.1852" y="-61.0667" fill="none" width="80" rx="15.5101" ry="15.5101" height="31.0201"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="570.8268" xml:space="preserve" y="-41.4023" stroke="none">okzalacetato</text>
        </g>
      </g>
    </g>
    <g id="y.node.4">
      <g fill="rgb(255,204,153)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,153)">
        <rect x="844.8" y="-48.3452" width="47.4832" rx="13.6393" ry="13.6393" height="27.2785" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="844.8" y="-48.3452" fill="none" width="47.4832" rx="13.6393" ry="13.6393" height="27.2785"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="849.0563" xml:space="preserve" y="-30.5516" stroke="none">citrato</text>
        </g>
      </g>
    </g>
    <g id="y.node.5">
      <g fill="rgb(255,204,153)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,153)">
        <rect x="988.8558" y="82.4707" width="60" rx="13.6393" ry="13.6393" height="27.2785" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="988.8558" y="82.4707" fill="none" width="60" rx="13.6393" ry="13.6393" height="27.2785"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="990.8831" xml:space="preserve" y="100.2642" stroke="none">izocitrato</text>
        </g>
      </g>
    </g>
    <g id="y.node.6">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M988.8558 -51.0667 Q988.8558 -61.0667 998.8558 -61.0667 L1058.8558 -61.0667 Q1068.8558 -61.0667 1068.8558 -51.0667 L1068.8558 -31.0667 Q1068.8558 -21.0667 1058.8558 -21.0667 L998.8558 -21.0667 Q988.8558 -21.0667 988.8558 -31.0667 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M988.8558 -51.0667 Q988.8558 -61.0667 998.8558 -61.0667 L1058.8558 -61.0667 Q1068.8558 -61.0667 1068.8558 -51.0667 L1068.8558 -31.0667 Q1068.8558 -21.0667 1058.8558 -21.0667 L998.8558 -21.0667 Q988.8558 -21.0667 988.8558 -31.0667 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="999.7142" xml:space="preserve" y="-36.9124" stroke="none">akonitazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.7">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M690.8 -164.6771 Q690.8 -174.6771 700.8 -174.6771 L768.8 -174.6771 Q778.8 -174.6771 778.8 -164.6771 L778.8 -144.6771 Q778.8 -134.6771 768.8 -134.6771 L700.8 -134.6771 Q690.8 -134.6771 690.8 -144.6771 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M690.8 -164.6771 Q690.8 -174.6771 700.8 -174.6771 L768.8 -174.6771 Q778.8 -174.6771 778.8 -164.6771 L778.8 -144.6771 Q778.8 -134.6771 768.8 -134.6771 L700.8 -134.6771 Q690.8 -134.6771 690.8 -144.6771 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="695.3752" xml:space="preserve" y="-150.5228" stroke="none">citrat-sintazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.8">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="725.8" width="18" height="18" y="-73.9656" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="725.8" width="18" height="18" y="-73.9656"/>
      </g>
      <g/>
    </g>
    <g id="y.node.9">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="767.3168" y="-21.0667" width="47.4832" rx="15.5101" ry="15.5101" height="31.0201" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="767.3168" y="-21.0667" fill="none" width="47.4832" rx="15.5101" ry="15.5101" height="31.0201"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="768.6082" xml:space="preserve" y="-1.4023" stroke="none">CoA-SH</text>
        </g>
      </g>
    </g>
    <g id="y.node.10">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="935.6785" width="18" height="18" y="12.6348" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="935.6785" width="18" height="18" y="12.6348"/>
      </g>
      <g/>
    </g>
    <g id="y.node.11">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="1040.5187" width="18" height="18" y="189.0717" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="1040.5187" width="18" height="18" y="189.0717"/>
      </g>
      <g/>
    </g>
    <g id="y.node.12">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M1116.4885 177.0717 Q1116.4885 167.0717 1126.4885 167.0717 L1203.7 167.0717 Q1213.7 167.0717 1213.7 177.0717 L1213.7 197.0717 Q1213.7 207.0717 1203.7 207.0717 L1126.4885 207.0717 Q1116.4885 207.0717 1116.4885 197.0717 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1116.4885 177.0717 Q1116.4885 167.0717 1126.4885 167.0717 L1203.7 167.0717 Q1213.7 167.0717 1213.7 177.0717 L1213.7 197.0717 Q1213.7 207.0717 1203.7 207.0717 L1126.4885 207.0717 Q1116.4885 207.0717 1116.4885 197.0717 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="1138.6274" xml:space="preserve" y="184.2417" stroke="none">izocitrat-</text>
          <text x="1120.3784" xml:space="preserve" y="198.2104" stroke="none">dehidrogenazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.13">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="1097.0065" y="232.4333" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="1097.0065" y="232.4333" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="1105.6891" xml:space="preserve" y="256.5876" stroke="none">CO₂</text>
        </g>
      </g>
    </g>
    <g id="y.node.14">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="948.8558" y="133.7492" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="948.8558" y="133.7492" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="950.6155" xml:space="preserve" y="157.9035" stroke="none">NAD+</text>
        </g>
      </g>
    </g>
    <g id="y.node.15">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="950.3194" y="232.4333" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="950.3194" y="232.4333" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="952.5948" xml:space="preserve" y="256.5876" stroke="none">NADH</text>
        </g>
      </g>
    </g>
    <g id="y.node.16">
      <g fill="rgb(255,204,153)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,153)">
        <rect x="1015.7771" y="288.7492" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="1015.7771" y="288.7492" fill="none" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="1023.0373" xml:space="preserve" y="301.4292" stroke="none">alfoketo-</text>
          <text x="1022.0441" xml:space="preserve" y="315.3979" stroke="none">glutarato</text>
        </g>
      </g>
    </g>
    <g id="y.node.17">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="988.8558" width="18" height="18" y="421.4811" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="988.8558" width="18" height="18" y="421.4811"/>
      </g>
      <g/>
    </g>
    <g id="y.edge.0">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M647.9799 -51.5508 L725.7704 -63.5704"/>
      </g>
    </g>
    <g id="y.edge.1">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M687.8466 -89.0665 L725.7899 -69.5904"/>
      </g>
    </g>
    <g id="y.edge.2">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M734.8 -134.6584 L734.8 -81.9835"/>
      </g>
      <g stroke-linecap="butt" transform="matrix(1,0,0,1,-245,248)" fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" stroke="white" stroke-miterlimit="1.45">
        <path d="M734.8 -73.9835 C732.5908 -73.9835 730.8 -75.7743 730.8 -77.9835 C730.8 -80.1926 732.5908 -81.9835 734.8 -81.9835 C737.0092 -81.9835 738.8 -80.1926 738.8 -77.9835 C738.8 -75.7743 737.0092 -73.9835 734.8 -73.9835 Z" stroke="none"/>
        <path fill="none" d="M734.8 -73.9835 C732.5908 -73.9835 730.8 -75.7743 730.8 -77.9835 C730.8 -80.1926 732.5908 -81.9835 734.8 -81.9835 C737.0092 -81.9835 738.8 -80.1926 738.8 -77.9835 C738.8 -75.7743 737.0092 -73.9835 734.8 -73.9835 Z" stroke="black"/>
      </g>
    </g>
    <g id="y.edge.3">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M743.7792 -62.934 L835.0595 -42.2814"/>
        <path d="M845.7883 -39.854 L835.4082 -48.3542 L832.7601 -36.65 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.4">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M743.3431 -55.944 L769.7721 -28.035"/>
        <path d="M777.3356 -20.0479 L773.4411 -32.8866 L764.7279 -24.6355 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.5">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M884.9363 -22.574 L935.6647 14.9646"/>
      </g>
    </g>
    <g id="y.edge.6">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1001.9955 -21.0591 L960.0781 10.1641"/>
        <path fill="white" d="M953.6623 14.943 C952.3427 13.1714 952.709 10.6654 954.4807 9.3457 C956.2524 8.026 958.7584 8.3925 960.0781 10.1641 C961.3977 11.9358 961.0313 14.4418 959.2596 15.7615 C957.488 17.0811 954.9819 16.7147 953.6623 14.943 Z" stroke="none"/>
        <path fill="none" d="M953.6623 14.943 C952.3427 13.1714 952.709 10.6654 954.4807 9.3457 C956.2524 8.026 958.7584 8.3925 960.0781 10.1641 C961.3977 11.9358 961.0313 14.4418 959.2596 15.7615 C957.488 17.0811 954.9819 16.7147 953.6623 14.943 Z"/>
      </g>
    </g>
    <g id="y.edge.7">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M953.6428 30.6351 L997.4966 74.6649"/>
        <path d="M1005.2592 82.4587 L1001.0421 69.7223 L992.5397 78.1906 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.8">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1022.9507 109.7264 L1046.8075 189.056"/>
      </g>
    </g>
    <g id="y.edge.9">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1116.4769 191.6989 L1066.4738 196.458"/>
        <path fill="white" d="M1058.5098 197.216 C1058.3004 195.0168 1059.9136 193.0643 1062.1128 192.855 C1064.312 192.6457 1066.2644 194.2588 1066.4738 196.458 C1066.6831 198.6572 1065.0699 200.6097 1062.8707 200.819 C1060.6715 201.0283 1058.7191 199.4152 1058.5098 197.216 Z" stroke="none"/>
        <path fill="none" d="M1058.5098 197.216 C1058.3004 195.0168 1059.9136 193.0643 1062.1128 192.855 C1064.312 192.6457 1066.2644 194.2588 1066.4738 196.458 C1066.6831 198.6572 1065.0699 200.6097 1062.8707 200.819 C1060.6715 201.0283 1058.7191 199.4152 1058.5098 197.216 Z"/>
      </g>
    </g>
    <g id="y.edge.11">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1058.5149 205.3182 L1092.8746 232.995"/>
        <path d="M1101.4412 239.8954 L1095.8597 227.6951 L1088.332 237.0403 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.13">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1040.4993 193.1158 L986.3818 163.3794"/>
      </g>
    </g>
    <g id="y.edge.12">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1040.5083 204.2564 L995.8734 234.8934"/>
        <path d="M986.8042 241.1183 L1000.0933 239.2743 L993.3024 229.3806 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.10">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1049.5187 207.0676 L1049.5187 277.7409"/>
        <path d="M1049.5187 288.7409 L1055.5187 276.7409 L1043.5187 276.7409 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.15">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1043.1744 319.7596 L1001.5401 421.4796"/>
      </g>
    </g>
    <g id="y.node.18">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M1068.8564 436.8252 L1192.3564 436.8252 L1204.3564 448.8252 L1204.3564 564.2838 L1192.3564 576.2838 L1068.8564 576.2838 L1056.8564 564.2838 L1056.8564 448.8252 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1068.8564 436.8252 L1192.3564 436.8252 L1204.3564 448.8252 L1204.3564 564.2838 L1192.3564 576.2838 L1068.8564 576.2838 L1056.8564 564.2838 L1056.8564 448.8252 Z"/>
      </g>
      <g/>
    </g>
    <g id="y.node.19">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M1066.8564 461.2838 Q1066.8564 451.2838 1076.8564 451.2838 L1182.2167 451.2838 Q1192.2167 451.2838 1192.2167 461.2838 L1192.2167 472.304 Q1192.2167 482.304 1182.2167 482.304 L1076.8564 482.304 Q1066.8564 482.304 1066.8564 472.304 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1066.8564 461.2838 Q1066.8564 451.2838 1076.8564 451.2838 L1182.2167 451.2838 Q1192.2167 451.2838 1192.2167 461.2838 L1192.2167 472.304 Q1192.2167 482.304 1182.2167 482.304 L1076.8564 482.304 Q1066.8564 482.304 1066.8564 472.304 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="1084.2583" xml:space="preserve" y="463.9638" stroke="none">α-ketoglutarat-</text>
          <text x="1084.8208" xml:space="preserve" y="477.9326" stroke="none">dehidrogenazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.20">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M1066.8564 499.304 Q1066.8564 489.304 1076.8564 489.304 L1182.2167 489.304 Q1192.2167 489.304 1192.2167 499.304 L1192.2167 510.3241 Q1192.2167 520.3241 1182.2167 520.3241 L1076.8564 520.3241 Q1066.8564 520.3241 1066.8564 510.3241 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1066.8564 499.304 Q1066.8564 489.304 1076.8564 489.304 L1182.2167 489.304 Q1192.2167 489.304 1192.2167 499.304 L1192.2167 510.3241 Q1192.2167 520.3241 1182.2167 520.3241 L1076.8564 520.3241 Q1066.8564 520.3241 1066.8564 510.3241 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="1080.6694" xml:space="preserve" y="501.984" stroke="none">dihidrolipoamid-</text>
          <text x="1072.8384" xml:space="preserve" y="515.9527" stroke="none">sukciniltransferazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.21">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M1066.8564 537.3241 Q1066.8564 527.3241 1076.8564 527.3241 L1182.2167 527.3241 Q1192.2167 527.3241 1192.2167 537.3241 L1192.2167 548.3442 Q1192.2167 558.3442 1182.2167 558.3442 L1076.8564 558.3442 Q1066.8564 558.3442 1066.8564 548.3442 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1066.8564 537.3241 Q1066.8564 527.3241 1076.8564 527.3241 L1182.2167 527.3241 Q1192.2167 527.3241 1192.2167 537.3241 L1192.2167 548.3442 Q1192.2167 558.3442 1182.2167 558.3442 L1076.8564 558.3442 Q1066.8564 558.3442 1066.8564 548.3442 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="1080.6694" xml:space="preserve" y="540.0041" stroke="none">dihidrolipoamid-</text>
          <text x="1084.8208" xml:space="preserve" y="553.9728" stroke="none">dehidrogenazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.22">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="975.7771" y="323.2438" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="975.7771" y="323.2438" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="977.5369" xml:space="preserve" y="347.398" stroke="none">NAD+</text>
        </g>
      </g>
    </g>
    <g id="y.node.23">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="919.5014" y="341.8898" width="47.4832" rx="19.2956" ry="19.2956" height="38.5913" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="919.5014" y="341.8898" fill="none" width="47.4832" rx="19.2956" ry="19.2956" height="38.5913"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="920.7928" xml:space="preserve" y="365.3398" stroke="none">CoA-SH</text>
        </g>
      </g>
    </g>
    <g id="y.node.24">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="888.8551" y="426.1915" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="888.8551" y="426.1915" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="891.1305" xml:space="preserve" y="450.3458" stroke="none">NADH</text>
        </g>
      </g>
    </g>
    <g id="y.node.25">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="977.8558" y="497.7185" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="977.8558" y="497.7185" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="986.5384" xml:space="preserve" y="521.8728" stroke="none">CO₂</text>
        </g>
      </g>
    </g>
    <g id="y.node.26">
      <g fill="rgb(255,204,153)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,153)">
        <rect x="861.3719" y="506.6984" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="861.3719" y="506.6984" fill="none" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="870.4426" xml:space="preserve" y="519.3784" stroke="none">sukcinil-</text>
          <text x="883.1486" xml:space="preserve" y="533.3471" stroke="none">CoA</text>
        </g>
      </g>
    </g>
    <g id="y.node.27">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="725.152" width="18" height="18" y="556.9333" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="725.152" width="18" height="18" y="556.9333"/>
      </g>
      <g/>
    </g>
    <g id="y.node.28">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="663.791" y="447.4983" width="47.4832" rx="19.2956" ry="19.2956" height="38.5913" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="663.791" y="447.4983" fill="none" width="47.4832" rx="19.2956" ry="19.2956" height="38.5913"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="665.0824" xml:space="preserve" y="470.9482" stroke="none">CoA-SH</text>
        </g>
      </g>
    </g>
    <g id="y.node.29">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="750.1032" y="446.7939" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="750.1032" y="446.7939" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="757.2156" xml:space="preserve" y="470.9482" stroke="none">GDP</text>
        </g>
      </g>
    </g>
    <g id="y.node.30">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="630.6738" y="491.7185" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="630.6738" y="491.7185" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="638.7412" xml:space="preserve" y="515.8728" stroke="none">GTP</text>
        </g>
      </g>
    </g>
    <g id="y.node.31">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="797.6302" y="480.4811" width="47.4832" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="797.6302" y="480.4811" fill="none" width="47.4832" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="800.6501" xml:space="preserve" y="504.6354" stroke="none">fosfato</text>
        </g>
      </g>
    </g>
    <g id="y.node.32">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M685.5463 620.2026 Q685.5463 610.2026 695.5463 610.2026 L772.7578 610.2026 Q782.7578 610.2026 782.7578 620.2026 L782.7578 640.2026 Q782.7578 650.2026 772.7578 650.2026 L695.5463 650.2026 Q685.5463 650.2026 685.5463 640.2026 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M685.5463 620.2026 Q685.5463 610.2026 695.5463 610.2026 L772.7578 610.2026 Q782.7578 610.2026 782.7578 620.2026 L782.7578 640.2026 Q782.7578 650.2026 772.7578 650.2026 L695.5463 650.2026 Q685.5463 650.2026 685.5463 640.2026 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="695.3513" xml:space="preserve" y="627.3725" stroke="none">sukcinil-CoA-</text>
          <text x="706.6628" xml:space="preserve" y="641.3412" stroke="none">sintetazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.33">
      <g fill="rgb(255,204,153)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,153)">
        <rect x="533.1906" y="512.7185" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="533.1906" y="512.7185" fill="none" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="538.0601" xml:space="preserve" y="532.3829" stroke="none">sukcinato</text>
        </g>
      </g>
    </g>
    <g id="y.node.34">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="471.8519" width="18" height="18" y="430.5774" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="471.8519" width="18" height="18" y="430.5774"/>
      </g>
      <g/>
    </g>
    <g id="y.node.35">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="548.791" y="419.5774" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="548.791" y="419.5774" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="556.6152" xml:space="preserve" y="443.7317" stroke="none">FAD</text>
        </g>
      </g>
    </g>
    <g id="y.node.36">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="498.8519" y="326.4362" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="498.8519" y="326.4362" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="499.7592" xml:space="preserve" y="350.5905" stroke="none">FADH₂</text>
        </g>
      </g>
    </g>
    <g id="y.node.37">
      <g fill="rgb(255,204,153)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,153)">
        <rect x="386.36" y="306.6131" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="386.36" y="306.6131" fill="none" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="392.4981" xml:space="preserve" y="326.2774" stroke="none">fumarato</text>
        </g>
      </g>
    </g>
    <g id="y.node.38">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M338.8519 478.4409 Q338.8519 468.4409 348.8519 468.4409 L431.8519 468.4409 Q441.8519 468.4409 441.8519 478.4409 L441.8519 498.4409 Q441.8519 508.4409 431.8519 508.4409 L348.8519 508.4409 Q338.8519 508.4409 338.8519 498.4409 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M338.8519 478.4409 Q338.8519 468.4409 348.8519 468.4409 L431.8519 468.4409 Q441.8519 468.4409 441.8519 478.4409 L441.8519 498.4409 Q441.8519 508.4409 431.8519 508.4409 L348.8519 508.4409 Q338.8519 508.4409 338.8519 498.4409 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="362.9857" xml:space="preserve" y="485.6108" stroke="none">sukcinat-</text>
          <text x="345.6361" xml:space="preserve" y="499.5795" stroke="none">dehidrogenazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.39">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M275.718 219.7492 Q275.718 209.7492 285.718 209.7492 L345.718 209.7492 Q355.718 209.7492 355.718 219.7492 L355.718 239.7492 Q355.718 249.7492 345.718 249.7492 L285.718 249.7492 Q275.718 249.7492 275.718 239.7492 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M275.718 219.7492 Q275.718 209.7492 285.718 209.7492 L345.718 209.7492 Q355.718 209.7492 355.718 219.7492 L355.718 239.7492 Q355.718 249.7492 345.718 249.7492 L285.718 249.7492 Q275.718 249.7492 275.718 239.7492 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="287.3176" xml:space="preserve" y="233.9035" stroke="none">fumarazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.40">
      <g fill="rgb(255,204,153)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,153)">
        <rect x="422.3687" y="92.8817" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="422.3687" y="92.8817" fill="none" width="67.4832" rx="15.5101" ry="15.5101" height="31.0201"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="431.3896" xml:space="preserve" y="112.5461" stroke="none">l-malato</text>
        </g>
      </g>
    </g>
    <g id="y.node.41">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="411.1016" width="18" height="18" y="220.7492" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="411.1016" width="18" height="18" y="220.7492"/>
      </g>
      <g/>
    </g>
    <g id="y.node.42">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="343.8668" y="123.9019" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="343.8668" y="123.9019" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="352.2271" xml:space="preserve" y="148.0562" stroke="none">H₂O</text>
        </g>
      </g>
    </g>
    <g id="y.node.43">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="509.8519" width="18" height="18" y="16.4984" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="509.8519" width="18" height="18" y="16.4984"/>
      </g>
      <g/>
    </g>
    <g onmouseout="HideTooltip(evt)" id="y.node.44" onmousemove="ShowTooltip(evt)">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="596.6852" y="6.7875" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="596.6852" y="6.7875" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="598.9606" xml:space="preserve" y="30.9418" stroke="none">NADH</text>
        </g>
      </g>
    </g>
    <g id="y.node.45">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <rect x="509.8519" y="76.1099" width="40" rx="20" ry="20" height="40" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect x="509.8519" y="76.1099" fill="none" width="40" rx="20" ry="20" height="40"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="511.6117" xml:space="preserve" y="100.2642" stroke="none">NAD+</text>
        </g>
      </g>
    </g>
    <g id="y.node.46">
      <g fill="white" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="white">
        <path d="M392.4 -48.7225 Q392.4 -58.7225 402.4 -58.7225 L485.4 -58.7225 Q495.4 -58.7225 495.4 -48.7225 L495.4 -28.7225 Q495.4 -18.7225 485.4 -18.7225 L402.4 -18.7225 Q392.4 -18.7225 392.4 -28.7225 Z" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M392.4 -48.7225 Q392.4 -58.7225 402.4 -58.7225 L485.4 -58.7225 Q495.4 -58.7225 495.4 -48.7225 L495.4 -28.7225 Q495.4 -18.7225 485.4 -18.7225 L402.4 -18.7225 Q392.4 -18.7225 392.4 -28.7225 Z"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="424.5172" xml:space="preserve" y="-41.5526" stroke="none">malat-</text>
          <text x="399.1842" xml:space="preserve" y="-27.5839" stroke="none">dehidrogenazo</text>
        </g>
      </g>
    </g>
    <g id="y.node.48">
      <g fill="rgb(255,204,0)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,0)">
        <rect x="285.3981" width="128" height="128" y="-200" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="285.3981" width="128" height="128" y="-200"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="322.0055" xml:space="preserve" y="-131.8457" stroke="none">_fo_fonto</text>
        </g>
      </g>
    </g>
    <g id="y.node.49">
      <g fill="rgb(255,204,0)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,0)">
        <rect x="1068.8558" width="128" height="128" y="-200" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="1068.8558" width="128" height="128" y="-200"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="1094.017" xml:space="preserve" y="-131.8457" stroke="none">_fo_produkto</text>
        </g>
      </g>
    </g>
    <g id="y.node.47">
      <g fill="rgb(255,204,0)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke="rgb(255,204,0)">
        <rect x="556.6494" width="360" height="360" y="51.9019" stroke="none"/>
      </g>
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <rect fill="none" x="556.6494" width="360" height="360" y="51.9019"/>
      </g>
      <g>
        <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" font-family="sans-serif" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
          <text x="699.7353" xml:space="preserve" y="236.0562" stroke="none">_fo_proteino</text>
        </g>
      </g>
    </g>
    <g id="y.edge.14">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M1056.874 464.3018 L1013.8168 439.6277"/>
        <path fill="white" d="M1006.8757 435.65 C1007.9741 433.7333 1010.4183 433.0699 1012.335 434.1683 C1014.2518 435.2667 1014.9152 437.7109 1013.8168 439.6277 C1012.7184 441.5444 1010.2741 442.2078 1008.3574 441.1094 C1006.4407 440.011 1005.7773 437.5667 1006.8757 435.65 Z" stroke="none"/>
        <path fill="none" d="M1006.8757 435.65 C1007.9741 433.7333 1010.4183 433.0699 1012.335 434.1683 C1014.2518 435.2667 1014.9152 437.7109 1013.8168 439.6277 C1012.7184 441.5444 1010.2741 442.2078 1008.3574 441.1094 C1006.4407 440.011 1005.7773 437.5667 1006.8757 435.65 Z"/>
      </g>
    </g>
    <g id="y.edge.16">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M996.2531 363.2215 L997.6406 421.4497"/>
      </g>
    </g>
    <g id="y.edge.17">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M956.7095 378.2726 L990.7637 421.4823"/>
      </g>
    </g>
    <g id="y.edge.18">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M988.8601 432.0691 L939.4154 440.797"/>
        <path d="M928.5829 442.7092 L941.4432 446.5318 L939.3572 434.7145 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.20">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M997.8558 439.469 L997.8558 486.7358"/>
        <path d="M997.8558 497.7358 L1003.8558 485.7358 L991.8558 485.7358 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.19">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M988.8508 438.5207 L920.6888 499.375"/>
        <path d="M912.4833 506.7009 L925.4307 503.1848 L917.4389 494.2332 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.26">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M863.8722 530.6951 L743.178 563.4814"/>
      </g>
    </g>
    <g id="y.edge.21">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M729.9294 556.9537 L701.0531 495.5462"/>
        <path d="M696.3722 485.5919 L696.049 499.0044 L706.9083 493.8979 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.23">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M763.2834 485.6004 L737.4094 556.9508"/>
      </g>
    </g>
    <g id="y.edge.22">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M725.1439 560.083 L676.662 528.5966"/>
        <path d="M667.4369 522.6052 L674.2327 534.1732 L680.7687 524.1093 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.24">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M803.0804 514.2076 L743.1383 559.1898"/>
      </g>
    </g>
    <g id="y.edge.25">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M734.152 610.2126 L734.152 582.9708"/>
        <path fill="white" d="M734.152 574.9708 C736.3612 574.9708 738.152 576.7617 738.152 578.9708 C738.152 581.18 736.3612 582.9708 734.152 582.9708 C731.9429 582.9708 730.152 581.18 730.152 578.9708 C730.152 576.7617 731.9429 574.9708 734.152 574.9708 Z" stroke="none"/>
        <path fill="none" d="M734.152 574.9708 C736.3612 574.9708 738.152 576.7617 738.152 578.9708 C738.152 581.18 736.3612 582.9708 734.152 582.9708 C731.9429 582.9708 730.152 581.18 730.152 578.9708 C730.152 576.7617 731.9429 574.9708 734.152 574.9708 Z"/>
      </g>
    </g>
    <g id="y.edge.27">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M725.1297 563.899 L598.873 535.4306"/>
      </g>
    </g>
    <g id="y.edge.28">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M551.864 512.7103 L489.6244 448.6118"/>
      </g>
    </g>
    <g id="y.edge.29">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M548.8243 439.5774 L489.8463 439.5774"/>
      </g>
    </g>
    <g id="y.edge.30">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M484.5072 430.618 L507.1334 375.1593"/>
        <path d="M511.2887 364.9743 L501.2002 373.8186 L512.3111 378.3517 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.31">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M476.2097 430.602 L433.1686 347.3868"/>
        <path d="M428.1151 337.6163 L428.2987 351.0315 L438.9574 345.5185 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.32">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M427.4048 468.435 L464.8089 448.2394"/>
        <path fill="white" d="M471.8484 444.4386 C472.8979 446.3825 472.1729 448.8092 470.2291 449.8588 C468.2852 450.9083 465.8585 450.1833 464.8089 448.2394 C463.7594 446.2955 464.4844 443.8689 466.4283 442.8193 C468.3722 441.7697 470.7988 442.4948 471.8484 444.4386 Z" stroke="none"/>
        <path fill="none" d="M471.8484 444.4386 C472.8979 446.3825 472.1729 448.8092 470.2291 449.8588 C468.2852 450.9083 465.8585 450.1833 464.8089 448.2394 C463.7594 446.2955 464.4844 443.8689 466.4283 442.8193 C468.3722 441.7697 470.7988 442.4948 471.8484 444.4386 Z"/>
      </g>
    </g>
    <g id="y.edge.33">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M355.7028 229.7492 L403.077 229.7492"/>
        <path fill="white" d="M411.077 229.7492 C411.077 231.9583 409.2861 233.7492 407.077 233.7492 C404.8679 233.7492 403.077 231.9583 403.077 229.7492 C403.077 227.5401 404.8679 225.7492 407.077 225.7492 C409.2861 225.7492 411.077 227.5401 411.077 229.7492 Z" stroke="none"/>
        <path fill="none" d="M411.077 229.7492 C411.077 231.9583 409.2861 233.7492 407.077 233.7492 C404.8679 233.7492 403.077 231.9583 403.077 229.7492 C403.077 227.5401 404.8679 225.7492 407.077 225.7492 C409.2861 225.7492 411.077 227.5401 411.077 229.7492 Z"/>
      </g>
    </g>
    <g id="y.edge.34">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M420.1016 306.6523 L420.1016 238.7237"/>
      </g>
    </g>
    <g id="y.edge.35">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M422.7654 220.7718 L448.3817 134.439"/>
        <path d="M451.5107 123.8934 L442.3451 133.6909 L453.8494 137.1044 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.36">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M414.2118 220.7579 L380.8336 169.8031"/>
        <path d="M374.806 160.6015 L376.3625 173.9274 L386.4005 167.3519 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.40">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M467.8591 92.8695 L512.0546 34.479"/>
      </g>
    </g>
    <g id="y.edge.37">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M527.872 18.4033 L580.8265 -23.25"/>
        <path d="M589.4724 -30.0507 L576.3311 -27.3477 L583.75 -17.9158 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.38">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M527.8805 25.6174 L585.6965 26.3792"/>
        <path d="M596.6955 26.5241 L584.7756 20.3665 L584.6175 32.3655 Z" stroke="none"/>
      </g>
    </g>
    <g id="y.edge.39">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M526.7743 76.3539 L520.2562 34.5123"/>
      </g>
    </g>
    <g id="y.edge.41">
      <g text-rendering="geometricPrecision" stroke-miterlimit="1.45" shape-rendering="geometricPrecision" transform="matrix(1,0,0,1,-245,248)" stroke-linecap="butt">
        <path fill="none" d="M467.2127 -18.7476 L503.7754 12.5804"/>
        <path fill="white" d="M509.8504 17.7856 C508.413 19.4631 505.8878 19.6579 504.2103 18.2205 C502.5327 16.7831 502.338 14.2579 503.7754 12.5804 C505.2127 10.9028 507.7379 10.7081 509.4155 12.1455 C511.093 13.5829 511.2878 16.108 509.8504 17.7856 Z" stroke="none"/>
        <path fill="none" d="M509.8504 17.7856 C508.413 19.4631 505.8878 19.6579 504.2103 18.2205 C502.5327 16.7831 502.338 14.2579 503.7754 12.5804 C505.2127 10.9028 507.7379 10.7081 509.4155 12.1455 C511.093 13.5829 511.2878 16.108 509.8504 17.7856 Z"/>
      </g>
    </g>
    <g visibility="hidden" id="tooltip.y.node.44" pointer-events="none">
      <g fill="rgb(195,212,232)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" font-family="sans-serif" stroke="rgb(195,212,232)">
        <rect x="0" width="78" height="17" y="0" clip-path="url(#clipPath3)" stroke="none"/>
        <text fill="black" x="4" xml:space="preserve" y="13" clip-path="url(#clipPath3)" stroke="none">id=NADH_2</text>
      </g>
      <g fill="rgb(49,106,196)" text-rendering="geometricPrecision" shape-rendering="geometricPrecision" font-family="sans-serif" stroke="rgb(49,106,196)">
        <path d="M0 0 L78 0 L78 17 L0 17 L0 0 ZM1 1 L77 1 L77 16 L1 16 L1 1 Z" fill-rule="evenodd" clip-path="url(#clipPath3)" stroke="none"/>
      </g>
    </g>
  </g>
</svg>
