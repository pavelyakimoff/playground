// rivets.js
// version: 0.4.8
// author: Michael Richards
// license: MIT
(function(){var e,t,n,r,i,s=function(e,t){return function(){return e.apply(t,arguments)}},o=[].slice,u=[].indexOf||function(e){for(var t=0,n=this.length;t<n;t++)if(t in this&&this[t]===e)return t;return-1};e={},String.prototype.trim||(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),e.Binding=function(){function t(t,n,r,i,o){var u,a,f,l;this.el=t,this.type=n,this.model=r,this.keypath=i,this.options=o!=null?o:{},this.unbind=s(this.unbind,this),this.bind=s(this.bind,this),this.publish=s(this.publish,this),this.sync=s(this.sync,this),this.set=s(this.set,this),this.formattedValue=s(this.formattedValue,this);if(!(this.binder=e.binders[n])){l=e.binders;for(u in l)f=l[u],u!=="*"&&u.indexOf("*")!==-1&&(a=new RegExp("^"+u.replace("*",".+")+"$"),a.test(n)&&(this.binder=f,this.args=(new RegExp("^"+u.replace("*","(.+)")+"$")).exec(n),this.args.shift()))}this.binder||(this.binder=e.binders["*"]),this.binder instanceof Function&&(this.binder={routine:this.binder}),this.formatters=this.options.formatters||[]}return t.prototype.formattedValue=function(t){var n,r,i,s,u,a;a=this.formatters;for(s=0,u=a.length;s<u;s++)r=a[s],n=r.split(/\s+/),i=n.shift(),r=this.model[i]instanceof Function?this.model[i]:e.formatters[i],(r!=null?r.read:void 0)instanceof Function?t=r.read.apply(r,[t].concat(o.call(n))):r instanceof Function&&(t=r.apply(null,[t].concat(o.call(n))));return t},t.prototype.set=function(e){var t;return e=e instanceof Function&&!this.binder["function"]?this.formattedValue(e.call(this.model)):this.formattedValue(e),(t=this.binder.routine)!=null?t.call(this,this.el,e):void 0},t.prototype.sync=function(){return this.set(this.options.bypass?this.model[this.keypath]:e.config.adapter.read(this.model,this.keypath))},t.prototype.publish=function(){var t,n,i,s,u,a,f,l,c;s=r(this.el),f=this.formatters.slice(0).reverse();for(u=0,a=f.length;u<a;u++){n=f[u],t=n.split(/\s+/),i=t.shift();if((l=e.formatters[i])!=null?l.publish:void 0)s=(c=e.formatters[i]).publish.apply(c,[s].concat(o.call(t)))}return e.config.adapter.publish(this.model,this.keypath,s)},t.prototype.bind=function(){var t,n,r,i,s,o,u,a,f;(o=this.binder.bind)!=null&&o.call(this,this.el),this.options.bypass?this.sync():(e.config.adapter.subscribe(this.model,this.keypath,this.sync),e.config.preloadData&&this.sync());if((u=this.options.dependencies)!=null?u.length:void 0){a=this.options.dependencies,f=[];for(i=0,s=a.length;i<s;i++)t=a[i],/^\./.test(t)?(r=this.model,n=t.substr(1)):(t=t.split("."),r=this.view.models[t.shift()],n=t.join(".")),f.push(e.config.adapter.subscribe(r,n,this.sync));return f}},t.prototype.unbind=function(){var t,n,r,i,s,o,u,a,f;(o=this.binder.unbind)!=null&&o.call(this,this.el),this.options.bypass||e.config.adapter.unsubscribe(this.model,this.keypath,this.sync);if((u=this.options.dependencies)!=null?u.length:void 0){a=this.options.dependencies,f=[];for(i=0,s=a.length;i<s;i++)t=a[i],/^\./.test(t)?(r=this.model,n=t.substr(1)):(t=t.split("."),r=this.view.models[t.shift()],n=t.join(".")),f.push(e.config.adapter.unsubscribe(r,n,this.sync));return f}},t}(),e.View=function(){function t(e,t){this.els=e,this.models=t,this.publish=s(this.publish,this),this.sync=s(this.sync,this),this.unbind=s(this.unbind,this),this.bind=s(this.bind,this),this.select=s(this.select,this),this.build=s(this.build,this),this.bindingRegExp=s(this.bindingRegExp,this),this.els.jquery||this.els instanceof Array||(this.els=[this.els]),this.build()}return t.prototype.bindingRegExp=function(){var t;return t=e.config.prefix,t?new RegExp("^data-"+t+"-"):/^data-/},t.prototype.build=function(){var t,n,r,i,s,o,a,f,l,c,h,p=this;this.bindings=[],s=[],t=this.bindingRegExp(),i=function(n){var r,i,o,a,f,l,c,h,d,v,m,g,y,b,w,E,S,x,T,N,C,k,L,A,O,M,_,D,P;if(u.call(s,n)<0){M=n.attributes;for(N=0,L=M.length;N<L;N++){r=M[N];if(t.test(r.name)){x=r.name.replace(t,"");if(!(o=e.binders[x])){_=e.binders;for(h in _)T=_[h],h!=="*"&&h.indexOf("*")!==-1&&(E=new RegExp("^"+h.replace("*",".+")+"$"),E.test(x)&&(o=T))}o||(o=e.binders["*"]);if(o.block){D=n.getElementsByTagName("*");for(C=0,A=D.length;C<A;C++)m=D[C],s.push(m);i=[r]}}}P=i||n.attributes;for(k=0,O=P.length;k<O;k++){r=P[k];if(t.test(r.name)){g={},x=r.name.replace(t,""),w=function(){var e,t,n,i;n=r.value.split("|"),i=[];for(e=0,t=n.length;e<t;e++)b=n[e],i.push(b.trim());return i}(),f=function(){var e,t,n,r;n=w.shift().split("<"),r=[];for(e=0,t=n.length;e<t;e++)l=n[e],r.push(l.trim());return r}(),y=f.shift(),S=y.split(/\.|:/),g.formatters=w,g.bypass=y.indexOf(":")!==-1,S[0]?v=p.models[S.shift()]:(v=p.models,S.shift()),d=S.join(".");if(v){if(c=f.shift())g.dependencies=c.split(/\s+/);a=new e.Binding(n,x,v,d,g),a.view=p,p.bindings.push(a)}}}i&&(i=null)}},c=this.els;for(o=0,f=c.length;o<f;o++){n=c[o],i(n),h=n.getElementsByTagName("*");for(a=0,l=h.length;a<l;a++)r=h[a],r.attributes!=null&&i(r)}},t.prototype.select=function(e){var t,n,r,i,s;i=this.bindings,s=[];for(n=0,r=i.length;n<r;n++)t=i[n],e(t)&&s.push(t);return s},t.prototype.bind=function(){var e,t,n,r,i;r=this.bindings,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.bind());return i},t.prototype.unbind=function(){var e,t,n,r,i;r=this.bindings,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.unbind());return i},t.prototype.sync=function(){var e,t,n,r,i;r=this.bindings,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.sync());return i},t.prototype.publish=function(){var e,t,n,r,i;r=this.select(function(e){return e.binder.publishes}),i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.publish());return i},t}(),t=function(e,t,n,r){var i;return i=function(e){return n.call(r,e)},window.jQuery!=null?(e=jQuery(e),e.on!=null?e.on(t,i):e.bind(t,i)):window.addEventListener!=null?e.addEventListener(t,i,!1):(t="on"+t,e.attachEvent(t,i)),i},i=function(e,t,n){return window.jQuery!=null?(e=jQuery(e),e.off!=null?e.off(t,n):e.unbind(t,n)):window.removeEventListener?e.removeEventListener(t,n,!1):(t="on"+t,e.detachEvent(t,n))},r=function(e){var t,n,r,i;if(window.jQuery!=null){e=jQuery(e);switch(e[0].type){case"checkbox":return e.is(":checked");default:return e.val()}}else switch(e.type){case"checkbox":return e.checked;case"select-multiple":i=[];for(n=0,r=e.length;n<r;n++)t=e[n],t.selected&&i.push(t.value);return i;default:return e.value}},e.binders={enabled:function(e,t){return e.disabled=!t},disabled:function(e,t){return e.disabled=!!t},checked:{publishes:!0,bind:function(e){return this.currentListener=t(e,"change",this.publish)},unbind:function(e){return i(e,"change",this.currentListener)},routine:function(e,t){var n;return e.type==="radio"?e.checked=((n=e.value)!=null?n.toString():void 0)===(t!=null?t.toString():void 0):e.checked=!!t}},unchecked:{publishes:!0,bind:function(e){return this.currentListener=t(e,"change",this.publish)},unbind:function(e){return i(e,"change",this.currentListener)},routine:function(e,t){var n;return e.type==="radio"?e.checked=((n=e.value)!=null?n.toString():void 0)!==(t!=null?t.toString():void 0):e.checked=!t}},show:function(e,t){return e.style.display=t?"":"none"},hide:function(e,t){return e.style.display=t?"none":""},html:function(e,t){return e.innerHTML=t!=null?t:""},value:{publishes:!0,bind:function(e){return this.currentListener=t(e,"change",this.publish)},unbind:function(e){return i(e,"change",this.currentListener)},routine:function(e,t){var n,r,i,s,o,a,f;if(window.jQuery!=null){e=jQuery(e);if((t!=null?t.toString():void 0)!==((s=e.val())!=null?s.toString():void 0))return e.val(t!=null?t:"")}else if(e.type==="select-multiple"){if(t!=null){f=[];for(r=0,i=e.length;r<i;r++)n=e[r],f.push(n.selected=(o=n.value,u.call(t,o)>=0));return f}}else if((t!=null?t.toString():void 0)!==((a=e.value)!=null?a.toString():void 0))return e.value=t!=null?t:""}},text:function(e,t){return e.innerText!=null?e.innerText=t!=null?t:"":e.textContent=t!=null?t:""},"on-*":{"function":!0,routine:function(e,n){return this.currentListener&&i(e,this.args[0],this.currentListener),this.currentListener=t(e,this.args[0],n,this.model)}},"each-*":{block:!0,bind:function(e,t){return e.removeAttribute(["data",rivets.config.prefix,this.type].join("-").replace("--","-"))},routine:function(e,t){var n,r,i,s,o,u,a,f,l,c,h,p,d,v,m,g,y,b,w;if(this.iterated!=null){m=this.iterated;for(l=0,p=m.length;l<p;l++){f=m[l],f.unbind(),g=f.els;for(c=0,d=g.length;c<d;c++)r=g[c],r.parentNode.removeChild(r)}}else this.marker=document.createComment(" rivets: "+this.type+" "),e.parentNode.insertBefore(this.marker,e),e.parentNode.removeChild(e);this.iterated=[];if(t){w=[];for(h=0,v=t.length;h<v;h++){i=t[h],n={},y=this.view.models;for(u in y)o=y[u],n[u]=o;n[this.args[0]]=i,s=e.cloneNode(!0),this.iterated.length>0?a=this.iterated[this.iterated.length-1].els[0]:a=this.marker,this.marker.parentNode.insertBefore(s,(b=a.nextSibling)!=null?b:null),w.push(this.iterated.push(rivets.bind(s,n)))}return w}}},"class-*":function(e,t){var n;n=" "+e.className+" ";if(!t==(n.indexOf(" "+this.args[0]+" ")!==-1))return e.className=t?""+e.className+" "+this.args[0]:n.replace(" "+this.args[0]+" "," ").trim()},"*":function(e,t){return t?e.setAttribute(this.type,t):e.removeAttribute(this.type)}},e.config={preloadData:!0},e.formatters={},n=function(t){return t.binders=e.binders,t.formatters=e.formatters,t.config=e.config,t.configure=function(t){var n,r;t==null&&(t={});for(n in t)r=t[n],e.config[n]=r},t.bind=function(t,n){var r;return n==null&&(n={}),r=new e.View(t,n),r.bind(),r}},typeof exports=="object"?n(exports):typeof define=="function"&&define.amd?define(["exports"],function(e){return n(this.rivets=e),e}):n(this.rivets={})}).call(this);
