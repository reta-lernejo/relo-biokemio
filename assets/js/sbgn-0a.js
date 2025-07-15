const SVGNS = "http://www.w3.org/2000/svg";
const XLINKNS = "http://www.w3.org/1999/xlink";
const XHTMLNS = "http://www.w3.org/1999/xhtml";


class SVG {


   /** Kreas SVG-elementon kun atributoj
     * @param nomo elementnomo, ekz-e 'div'
     * @param atributoj objekto kies kampoj estas la atributnomoj kaj ties valoroj
     */
    static e(nomo, atributoj, teksto) {
        const el = document.createElementNS(SVGNS, nomo);
        if (atributoj) {
            for (const [atr,val] of Object.entries(atributoj)) {
                el.setAttribute(atr,val);
            }
        };
        if (teksto) el.textContent = teksto;
        return el;
    }


    /**
     * Aldonas aŭ ŝanĝas atributojn de SVG-DOM-elemento
     * 
     * @param elemento la DOM-elemento 
     * @param atributoj objekto kies kampoj estas la atributnomoj kaj ties valoroj
     * @returns 
     */
    static a(elemento, atributoj) {
        if (atributoj) {
            for (const [atr,val] of Object.entries(atributoj)) {
                elemento.setAttribute(atr,val);
            }
        };
        return elemento;
    }


    /**
     * Aldonas idon al SVG-elemento. Se jam ekzistas tia kun
     * la donita nomo, tion ni forigos unue
     * @param {*} elm 
     * @param {*} id 
     * @param {*} nom 
     */
    static ido(elm, id, nom) {
        const malnov = document.getElementById(nom);
        if (malnov) malnov.remove();

        id.setAttribute("id",nom);
        elm.append(id);
    }    
}

class SBGN {

    /**
     * Kalkulas la punkton de la fokuslinio sur la rando
     * de cirklo (flanko = 1|-1) 
     */
    static radipunkto(ax,ay,cx,cy,r,flanko=1) {
        // longo de la kateto a_c
        const dx = ax-cx;
        const dy = ay-cy;
        const A = Math.sqrt(dx*dx + dy*dy);
    
        const bx = cx + r*(dy/A)*flanko;
        const by = cy + r*(-dx/A)*flanko;
    
        return[bx,by];
    }
  

    /**
     * 
     * @param {*} modelo - modelo eltirita per pro/trf/graphml2mdl.pl el SBGN graphml-dosiero (kreita per yEd)
     * @param {*} molekuloj - listo de molekul-dosieroj por la simplaj molekuloj (SDF)
     * @param {*} proteinoj - listo de molekul-dosieroj por la proteinoj/makromolekuloj (CIF, PDB)
     */
    constructor(svg,modelo,molekuloj,proteinoj) {
        this.svg = svg;
        this.modelo = modelo;
        this.molekuloj = molekuloj;
        this.proteinoj = proteinoj;
    }

    /**
     * Kontrolas la kompletecon de SBGN-modelo: por ĉiu nodo ni 
     * havu difinitan dosieron referencitan en molekulon (SimpleChemical) aŭ proteinon (Macromolecule)
     */
    kompleteco() {
        for (const n of Object.values(this.modelo.nodoj)) {
            if (n[0] == "sbgn.SimpleChemical") {
                const g = this.nodo_href(n[1]);
                //const text = g.querySelector("text");
                const molekulo = g.textContent.replace(/[\s\n]/g,"");
                if (! this.molekuloj[molekulo]) {
                    console.error(`Mankas molekulo: ${molekulo} (${n[1]})`);
                }
            } else if (n[0] == "sbgn.Macromolecule") {
                const g = this.nodo_href(n[1]);
                //const text = g.querySelector("text");
                const molekulo = g.textContent.replace(/[\s\n]/g,"");
                if (! this.proteinoj[molekulo]) {
                    console.error(`Mankas proteino: ${molekulo} (${n[1]})`);
                }
            }
        }
    }


    /**
     *  Anstataŭigas la enhavon de la SVG-grupo gid
     * per foreignObject por uzi ĝin kun JsMol
     */
    foreignObject(gid,fid) {

        const a = this.svg.querySelector(`a[*|href="${gid}"`);
        const g = a.parentElement;
      
        // ni devas eltrovi mezurojn kaj transformon
        // de enhavita g, rect
      
        const fO = SVG.e("foreignObject");
        const r = g.querySelector("rect");
      
        // matrix(1,0,0,1,-249,192)
        let x = parseFloat(r.getAttribute("x"));
        let y = parseFloat(r.getAttribute("y"));
        let width = parseFloat(r.getAttribute("width"));
        let height = parseFloat(r.getAttribute("height"));
      
        const [tf,dx,dy] = this.translation(g);
      
        if (!dx && !dy && tf.length)
          g.setAttribute("transform",tf);
      
        // ni kreas fokusliniojn por montri de la
        // molekulo en la ciklo al al JMol-rigardo
        const fono = svg.querySelector('g[fill="white"][stroke="white"]');
        // PLIBONIGU: ni supozas ke estas la sama transformo kiel de fO
        // sed pli bone estus forigi la transformon de la fono
        // kaj ĝustigi la koordinatojn de ĝia rektangulo
        //const fono_tf = fono.getAttribute("transform");
        const klaso = fid.split('_')[1];
        const l1 = SVG.e("line",{
          id: fid+"_fokus_1",
          class: "fokuso "+klaso,
          //transform: fono_tf,
          x1: -dx, y1: -dy,
          x2: x+width/2,
          y2: y+height/2
        });
        const l2 = SVG.e("line",{
          id: fid+"_fokus_2",
          class: "fokuso "+klaso,
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
      
        const div = document.createElementNS(XHTMLNS,"div")
        div.id = fid;
        fO.append(div);
      
        // anstataŭgu enhavon de t per fO
        g.textContent="";
        g.append(fO);
      
        return div;
    }


    jmol_fokuso(jmol_id,g) {
        // ŝanĝu la eliron de fokuslinoj al la elektita molekulo
        const l1 = svg.querySelector("#"+jmol_id+"_fokus_1");
        const l2 = svg.querySelector("#"+jmol_id+"_fokus_2");
        const jm = svg.querySelector("#"+jmol_id);
      
        const bb1 = g.getBBox();
        const bb2 = jm.parentElement.getBBox();
      
        // console.log(jm.parentElement);
        // console.log(bb2);
      
        // elturniĝu pro cimo en Safari/Webkit
        if (!bb2.x && !bb2.y) {
          bb2.x = jm.parentElement.getAttribute("x");
          bb2.y = jm.parentElement.getAttribute("y");
        }
      
        const ax = bb1.x+bb1.width/2;
        const ay = bb1.y+bb1.height/2;
      
        const cx = bb2.x+bb2.width/2;
        const cy = bb2.y+bb2.height/2;
      
        const fp1 = SBGN.radipunkto(ax,ay,cx,cy,bb2.width/2,1);
        const fp2 = SBGN.radipunkto(ax,ay,cx,cy,bb2.width/2,-1);
      
        // tio estas la ŝoviĝo, kiun yEd aplikas
        // al ĉiuj grupoj, pro simpleco ni metas tie
        // ĉi fikse, sed:
        // PLIBONIGU: eltrovu tion prepare unufoje!
        const [tf,tx,ty] = sbgn.translation(g);
      
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
      

    /**
     * la molekulo href estas produkto de iu procezo
     */
    produkto_de_procezo(href) {
        for (const ev of Object.values(this.modelo.eĝoj)) {
            const n0 = modelo.nodoj[ev[0]];
            const n1 = modelo.nodoj[ev[1]];
            if (n1[1] == href && n0[0] == "sbgn.Process") return true;
        }
    }
    
    /**
     * la molekulo href estas fonto de iu procezo
     */
    fonto_de_procezo(href) {
        for (const ev of Object.values(this.modelo.eĝoj)) {
            const n0 = modelo.nodoj[ev[0]];
            const n1 = modelo.nodoj[ev[1]];
            if (n0[1] == href && n1[0] == "sbgn.Process") return true;
        }
    }    
    
    /**
     * Redonas g-elementon de nodo identigitan per xlink:href
     * Por ke tio funkciu la nodo devas ricevi URL #<href> en yEd
     */
    nodo_href(href) {
        const a = svg.querySelector(`a[*|href="${href}"`);
        if (a) return a.parentElement;
    }    

    /**
     * Aldonas CSS-klasojn al nodo identigitan per href
     * Por ke tio funkciu la nodo devas ricevi URL #<href> en yEd
     * @param {*} href 
     * @param  {...any} klasoj 
     */
    nodo_klaso(href,...klasoj) {
        const g = this.nodo_href(href);
        if (g) {
          if (klasoj)
            g.classList.add(...klasoj);
          else
            g.className = "";
        }
    }    

    /**
     * yEd donas al ĉiu grupo de nodo, eĝo transformmatricon, kiu kutime nur en havas ŝovon (translation)
     * La funkcio redonas la koordinatojn [x,y] de tiu aŭ [0,0] aliokaze
     * @param {*} g SVG g-elemento de kiu eltrovi la ŝov-koordinatojn
     * @returns 
     */
    translation(g) {
        const re_mx = /matrix\(1,0,0,1,(.*)\)/;
      
        const tf = g.querySelector("g[transform]").getAttribute("transform");
      
        const m = tf.match(re_mx);
        if (m) {
          const coord = m[1].split(',');
          return["",parseFloat(coord[0]),parseFloat(coord[1])];
        } else {
          return [tf,0,0];
        }
    }
      

};    