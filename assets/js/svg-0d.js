const ns = "http://www.w3.org/2000/svg";
const xlink = "http://www.w3.org/1999/xlink";


class SVG {

    /**
     * legas SVG-dokumenton el dosiero por enŝovi ĝin rekte en DOM
     * ĉe elemento kun id "el_id"
     * @param {*} dosiero 
     * @param {*} el_id 
     */
    static async legu_svg_dokumenton(dosiero, el_id) {
        try {
            const response = await fetch(dosiero);

            if (!response.ok) {
                throw new Error(`Respondstato: ${response.status}`);
            }        
            
            const svgText = await response.text();
    
            // analizu la SVG-dokumenton
            const parser = new DOMParser();
            const svgDoc = parser.parseFromString(svgText, "image/svg+xml");
            const svgElement = svgDoc.querySelector('svg'); // aŭ svgDoc.getElementById('parto...');
    
            if (svgElement) {
                // enŝovu la svg-grafikon en DOM
                const targetElement = document.getElementById(el_id);
                if (targetElement) {
                    targetElement.appendChild(svgElement);
                    return svgElement;
                } else {
                    console.error(`Elemento "+${el_id}" ne trovita.`);
                }
            } else {
                console.error("Mankas SVG-elemento en la ŝargita dosiero.");
            }
    
        } catch (error) {
            console.error("Eraro dum ŝargo de SVG:", error.message);
        }
    }
    

   /** Kreas SVG-elementon kun atributoj
     * @param nomo elementnomo, ekz-e 'div'
     * @param atributoj objekto kies kampoj estas la atributnomoj kaj ties valoroj
     */
    static e(nomo, atributoj, teksto) {
        const ns = "http://www.w3.org/2000/svg";
        const el = document.createElementNS(ns, nomo);
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

    static aldonu(parenco,...idoj) {
        // parenco povas esti id aŭ Element
        let p = parenco;
        if (typeof parenco === 'string') {
            p = document.getElementById(parenco);
        }
        p.append(...idoj);
    }

    static enŝovu(parenco,...idoj) {
        // parenco povas esti id aŭ Element
        let p = parenco;
        if (typeof parenco === 'string') {
            p = document.getElementById(parenco);
        }
        p.prepend(...idoj);
    }

    static elemento(spec) {
        return document.querySelector(spec);
    }

    static forigu(parenco,idospec) {
        let p = parenco;
        if (typeof parenco === 'string') {
            p = document.getElementById(parenco);
        }
        for (ido of p.querySelectorAll(idospec)) {
            ido.remove();
        }
    }

    static malplenigu(parenco) {
        let p = parenco;
        if (typeof parenco === 'string') {
            p = document.getElementById(parenco);
        }
        p.textContent='';  
    }

    static linio(x1,y1,x2,y2) {
        const linio = document.createElementNS(ns,"line");
        linio.setAttribute("x1",x1);
        linio.setAttribute("y1",y1);
        linio.setAttribute("x2",x2);
        linio.setAttribute("y2",y2);
        return linio;
    }

    static rektangulo(x,y,width,height) {
        const rektangulo = document.createElementNS(ns,"rect");
        rektangulo.setAttribute("x",x);
        rektangulo.setAttribute("y",y);
        rektangulo.setAttribute("width",width);
        rektangulo.setAttribute("height",height);
        return rektangulo;
    }


    static cirklo(cx,cy,r) {
        const cirklo = document.createElementNS(ns,"circle");
        cirklo.setAttribute("cx",cx);
        cirklo.setAttribute("cy",cy);
        cirklo.setAttribute("r",r);
        return cirklo;
    }

    static poligono(punktoj,transformo=null) {
        const poligono = document.createElementNS(ns,"polygon");
        poligono.setAttribute("points",punktoj);
        if (transformo) poligono.setAttribute("transform",transformo);
        return poligono;
    }

    static pado(difino,transformo=null) {
        const pado = document.createElementNS(ns,"path");
        pado.setAttribute("d",difino);
        if (transformo) pado.setAttribute("transform",transformo);
        return pado;
    }

    static grupo(id,cls) {
        const g = document.createElementNS(ns,"g");
        if (id) g.id=id;
        if (cls) g.classList.add(cls);
        return g;
    }

    static defs() {
        return document.createElementNS(ns,"defs");
    }

    static pattern(id,x,y,width,height) {
        const pattern = document.createElementNS(ns,"pattern");
        pattern.id = id;
        pattern.setAttribute("x",x);
        pattern.setAttribute("y",y);
        pattern.setAttribute("width",width);
        pattern.setAttribute("height",height);
        return pattern
    }

    static animacio(id,atr,de,al,dauro) {
        const patteanimaciorn = document.createElementNS(ns,"animate");
        animacio.id = id;
        animacio.setAttribute("attributeType","XML");
        animacio.setAttribute("attributeName",atr);
        animacio.setAttribute("from",de);
        animacio.setAttribute("to",al);
        animacio.setAttribute("dur",dauro);
        return animacio;
    }

    static movo(id,pado,ripetoj,dauro) {
        const animacio = document.createElementNS(ns,"animateMotion");
        animacio.id = id;
        animacio.setAttribute("path",pado);
        animacio.setAttribute("repeatCount",ripetoj);
        animacio.setAttribute("dur",dauro+"s");
        return animacio;
    }    

    static image(href,x,y,width,height) {
        const image = document.createElementNS(ns,"image");
        image.setAttributeNS(xlink,"href",href);
        image.setAttribute("x",x);
        image.setAttribute("y",y);
        image.setAttribute("width",width);
        image.setAttribute("height",height);
        return image
    }    

    static teksto(tx,x,y,sy=false) {
        const teksto = document.createElementNS(ns,"text");
        teksto.textContent = tx;
        teksto.setAttribute("x",x||0);
        teksto.setAttribute("y",y||0); 
        // por matematiko: -y ĉar ni devos speguli la koordinasistemon
        if (sy) teksto.setAttribute("transform","scale(+1,-1)");
        return teksto;
    }

    static titolo(elemento,titolo) {
        const ttl = document.createElementNS(ns,"title");
        ttl.textContent = titolo;
        elemento.append(ttl);
    }

    static uzo(href,transform) {
        const u = document.createElementNS(ns,"use");
        u.setAttribute("href",href);
        if (transform) u.setAttribute("transform",transform);
        return u;
    }

};    