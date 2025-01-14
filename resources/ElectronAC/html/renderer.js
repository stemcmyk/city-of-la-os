(()=>{var il=Object.defineProperty;var Ta=(e,t)=>{for(var r in t)il(e,r,{get:t[r],enumerable:!0})};Number.EPSILON===void 0&&(Number.EPSILON=Math.pow(2,-52));Number.isInteger===void 0&&(Number.isInteger=function(e){return typeof e=="number"&&isFinite(e)&&Math.floor(e)===e});Math.sign===void 0&&(Math.sign=function(e){return e<0?-1:e>0?1:+e});"name"in Function.prototype||Object.defineProperty(Function.prototype,"name",{get:function(){return this.toString().match(/^\s*function\s*([^\(\s]*)/)[1]}});Object.assign===void 0&&function(){Object.assign=function(e){"use strict";if(e==null)throw new TypeError("Cannot convert undefined or null to object");for(var t=Object(e),r=1;r<arguments.length;r++){var i=arguments[r];if(i!=null)for(var n in i)Object.prototype.hasOwnProperty.call(i,n)&&(t[n]=i[n])}return t}}();function bt(){}Object.assign(bt.prototype,{addEventListener:function(e,t){this._listeners===void 0&&(this._listeners={});var r=this._listeners;r[e]===void 0&&(r[e]=[]),r[e].indexOf(t)===-1&&r[e].push(t)},hasEventListener:function(e,t){if(this._listeners===void 0)return!1;var r=this._listeners;return r[e]!==void 0&&r[e].indexOf(t)!==-1},removeEventListener:function(e,t){if(this._listeners!==void 0){var r=this._listeners,i=r[e];if(i!==void 0){var n=i.indexOf(t);n!==-1&&i.splice(n,1)}}},dispatchEvent:function(e){if(this._listeners!==void 0){var t=this._listeners,r=t[e.type];if(r!==void 0){e.target=this;for(var i=r.slice(0),n=0,o=i.length;n<o;n++)i[n].call(this,e)}}}});var ls="101dev";var ps=0,Sa=1,ds=2;var Ro=1,ms=2,gr=0,Ze=1,or=2,Co=1;var Aa=0,Po=1,zt=2,Rr=0,yr=1,xn=2,_n=3,bn=4,Bo=5,xr=100,vs=101,gs=102,Fo=103,Do=104,ys=200,xs=201,_s=202,bs=203,Io=204,Oo=205,ws=206,Ms=207,Es=208,Ts=209,Ss=210,As=0,Ls=1,Rs=2,wn=3,Cs=4,Ps=5,Bs=6,Fs=7,Cr=0,Ds=1,Is=2,Uo=0,No=1,Os=2,Us=3,Ns=4,Gs=5,Mn=300,Li=301,En=302,Go=303,Tn=304,zo=305,Ri=306,Ci=307,Ht=1e3,vt=1001,ar=1002,ke=1003,Pi=1004,Bi=1005,qe=1006,Ho=1007,Pr=1008,Br=1009,zs=1010,Hs=1011,ei=1012,Vs=1013,Vo=1014,Fr=1015,Fi=1016,ks=1017,Ws=1018,Xs=1019,ti=1020,js=1021,Ot=1022,wt=1023,qs=1024,Ys=1025;var _r=1026,Dr=1027,Zs=1028,La=33776,Ra=33777,Ca=33778,Pa=33779,Ba=35840,Fa=35841,Da=35842,Ia=35843,Js=36196,Qs=37808,Ks=37809,$s=37810,ef=37811,tf=37812,rf=37813,nf=37814,of=37815,af=37816,sf=37817,ff=37818,uf=37819,cf=37820,hf=37821,lf=2200,pf=2201,df=2202,ri=2300,Di=2301,ko=2302,Ir=2400,Or=2401,Ii=2402,Wo=0,mf=1,vf=2,ii=3e3,gf=3001,Xo=3007,yf=3002;var xf=3004,_f=3005,bf=3006,wf=3200,Mf=3201,Ur=0,Ef=1;var ie={DEG2RAD:Math.PI/180,RAD2DEG:180/Math.PI,generateUUID:function(){for(var e=[],t=0;t<256;t++)e[t]=(t<16?"0":"")+t.toString(16);return function(){var i=Math.random()*4294967295|0,n=Math.random()*4294967295|0,o=Math.random()*4294967295|0,a=Math.random()*4294967295|0,s=e[i&255]+e[i>>8&255]+e[i>>16&255]+e[i>>24&255]+"-"+e[n&255]+e[n>>8&255]+"-"+e[n>>16&15|64]+e[n>>24&255]+"-"+e[o&63|128]+e[o>>8&255]+"-"+e[o>>16&255]+e[o>>24&255]+e[a&255]+e[a>>8&255]+e[a>>16&255]+e[a>>24&255];return s.toUpperCase()}}(),clamp:function(e,t,r){return Math.max(t,Math.min(r,e))},euclideanModulo:function(e,t){return(e%t+t)%t},mapLinear:function(e,t,r,i,n){return i+(e-t)*(n-i)/(r-t)},lerp:function(e,t,r){return(1-r)*e+r*t},smoothstep:function(e,t,r){return e<=t?0:e>=r?1:(e=(e-t)/(r-t),e*e*(3-2*e))},smootherstep:function(e,t,r){return e<=t?0:e>=r?1:(e=(e-t)/(r-t),e*e*e*(e*(e*6-15)+10))},randInt:function(e,t){return e+Math.floor(Math.random()*(t-e+1))},randFloat:function(e,t){return e+Math.random()*(t-e)},randFloatSpread:function(e){return e*(.5-Math.random())},degToRad:function(e){return e*ie.DEG2RAD},radToDeg:function(e){return e*ie.RAD2DEG},isPowerOfTwo:function(e){return(e&e-1)===0&&e!==0},ceilPowerOfTwo:function(e){return Math.pow(2,Math.ceil(Math.log(e)/Math.LN2))},floorPowerOfTwo:function(e){return Math.pow(2,Math.floor(Math.log(e)/Math.LN2))}};function O(e,t){this.x=e||0,this.y=t||0}Object.defineProperties(O.prototype,{width:{get:function(){return this.x},set:function(e){this.x=e}},height:{get:function(){return this.y},set:function(e){this.y=e}}});Object.assign(O.prototype,{isVector2:!0,set:function(e,t){return this.x=e,this.y=t,this},setScalar:function(e){return this.x=e,this.y=e,this},setX:function(e){return this.x=e,this},setY:function(e){return this.y=e,this},setComponent:function(e,t){switch(e){case 0:this.x=t;break;case 1:this.y=t;break;default:throw new Error("index is out of range: "+e)}return this},getComponent:function(e){switch(e){case 0:return this.x;case 1:return this.y;default:throw new Error("index is out of range: "+e)}},clone:function(){return new this.constructor(this.x,this.y)},copy:function(e){return this.x=e.x,this.y=e.y,this},add:function(e,t){return t!==void 0?(console.warn("THREE.Vector2: .add() now only accepts one argument. Use .addVectors( a, b ) instead."),this.addVectors(e,t)):(this.x+=e.x,this.y+=e.y,this)},addScalar:function(e){return this.x+=e,this.y+=e,this},addVectors:function(e,t){return this.x=e.x+t.x,this.y=e.y+t.y,this},addScaledVector:function(e,t){return this.x+=e.x*t,this.y+=e.y*t,this},sub:function(e,t){return t!==void 0?(console.warn("THREE.Vector2: .sub() now only accepts one argument. Use .subVectors( a, b ) instead."),this.subVectors(e,t)):(this.x-=e.x,this.y-=e.y,this)},subScalar:function(e){return this.x-=e,this.y-=e,this},subVectors:function(e,t){return this.x=e.x-t.x,this.y=e.y-t.y,this},multiply:function(e){return this.x*=e.x,this.y*=e.y,this},multiplyScalar:function(e){return this.x*=e,this.y*=e,this},divide:function(e){return this.x/=e.x,this.y/=e.y,this},divideScalar:function(e){return this.multiplyScalar(1/e)},applyMatrix3:function(e){var t=this.x,r=this.y,i=e.elements;return this.x=i[0]*t+i[3]*r+i[6],this.y=i[1]*t+i[4]*r+i[7],this},min:function(e){return this.x=Math.min(this.x,e.x),this.y=Math.min(this.y,e.y),this},max:function(e){return this.x=Math.max(this.x,e.x),this.y=Math.max(this.y,e.y),this},clamp:function(e,t){return this.x=Math.max(e.x,Math.min(t.x,this.x)),this.y=Math.max(e.y,Math.min(t.y,this.y)),this},clampScalar:function(){var e=new O,t=new O;return function(i,n){return e.set(i,i),t.set(n,n),this.clamp(e,t)}}(),clampLength:function(e,t){var r=this.length();return this.divideScalar(r||1).multiplyScalar(Math.max(e,Math.min(t,r)))},floor:function(){return this.x=Math.floor(this.x),this.y=Math.floor(this.y),this},ceil:function(){return this.x=Math.ceil(this.x),this.y=Math.ceil(this.y),this},round:function(){return this.x=Math.round(this.x),this.y=Math.round(this.y),this},roundToZero:function(){return this.x=this.x<0?Math.ceil(this.x):Math.floor(this.x),this.y=this.y<0?Math.ceil(this.y):Math.floor(this.y),this},negate:function(){return this.x=-this.x,this.y=-this.y,this},dot:function(e){return this.x*e.x+this.y*e.y},cross:function(e){return this.x*e.y-this.y*e.x},lengthSq:function(){return this.x*this.x+this.y*this.y},length:function(){return Math.sqrt(this.x*this.x+this.y*this.y)},manhattanLength:function(){return Math.abs(this.x)+Math.abs(this.y)},normalize:function(){return this.divideScalar(this.length()||1)},angle:function(){var e=Math.atan2(this.y,this.x);return e<0&&(e+=2*Math.PI),e},distanceTo:function(e){return Math.sqrt(this.distanceToSquared(e))},distanceToSquared:function(e){var t=this.x-e.x,r=this.y-e.y;return t*t+r*r},manhattanDistanceTo:function(e){return Math.abs(this.x-e.x)+Math.abs(this.y-e.y)},setLength:function(e){return this.normalize().multiplyScalar(e)},lerp:function(e,t){return this.x+=(e.x-this.x)*t,this.y+=(e.y-this.y)*t,this},lerpVectors:function(e,t,r){return this.subVectors(t,e).multiplyScalar(r).add(e)},equals:function(e){return e.x===this.x&&e.y===this.y},fromArray:function(e,t){return t===void 0&&(t=0),this.x=e[t],this.y=e[t+1],this},toArray:function(e,t){return e===void 0&&(e=[]),t===void 0&&(t=0),e[t]=this.x,e[t+1]=this.y,e},fromBufferAttribute:function(e,t,r){return r!==void 0&&console.warn("THREE.Vector2: offset has been removed from .fromBufferAttribute()."),this.x=e.getX(t),this.y=e.getY(t),this},rotateAround:function(e,t){var r=Math.cos(t),i=Math.sin(t),n=this.x-e.x,o=this.y-e.y;return this.x=n*r-o*i+e.x,this.y=n*i+o*r+e.y,this}});function ee(){this.elements=[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1],arguments.length>0&&console.error("THREE.Matrix4: the constructor no longer reads arguments. use .set() instead.")}Object.assign(ee.prototype,{isMatrix4:!0,set:function(e,t,r,i,n,o,a,s,f,u,c,h,l,p,d,m){var v=this.elements;return v[0]=e,v[4]=t,v[8]=r,v[12]=i,v[1]=n,v[5]=o,v[9]=a,v[13]=s,v[2]=f,v[6]=u,v[10]=c,v[14]=h,v[3]=l,v[7]=p,v[11]=d,v[15]=m,this},identity:function(){return this.set(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1),this},clone:function(){return new ee().fromArray(this.elements)},copy:function(e){var t=this.elements,r=e.elements;return t[0]=r[0],t[1]=r[1],t[2]=r[2],t[3]=r[3],t[4]=r[4],t[5]=r[5],t[6]=r[6],t[7]=r[7],t[8]=r[8],t[9]=r[9],t[10]=r[10],t[11]=r[11],t[12]=r[12],t[13]=r[13],t[14]=r[14],t[15]=r[15],this},copyPosition:function(e){var t=this.elements,r=e.elements;return t[12]=r[12],t[13]=r[13],t[14]=r[14],this},extractBasis:function(e,t,r){return e.setFromMatrixColumn(this,0),t.setFromMatrixColumn(this,1),r.setFromMatrixColumn(this,2),this},makeBasis:function(e,t,r){return this.set(e.x,t.x,r.x,0,e.y,t.y,r.y,0,e.z,t.z,r.z,0,0,0,0,1),this},extractRotation:function(){var e=new x;return function(r){var i=this.elements,n=r.elements,o=1/e.setFromMatrixColumn(r,0).length(),a=1/e.setFromMatrixColumn(r,1).length(),s=1/e.setFromMatrixColumn(r,2).length();return i[0]=n[0]*o,i[1]=n[1]*o,i[2]=n[2]*o,i[3]=0,i[4]=n[4]*a,i[5]=n[5]*a,i[6]=n[6]*a,i[7]=0,i[8]=n[8]*s,i[9]=n[9]*s,i[10]=n[10]*s,i[11]=0,i[12]=0,i[13]=0,i[14]=0,i[15]=1,this}}(),makeRotationFromEuler:function(e){e&&e.isEuler||console.error("THREE.Matrix4: .makeRotationFromEuler() now expects a Euler rotation rather than a Vector3 and order.");var t=this.elements,r=e.x,i=e.y,n=e.z,o=Math.cos(r),a=Math.sin(r),s=Math.cos(i),f=Math.sin(i),u=Math.cos(n),c=Math.sin(n);if(e.order==="XYZ"){var h=o*u,l=o*c,p=a*u,d=a*c;t[0]=s*u,t[4]=-s*c,t[8]=f,t[1]=l+p*f,t[5]=h-d*f,t[9]=-a*s,t[2]=d-h*f,t[6]=p+l*f,t[10]=o*s}else if(e.order==="YXZ"){var m=s*u,v=s*c,g=f*u,b=f*c;t[0]=m+b*a,t[4]=g*a-v,t[8]=o*f,t[1]=o*c,t[5]=o*u,t[9]=-a,t[2]=v*a-g,t[6]=b+m*a,t[10]=o*s}else if(e.order==="ZXY"){var m=s*u,v=s*c,g=f*u,b=f*c;t[0]=m-b*a,t[4]=-o*c,t[8]=g+v*a,t[1]=v+g*a,t[5]=o*u,t[9]=b-m*a,t[2]=-o*f,t[6]=a,t[10]=o*s}else if(e.order==="ZYX"){var h=o*u,l=o*c,p=a*u,d=a*c;t[0]=s*u,t[4]=p*f-l,t[8]=h*f+d,t[1]=s*c,t[5]=d*f+h,t[9]=l*f-p,t[2]=-f,t[6]=a*s,t[10]=o*s}else if(e.order==="YZX"){var w=o*s,y=o*f,S=a*s,R=a*f;t[0]=s*u,t[4]=R-w*c,t[8]=S*c+y,t[1]=c,t[5]=o*u,t[9]=-a*u,t[2]=-f*u,t[6]=y*c+S,t[10]=w-R*c}else if(e.order==="XZY"){var w=o*s,y=o*f,S=a*s,R=a*f;t[0]=s*u,t[4]=-c,t[8]=f*u,t[1]=w*c+R,t[5]=o*u,t[9]=y*c-S,t[2]=S*c-y,t[6]=a*u,t[10]=R*c+w}return t[3]=0,t[7]=0,t[11]=0,t[12]=0,t[13]=0,t[14]=0,t[15]=1,this},makeRotationFromQuaternion:function(){var e=new x(0,0,0),t=new x(1,1,1);return function(i){return this.compose(e,i,t)}}(),lookAt:function(){var e=new x,t=new x,r=new x;return function(n,o,a){var s=this.elements;return r.subVectors(n,o),r.lengthSq()===0&&(r.z=1),r.normalize(),e.crossVectors(a,r),e.lengthSq()===0&&(Math.abs(a.z)===1?r.x+=1e-4:r.z+=1e-4,r.normalize(),e.crossVectors(a,r)),e.normalize(),t.crossVectors(r,e),s[0]=e.x,s[4]=t.x,s[8]=r.x,s[1]=e.y,s[5]=t.y,s[9]=r.y,s[2]=e.z,s[6]=t.z,s[10]=r.z,this}}(),multiply:function(e,t){return t!==void 0?(console.warn("THREE.Matrix4: .multiply() now only accepts one argument. Use .multiplyMatrices( a, b ) instead."),this.multiplyMatrices(e,t)):this.multiplyMatrices(this,e)},premultiply:function(e){return this.multiplyMatrices(e,this)},multiplyMatrices:function(e,t){var r=e.elements,i=t.elements,n=this.elements,o=r[0],a=r[4],s=r[8],f=r[12],u=r[1],c=r[5],h=r[9],l=r[13],p=r[2],d=r[6],m=r[10],v=r[14],g=r[3],b=r[7],w=r[11],y=r[15],S=i[0],R=i[4],B=i[8],P=i[12],A=i[1],D=i[5],I=i[9],H=i[13],X=i[2],j=i[6],V=i[10],$=i[14],K=i[3],Q=i[7],E=i[11],T=i[15];return n[0]=o*S+a*A+s*X+f*K,n[4]=o*R+a*D+s*j+f*Q,n[8]=o*B+a*I+s*V+f*E,n[12]=o*P+a*H+s*$+f*T,n[1]=u*S+c*A+h*X+l*K,n[5]=u*R+c*D+h*j+l*Q,n[9]=u*B+c*I+h*V+l*E,n[13]=u*P+c*H+h*$+l*T,n[2]=p*S+d*A+m*X+v*K,n[6]=p*R+d*D+m*j+v*Q,n[10]=p*B+d*I+m*V+v*E,n[14]=p*P+d*H+m*$+v*T,n[3]=g*S+b*A+w*X+y*K,n[7]=g*R+b*D+w*j+y*Q,n[11]=g*B+b*I+w*V+y*E,n[15]=g*P+b*H+w*$+y*T,this},multiplyScalar:function(e){var t=this.elements;return t[0]*=e,t[4]*=e,t[8]*=e,t[12]*=e,t[1]*=e,t[5]*=e,t[9]*=e,t[13]*=e,t[2]*=e,t[6]*=e,t[10]*=e,t[14]*=e,t[3]*=e,t[7]*=e,t[11]*=e,t[15]*=e,this},applyToBufferAttribute:function(){var e=new x;return function(r){for(var i=0,n=r.count;i<n;i++)e.x=r.getX(i),e.y=r.getY(i),e.z=r.getZ(i),e.applyMatrix4(this),r.setXYZ(i,e.x,e.y,e.z);return r}}(),determinant:function(){var e=this.elements,t=e[0],r=e[4],i=e[8],n=e[12],o=e[1],a=e[5],s=e[9],f=e[13],u=e[2],c=e[6],h=e[10],l=e[14],p=e[3],d=e[7],m=e[11],v=e[15];return p*(+n*s*c-i*f*c-n*a*h+r*f*h+i*a*l-r*s*l)+d*(+t*s*l-t*f*h+n*o*h-i*o*l+i*f*u-n*s*u)+m*(+t*f*c-t*a*l-n*o*c+r*o*l+n*a*u-r*f*u)+v*(-i*a*u-t*s*c+t*a*h+i*o*c-r*o*h+r*s*u)},transpose:function(){var e=this.elements,t;return t=e[1],e[1]=e[4],e[4]=t,t=e[2],e[2]=e[8],e[8]=t,t=e[6],e[6]=e[9],e[9]=t,t=e[3],e[3]=e[12],e[12]=t,t=e[7],e[7]=e[13],e[13]=t,t=e[11],e[11]=e[14],e[14]=t,this},setPosition:function(e){var t=this.elements;return t[12]=e.x,t[13]=e.y,t[14]=e.z,this},getInverse:function(e,t){var r=this.elements,i=e.elements,n=i[0],o=i[1],a=i[2],s=i[3],f=i[4],u=i[5],c=i[6],h=i[7],l=i[8],p=i[9],d=i[10],m=i[11],v=i[12],g=i[13],b=i[14],w=i[15],y=p*b*h-g*d*h+g*c*m-u*b*m-p*c*w+u*d*w,S=v*d*h-l*b*h-v*c*m+f*b*m+l*c*w-f*d*w,R=l*g*h-v*p*h+v*u*m-f*g*m-l*u*w+f*p*w,B=v*p*c-l*g*c-v*u*d+f*g*d+l*u*b-f*p*b,P=n*y+o*S+a*R+s*B;if(P===0){var A="THREE.Matrix4: .getInverse() can't invert matrix, determinant is 0";if(t===!0)throw new Error(A);return console.warn(A),this.identity()}var D=1/P;return r[0]=y*D,r[1]=(g*d*s-p*b*s-g*a*m+o*b*m+p*a*w-o*d*w)*D,r[2]=(u*b*s-g*c*s+g*a*h-o*b*h-u*a*w+o*c*w)*D,r[3]=(p*c*s-u*d*s-p*a*h+o*d*h+u*a*m-o*c*m)*D,r[4]=S*D,r[5]=(l*b*s-v*d*s+v*a*m-n*b*m-l*a*w+n*d*w)*D,r[6]=(v*c*s-f*b*s-v*a*h+n*b*h+f*a*w-n*c*w)*D,r[7]=(f*d*s-l*c*s+l*a*h-n*d*h-f*a*m+n*c*m)*D,r[8]=R*D,r[9]=(v*p*s-l*g*s-v*o*m+n*g*m+l*o*w-n*p*w)*D,r[10]=(f*g*s-v*u*s+v*o*h-n*g*h-f*o*w+n*u*w)*D,r[11]=(l*u*s-f*p*s-l*o*h+n*p*h+f*o*m-n*u*m)*D,r[12]=B*D,r[13]=(l*g*a-v*p*a+v*o*d-n*g*d-l*o*b+n*p*b)*D,r[14]=(v*u*a-f*g*a-v*o*c+n*g*c+f*o*b-n*u*b)*D,r[15]=(f*p*a-l*u*a+l*o*c-n*p*c-f*o*d+n*u*d)*D,this},scale:function(e){var t=this.elements,r=e.x,i=e.y,n=e.z;return t[0]*=r,t[4]*=i,t[8]*=n,t[1]*=r,t[5]*=i,t[9]*=n,t[2]*=r,t[6]*=i,t[10]*=n,t[3]*=r,t[7]*=i,t[11]*=n,this},getMaxScaleOnAxis:function(){var e=this.elements,t=e[0]*e[0]+e[1]*e[1]+e[2]*e[2],r=e[4]*e[4]+e[5]*e[5]+e[6]*e[6],i=e[8]*e[8]+e[9]*e[9]+e[10]*e[10];return Math.sqrt(Math.max(t,r,i))},makeTranslation:function(e,t,r){return this.set(1,0,0,e,0,1,0,t,0,0,1,r,0,0,0,1),this},makeRotationX:function(e){var t=Math.cos(e),r=Math.sin(e);return this.set(1,0,0,0,0,t,-r,0,0,r,t,0,0,0,0,1),this},makeRotationY:function(e){var t=Math.cos(e),r=Math.sin(e);return this.set(t,0,r,0,0,1,0,0,-r,0,t,0,0,0,0,1),this},makeRotationZ:function(e){var t=Math.cos(e),r=Math.sin(e);return this.set(t,-r,0,0,r,t,0,0,0,0,1,0,0,0,0,1),this},makeRotationAxis:function(e,t){var r=Math.cos(t),i=Math.sin(t),n=1-r,o=e.x,a=e.y,s=e.z,f=n*o,u=n*a;return this.set(f*o+r,f*a-i*s,f*s+i*a,0,f*a+i*s,u*a+r,u*s-i*o,0,f*s-i*a,u*s+i*o,n*s*s+r,0,0,0,0,1),this},makeScale:function(e,t,r){return this.set(e,0,0,0,0,t,0,0,0,0,r,0,0,0,0,1),this},makeShear:function(e,t,r){return this.set(1,t,r,0,e,1,r,0,e,t,1,0,0,0,0,1),this},compose:function(e,t,r){var i=this.elements,n=t._x,o=t._y,a=t._z,s=t._w,f=n+n,u=o+o,c=a+a,h=n*f,l=n*u,p=n*c,d=o*u,m=o*c,v=a*c,g=s*f,b=s*u,w=s*c,y=r.x,S=r.y,R=r.z;return i[0]=(1-(d+v))*y,i[1]=(l+w)*y,i[2]=(p-b)*y,i[3]=0,i[4]=(l-w)*S,i[5]=(1-(h+v))*S,i[6]=(m+g)*S,i[7]=0,i[8]=(p+b)*R,i[9]=(m-g)*R,i[10]=(1-(h+d))*R,i[11]=0,i[12]=e.x,i[13]=e.y,i[14]=e.z,i[15]=1,this},decompose:function(){var e=new x,t=new ee;return function(i,n,o){var a=this.elements,s=e.set(a[0],a[1],a[2]).length(),f=e.set(a[4],a[5],a[6]).length(),u=e.set(a[8],a[9],a[10]).length(),c=this.determinant();c<0&&(s=-s),i.x=a[12],i.y=a[13],i.z=a[14],t.copy(this);var h=1/s,l=1/f,p=1/u;return t.elements[0]*=h,t.elements[1]*=h,t.elements[2]*=h,t.elements[4]*=l,t.elements[5]*=l,t.elements[6]*=l,t.elements[8]*=p,t.elements[9]*=p,t.elements[10]*=p,n.setFromRotationMatrix(t),o.x=s,o.y=f,o.z=u,this}}(),makePerspective:function(e,t,r,i,n,o){o===void 0&&console.warn("THREE.Matrix4: .makePerspective() has been redefined and has a new signature. Please check the docs.");var a=this.elements,s=2*n/(t-e),f=2*n/(r-i),u=(t+e)/(t-e),c=(r+i)/(r-i),h=-(o+n)/(o-n),l=-2*o*n/(o-n);return a[0]=s,a[4]=0,a[8]=u,a[12]=0,a[1]=0,a[5]=f,a[9]=c,a[13]=0,a[2]=0,a[6]=0,a[10]=h,a[14]=l,a[3]=0,a[7]=0,a[11]=-1,a[15]=0,this},makeOrthographic:function(e,t,r,i,n,o){var a=this.elements,s=1/(t-e),f=1/(r-i),u=1/(o-n),c=(t+e)*s,h=(r+i)*f,l=(o+n)*u;return a[0]=2*s,a[4]=0,a[8]=0,a[12]=-c,a[1]=0,a[5]=2*f,a[9]=0,a[13]=-h,a[2]=0,a[6]=0,a[10]=-2*u,a[14]=-l,a[3]=0,a[7]=0,a[11]=0,a[15]=1,this},equals:function(e){for(var t=this.elements,r=e.elements,i=0;i<16;i++)if(t[i]!==r[i])return!1;return!0},fromArray:function(e,t){t===void 0&&(t=0);for(var r=0;r<16;r++)this.elements[r]=e[r+t];return this},toArray:function(e,t){e===void 0&&(e=[]),t===void 0&&(t=0);var r=this.elements;return e[t]=r[0],e[t+1]=r[1],e[t+2]=r[2],e[t+3]=r[3],e[t+4]=r[4],e[t+5]=r[5],e[t+6]=r[6],e[t+7]=r[7],e[t+8]=r[8],e[t+9]=r[9],e[t+10]=r[10],e[t+11]=r[11],e[t+12]=r[12],e[t+13]=r[13],e[t+14]=r[14],e[t+15]=r[15],e}});function Ge(e,t,r,i){this._x=e||0,this._y=t||0,this._z=r||0,this._w=i!==void 0?i:1}Object.assign(Ge,{slerp:function(e,t,r,i){return r.copy(e).slerp(t,i)},slerpFlat:function(e,t,r,i,n,o,a){var s=r[i+0],f=r[i+1],u=r[i+2],c=r[i+3],h=n[o+0],l=n[o+1],p=n[o+2],d=n[o+3];if(c!==d||s!==h||f!==l||u!==p){var m=1-a,v=s*h+f*l+u*p+c*d,g=v>=0?1:-1,b=1-v*v;if(b>Number.EPSILON){var w=Math.sqrt(b),y=Math.atan2(w,v*g);m=Math.sin(m*y)/w,a=Math.sin(a*y)/w}var S=a*g;if(s=s*m+h*S,f=f*m+l*S,u=u*m+p*S,c=c*m+d*S,m===1-a){var R=1/Math.sqrt(s*s+f*f+u*u+c*c);s*=R,f*=R,u*=R,c*=R}}e[t]=s,e[t+1]=f,e[t+2]=u,e[t+3]=c}});Object.defineProperties(Ge.prototype,{x:{get:function(){return this._x},set:function(e){this._x=e,this.onChangeCallback()}},y:{get:function(){return this._y},set:function(e){this._y=e,this.onChangeCallback()}},z:{get:function(){return this._z},set:function(e){this._z=e,this.onChangeCallback()}},w:{get:function(){return this._w},set:function(e){this._w=e,this.onChangeCallback()}}});Object.assign(Ge.prototype,{isQuaternion:!0,set:function(e,t,r,i){return this._x=e,this._y=t,this._z=r,this._w=i,this.onChangeCallback(),this},clone:function(){return new this.constructor(this._x,this._y,this._z,this._w)},copy:function(e){return this._x=e.x,this._y=e.y,this._z=e.z,this._w=e.w,this.onChangeCallback(),this},setFromEuler:function(e,t){if(!(e&&e.isEuler))throw new Error("THREE.Quaternion: .setFromEuler() now expects an Euler rotation rather than a Vector3 and order.");var r=e._x,i=e._y,n=e._z,o=e.order,a=Math.cos,s=Math.sin,f=a(r/2),u=a(i/2),c=a(n/2),h=s(r/2),l=s(i/2),p=s(n/2);return o==="XYZ"?(this._x=h*u*c+f*l*p,this._y=f*l*c-h*u*p,this._z=f*u*p+h*l*c,this._w=f*u*c-h*l*p):o==="YXZ"?(this._x=h*u*c+f*l*p,this._y=f*l*c-h*u*p,this._z=f*u*p-h*l*c,this._w=f*u*c+h*l*p):o==="ZXY"?(this._x=h*u*c-f*l*p,this._y=f*l*c+h*u*p,this._z=f*u*p+h*l*c,this._w=f*u*c-h*l*p):o==="ZYX"?(this._x=h*u*c-f*l*p,this._y=f*l*c+h*u*p,this._z=f*u*p-h*l*c,this._w=f*u*c+h*l*p):o==="YZX"?(this._x=h*u*c+f*l*p,this._y=f*l*c+h*u*p,this._z=f*u*p-h*l*c,this._w=f*u*c-h*l*p):o==="XZY"&&(this._x=h*u*c-f*l*p,this._y=f*l*c-h*u*p,this._z=f*u*p+h*l*c,this._w=f*u*c+h*l*p),t!==!1&&this.onChangeCallback(),this},setFromAxisAngle:function(e,t){var r=t/2,i=Math.sin(r);return this._x=e.x*i,this._y=e.y*i,this._z=e.z*i,this._w=Math.cos(r),this.onChangeCallback(),this},setFromRotationMatrix:function(e){var t=e.elements,r=t[0],i=t[4],n=t[8],o=t[1],a=t[5],s=t[9],f=t[2],u=t[6],c=t[10],h=r+a+c,l;return h>0?(l=.5/Math.sqrt(h+1),this._w=.25/l,this._x=(u-s)*l,this._y=(n-f)*l,this._z=(o-i)*l):r>a&&r>c?(l=2*Math.sqrt(1+r-a-c),this._w=(u-s)/l,this._x=.25*l,this._y=(i+o)/l,this._z=(n+f)/l):a>c?(l=2*Math.sqrt(1+a-r-c),this._w=(n-f)/l,this._x=(i+o)/l,this._y=.25*l,this._z=(s+u)/l):(l=2*Math.sqrt(1+c-r-a),this._w=(o-i)/l,this._x=(n+f)/l,this._y=(s+u)/l,this._z=.25*l),this.onChangeCallback(),this},setFromUnitVectors:function(){var e=new x,t,r=1e-6;return function(n,o){return e===void 0&&(e=new x),t=n.dot(o)+1,t<r?(t=0,Math.abs(n.x)>Math.abs(n.z)?e.set(-n.y,n.x,0):e.set(0,-n.z,n.y)):e.crossVectors(n,o),this._x=e.x,this._y=e.y,this._z=e.z,this._w=t,this.normalize()}}(),angleTo:function(e){return 2*Math.acos(Math.abs(ie.clamp(this.dot(e),-1,1)))},rotateTowards:function(e,t){var r=this.angleTo(e);if(r===0)return this;var i=Math.min(1,t/r);return this.slerp(e,i),this},inverse:function(){return this.conjugate()},conjugate:function(){return this._x*=-1,this._y*=-1,this._z*=-1,this.onChangeCallback(),this},dot:function(e){return this._x*e._x+this._y*e._y+this._z*e._z+this._w*e._w},lengthSq:function(){return this._x*this._x+this._y*this._y+this._z*this._z+this._w*this._w},length:function(){return Math.sqrt(this._x*this._x+this._y*this._y+this._z*this._z+this._w*this._w)},normalize:function(){var e=this.length();return e===0?(this._x=0,this._y=0,this._z=0,this._w=1):(e=1/e,this._x=this._x*e,this._y=this._y*e,this._z=this._z*e,this._w=this._w*e),this.onChangeCallback(),this},multiply:function(e,t){return t!==void 0?(console.warn("THREE.Quaternion: .multiply() now only accepts one argument. Use .multiplyQuaternions( a, b ) instead."),this.multiplyQuaternions(e,t)):this.multiplyQuaternions(this,e)},premultiply:function(e){return this.multiplyQuaternions(e,this)},multiplyQuaternions:function(e,t){var r=e._x,i=e._y,n=e._z,o=e._w,a=t._x,s=t._y,f=t._z,u=t._w;return this._x=r*u+o*a+i*f-n*s,this._y=i*u+o*s+n*a-r*f,this._z=n*u+o*f+r*s-i*a,this._w=o*u-r*a-i*s-n*f,this.onChangeCallback(),this},slerp:function(e,t){if(t===0)return this;if(t===1)return this.copy(e);var r=this._x,i=this._y,n=this._z,o=this._w,a=o*e._w+r*e._x+i*e._y+n*e._z;if(a<0?(this._w=-e._w,this._x=-e._x,this._y=-e._y,this._z=-e._z,a=-a):this.copy(e),a>=1)return this._w=o,this._x=r,this._y=i,this._z=n,this;var s=1-a*a;if(s<=Number.EPSILON){var f=1-t;return this._w=f*o+t*this._w,this._x=f*r+t*this._x,this._y=f*i+t*this._y,this._z=f*n+t*this._z,this.normalize()}var u=Math.sqrt(s),c=Math.atan2(u,a),h=Math.sin((1-t)*c)/u,l=Math.sin(t*c)/u;return this._w=o*h+this._w*l,this._x=r*h+this._x*l,this._y=i*h+this._y*l,this._z=n*h+this._z*l,this.onChangeCallback(),this},equals:function(e){return e._x===this._x&&e._y===this._y&&e._z===this._z&&e._w===this._w},fromArray:function(e,t){return t===void 0&&(t=0),this._x=e[t],this._y=e[t+1],this._z=e[t+2],this._w=e[t+3],this.onChangeCallback(),this},toArray:function(e,t){return e===void 0&&(e=[]),t===void 0&&(t=0),e[t]=this._x,e[t+1]=this._y,e[t+2]=this._z,e[t+3]=this._w,e},onChange:function(e){return this.onChangeCallback=e,this},onChangeCallback:function(){}});function x(e,t,r){this.x=e||0,this.y=t||0,this.z=r||0}Object.assign(x.prototype,{isVector3:!0,set:function(e,t,r){return this.x=e,this.y=t,this.z=r,this},setScalar:function(e){return this.x=e,this.y=e,this.z=e,this},setX:function(e){return this.x=e,this},setY:function(e){return this.y=e,this},setZ:function(e){return this.z=e,this},setComponent:function(e,t){switch(e){case 0:this.x=t;break;case 1:this.y=t;break;case 2:this.z=t;break;default:throw new Error("index is out of range: "+e)}return this},getComponent:function(e){switch(e){case 0:return this.x;case 1:return this.y;case 2:return this.z;default:throw new Error("index is out of range: "+e)}},clone:function(){return new this.constructor(this.x,this.y,this.z)},copy:function(e){return this.x=e.x,this.y=e.y,this.z=e.z,this},add:function(e,t){return t!==void 0?(console.warn("THREE.Vector3: .add() now only accepts one argument. Use .addVectors( a, b ) instead."),this.addVectors(e,t)):(this.x+=e.x,this.y+=e.y,this.z+=e.z,this)},addScalar:function(e){return this.x+=e,this.y+=e,this.z+=e,this},addVectors:function(e,t){return this.x=e.x+t.x,this.y=e.y+t.y,this.z=e.z+t.z,this},addScaledVector:function(e,t){return this.x+=e.x*t,this.y+=e.y*t,this.z+=e.z*t,this},sub:function(e,t){return t!==void 0?(console.warn("THREE.Vector3: .sub() now only accepts one argument. Use .subVectors( a, b ) instead."),this.subVectors(e,t)):(this.x-=e.x,this.y-=e.y,this.z-=e.z,this)},subScalar:function(e){return this.x-=e,this.y-=e,this.z-=e,this},subVectors:function(e,t){return this.x=e.x-t.x,this.y=e.y-t.y,this.z=e.z-t.z,this},multiply:function(e,t){return t!==void 0?(console.warn("THREE.Vector3: .multiply() now only accepts one argument. Use .multiplyVectors( a, b ) instead."),this.multiplyVectors(e,t)):(this.x*=e.x,this.y*=e.y,this.z*=e.z,this)},multiplyScalar:function(e){return this.x*=e,this.y*=e,this.z*=e,this},multiplyVectors:function(e,t){return this.x=e.x*t.x,this.y=e.y*t.y,this.z=e.z*t.z,this},applyEuler:function(){var e=new Ge;return function(r){return r&&r.isEuler||console.error("THREE.Vector3: .applyEuler() now expects an Euler rotation rather than a Vector3 and order."),this.applyQuaternion(e.setFromEuler(r))}}(),applyAxisAngle:function(){var e=new Ge;return function(r,i){return this.applyQuaternion(e.setFromAxisAngle(r,i))}}(),applyMatrix3:function(e){var t=this.x,r=this.y,i=this.z,n=e.elements;return this.x=n[0]*t+n[3]*r+n[6]*i,this.y=n[1]*t+n[4]*r+n[7]*i,this.z=n[2]*t+n[5]*r+n[8]*i,this},applyMatrix4:function(e){var t=this.x,r=this.y,i=this.z,n=e.elements,o=1/(n[3]*t+n[7]*r+n[11]*i+n[15]);return this.x=(n[0]*t+n[4]*r+n[8]*i+n[12])*o,this.y=(n[1]*t+n[5]*r+n[9]*i+n[13])*o,this.z=(n[2]*t+n[6]*r+n[10]*i+n[14])*o,this},applyQuaternion:function(e){var t=this.x,r=this.y,i=this.z,n=e.x,o=e.y,a=e.z,s=e.w,f=s*t+o*i-a*r,u=s*r+a*t-n*i,c=s*i+n*r-o*t,h=-n*t-o*r-a*i;return this.x=f*s+h*-n+u*-a-c*-o,this.y=u*s+h*-o+c*-n-f*-a,this.z=c*s+h*-a+f*-o-u*-n,this},project:function(e){return this.applyMatrix4(e.matrixWorldInverse).applyMatrix4(e.projectionMatrix)},unproject:function(){var e=new ee;return function(r){return this.applyMatrix4(e.getInverse(r.projectionMatrix)).applyMatrix4(r.matrixWorld)}}(),transformDirection:function(e){var t=this.x,r=this.y,i=this.z,n=e.elements;return this.x=n[0]*t+n[4]*r+n[8]*i,this.y=n[1]*t+n[5]*r+n[9]*i,this.z=n[2]*t+n[6]*r+n[10]*i,this.normalize()},divide:function(e){return this.x/=e.x,this.y/=e.y,this.z/=e.z,this},divideScalar:function(e){return this.multiplyScalar(1/e)},min:function(e){return this.x=Math.min(this.x,e.x),this.y=Math.min(this.y,e.y),this.z=Math.min(this.z,e.z),this},max:function(e){return this.x=Math.max(this.x,e.x),this.y=Math.max(this.y,e.y),this.z=Math.max(this.z,e.z),this},clamp:function(e,t){return this.x=Math.max(e.x,Math.min(t.x,this.x)),this.y=Math.max(e.y,Math.min(t.y,this.y)),this.z=Math.max(e.z,Math.min(t.z,this.z)),this},clampScalar:function(){var e=new x,t=new x;return function(i,n){return e.set(i,i,i),t.set(n,n,n),this.clamp(e,t)}}(),clampLength:function(e,t){var r=this.length();return this.divideScalar(r||1).multiplyScalar(Math.max(e,Math.min(t,r)))},floor:function(){return this.x=Math.floor(this.x),this.y=Math.floor(this.y),this.z=Math.floor(this.z),this},ceil:function(){return this.x=Math.ceil(this.x),this.y=Math.ceil(this.y),this.z=Math.ceil(this.z),this},round:function(){return this.x=Math.round(this.x),this.y=Math.round(this.y),this.z=Math.round(this.z),this},roundToZero:function(){return this.x=this.x<0?Math.ceil(this.x):Math.floor(this.x),this.y=this.y<0?Math.ceil(this.y):Math.floor(this.y),this.z=this.z<0?Math.ceil(this.z):Math.floor(this.z),this},negate:function(){return this.x=-this.x,this.y=-this.y,this.z=-this.z,this},dot:function(e){return this.x*e.x+this.y*e.y+this.z*e.z},lengthSq:function(){return this.x*this.x+this.y*this.y+this.z*this.z},length:function(){return Math.sqrt(this.x*this.x+this.y*this.y+this.z*this.z)},manhattanLength:function(){return Math.abs(this.x)+Math.abs(this.y)+Math.abs(this.z)},normalize:function(){return this.divideScalar(this.length()||1)},setLength:function(e){return this.normalize().multiplyScalar(e)},lerp:function(e,t){return this.x+=(e.x-this.x)*t,this.y+=(e.y-this.y)*t,this.z+=(e.z-this.z)*t,this},lerpVectors:function(e,t,r){return this.subVectors(t,e).multiplyScalar(r).add(e)},cross:function(e,t){return t!==void 0?(console.warn("THREE.Vector3: .cross() now only accepts one argument. Use .crossVectors( a, b ) instead."),this.crossVectors(e,t)):this.crossVectors(this,e)},crossVectors:function(e,t){var r=e.x,i=e.y,n=e.z,o=t.x,a=t.y,s=t.z;return this.x=i*s-n*a,this.y=n*o-r*s,this.z=r*a-i*o,this},projectOnVector:function(e){var t=e.dot(this)/e.lengthSq();return this.copy(e).multiplyScalar(t)},projectOnPlane:function(){var e=new x;return function(r){return e.copy(this).projectOnVector(r),this.sub(e)}}(),reflect:function(){var e=new x;return function(r){return this.sub(e.copy(r).multiplyScalar(2*this.dot(r)))}}(),angleTo:function(e){var t=this.dot(e)/Math.sqrt(this.lengthSq()*e.lengthSq());return Math.acos(ie.clamp(t,-1,1))},distanceTo:function(e){return Math.sqrt(this.distanceToSquared(e))},distanceToSquared:function(e){var t=this.x-e.x,r=this.y-e.y,i=this.z-e.z;return t*t+r*r+i*i},manhattanDistanceTo:function(e){return Math.abs(this.x-e.x)+Math.abs(this.y-e.y)+Math.abs(this.z-e.z)},setFromSpherical:function(e){return this.setFromSphericalCoords(e.radius,e.phi,e.theta)},setFromSphericalCoords:function(e,t,r){var i=Math.sin(t)*e;return this.x=i*Math.sin(r),this.y=Math.cos(t)*e,this.z=i*Math.cos(r),this},setFromCylindrical:function(e){return this.setFromCylindricalCoords(e.radius,e.theta,e.y)},setFromCylindricalCoords:function(e,t,r){return this.x=e*Math.sin(t),this.y=r,this.z=e*Math.cos(t),this},setFromMatrixPosition:function(e){var t=e.elements;return this.x=t[12],this.y=t[13],this.z=t[14],this},setFromMatrixScale:function(e){var t=this.setFromMatrixColumn(e,0).length(),r=this.setFromMatrixColumn(e,1).length(),i=this.setFromMatrixColumn(e,2).length();return this.x=t,this.y=r,this.z=i,this},setFromMatrixColumn:function(e,t){return this.fromArray(e.elements,t*4)},equals:function(e){return e.x===this.x&&e.y===this.y&&e.z===this.z},fromArray:function(e,t){return t===void 0&&(t=0),this.x=e[t],this.y=e[t+1],this.z=e[t+2],this},toArray:function(e,t){return e===void 0&&(e=[]),t===void 0&&(t=0),e[t]=this.x,e[t+1]=this.y,e[t+2]=this.z,e},fromBufferAttribute:function(e,t,r){return r!==void 0&&console.warn("THREE.Vector3: offset has been removed from .fromBufferAttribute()."),this.x=e.getX(t),this.y=e.getY(t),this.z=e.getZ(t),this}});function Oe(){this.elements=[1,0,0,0,1,0,0,0,1],arguments.length>0&&console.error("THREE.Matrix3: the constructor no longer reads arguments. use .set() instead.")}Object.assign(Oe.prototype,{isMatrix3:!0,set:function(e,t,r,i,n,o,a,s,f){var u=this.elements;return u[0]=e,u[1]=i,u[2]=a,u[3]=t,u[4]=n,u[5]=s,u[6]=r,u[7]=o,u[8]=f,this},identity:function(){return this.set(1,0,0,0,1,0,0,0,1),this},clone:function(){return new this.constructor().fromArray(this.elements)},copy:function(e){var t=this.elements,r=e.elements;return t[0]=r[0],t[1]=r[1],t[2]=r[2],t[3]=r[3],t[4]=r[4],t[5]=r[5],t[6]=r[6],t[7]=r[7],t[8]=r[8],this},setFromMatrix4:function(e){var t=e.elements;return this.set(t[0],t[4],t[8],t[1],t[5],t[9],t[2],t[6],t[10]),this},applyToBufferAttribute:function(){var e=new x;return function(r){for(var i=0,n=r.count;i<n;i++)e.x=r.getX(i),e.y=r.getY(i),e.z=r.getZ(i),e.applyMatrix3(this),r.setXYZ(i,e.x,e.y,e.z);return r}}(),multiply:function(e){return this.multiplyMatrices(this,e)},premultiply:function(e){return this.multiplyMatrices(e,this)},multiplyMatrices:function(e,t){var r=e.elements,i=t.elements,n=this.elements,o=r[0],a=r[3],s=r[6],f=r[1],u=r[4],c=r[7],h=r[2],l=r[5],p=r[8],d=i[0],m=i[3],v=i[6],g=i[1],b=i[4],w=i[7],y=i[2],S=i[5],R=i[8];return n[0]=o*d+a*g+s*y,n[3]=o*m+a*b+s*S,n[6]=o*v+a*w+s*R,n[1]=f*d+u*g+c*y,n[4]=f*m+u*b+c*S,n[7]=f*v+u*w+c*R,n[2]=h*d+l*g+p*y,n[5]=h*m+l*b+p*S,n[8]=h*v+l*w+p*R,this},multiplyScalar:function(e){var t=this.elements;return t[0]*=e,t[3]*=e,t[6]*=e,t[1]*=e,t[4]*=e,t[7]*=e,t[2]*=e,t[5]*=e,t[8]*=e,this},determinant:function(){var e=this.elements,t=e[0],r=e[1],i=e[2],n=e[3],o=e[4],a=e[5],s=e[6],f=e[7],u=e[8];return t*o*u-t*a*f-r*n*u+r*a*s+i*n*f-i*o*s},getInverse:function(e,t){e&&e.isMatrix4&&console.error("THREE.Matrix3: .getInverse() no longer takes a Matrix4 argument.");var r=e.elements,i=this.elements,n=r[0],o=r[1],a=r[2],s=r[3],f=r[4],u=r[5],c=r[6],h=r[7],l=r[8],p=l*f-u*h,d=u*c-l*s,m=h*s-f*c,v=n*p+o*d+a*m;if(v===0){var g="THREE.Matrix3: .getInverse() can't invert matrix, determinant is 0";if(t===!0)throw new Error(g);return console.warn(g),this.identity()}var b=1/v;return i[0]=p*b,i[1]=(a*h-l*o)*b,i[2]=(u*o-a*f)*b,i[3]=d*b,i[4]=(l*n-a*c)*b,i[5]=(a*s-u*n)*b,i[6]=m*b,i[7]=(o*c-h*n)*b,i[8]=(f*n-o*s)*b,this},transpose:function(){var e,t=this.elements;return e=t[1],t[1]=t[3],t[3]=e,e=t[2],t[2]=t[6],t[6]=e,e=t[5],t[5]=t[7],t[7]=e,this},getNormalMatrix:function(e){return this.setFromMatrix4(e).getInverse(this).transpose()},transposeIntoArray:function(e){var t=this.elements;return e[0]=t[0],e[1]=t[3],e[2]=t[6],e[3]=t[1],e[4]=t[4],e[5]=t[7],e[6]=t[2],e[7]=t[5],e[8]=t[8],this},setUvTransform:function(e,t,r,i,n,o,a){var s=Math.cos(n),f=Math.sin(n);this.set(r*s,r*f,-r*(s*o+f*a)+o+e,-i*f,i*s,-i*(-f*o+s*a)+a+t,0,0,1)},scale:function(e,t){var r=this.elements;return r[0]*=e,r[3]*=e,r[6]*=e,r[1]*=t,r[4]*=t,r[7]*=t,this},rotate:function(e){var t=Math.cos(e),r=Math.sin(e),i=this.elements,n=i[0],o=i[3],a=i[6],s=i[1],f=i[4],u=i[7];return i[0]=t*n+r*s,i[3]=t*o+r*f,i[6]=t*a+r*u,i[1]=-r*n+t*s,i[4]=-r*o+t*f,i[7]=-r*a+t*u,this},translate:function(e,t){var r=this.elements;return r[0]+=e*r[2],r[3]+=e*r[5],r[6]+=e*r[8],r[1]+=t*r[2],r[4]+=t*r[5],r[7]+=t*r[8],this},equals:function(e){for(var t=this.elements,r=e.elements,i=0;i<9;i++)if(t[i]!==r[i])return!1;return!0},fromArray:function(e,t){t===void 0&&(t=0);for(var r=0;r<9;r++)this.elements[r]=e[r+t];return this},toArray:function(e,t){e===void 0&&(e=[]),t===void 0&&(t=0);var r=this.elements;return e[t]=r[0],e[t+1]=r[1],e[t+2]=r[2],e[t+3]=r[3],e[t+4]=r[4],e[t+5]=r[5],e[t+6]=r[6],e[t+7]=r[7],e[t+8]=r[8],e}});var Oi,sr={getDataURL:function(e){var t;if(typeof HTMLCanvasElement>"u")return e.src;if(e instanceof HTMLCanvasElement)t=e;else{Oi===void 0&&(Oi=document.createElementNS("http://www.w3.org/1999/xhtml","canvas")),Oi.width=e.width,Oi.height=e.height;var r=Oi.getContext("2d");e instanceof ImageData?r.putImageData(e,0,0):r.drawImage(e,0,0,e.width,e.height),t=Oi}return t.width>2048||t.height>2048?t.toDataURL("image/jpeg",.6):t.toDataURL("image/png")}};var nl=0;function _e(e,t,r,i,n,o,a,s,f,u){Object.defineProperty(this,"id",{value:nl++}),this.uuid=ie.generateUUID(),this.name="",this.image=e!==void 0?e:_e.DEFAULT_IMAGE,this.mipmaps=[],this.mapping=t!==void 0?t:_e.DEFAULT_MAPPING,this.wrapS=r!==void 0?r:vt,this.wrapT=i!==void 0?i:vt,this.magFilter=n!==void 0?n:qe,this.minFilter=o!==void 0?o:Pr,this.anisotropy=f!==void 0?f:1,this.format=a!==void 0?a:wt,this.type=s!==void 0?s:Br,this.offset=new O(0,0),this.repeat=new O(1,1),this.center=new O(0,0),this.rotation=0,this.matrixAutoUpdate=!0,this.matrix=new Oe,this.generateMipmaps=!0,this.premultiplyAlpha=!1,this.flipY=!0,this.unpackAlignment=4,this.encoding=u!==void 0?u:ii,this.version=0,this.onUpdate=null}_e.DEFAULT_IMAGE=void 0;_e.DEFAULT_MAPPING=Mn;_e.prototype=Object.assign(Object.create(bt.prototype),{constructor:_e,isTexture:!0,updateMatrix:function(){this.matrix.setUvTransform(this.offset.x,this.offset.y,this.repeat.x,this.repeat.y,this.rotation,this.center.x,this.center.y)},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.name=e.name,this.image=e.image,this.mipmaps=e.mipmaps.slice(0),this.mapping=e.mapping,this.wrapS=e.wrapS,this.wrapT=e.wrapT,this.magFilter=e.magFilter,this.minFilter=e.minFilter,this.anisotropy=e.anisotropy,this.format=e.format,this.type=e.type,this.offset.copy(e.offset),this.repeat.copy(e.repeat),this.center.copy(e.center),this.rotation=e.rotation,this.matrixAutoUpdate=e.matrixAutoUpdate,this.matrix.copy(e.matrix),this.generateMipmaps=e.generateMipmaps,this.premultiplyAlpha=e.premultiplyAlpha,this.flipY=e.flipY,this.unpackAlignment=e.unpackAlignment,this.encoding=e.encoding,this},toJSON:function(e){var t=e===void 0||typeof e=="string";if(!t&&e.textures[this.uuid]!==void 0)return e.textures[this.uuid];var r={metadata:{version:4.5,type:"Texture",generator:"Texture.toJSON"},uuid:this.uuid,name:this.name,mapping:this.mapping,repeat:[this.repeat.x,this.repeat.y],offset:[this.offset.x,this.offset.y],center:[this.center.x,this.center.y],rotation:this.rotation,wrap:[this.wrapS,this.wrapT],format:this.format,type:this.type,encoding:this.encoding,minFilter:this.minFilter,magFilter:this.magFilter,anisotropy:this.anisotropy,flipY:this.flipY,premultiplyAlpha:this.premultiplyAlpha,unpackAlignment:this.unpackAlignment};if(this.image!==void 0){var i=this.image;if(i.uuid===void 0&&(i.uuid=ie.generateUUID()),!t&&e.images[i.uuid]===void 0){var n;if(Array.isArray(i)){n=[];for(var o=0,a=i.length;o<a;o++)n.push(sr.getDataURL(i[o]))}else n=sr.getDataURL(i);e.images[i.uuid]={uuid:i.uuid,url:n}}r.image=i.uuid}return t||(e.textures[this.uuid]=r),r},dispose:function(){this.dispatchEvent({type:"dispose"})},transformUv:function(e){if(this.mapping!==Mn)return e;if(e.applyMatrix3(this.matrix),e.x<0||e.x>1)switch(this.wrapS){case Ht:e.x=e.x-Math.floor(e.x);break;case vt:e.x=e.x<0?0:1;break;case ar:Math.abs(Math.floor(e.x)%2)===1?e.x=Math.ceil(e.x)-e.x:e.x=e.x-Math.floor(e.x);break}if(e.y<0||e.y>1)switch(this.wrapT){case Ht:e.y=e.y-Math.floor(e.y);break;case vt:e.y=e.y<0?0:1;break;case ar:Math.abs(Math.floor(e.y)%2)===1?e.y=Math.ceil(e.y)-e.y:e.y=e.y-Math.floor(e.y);break}return this.flipY&&(e.y=1-e.y),e}});Object.defineProperty(_e.prototype,"needsUpdate",{set:function(e){e===!0&&this.version++}});function we(e,t,r,i){this.x=e||0,this.y=t||0,this.z=r||0,this.w=i!==void 0?i:1}Object.assign(we.prototype,{isVector4:!0,set:function(e,t,r,i){return this.x=e,this.y=t,this.z=r,this.w=i,this},setScalar:function(e){return this.x=e,this.y=e,this.z=e,this.w=e,this},setX:function(e){return this.x=e,this},setY:function(e){return this.y=e,this},setZ:function(e){return this.z=e,this},setW:function(e){return this.w=e,this},setComponent:function(e,t){switch(e){case 0:this.x=t;break;case 1:this.y=t;break;case 2:this.z=t;break;case 3:this.w=t;break;default:throw new Error("index is out of range: "+e)}return this},getComponent:function(e){switch(e){case 0:return this.x;case 1:return this.y;case 2:return this.z;case 3:return this.w;default:throw new Error("index is out of range: "+e)}},clone:function(){return new this.constructor(this.x,this.y,this.z,this.w)},copy:function(e){return this.x=e.x,this.y=e.y,this.z=e.z,this.w=e.w!==void 0?e.w:1,this},add:function(e,t){return t!==void 0?(console.warn("THREE.Vector4: .add() now only accepts one argument. Use .addVectors( a, b ) instead."),this.addVectors(e,t)):(this.x+=e.x,this.y+=e.y,this.z+=e.z,this.w+=e.w,this)},addScalar:function(e){return this.x+=e,this.y+=e,this.z+=e,this.w+=e,this},addVectors:function(e,t){return this.x=e.x+t.x,this.y=e.y+t.y,this.z=e.z+t.z,this.w=e.w+t.w,this},addScaledVector:function(e,t){return this.x+=e.x*t,this.y+=e.y*t,this.z+=e.z*t,this.w+=e.w*t,this},sub:function(e,t){return t!==void 0?(console.warn("THREE.Vector4: .sub() now only accepts one argument. Use .subVectors( a, b ) instead."),this.subVectors(e,t)):(this.x-=e.x,this.y-=e.y,this.z-=e.z,this.w-=e.w,this)},subScalar:function(e){return this.x-=e,this.y-=e,this.z-=e,this.w-=e,this},subVectors:function(e,t){return this.x=e.x-t.x,this.y=e.y-t.y,this.z=e.z-t.z,this.w=e.w-t.w,this},multiplyScalar:function(e){return this.x*=e,this.y*=e,this.z*=e,this.w*=e,this},applyMatrix4:function(e){var t=this.x,r=this.y,i=this.z,n=this.w,o=e.elements;return this.x=o[0]*t+o[4]*r+o[8]*i+o[12]*n,this.y=o[1]*t+o[5]*r+o[9]*i+o[13]*n,this.z=o[2]*t+o[6]*r+o[10]*i+o[14]*n,this.w=o[3]*t+o[7]*r+o[11]*i+o[15]*n,this},divideScalar:function(e){return this.multiplyScalar(1/e)},setAxisAngleFromQuaternion:function(e){this.w=2*Math.acos(e.w);var t=Math.sqrt(1-e.w*e.w);return t<1e-4?(this.x=1,this.y=0,this.z=0):(this.x=e.x/t,this.y=e.y/t,this.z=e.z/t),this},setAxisAngleFromRotationMatrix:function(e){var t,r,i,n,o=.01,a=.1,s=e.elements,f=s[0],u=s[4],c=s[8],h=s[1],l=s[5],p=s[9],d=s[2],m=s[6],v=s[10];if(Math.abs(u-h)<o&&Math.abs(c-d)<o&&Math.abs(p-m)<o){if(Math.abs(u+h)<a&&Math.abs(c+d)<a&&Math.abs(p+m)<a&&Math.abs(f+l+v-3)<a)return this.set(1,0,0,0),this;t=Math.PI;var g=(f+1)/2,b=(l+1)/2,w=(v+1)/2,y=(u+h)/4,S=(c+d)/4,R=(p+m)/4;return g>b&&g>w?g<o?(r=0,i=.707106781,n=.707106781):(r=Math.sqrt(g),i=y/r,n=S/r):b>w?b<o?(r=.707106781,i=0,n=.707106781):(i=Math.sqrt(b),r=y/i,n=R/i):w<o?(r=.707106781,i=.707106781,n=0):(n=Math.sqrt(w),r=S/n,i=R/n),this.set(r,i,n,t),this}var B=Math.sqrt((m-p)*(m-p)+(c-d)*(c-d)+(h-u)*(h-u));return Math.abs(B)<.001&&(B=1),this.x=(m-p)/B,this.y=(c-d)/B,this.z=(h-u)/B,this.w=Math.acos((f+l+v-1)/2),this},min:function(e){return this.x=Math.min(this.x,e.x),this.y=Math.min(this.y,e.y),this.z=Math.min(this.z,e.z),this.w=Math.min(this.w,e.w),this},max:function(e){return this.x=Math.max(this.x,e.x),this.y=Math.max(this.y,e.y),this.z=Math.max(this.z,e.z),this.w=Math.max(this.w,e.w),this},clamp:function(e,t){return this.x=Math.max(e.x,Math.min(t.x,this.x)),this.y=Math.max(e.y,Math.min(t.y,this.y)),this.z=Math.max(e.z,Math.min(t.z,this.z)),this.w=Math.max(e.w,Math.min(t.w,this.w)),this},clampScalar:function(){var e,t;return function(i,n){return e===void 0&&(e=new we,t=new we),e.set(i,i,i,i),t.set(n,n,n,n),this.clamp(e,t)}}(),clampLength:function(e,t){var r=this.length();return this.divideScalar(r||1).multiplyScalar(Math.max(e,Math.min(t,r)))},floor:function(){return this.x=Math.floor(this.x),this.y=Math.floor(this.y),this.z=Math.floor(this.z),this.w=Math.floor(this.w),this},ceil:function(){return this.x=Math.ceil(this.x),this.y=Math.ceil(this.y),this.z=Math.ceil(this.z),this.w=Math.ceil(this.w),this},round:function(){return this.x=Math.round(this.x),this.y=Math.round(this.y),this.z=Math.round(this.z),this.w=Math.round(this.w),this},roundToZero:function(){return this.x=this.x<0?Math.ceil(this.x):Math.floor(this.x),this.y=this.y<0?Math.ceil(this.y):Math.floor(this.y),this.z=this.z<0?Math.ceil(this.z):Math.floor(this.z),this.w=this.w<0?Math.ceil(this.w):Math.floor(this.w),this},negate:function(){return this.x=-this.x,this.y=-this.y,this.z=-this.z,this.w=-this.w,this},dot:function(e){return this.x*e.x+this.y*e.y+this.z*e.z+this.w*e.w},lengthSq:function(){return this.x*this.x+this.y*this.y+this.z*this.z+this.w*this.w},length:function(){return Math.sqrt(this.x*this.x+this.y*this.y+this.z*this.z+this.w*this.w)},manhattanLength:function(){return Math.abs(this.x)+Math.abs(this.y)+Math.abs(this.z)+Math.abs(this.w)},normalize:function(){return this.divideScalar(this.length()||1)},setLength:function(e){return this.normalize().multiplyScalar(e)},lerp:function(e,t){return this.x+=(e.x-this.x)*t,this.y+=(e.y-this.y)*t,this.z+=(e.z-this.z)*t,this.w+=(e.w-this.w)*t,this},lerpVectors:function(e,t,r){return this.subVectors(t,e).multiplyScalar(r).add(e)},equals:function(e){return e.x===this.x&&e.y===this.y&&e.z===this.z&&e.w===this.w},fromArray:function(e,t){return t===void 0&&(t=0),this.x=e[t],this.y=e[t+1],this.z=e[t+2],this.w=e[t+3],this},toArray:function(e,t){return e===void 0&&(e=[]),t===void 0&&(t=0),e[t]=this.x,e[t+1]=this.y,e[t+2]=this.z,e[t+3]=this.w,e},fromBufferAttribute:function(e,t,r){return r!==void 0&&console.warn("THREE.Vector4: offset has been removed from .fromBufferAttribute()."),this.x=e.getX(t),this.y=e.getY(t),this.z=e.getZ(t),this.w=e.getW(t),this}});function Mt(e,t,r){this.width=e,this.height=t,this.scissor=new we(0,0,e,t),this.scissorTest=!1,this.viewport=new we(0,0,e,t),r=r||{},this.texture=new _e(void 0,void 0,r.wrapS,r.wrapT,r.magFilter,r.minFilter,r.format,r.type,r.anisotropy,r.encoding),this.texture.generateMipmaps=r.generateMipmaps!==void 0?r.generateMipmaps:!1,this.texture.minFilter=r.minFilter!==void 0?r.minFilter:qe,this.depthBuffer=r.depthBuffer!==void 0?r.depthBuffer:!0,this.stencilBuffer=r.stencilBuffer!==void 0?r.stencilBuffer:!0,this.depthTexture=r.depthTexture!==void 0?r.depthTexture:null}Mt.prototype=Object.assign(Object.create(bt.prototype),{constructor:Mt,isWebGLRenderTarget:!0,setSize:function(e,t){(this.width!==e||this.height!==t)&&(this.width=e,this.height=t,this.dispose()),this.viewport.set(0,0,e,t),this.scissor.set(0,0,e,t)},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.width=e.width,this.height=e.height,this.viewport.copy(e.viewport),this.texture=e.texture.clone(),this.depthBuffer=e.depthBuffer,this.stencilBuffer=e.stencilBuffer,this.depthTexture=e.depthTexture,this},dispose:function(){this.dispatchEvent({type:"dispose"})}});function Oa(e,t,r){Mt.call(this,e,t,r),this.samples=4}Oa.prototype=Object.assign(Object.create(Mt.prototype),{constructor:Oa,isWebGLMultisampleRenderTarget:!0,copy:function(e){return Mt.prototype.copy.call(this,e),this.samples=e.samples,this}});function ni(e,t,r){Mt.call(this,e,t,r),this.activeCubeFace=0,this.activeMipMapLevel=0}ni.prototype=Object.create(Mt.prototype);ni.prototype.constructor=ni;ni.prototype.isWebGLRenderTargetCube=!0;function br(e,t,r,i,n,o,a,s,f,u,c,h){_e.call(this,null,o,a,s,f,u,i,n,c,h),this.image={data:e,width:t,height:r},this.magFilter=f!==void 0?f:ke,this.minFilter=u!==void 0?u:ke,this.generateMipmaps=!1,this.flipY=!1,this.unpackAlignment=1}br.prototype=Object.create(_e.prototype);br.prototype.constructor=br;br.prototype.isDataTexture=!0;function Pt(e,t){this.min=e!==void 0?e:new x(1/0,1/0,1/0),this.max=t!==void 0?t:new x(-1/0,-1/0,-1/0)}Object.assign(Pt.prototype,{isBox3:!0,set:function(e,t){return this.min.copy(e),this.max.copy(t),this},setFromArray:function(e){for(var t=1/0,r=1/0,i=1/0,n=-1/0,o=-1/0,a=-1/0,s=0,f=e.length;s<f;s+=3){var u=e[s],c=e[s+1],h=e[s+2];u<t&&(t=u),c<r&&(r=c),h<i&&(i=h),u>n&&(n=u),c>o&&(o=c),h>a&&(a=h)}return this.min.set(t,r,i),this.max.set(n,o,a),this},setFromBufferAttribute:function(e){for(var t=1/0,r=1/0,i=1/0,n=-1/0,o=-1/0,a=-1/0,s=0,f=e.count;s<f;s++){var u=e.getX(s),c=e.getY(s),h=e.getZ(s);u<t&&(t=u),c<r&&(r=c),h<i&&(i=h),u>n&&(n=u),c>o&&(o=c),h>a&&(a=h)}return this.min.set(t,r,i),this.max.set(n,o,a),this},setFromPoints:function(e){this.makeEmpty();for(var t=0,r=e.length;t<r;t++)this.expandByPoint(e[t]);return this},setFromCenterAndSize:function(){var e=new x;return function(r,i){var n=e.copy(i).multiplyScalar(.5);return this.min.copy(r).sub(n),this.max.copy(r).add(n),this}}(),setFromObject:function(e){return this.makeEmpty(),this.expandByObject(e)},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.min.copy(e.min),this.max.copy(e.max),this},makeEmpty:function(){return this.min.x=this.min.y=this.min.z=1/0,this.max.x=this.max.y=this.max.z=-1/0,this},isEmpty:function(){return this.max.x<this.min.x||this.max.y<this.min.y||this.max.z<this.min.z},getCenter:function(e){return e===void 0&&(console.warn("THREE.Box3: .getCenter() target is now required"),e=new x),this.isEmpty()?e.set(0,0,0):e.addVectors(this.min,this.max).multiplyScalar(.5)},getSize:function(e){return e===void 0&&(console.warn("THREE.Box3: .getSize() target is now required"),e=new x),this.isEmpty()?e.set(0,0,0):e.subVectors(this.max,this.min)},expandByPoint:function(e){return this.min.min(e),this.max.max(e),this},expandByVector:function(e){return this.min.sub(e),this.max.add(e),this},expandByScalar:function(e){return this.min.addScalar(-e),this.max.addScalar(e),this},expandByObject:function(){var e,t,r,i=new x;function n(o){var a=o.geometry;if(a!==void 0){if(a.isGeometry){var s=a.vertices;for(t=0,r=s.length;t<r;t++)i.copy(s[t]),i.applyMatrix4(o.matrixWorld),e.expandByPoint(i)}else if(a.isBufferGeometry){var f=a.attributes.position;if(f!==void 0)for(t=0,r=f.count;t<r;t++)i.fromBufferAttribute(f,t).applyMatrix4(o.matrixWorld),e.expandByPoint(i)}}}return function(a){return e=this,a.updateMatrixWorld(!0),a.traverse(n),this}}(),containsPoint:function(e){return!(e.x<this.min.x||e.x>this.max.x||e.y<this.min.y||e.y>this.max.y||e.z<this.min.z||e.z>this.max.z)},containsBox:function(e){return this.min.x<=e.min.x&&e.max.x<=this.max.x&&this.min.y<=e.min.y&&e.max.y<=this.max.y&&this.min.z<=e.min.z&&e.max.z<=this.max.z},getParameter:function(e,t){return t===void 0&&(console.warn("THREE.Box3: .getParameter() target is now required"),t=new x),t.set((e.x-this.min.x)/(this.max.x-this.min.x),(e.y-this.min.y)/(this.max.y-this.min.y),(e.z-this.min.z)/(this.max.z-this.min.z))},intersectsBox:function(e){return!(e.max.x<this.min.x||e.min.x>this.max.x||e.max.y<this.min.y||e.min.y>this.max.y||e.max.z<this.min.z||e.min.z>this.max.z)},intersectsSphere:function(){var e=new x;return function(r){return this.clampPoint(r.center,e),e.distanceToSquared(r.center)<=r.radius*r.radius}}(),intersectsPlane:function(e){var t,r;return e.normal.x>0?(t=e.normal.x*this.min.x,r=e.normal.x*this.max.x):(t=e.normal.x*this.max.x,r=e.normal.x*this.min.x),e.normal.y>0?(t+=e.normal.y*this.min.y,r+=e.normal.y*this.max.y):(t+=e.normal.y*this.max.y,r+=e.normal.y*this.min.y),e.normal.z>0?(t+=e.normal.z*this.min.z,r+=e.normal.z*this.max.z):(t+=e.normal.z*this.max.z,r+=e.normal.z*this.min.z),t<=-e.constant&&r>=-e.constant},intersectsTriangle:function(){var e=new x,t=new x,r=new x,i=new x,n=new x,o=new x,a=new x,s=new x,f=new x,u=new x;function c(h){var l,p;for(l=0,p=h.length-3;l<=p;l+=3){a.fromArray(h,l);var d=f.x*Math.abs(a.x)+f.y*Math.abs(a.y)+f.z*Math.abs(a.z),m=e.dot(a),v=t.dot(a),g=r.dot(a);if(Math.max(-Math.max(m,v,g),Math.min(m,v,g))>d)return!1}return!0}return function(l){if(this.isEmpty())return!1;this.getCenter(s),f.subVectors(this.max,s),e.subVectors(l.a,s),t.subVectors(l.b,s),r.subVectors(l.c,s),i.subVectors(t,e),n.subVectors(r,t),o.subVectors(e,r);var p=[0,-i.z,i.y,0,-n.z,n.y,0,-o.z,o.y,i.z,0,-i.x,n.z,0,-n.x,o.z,0,-o.x,-i.y,i.x,0,-n.y,n.x,0,-o.y,o.x,0];return!c(p)||(p=[1,0,0,0,1,0,0,0,1],!c(p))?!1:(u.crossVectors(i,n),p=[u.x,u.y,u.z],c(p))}}(),clampPoint:function(e,t){return t===void 0&&(console.warn("THREE.Box3: .clampPoint() target is now required"),t=new x),t.copy(e).clamp(this.min,this.max)},distanceToPoint:function(){var e=new x;return function(r){var i=e.copy(r).clamp(this.min,this.max);return i.sub(r).length()}}(),getBoundingSphere:function(){var e=new x;return function(r){return r===void 0&&(console.warn("THREE.Box3: .getBoundingSphere() target is now required"),r=new it),this.getCenter(r.center),r.radius=this.getSize(e).length()*.5,r}}(),intersect:function(e){return this.min.max(e.min),this.max.min(e.max),this.isEmpty()&&this.makeEmpty(),this},union:function(e){return this.min.min(e.min),this.max.max(e.max),this},applyMatrix4:function(){var e=[new x,new x,new x,new x,new x,new x,new x,new x];return function(r){return this.isEmpty()?this:(e[0].set(this.min.x,this.min.y,this.min.z).applyMatrix4(r),e[1].set(this.min.x,this.min.y,this.max.z).applyMatrix4(r),e[2].set(this.min.x,this.max.y,this.min.z).applyMatrix4(r),e[3].set(this.min.x,this.max.y,this.max.z).applyMatrix4(r),e[4].set(this.max.x,this.min.y,this.min.z).applyMatrix4(r),e[5].set(this.max.x,this.min.y,this.max.z).applyMatrix4(r),e[6].set(this.max.x,this.max.y,this.min.z).applyMatrix4(r),e[7].set(this.max.x,this.max.y,this.max.z).applyMatrix4(r),this.setFromPoints(e),this)}}(),translate:function(e){return this.min.add(e),this.max.add(e),this},equals:function(e){return e.min.equals(this.min)&&e.max.equals(this.max)}});function it(e,t){this.center=e!==void 0?e:new x,this.radius=t!==void 0?t:0}Object.assign(it.prototype,{set:function(e,t){return this.center.copy(e),this.radius=t,this},setFromPoints:function(){var e=new Pt;return function(r,i){var n=this.center;i!==void 0?n.copy(i):e.setFromPoints(r).getCenter(n);for(var o=0,a=0,s=r.length;a<s;a++)o=Math.max(o,n.distanceToSquared(r[a]));return this.radius=Math.sqrt(o),this}}(),clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.center.copy(e.center),this.radius=e.radius,this},empty:function(){return this.radius<=0},containsPoint:function(e){return e.distanceToSquared(this.center)<=this.radius*this.radius},distanceToPoint:function(e){return e.distanceTo(this.center)-this.radius},intersectsSphere:function(e){var t=this.radius+e.radius;return e.center.distanceToSquared(this.center)<=t*t},intersectsBox:function(e){return e.intersectsSphere(this)},intersectsPlane:function(e){return Math.abs(e.distanceToPoint(this.center))<=this.radius},clampPoint:function(e,t){var r=this.center.distanceToSquared(e);return t===void 0&&(console.warn("THREE.Sphere: .clampPoint() target is now required"),t=new x),t.copy(e),r>this.radius*this.radius&&(t.sub(this.center).normalize(),t.multiplyScalar(this.radius).add(this.center)),t},getBoundingBox:function(e){return e===void 0&&(console.warn("THREE.Sphere: .getBoundingBox() target is now required"),e=new Pt),e.set(this.center,this.center),e.expandByScalar(this.radius),e},applyMatrix4:function(e){return this.center.applyMatrix4(e),this.radius=this.radius*e.getMaxScaleOnAxis(),this},translate:function(e){return this.center.add(e),this},equals:function(e){return e.center.equals(this.center)&&e.radius===this.radius}});function Ut(e,t){this.normal=e!==void 0?e:new x(1,0,0),this.constant=t!==void 0?t:0}Object.assign(Ut.prototype,{set:function(e,t){return this.normal.copy(e),this.constant=t,this},setComponents:function(e,t,r,i){return this.normal.set(e,t,r),this.constant=i,this},setFromNormalAndCoplanarPoint:function(e,t){return this.normal.copy(e),this.constant=-t.dot(this.normal),this},setFromCoplanarPoints:function(){var e=new x,t=new x;return function(i,n,o){var a=e.subVectors(o,n).cross(t.subVectors(i,n)).normalize();return this.setFromNormalAndCoplanarPoint(a,i),this}}(),clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.normal.copy(e.normal),this.constant=e.constant,this},normalize:function(){var e=1/this.normal.length();return this.normal.multiplyScalar(e),this.constant*=e,this},negate:function(){return this.constant*=-1,this.normal.negate(),this},distanceToPoint:function(e){return this.normal.dot(e)+this.constant},distanceToSphere:function(e){return this.distanceToPoint(e.center)-e.radius},projectPoint:function(e,t){return t===void 0&&(console.warn("THREE.Plane: .projectPoint() target is now required"),t=new x),t.copy(this.normal).multiplyScalar(-this.distanceToPoint(e)).add(e)},intersectLine:function(){var e=new x;return function(r,i){i===void 0&&(console.warn("THREE.Plane: .intersectLine() target is now required"),i=new x);var n=r.delta(e),o=this.normal.dot(n);if(o===0)return this.distanceToPoint(r.start)===0?i.copy(r.start):void 0;var a=-(r.start.dot(this.normal)+this.constant)/o;if(!(a<0||a>1))return i.copy(n).multiplyScalar(a).add(r.start)}}(),intersectsLine:function(e){var t=this.distanceToPoint(e.start),r=this.distanceToPoint(e.end);return t<0&&r>0||r<0&&t>0},intersectsBox:function(e){return e.intersectsPlane(this)},intersectsSphere:function(e){return e.intersectsPlane(this)},coplanarPoint:function(e){return e===void 0&&(console.warn("THREE.Plane: .coplanarPoint() target is now required"),e=new x),e.copy(this.normal).multiplyScalar(-this.constant)},applyMatrix4:function(){var e=new x,t=new Oe;return function(i,n){var o=n||t.getNormalMatrix(i),a=this.coplanarPoint(e).applyMatrix4(i),s=this.normal.applyMatrix3(o).normalize();return this.constant=-a.dot(s),this}}(),translate:function(e){return this.constant-=e.dot(this.normal),this},equals:function(e){return e.normal.equals(this.normal)&&e.constant===this.constant}});function Ui(e,t,r,i,n,o){this.planes=[e!==void 0?e:new Ut,t!==void 0?t:new Ut,r!==void 0?r:new Ut,i!==void 0?i:new Ut,n!==void 0?n:new Ut,o!==void 0?o:new Ut]}Object.assign(Ui.prototype,{set:function(e,t,r,i,n,o){var a=this.planes;return a[0].copy(e),a[1].copy(t),a[2].copy(r),a[3].copy(i),a[4].copy(n),a[5].copy(o),this},clone:function(){return new this.constructor().copy(this)},copy:function(e){for(var t=this.planes,r=0;r<6;r++)t[r].copy(e.planes[r]);return this},setFromMatrix:function(e){var t=this.planes,r=e.elements,i=r[0],n=r[1],o=r[2],a=r[3],s=r[4],f=r[5],u=r[6],c=r[7],h=r[8],l=r[9],p=r[10],d=r[11],m=r[12],v=r[13],g=r[14],b=r[15];return t[0].setComponents(a-i,c-s,d-h,b-m).normalize(),t[1].setComponents(a+i,c+s,d+h,b+m).normalize(),t[2].setComponents(a+n,c+f,d+l,b+v).normalize(),t[3].setComponents(a-n,c-f,d-l,b-v).normalize(),t[4].setComponents(a-o,c-u,d-p,b-g).normalize(),t[5].setComponents(a+o,c+u,d+p,b+g).normalize(),this},intersectsObject:function(){var e=new it;return function(r){var i=r.geometry;return i.boundingSphere===null&&i.computeBoundingSphere(),e.copy(i.boundingSphere).applyMatrix4(r.matrixWorld),this.intersectsSphere(e)}}(),intersectsSprite:function(){var e=new it;return function(r){return e.center.set(0,0,0),e.radius=.7071067811865476,e.applyMatrix4(r.matrixWorld),this.intersectsSphere(e)}}(),intersectsSphere:function(e){for(var t=this.planes,r=e.center,i=-e.radius,n=0;n<6;n++){var o=t[n].distanceToPoint(r);if(o<i)return!1}return!0},intersectsBox:function(){var e=new x;return function(r){for(var i=this.planes,n=0;n<6;n++){var o=i[n];if(e.x=o.normal.x>0?r.max.x:r.min.x,e.y=o.normal.y>0?r.max.y:r.min.y,e.z=o.normal.z>0?r.max.z:r.min.z,o.distanceToPoint(e)<0)return!1}return!0}}(),containsPoint:function(e){for(var t=this.planes,r=0;r<6;r++)if(t[r].distanceToPoint(e)<0)return!1;return!0}});var Tf=`
#ifdef USE_ALPHAMAP

	diffuseColor.a *= texture2D( alphaMap, vUv ).g;

#endif
`;var Sf=`
#ifdef USE_ALPHAMAP

	uniform sampler2D alphaMap;

#endif
`;var Af=`
#ifdef ALPHATEST

	if ( diffuseColor.a < ALPHATEST ) discard;

#endif
`;var Lf=`
#ifdef USE_AOMAP

	// reads channel R, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
	float ambientOcclusion = ( texture2D( aoMap, vUv2 ).r - 1.0 ) * aoMapIntensity + 1.0;

	reflectedLight.indirectDiffuse *= ambientOcclusion;

	#if defined( USE_ENVMAP ) && defined( PHYSICAL )

		float dotNV = saturate( dot( geometry.normal, geometry.viewDir ) );

		reflectedLight.indirectSpecular *= computeSpecularOcclusion( dotNV, ambientOcclusion, material.specularRoughness );

	#endif

#endif
`;var Rf=`
#ifdef USE_AOMAP

	uniform sampler2D aoMap;
	uniform float aoMapIntensity;

#endif
`;var Cf=`
vec3 transformed = vec3( position );
`;var Pf=`
vec3 objectNormal = vec3( normal );
`;var Bf=`
float punctualLightIntensityToIrradianceFactor( const in float lightDistance, const in float cutoffDistance, const in float decayExponent ) {

#if defined ( PHYSICALLY_CORRECT_LIGHTS )

	// based upon Frostbite 3 Moving to Physically-based Rendering
	// page 32, equation 26: E[window1]
	// https://seblagarde.files.wordpress.com/2015/07/course_notes_moving_frostbite_to_pbr_v32.pdf
	// this is intended to be used on spot and point lights who are represented as luminous intensity
	// but who must be converted to luminous irradiance for surface lighting calculation
	float distanceFalloff = 1.0 / max( pow( lightDistance, decayExponent ), 0.01 );

	if( cutoffDistance > 0.0 ) {

		distanceFalloff *= pow2( saturate( 1.0 - pow4( lightDistance / cutoffDistance ) ) );

	}

	return distanceFalloff;

#else

	if( cutoffDistance > 0.0 && decayExponent > 0.0 ) {

		return pow( saturate( -lightDistance / cutoffDistance + 1.0 ), decayExponent );

	}

	return 1.0;

#endif

}

vec3 BRDF_Diffuse_Lambert( const in vec3 diffuseColor ) {

	return RECIPROCAL_PI * diffuseColor;

} // validated

vec3 F_Schlick( const in vec3 specularColor, const in float dotLH ) {

	// Original approximation by Christophe Schlick '94
	// float fresnel = pow( 1.0 - dotLH, 5.0 );

	// Optimized variant (presented by Epic at SIGGRAPH '13)
	// https://cdn2.unrealengine.com/Resources/files/2013SiggraphPresentationsNotes-26915738.pdf
	float fresnel = exp2( ( -5.55473 * dotLH - 6.98316 ) * dotLH );

	return ( 1.0 - specularColor ) * fresnel + specularColor;

} // validated

// Microfacet Models for Refraction through Rough Surfaces - equation (34)
// http://graphicrants.blogspot.com/2013/08/specular-brdf-reference.html
// alpha is "roughness squared" in Disney\u2019s reparameterization
float G_GGX_Smith( const in float alpha, const in float dotNL, const in float dotNV ) {

	// geometry term (normalized) = G(l)\u22C5G(v) / 4(n\u22C5l)(n\u22C5v)
	// also see #12151

	float a2 = pow2( alpha );

	float gl = dotNL + sqrt( a2 + ( 1.0 - a2 ) * pow2( dotNL ) );
	float gv = dotNV + sqrt( a2 + ( 1.0 - a2 ) * pow2( dotNV ) );

	return 1.0 / ( gl * gv );

} // validated

// Moving Frostbite to Physically Based Rendering 3.0 - page 12, listing 2
// https://seblagarde.files.wordpress.com/2015/07/course_notes_moving_frostbite_to_pbr_v32.pdf
float G_GGX_SmithCorrelated( const in float alpha, const in float dotNL, const in float dotNV ) {

	float a2 = pow2( alpha );

	// dotNL and dotNV are explicitly swapped. This is not a mistake.
	float gv = dotNL * sqrt( a2 + ( 1.0 - a2 ) * pow2( dotNV ) );
	float gl = dotNV * sqrt( a2 + ( 1.0 - a2 ) * pow2( dotNL ) );

	return 0.5 / max( gv + gl, EPSILON );

}

// Microfacet Models for Refraction through Rough Surfaces - equation (33)
// http://graphicrants.blogspot.com/2013/08/specular-brdf-reference.html
// alpha is "roughness squared" in Disney\u2019s reparameterization
float D_GGX( const in float alpha, const in float dotNH ) {

	float a2 = pow2( alpha );

	float denom = pow2( dotNH ) * ( a2 - 1.0 ) + 1.0; // avoid alpha = 0 with dotNH = 1

	return RECIPROCAL_PI * a2 / pow2( denom );

}

// GGX Distribution, Schlick Fresnel, GGX-Smith Visibility
vec3 BRDF_Specular_GGX( const in IncidentLight incidentLight, const in GeometricContext geometry, const in vec3 specularColor, const in float roughness ) {

	float alpha = pow2( roughness ); // UE4's roughness

	vec3 halfDir = normalize( incidentLight.direction + geometry.viewDir );

	float dotNL = saturate( dot( geometry.normal, incidentLight.direction ) );
	float dotNV = saturate( dot( geometry.normal, geometry.viewDir ) );
	float dotNH = saturate( dot( geometry.normal, halfDir ) );
	float dotLH = saturate( dot( incidentLight.direction, halfDir ) );

	vec3 F = F_Schlick( specularColor, dotLH );

	float G = G_GGX_SmithCorrelated( alpha, dotNL, dotNV );

	float D = D_GGX( alpha, dotNH );

	return F * ( G * D );

} // validated

// Rect Area Light

// Real-Time Polygonal-Light Shading with Linearly Transformed Cosines
// by Eric Heitz, Jonathan Dupuy, Stephen Hill and David Neubelt
// code: https://github.com/selfshadow/ltc_code/

vec2 LTC_Uv( const in vec3 N, const in vec3 V, const in float roughness ) {

	const float LUT_SIZE  = 64.0;
	const float LUT_SCALE = ( LUT_SIZE - 1.0 ) / LUT_SIZE;
	const float LUT_BIAS  = 0.5 / LUT_SIZE;

	float dotNV = saturate( dot( N, V ) );

	// texture parameterized by sqrt( GGX alpha ) and sqrt( 1 - cos( theta ) )
	vec2 uv = vec2( roughness, sqrt( 1.0 - dotNV ) );

	uv = uv * LUT_SCALE + LUT_BIAS;

	return uv;

}

float LTC_ClippedSphereFormFactor( const in vec3 f ) {

	// Real-Time Area Lighting: a Journey from Research to Production (p.102)
	// An approximation of the form factor of a horizon-clipped rectangle.

	float l = length( f );

	return max( ( l * l + f.z ) / ( l + 1.0 ), 0.0 );

}

vec3 LTC_EdgeVectorFormFactor( const in vec3 v1, const in vec3 v2 ) {

	float x = dot( v1, v2 );

	float y = abs( x );

	// rational polynomial approximation to theta / sin( theta ) / 2PI
	float a = 0.8543985 + ( 0.4965155 + 0.0145206 * y ) * y;
	float b = 3.4175940 + ( 4.1616724 + y ) * y;
	float v = a / b;

	float theta_sintheta = ( x > 0.0 ) ? v : 0.5 * inversesqrt( max( 1.0 - x * x, 1e-7 ) ) - v;

	return cross( v1, v2 ) * theta_sintheta;

}

vec3 LTC_Evaluate( const in vec3 N, const in vec3 V, const in vec3 P, const in mat3 mInv, const in vec3 rectCoords[ 4 ] ) {

	// bail if point is on back side of plane of light
	// assumes ccw winding order of light vertices
	vec3 v1 = rectCoords[ 1 ] - rectCoords[ 0 ];
	vec3 v2 = rectCoords[ 3 ] - rectCoords[ 0 ];
	vec3 lightNormal = cross( v1, v2 );

	if( dot( lightNormal, P - rectCoords[ 0 ] ) < 0.0 ) return vec3( 0.0 );

	// construct orthonormal basis around N
	vec3 T1, T2;
	T1 = normalize( V - N * dot( V, N ) );
	T2 = - cross( N, T1 ); // negated from paper; possibly due to a different handedness of world coordinate system

	// compute transform
	mat3 mat = mInv * transposeMat3( mat3( T1, T2, N ) );

	// transform rect
	vec3 coords[ 4 ];
	coords[ 0 ] = mat * ( rectCoords[ 0 ] - P );
	coords[ 1 ] = mat * ( rectCoords[ 1 ] - P );
	coords[ 2 ] = mat * ( rectCoords[ 2 ] - P );
	coords[ 3 ] = mat * ( rectCoords[ 3 ] - P );

	// project rect onto sphere
	coords[ 0 ] = normalize( coords[ 0 ] );
	coords[ 1 ] = normalize( coords[ 1 ] );
	coords[ 2 ] = normalize( coords[ 2 ] );
	coords[ 3 ] = normalize( coords[ 3 ] );

	// calculate vector form factor
	vec3 vectorFormFactor = vec3( 0.0 );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 0 ], coords[ 1 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 1 ], coords[ 2 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 2 ], coords[ 3 ] );
	vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 3 ], coords[ 0 ] );

	// adjust for horizon clipping
	float result = LTC_ClippedSphereFormFactor( vectorFormFactor );

/*
	// alternate method of adjusting for horizon clipping (see referece)
	// refactoring required
	float len = length( vectorFormFactor );
	float z = vectorFormFactor.z / len;

	const float LUT_SIZE  = 64.0;
	const float LUT_SCALE = ( LUT_SIZE - 1.0 ) / LUT_SIZE;
	const float LUT_BIAS  = 0.5 / LUT_SIZE;

	// tabulated horizon-clipped sphere, apparently...
	vec2 uv = vec2( z * 0.5 + 0.5, len );
	uv = uv * LUT_SCALE + LUT_BIAS;

	float scale = texture2D( ltc_2, uv ).w;

	float result = len * scale;
*/

	return vec3( result );

}

// End Rect Area Light

// ref: https://www.unrealengine.com/blog/physically-based-shading-on-mobile - environmentBRDF for GGX on mobile
vec3 BRDF_Specular_GGX_Environment( const in GeometricContext geometry, const in vec3 specularColor, const in float roughness ) {

	float dotNV = saturate( dot( geometry.normal, geometry.viewDir ) );

	const vec4 c0 = vec4( - 1, - 0.0275, - 0.572, 0.022 );

	const vec4 c1 = vec4( 1, 0.0425, 1.04, - 0.04 );

	vec4 r = roughness * c0 + c1;

	float a004 = min( r.x * r.x, exp2( - 9.28 * dotNV ) ) * r.x + r.y;

	vec2 AB = vec2( -1.04, 1.04 ) * a004 + r.zw;

	return specularColor * AB.x + AB.y;

} // validated


float G_BlinnPhong_Implicit( /* const in float dotNL, const in float dotNV */ ) {

	// geometry term is (n dot l)(n dot v) / 4(n dot l)(n dot v)
	return 0.25;

}

float D_BlinnPhong( const in float shininess, const in float dotNH ) {

	return RECIPROCAL_PI * ( shininess * 0.5 + 1.0 ) * pow( dotNH, shininess );

}

vec3 BRDF_Specular_BlinnPhong( const in IncidentLight incidentLight, const in GeometricContext geometry, const in vec3 specularColor, const in float shininess ) {

	vec3 halfDir = normalize( incidentLight.direction + geometry.viewDir );

	//float dotNL = saturate( dot( geometry.normal, incidentLight.direction ) );
	//float dotNV = saturate( dot( geometry.normal, geometry.viewDir ) );
	float dotNH = saturate( dot( geometry.normal, halfDir ) );
	float dotLH = saturate( dot( incidentLight.direction, halfDir ) );

	vec3 F = F_Schlick( specularColor, dotLH );

	float G = G_BlinnPhong_Implicit( /* dotNL, dotNV */ );

	float D = D_BlinnPhong( shininess, dotNH );

	return F * ( G * D );

} // validated

// source: http://simonstechblog.blogspot.ca/2011/12/microfacet-brdf.html
float GGXRoughnessToBlinnExponent( const in float ggxRoughness ) {
	return ( 2.0 / pow2( ggxRoughness + 0.0001 ) - 2.0 );
}

float BlinnExponentToGGXRoughness( const in float blinnExponent ) {
	return sqrt( 2.0 / ( blinnExponent + 2.0 ) );
}
`;var Ff=`
#ifdef USE_BUMPMAP

	uniform sampler2D bumpMap;
	uniform float bumpScale;

	// Bump Mapping Unparametrized Surfaces on the GPU by Morten S. Mikkelsen
	// http://api.unrealengine.com/attachments/Engine/Rendering/LightingAndShadows/BumpMappingWithoutTangentSpace/mm_sfgrad_bump.pdf

	// Evaluate the derivative of the height w.r.t. screen-space using forward differencing (listing 2)

	vec2 dHdxy_fwd() {

		vec2 dSTdx = dFdx( vUv );
		vec2 dSTdy = dFdy( vUv );

		float Hll = bumpScale * texture2D( bumpMap, vUv ).x;
		float dBx = bumpScale * texture2D( bumpMap, vUv + dSTdx ).x - Hll;
		float dBy = bumpScale * texture2D( bumpMap, vUv + dSTdy ).x - Hll;

		return vec2( dBx, dBy );

	}

	vec3 perturbNormalArb( vec3 surf_pos, vec3 surf_norm, vec2 dHdxy ) {

		// Workaround for Adreno 3XX dFd*( vec3 ) bug. See #9988

		vec3 vSigmaX = vec3( dFdx( surf_pos.x ), dFdx( surf_pos.y ), dFdx( surf_pos.z ) );
		vec3 vSigmaY = vec3( dFdy( surf_pos.x ), dFdy( surf_pos.y ), dFdy( surf_pos.z ) );
		vec3 vN = surf_norm;		// normalized

		vec3 R1 = cross( vSigmaY, vN );
		vec3 R2 = cross( vN, vSigmaX );

		float fDet = dot( vSigmaX, R1 );

		fDet *= ( float( gl_FrontFacing ) * 2.0 - 1.0 );

		vec3 vGrad = sign( fDet ) * ( dHdxy.x * R1 + dHdxy.y * R2 );
		return normalize( abs( fDet ) * surf_norm - vGrad );

	}

#endif
`;var Df=`
#if NUM_CLIPPING_PLANES > 0

	vec4 plane;

	#pragma unroll_loop
	for ( int i = 0; i < UNION_CLIPPING_PLANES; i ++ ) {

		plane = clippingPlanes[ i ];
		if ( dot( vViewPosition, plane.xyz ) > plane.w ) discard;

	}

	#if UNION_CLIPPING_PLANES < NUM_CLIPPING_PLANES

		bool clipped = true;

		#pragma unroll_loop
		for ( int i = UNION_CLIPPING_PLANES; i < NUM_CLIPPING_PLANES; i ++ ) {

			plane = clippingPlanes[ i ];
			clipped = ( dot( vViewPosition, plane.xyz ) > plane.w ) && clipped;

		}

		if ( clipped ) discard;

	#endif

#endif
`;var If=`
#if NUM_CLIPPING_PLANES > 0

	#if ! defined( PHYSICAL ) && ! defined( PHONG ) && ! defined( MATCAP )
		varying vec3 vViewPosition;
	#endif

	uniform vec4 clippingPlanes[ NUM_CLIPPING_PLANES ];

#endif
`;var Of=`
#if NUM_CLIPPING_PLANES > 0 && ! defined( PHYSICAL ) && ! defined( PHONG ) && ! defined( MATCAP )
	varying vec3 vViewPosition;
#endif
`;var Uf=`
#if NUM_CLIPPING_PLANES > 0 && ! defined( PHYSICAL ) && ! defined( PHONG ) && ! defined( MATCAP )
	vViewPosition = - mvPosition.xyz;
#endif
`;var Nf=`
#ifdef USE_COLOR

	diffuseColor.rgb *= vColor;

#endif
`;var Gf=`
#ifdef USE_COLOR

	varying vec3 vColor;

#endif
`;var zf=`
#ifdef USE_COLOR

	varying vec3 vColor;

#endif
`;var Hf=`
#ifdef USE_COLOR

	vColor.xyz = color.xyz;

#endif
`;var Vf=`
#define PI 3.14159265359
#define PI2 6.28318530718
#define PI_HALF 1.5707963267949
#define RECIPROCAL_PI 0.31830988618
#define RECIPROCAL_PI2 0.15915494
#define LOG2 1.442695
#define EPSILON 1e-6

#define saturate(a) clamp( a, 0.0, 1.0 )
#define whiteCompliment(a) ( 1.0 - saturate( a ) )

float pow2( const in float x ) { return x*x; }
float pow3( const in float x ) { return x*x*x; }
float pow4( const in float x ) { float x2 = x*x; return x2*x2; }
float average( const in vec3 color ) { return dot( color, vec3( 0.3333 ) ); }
// expects values in the range of [0,1]x[0,1], returns values in the [0,1] range.
// do not collapse into a single function per: http://byteblacksmith.com/improvements-to-the-canonical-one-liner-glsl-rand-for-opengl-es-2-0/
highp float rand( const in vec2 uv ) {
	const highp float a = 12.9898, b = 78.233, c = 43758.5453;
	highp float dt = dot( uv.xy, vec2( a,b ) ), sn = mod( dt, PI );
	return fract(sin(sn) * c);
}

struct IncidentLight {
	vec3 color;
	vec3 direction;
	bool visible;
};

struct ReflectedLight {
	vec3 directDiffuse;
	vec3 directSpecular;
	vec3 indirectDiffuse;
	vec3 indirectSpecular;
};

struct GeometricContext {
	vec3 position;
	vec3 normal;
	vec3 viewDir;
};

vec3 transformDirection( in vec3 dir, in mat4 matrix ) {

	return normalize( ( matrix * vec4( dir, 0.0 ) ).xyz );

}

// http://en.wikibooks.org/wiki/GLSL_Programming/Applying_Matrix_Transformations
vec3 inverseTransformDirection( in vec3 dir, in mat4 matrix ) {

	return normalize( ( vec4( dir, 0.0 ) * matrix ).xyz );

}

vec3 projectOnPlane(in vec3 point, in vec3 pointOnPlane, in vec3 planeNormal ) {

	float distance = dot( planeNormal, point - pointOnPlane );

	return - distance * planeNormal + point;

}

float sideOfPlane( in vec3 point, in vec3 pointOnPlane, in vec3 planeNormal ) {

	return sign( dot( point - pointOnPlane, planeNormal ) );

}

vec3 linePlaneIntersect( in vec3 pointOnLine, in vec3 lineDirection, in vec3 pointOnPlane, in vec3 planeNormal ) {

	return lineDirection * ( dot( planeNormal, pointOnPlane - pointOnLine ) / dot( planeNormal, lineDirection ) ) + pointOnLine;

}

mat3 transposeMat3( const in mat3 m ) {

	mat3 tmp;

	tmp[ 0 ] = vec3( m[ 0 ].x, m[ 1 ].x, m[ 2 ].x );
	tmp[ 1 ] = vec3( m[ 0 ].y, m[ 1 ].y, m[ 2 ].y );
	tmp[ 2 ] = vec3( m[ 0 ].z, m[ 1 ].z, m[ 2 ].z );

	return tmp;

}

// https://en.wikipedia.org/wiki/Relative_luminance
float linearToRelativeLuminance( const in vec3 color ) {

	vec3 weights = vec3( 0.2126, 0.7152, 0.0722 );

	return dot( weights, color.rgb );

}
`;var kf=`
#ifdef ENVMAP_TYPE_CUBE_UV

#define cubeUV_textureSize (1024.0)

int getFaceFromDirection(vec3 direction) {
	vec3 absDirection = abs(direction);
	int face = -1;
	if( absDirection.x > absDirection.z ) {
		if(absDirection.x > absDirection.y )
			face = direction.x > 0.0 ? 0 : 3;
		else
			face = direction.y > 0.0 ? 1 : 4;
	}
	else {
		if(absDirection.z > absDirection.y )
			face = direction.z > 0.0 ? 2 : 5;
		else
			face = direction.y > 0.0 ? 1 : 4;
	}
	return face;
}
#define cubeUV_maxLods1  (log2(cubeUV_textureSize*0.25) - 1.0)
#define cubeUV_rangeClamp (exp2((6.0 - 1.0) * 2.0))

vec2 MipLevelInfo( vec3 vec, float roughnessLevel, float roughness ) {
	float scale = exp2(cubeUV_maxLods1 - roughnessLevel);
	float dxRoughness = dFdx(roughness);
	float dyRoughness = dFdy(roughness);
	vec3 dx = dFdx( vec * scale * dxRoughness );
	vec3 dy = dFdy( vec * scale * dyRoughness );
	float d = max( dot( dx, dx ), dot( dy, dy ) );
	// Clamp the value to the max mip level counts. hard coded to 6 mips
	d = clamp(d, 1.0, cubeUV_rangeClamp);
	float mipLevel = 0.5 * log2(d);
	return vec2(floor(mipLevel), fract(mipLevel));
}

#define cubeUV_maxLods2 (log2(cubeUV_textureSize*0.25) - 2.0)
#define cubeUV_rcpTextureSize (1.0 / cubeUV_textureSize)

vec2 getCubeUV(vec3 direction, float roughnessLevel, float mipLevel) {
	mipLevel = roughnessLevel > cubeUV_maxLods2 - 3.0 ? 0.0 : mipLevel;
	float a = 16.0 * cubeUV_rcpTextureSize;

	vec2 exp2_packed = exp2( vec2( roughnessLevel, mipLevel ) );
	vec2 rcp_exp2_packed = vec2( 1.0 ) / exp2_packed;
	// float powScale = exp2(roughnessLevel + mipLevel);
	float powScale = exp2_packed.x * exp2_packed.y;
	// float scale =  1.0 / exp2(roughnessLevel + 2.0 + mipLevel);
	float scale = rcp_exp2_packed.x * rcp_exp2_packed.y * 0.25;
	// float mipOffset = 0.75*(1.0 - 1.0/exp2(mipLevel))/exp2(roughnessLevel);
	float mipOffset = 0.75*(1.0 - rcp_exp2_packed.y) * rcp_exp2_packed.x;

	bool bRes = mipLevel == 0.0;
	scale =  bRes && (scale < a) ? a : scale;

	vec3 r;
	vec2 offset;
	int face = getFaceFromDirection(direction);

	float rcpPowScale = 1.0 / powScale;

	if( face == 0) {
		r = vec3(direction.x, -direction.z, direction.y);
		offset = vec2(0.0+mipOffset,0.75 * rcpPowScale);
		offset.y = bRes && (offset.y < 2.0*a) ? a : offset.y;
	}
	else if( face == 1) {
		r = vec3(direction.y, direction.x, direction.z);
		offset = vec2(scale+mipOffset, 0.75 * rcpPowScale);
		offset.y = bRes && (offset.y < 2.0*a) ? a : offset.y;
	}
	else if( face == 2) {
		r = vec3(direction.z, direction.x, direction.y);
		offset = vec2(2.0*scale+mipOffset, 0.75 * rcpPowScale);
		offset.y = bRes && (offset.y < 2.0*a) ? a : offset.y;
	}
	else if( face == 3) {
		r = vec3(direction.x, direction.z, direction.y);
		offset = vec2(0.0+mipOffset,0.5 * rcpPowScale);
		offset.y = bRes && (offset.y < 2.0*a) ? 0.0 : offset.y;
	}
	else if( face == 4) {
		r = vec3(direction.y, direction.x, -direction.z);
		offset = vec2(scale+mipOffset, 0.5 * rcpPowScale);
		offset.y = bRes && (offset.y < 2.0*a) ? 0.0 : offset.y;
	}
	else {
		r = vec3(direction.z, -direction.x, direction.y);
		offset = vec2(2.0*scale+mipOffset, 0.5 * rcpPowScale);
		offset.y = bRes && (offset.y < 2.0*a) ? 0.0 : offset.y;
	}
	r = normalize(r);
	float texelOffset = 0.5 * cubeUV_rcpTextureSize;
	vec2 s = ( r.yz / abs( r.x ) + vec2( 1.0 ) ) * 0.5;
	vec2 base = offset + vec2( texelOffset );
	return base + s * ( scale - 2.0 * texelOffset );
}

#define cubeUV_maxLods3 (log2(cubeUV_textureSize*0.25) - 3.0)

vec4 textureCubeUV( sampler2D envMap, vec3 reflectedDirection, float roughness ) {
	float roughnessVal = roughness* cubeUV_maxLods3;
	float r1 = floor(roughnessVal);
	float r2 = r1 + 1.0;
	float t = fract(roughnessVal);
	vec2 mipInfo = MipLevelInfo(reflectedDirection, r1, roughness);
	float s = mipInfo.y;
	float level0 = mipInfo.x;
	float level1 = level0 + 1.0;
	level1 = level1 > 5.0 ? 5.0 : level1;

	// round to nearest mipmap if we are not interpolating.
	level0 += min( floor( s + 0.5 ), 5.0 );

	// Tri linear interpolation.
	vec2 uv_10 = getCubeUV(reflectedDirection, r1, level0);
	vec4 color10 = envMapTexelToLinear(texture2D(envMap, uv_10));

	vec2 uv_20 = getCubeUV(reflectedDirection, r2, level0);
	vec4 color20 = envMapTexelToLinear(texture2D(envMap, uv_20));

	vec4 result = mix(color10, color20, t);

	return vec4(result.rgb, 1.0);
}

#endif
`;var Wf=`
vec3 transformedNormal = normalMatrix * objectNormal;

#ifdef FLIP_SIDED

	transformedNormal = - transformedNormal;

#endif
`;var Xf=`
#ifdef USE_DISPLACEMENTMAP

	uniform sampler2D displacementMap;
	uniform float displacementScale;
	uniform float displacementBias;

#endif
`;var jf=`
#ifdef USE_DISPLACEMENTMAP

	transformed += normalize( objectNormal ) * ( texture2D( displacementMap, uv ).x * displacementScale + displacementBias );

#endif
`;var qf=`
#ifdef USE_EMISSIVEMAP

	vec4 emissiveColor = texture2D( emissiveMap, vUv );

	emissiveColor.rgb = emissiveMapTexelToLinear( emissiveColor ).rgb;

	totalEmissiveRadiance *= emissiveColor.rgb;

#endif
`;var Yf=`
#ifdef USE_EMISSIVEMAP

	uniform sampler2D emissiveMap;

#endif
`;var Zf=`
  gl_FragColor = linearToOutputTexel( gl_FragColor );
`;var Jf=`
// For a discussion of what this is, please read this: http://lousodrome.net/blog/light/2013/05/26/gamma-correct-and-hdr-rendering-in-a-32-bits-buffer/

vec4 LinearToLinear( in vec4 value ) {
	return value;
}

vec4 GammaToLinear( in vec4 value, in float gammaFactor ) {
	return vec4( pow( value.rgb, vec3( gammaFactor ) ), value.a );
}

vec4 LinearToGamma( in vec4 value, in float gammaFactor ) {
	return vec4( pow( value.rgb, vec3( 1.0 / gammaFactor ) ), value.a );
}

vec4 sRGBToLinear( in vec4 value ) {
	return vec4( mix( pow( value.rgb * 0.9478672986 + vec3( 0.0521327014 ), vec3( 2.4 ) ), value.rgb * 0.0773993808, vec3( lessThanEqual( value.rgb, vec3( 0.04045 ) ) ) ), value.a );
}

vec4 LinearTosRGB( in vec4 value ) {
	return vec4( mix( pow( value.rgb, vec3( 0.41666 ) ) * 1.055 - vec3( 0.055 ), value.rgb * 12.92, vec3( lessThanEqual( value.rgb, vec3( 0.0031308 ) ) ) ), value.a );
}

vec4 RGBEToLinear( in vec4 value ) {
	return vec4( value.rgb * exp2( value.a * 255.0 - 128.0 ), 1.0 );
}

vec4 LinearToRGBE( in vec4 value ) {
	float maxComponent = max( max( value.r, value.g ), value.b );
	float fExp = clamp( ceil( log2( maxComponent ) ), -128.0, 127.0 );
	return vec4( value.rgb / exp2( fExp ), ( fExp + 128.0 ) / 255.0 );
//  return vec4( value.brg, ( 3.0 + 128.0 ) / 256.0 );
}

// reference: http://iwasbeingirony.blogspot.ca/2010/06/difference-between-rgbm-and-rgbd.html
vec4 RGBMToLinear( in vec4 value, in float maxRange ) {
	return vec4( value.rgb * value.a * maxRange, 1.0 );
}

vec4 LinearToRGBM( in vec4 value, in float maxRange ) {
	float maxRGB = max( value.r, max( value.g, value.b ) );
	float M = clamp( maxRGB / maxRange, 0.0, 1.0 );
	M = ceil( M * 255.0 ) / 255.0;
	return vec4( value.rgb / ( M * maxRange ), M );
}

// reference: http://iwasbeingirony.blogspot.ca/2010/06/difference-between-rgbm-and-rgbd.html
vec4 RGBDToLinear( in vec4 value, in float maxRange ) {
	return vec4( value.rgb * ( ( maxRange / 255.0 ) / value.a ), 1.0 );
}

vec4 LinearToRGBD( in vec4 value, in float maxRange ) {
	float maxRGB = max( value.r, max( value.g, value.b ) );
	float D = max( maxRange / maxRGB, 1.0 );
	D = min( floor( D ) / 255.0, 1.0 );
	return vec4( value.rgb * ( D * ( 255.0 / maxRange ) ), D );
}

// LogLuv reference: http://graphicrants.blogspot.ca/2009/04/rgbm-color-encoding.html

// M matrix, for encoding
const mat3 cLogLuvM = mat3( 0.2209, 0.3390, 0.4184, 0.1138, 0.6780, 0.7319, 0.0102, 0.1130, 0.2969 );
vec4 LinearToLogLuv( in vec4 value )  {
	vec3 Xp_Y_XYZp = value.rgb * cLogLuvM;
	Xp_Y_XYZp = max( Xp_Y_XYZp, vec3( 1e-6, 1e-6, 1e-6 ) );
	vec4 vResult;
	vResult.xy = Xp_Y_XYZp.xy / Xp_Y_XYZp.z;
	float Le = 2.0 * log2(Xp_Y_XYZp.y) + 127.0;
	vResult.w = fract( Le );
	vResult.z = ( Le - ( floor( vResult.w * 255.0 ) ) / 255.0 ) / 255.0;
	return vResult;
}

// Inverse M matrix, for decoding
const mat3 cLogLuvInverseM = mat3( 6.0014, -2.7008, -1.7996, -1.3320, 3.1029, -5.7721, 0.3008, -1.0882, 5.6268 );
vec4 LogLuvToLinear( in vec4 value ) {
	float Le = value.z * 255.0 + value.w;
	vec3 Xp_Y_XYZp;
	Xp_Y_XYZp.y = exp2( ( Le - 127.0 ) / 2.0 );
	Xp_Y_XYZp.z = Xp_Y_XYZp.y / value.y;
	Xp_Y_XYZp.x = value.x * Xp_Y_XYZp.z;
	vec3 vRGB = Xp_Y_XYZp.rgb * cLogLuvInverseM;
	return vec4( max( vRGB, 0.0 ), 1.0 );
}
`;var Qf=`
#ifdef USE_ENVMAP

	#if defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( PHONG )

		vec3 cameraToVertex = normalize( vWorldPosition - cameraPosition );

		// Transforming Normal Vectors with the Inverse Transformation
		vec3 worldNormal = inverseTransformDirection( normal, viewMatrix );

		#ifdef ENVMAP_MODE_REFLECTION

			vec3 reflectVec = reflect( cameraToVertex, worldNormal );

		#else

			vec3 reflectVec = refract( cameraToVertex, worldNormal, refractionRatio );

		#endif

	#else

		vec3 reflectVec = vReflect;

	#endif

	#ifdef ENVMAP_TYPE_CUBE

		vec4 envColor = textureCube( envMap, vec3( flipEnvMap * reflectVec.x, reflectVec.yz ) );

	#elif defined( ENVMAP_TYPE_EQUIREC )

		vec2 sampleUV;

		reflectVec = normalize( reflectVec );

		sampleUV.y = asin( clamp( reflectVec.y, - 1.0, 1.0 ) ) * RECIPROCAL_PI + 0.5;

		sampleUV.x = atan( reflectVec.z, reflectVec.x ) * RECIPROCAL_PI2 + 0.5;

		vec4 envColor = texture2D( envMap, sampleUV );

	#elif defined( ENVMAP_TYPE_SPHERE )

		reflectVec = normalize( reflectVec );

		vec3 reflectView = normalize( ( viewMatrix * vec4( reflectVec, 0.0 ) ).xyz + vec3( 0.0, 0.0, 1.0 ) );

		vec4 envColor = texture2D( envMap, reflectView.xy * 0.5 + 0.5 );

	#else

		vec4 envColor = vec4( 0.0 );

	#endif

	envColor = envMapTexelToLinear( envColor );

	#ifdef ENVMAP_BLENDING_MULTIPLY

		outgoingLight = mix( outgoingLight, outgoingLight * envColor.xyz, specularStrength * reflectivity );

	#elif defined( ENVMAP_BLENDING_MIX )

		outgoingLight = mix( outgoingLight, envColor.xyz, specularStrength * reflectivity );

	#elif defined( ENVMAP_BLENDING_ADD )

		outgoingLight += envColor.xyz * specularStrength * reflectivity;

	#endif

#endif
`;var Kf=`
#if defined( USE_ENVMAP ) || defined( PHYSICAL )
	uniform float reflectivity;
	uniform float envMapIntensity;
#endif

#ifdef USE_ENVMAP

	#if ! defined( PHYSICAL ) && ( defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( PHONG ) )
		varying vec3 vWorldPosition;
	#endif

	#ifdef ENVMAP_TYPE_CUBE
		uniform samplerCube envMap;
	#else
		uniform sampler2D envMap;
	#endif
	uniform float flipEnvMap;
	uniform int maxMipLevel;

	#if defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( PHONG ) || defined( PHYSICAL )
		uniform float refractionRatio;
	#else
		varying vec3 vReflect;
	#endif

#endif
`;var $f=`
#ifdef USE_ENVMAP

	#if defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( PHONG )
		varying vec3 vWorldPosition;

	#else

		varying vec3 vReflect;
		uniform float refractionRatio;

	#endif

#endif
`;var eu=`
#ifdef USE_ENVMAP

	#if defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( PHONG )

		vWorldPosition = worldPosition.xyz;

	#else

		vec3 cameraToVertex = normalize( worldPosition.xyz - cameraPosition );

		vec3 worldNormal = inverseTransformDirection( transformedNormal, viewMatrix );

		#ifdef ENVMAP_MODE_REFLECTION

			vReflect = reflect( cameraToVertex, worldNormal );

		#else

			vReflect = refract( cameraToVertex, worldNormal, refractionRatio );

		#endif

	#endif

#endif
`;var tu=`
#ifdef USE_FOG

	fogDepth = -mvPosition.z;

#endif
`;var ru=`
#ifdef USE_FOG

	varying float fogDepth;

#endif
`;var iu=`
#ifdef USE_FOG

	#ifdef FOG_EXP2

		float fogFactor = whiteCompliment( exp2( - fogDensity * fogDensity * fogDepth * fogDepth * LOG2 ) );

	#else

		float fogFactor = smoothstep( fogNear, fogFar, fogDepth );

	#endif

	gl_FragColor.rgb = mix( gl_FragColor.rgb, fogColor, fogFactor );

#endif
`;var nu=`
#ifdef USE_FOG

	uniform vec3 fogColor;
	varying float fogDepth;

	#ifdef FOG_EXP2

		uniform float fogDensity;

	#else

		uniform float fogNear;
		uniform float fogFar;

	#endif

#endif
`;var ou=`
#ifdef TOON

	uniform sampler2D gradientMap;

	vec3 getGradientIrradiance( vec3 normal, vec3 lightDirection ) {

		// dotNL will be from -1.0 to 1.0
		float dotNL = dot( normal, lightDirection );
		vec2 coord = vec2( dotNL * 0.5 + 0.5, 0.0 );

		#ifdef USE_GRADIENTMAP

			return texture2D( gradientMap, coord ).rgb;

		#else

			return ( coord.x < 0.7 ) ? vec3( 0.7 ) : vec3( 1.0 );

		#endif


	}

#endif
`;var au=`
#ifdef USE_LIGHTMAP

	reflectedLight.indirectDiffuse += PI * texture2D( lightMap, vUv2 ).xyz * lightMapIntensity; // factor of PI should not be present; included here to prevent breakage

#endif
`;var su=`
#ifdef USE_LIGHTMAP

	uniform sampler2D lightMap;
	uniform float lightMapIntensity;

#endif
`;var fu=`
vec3 diffuse = vec3( 1.0 );

GeometricContext geometry;
geometry.position = mvPosition.xyz;
geometry.normal = normalize( transformedNormal );
geometry.viewDir = normalize( -mvPosition.xyz );

GeometricContext backGeometry;
backGeometry.position = geometry.position;
backGeometry.normal = -geometry.normal;
backGeometry.viewDir = geometry.viewDir;

vLightFront = vec3( 0.0 );

#ifdef DOUBLE_SIDED
	vLightBack = vec3( 0.0 );
#endif

IncidentLight directLight;
float dotNL;
vec3 directLightColor_Diffuse;

#if NUM_POINT_LIGHTS > 0

	#pragma unroll_loop
	for ( int i = 0; i < NUM_POINT_LIGHTS; i ++ ) {

		getPointDirectLightIrradiance( pointLights[ i ], geometry, directLight );

		dotNL = dot( geometry.normal, directLight.direction );
		directLightColor_Diffuse = PI * directLight.color;

		vLightFront += saturate( dotNL ) * directLightColor_Diffuse;

		#ifdef DOUBLE_SIDED

			vLightBack += saturate( -dotNL ) * directLightColor_Diffuse;

		#endif

	}

#endif

#if NUM_SPOT_LIGHTS > 0

	#pragma unroll_loop
	for ( int i = 0; i < NUM_SPOT_LIGHTS; i ++ ) {

		getSpotDirectLightIrradiance( spotLights[ i ], geometry, directLight );

		dotNL = dot( geometry.normal, directLight.direction );
		directLightColor_Diffuse = PI * directLight.color;

		vLightFront += saturate( dotNL ) * directLightColor_Diffuse;

		#ifdef DOUBLE_SIDED

			vLightBack += saturate( -dotNL ) * directLightColor_Diffuse;

		#endif
	}

#endif

/*
#if NUM_RECT_AREA_LIGHTS > 0

	for ( int i = 0; i < NUM_RECT_AREA_LIGHTS; i ++ ) {

		// TODO (abelnation): implement

	}

#endif
*/

#if NUM_DIR_LIGHTS > 0

	#pragma unroll_loop
	for ( int i = 0; i < NUM_DIR_LIGHTS; i ++ ) {

		getDirectionalDirectLightIrradiance( directionalLights[ i ], geometry, directLight );

		dotNL = dot( geometry.normal, directLight.direction );
		directLightColor_Diffuse = PI * directLight.color;

		vLightFront += saturate( dotNL ) * directLightColor_Diffuse;

		#ifdef DOUBLE_SIDED

			vLightBack += saturate( -dotNL ) * directLightColor_Diffuse;

		#endif

	}

#endif

#if NUM_HEMI_LIGHTS > 0

	#pragma unroll_loop
	for ( int i = 0; i < NUM_HEMI_LIGHTS; i ++ ) {

		vLightFront += getHemisphereLightIrradiance( hemisphereLights[ i ], geometry );

		#ifdef DOUBLE_SIDED

			vLightBack += getHemisphereLightIrradiance( hemisphereLights[ i ], backGeometry );

		#endif

	}

#endif
`;var uu=`
uniform vec3 ambientLightColor;

vec3 getAmbientLightIrradiance( const in vec3 ambientLightColor ) {

	vec3 irradiance = ambientLightColor;

	#ifndef PHYSICALLY_CORRECT_LIGHTS

		irradiance *= PI;

	#endif

	return irradiance;

}

#if NUM_DIR_LIGHTS > 0

	struct DirectionalLight {
		vec3 direction;
		vec3 color;

		int shadow;
		float shadowBias;
		float shadowRadius;
		vec2 shadowMapSize;
	};

	uniform DirectionalLight directionalLights[ NUM_DIR_LIGHTS ];

	void getDirectionalDirectLightIrradiance( const in DirectionalLight directionalLight, const in GeometricContext geometry, out IncidentLight directLight ) {

		directLight.color = directionalLight.color;
		directLight.direction = directionalLight.direction;
		directLight.visible = true;

	}

#endif


#if NUM_POINT_LIGHTS > 0

	struct PointLight {
		vec3 position;
		vec3 color;
		float distance;
		float decay;

		int shadow;
		float shadowBias;
		float shadowRadius;
		vec2 shadowMapSize;
		float shadowCameraNear;
		float shadowCameraFar;
	};

	uniform PointLight pointLights[ NUM_POINT_LIGHTS ];

	// directLight is an out parameter as having it as a return value caused compiler errors on some devices
	void getPointDirectLightIrradiance( const in PointLight pointLight, const in GeometricContext geometry, out IncidentLight directLight ) {

		vec3 lVector = pointLight.position - geometry.position;
		directLight.direction = normalize( lVector );

		float lightDistance = length( lVector );

		directLight.color = pointLight.color;
		directLight.color *= punctualLightIntensityToIrradianceFactor( lightDistance, pointLight.distance, pointLight.decay );
		directLight.visible = ( directLight.color != vec3( 0.0 ) );

	}

#endif


#if NUM_SPOT_LIGHTS > 0

	struct SpotLight {
		vec3 position;
		vec3 direction;
		vec3 color;
		float distance;
		float decay;
		float coneCos;
		float penumbraCos;

		int shadow;
		float shadowBias;
		float shadowRadius;
		vec2 shadowMapSize;
	};

	uniform SpotLight spotLights[ NUM_SPOT_LIGHTS ];

	// directLight is an out parameter as having it as a return value caused compiler errors on some devices
	void getSpotDirectLightIrradiance( const in SpotLight spotLight, const in GeometricContext geometry, out IncidentLight directLight  ) {

		vec3 lVector = spotLight.position - geometry.position;
		directLight.direction = normalize( lVector );

		float lightDistance = length( lVector );
		float angleCos = dot( directLight.direction, spotLight.direction );

		if ( angleCos > spotLight.coneCos ) {

			float spotEffect = smoothstep( spotLight.coneCos, spotLight.penumbraCos, angleCos );

			directLight.color = spotLight.color;
			directLight.color *= spotEffect * punctualLightIntensityToIrradianceFactor( lightDistance, spotLight.distance, spotLight.decay );
			directLight.visible = true;

		} else {

			directLight.color = vec3( 0.0 );
			directLight.visible = false;

		}
	}

#endif


#if NUM_RECT_AREA_LIGHTS > 0

	struct RectAreaLight {
		vec3 color;
		vec3 position;
		vec3 halfWidth;
		vec3 halfHeight;
	};

	// Pre-computed values of LinearTransformedCosine approximation of BRDF
	// BRDF approximation Texture is 64x64
	uniform sampler2D ltc_1; // RGBA Float
	uniform sampler2D ltc_2; // RGBA Float

	uniform RectAreaLight rectAreaLights[ NUM_RECT_AREA_LIGHTS ];

#endif


#if NUM_HEMI_LIGHTS > 0

	struct HemisphereLight {
		vec3 direction;
		vec3 skyColor;
		vec3 groundColor;
	};

	uniform HemisphereLight hemisphereLights[ NUM_HEMI_LIGHTS ];

	vec3 getHemisphereLightIrradiance( const in HemisphereLight hemiLight, const in GeometricContext geometry ) {

		float dotNL = dot( geometry.normal, hemiLight.direction );
		float hemiDiffuseWeight = 0.5 * dotNL + 0.5;

		vec3 irradiance = mix( hemiLight.groundColor, hemiLight.skyColor, hemiDiffuseWeight );

		#ifndef PHYSICALLY_CORRECT_LIGHTS

			irradiance *= PI;

		#endif

		return irradiance;

	}

#endif
`;var cu=`
#if defined( USE_ENVMAP ) && defined( PHYSICAL )

	vec3 getLightProbeIndirectIrradiance( /*const in SpecularLightProbe specularLightProbe,*/ const in GeometricContext geometry, const in int maxMIPLevel ) {

		vec3 worldNormal = inverseTransformDirection( geometry.normal, viewMatrix );

		#ifdef ENVMAP_TYPE_CUBE

			vec3 queryVec = vec3( flipEnvMap * worldNormal.x, worldNormal.yz );

			// TODO: replace with properly filtered cubemaps and access the irradiance LOD level, be it the last LOD level
			// of a specular cubemap, or just the default level of a specially created irradiance cubemap.

			#ifdef TEXTURE_LOD_EXT

				vec4 envMapColor = textureCubeLodEXT( envMap, queryVec, float( maxMIPLevel ) );

			#else

				// force the bias high to get the last LOD level as it is the most blurred.
				vec4 envMapColor = textureCube( envMap, queryVec, float( maxMIPLevel ) );

			#endif

			envMapColor.rgb = envMapTexelToLinear( envMapColor ).rgb;

		#elif defined( ENVMAP_TYPE_CUBE_UV )

			vec3 queryVec = vec3( flipEnvMap * worldNormal.x, worldNormal.yz );
			vec4 envMapColor = textureCubeUV( envMap, queryVec, 1.0 );

		#else

			vec4 envMapColor = vec4( 0.0 );

		#endif

		return PI * envMapColor.rgb * envMapIntensity;

	}

	// taken from here: http://casual-effects.blogspot.ca/2011/08/plausible-environment-lighting-in-two.html
	float getSpecularMIPLevel( const in float blinnShininessExponent, const in int maxMIPLevel ) {

		//float envMapWidth = pow( 2.0, maxMIPLevelScalar );
		//float desiredMIPLevel = log2( envMapWidth * sqrt( 3.0 ) ) - 0.5 * log2( pow2( blinnShininessExponent ) + 1.0 );

		float maxMIPLevelScalar = float( maxMIPLevel );
		float desiredMIPLevel = maxMIPLevelScalar + 0.79248 - 0.5 * log2( pow2( blinnShininessExponent ) + 1.0 );

		// clamp to allowable LOD ranges.
		return clamp( desiredMIPLevel, 0.0, maxMIPLevelScalar );

	}

	vec3 getLightProbeIndirectRadiance( /*const in SpecularLightProbe specularLightProbe,*/ const in GeometricContext geometry, const in float blinnShininessExponent, const in int maxMIPLevel ) {

		#ifdef ENVMAP_MODE_REFLECTION

			vec3 reflectVec = reflect( -geometry.viewDir, geometry.normal );

		#else

			vec3 reflectVec = refract( -geometry.viewDir, geometry.normal, refractionRatio );

		#endif

		reflectVec = inverseTransformDirection( reflectVec, viewMatrix );

		float specularMIPLevel = getSpecularMIPLevel( blinnShininessExponent, maxMIPLevel );

		#ifdef ENVMAP_TYPE_CUBE

			vec3 queryReflectVec = vec3( flipEnvMap * reflectVec.x, reflectVec.yz );

			#ifdef TEXTURE_LOD_EXT

				vec4 envMapColor = textureCubeLodEXT( envMap, queryReflectVec, specularMIPLevel );

			#else

				vec4 envMapColor = textureCube( envMap, queryReflectVec, specularMIPLevel );

			#endif

			envMapColor.rgb = envMapTexelToLinear( envMapColor ).rgb;

		#elif defined( ENVMAP_TYPE_CUBE_UV )

			vec3 queryReflectVec = vec3( flipEnvMap * reflectVec.x, reflectVec.yz );
			vec4 envMapColor = textureCubeUV( envMap, queryReflectVec, BlinnExponentToGGXRoughness(blinnShininessExponent ));

		#elif defined( ENVMAP_TYPE_EQUIREC )

			vec2 sampleUV;
			sampleUV.y = asin( clamp( reflectVec.y, - 1.0, 1.0 ) ) * RECIPROCAL_PI + 0.5;
			sampleUV.x = atan( reflectVec.z, reflectVec.x ) * RECIPROCAL_PI2 + 0.5;

			#ifdef TEXTURE_LOD_EXT

				vec4 envMapColor = texture2DLodEXT( envMap, sampleUV, specularMIPLevel );

			#else

				vec4 envMapColor = texture2D( envMap, sampleUV, specularMIPLevel );

			#endif

			envMapColor.rgb = envMapTexelToLinear( envMapColor ).rgb;

		#elif defined( ENVMAP_TYPE_SPHERE )

			vec3 reflectView = normalize( ( viewMatrix * vec4( reflectVec, 0.0 ) ).xyz + vec3( 0.0,0.0,1.0 ) );

			#ifdef TEXTURE_LOD_EXT

				vec4 envMapColor = texture2DLodEXT( envMap, reflectView.xy * 0.5 + 0.5, specularMIPLevel );

			#else

				vec4 envMapColor = texture2D( envMap, reflectView.xy * 0.5 + 0.5, specularMIPLevel );

			#endif

			envMapColor.rgb = envMapTexelToLinear( envMapColor ).rgb;

		#endif

		return envMapColor.rgb * envMapIntensity;

	}

#endif
`;var hu=`
BlinnPhongMaterial material;
material.diffuseColor = diffuseColor.rgb;
material.specularColor = specular;
material.specularShininess = shininess;
material.specularStrength = specularStrength;
`;var lu=`
varying vec3 vViewPosition;

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif


struct BlinnPhongMaterial {

	vec3	diffuseColor;
	vec3	specularColor;
	float	specularShininess;
	float	specularStrength;

};

void RE_Direct_BlinnPhong( const in IncidentLight directLight, const in GeometricContext geometry, const in BlinnPhongMaterial material, inout ReflectedLight reflectedLight ) {

	#ifdef TOON

		vec3 irradiance = getGradientIrradiance( geometry.normal, directLight.direction ) * directLight.color;

	#else

		float dotNL = saturate( dot( geometry.normal, directLight.direction ) );
		vec3 irradiance = dotNL * directLight.color;

	#endif

	#ifndef PHYSICALLY_CORRECT_LIGHTS

		irradiance *= PI; // punctual light

	#endif

	reflectedLight.directDiffuse += irradiance * BRDF_Diffuse_Lambert( material.diffuseColor );

	reflectedLight.directSpecular += irradiance * BRDF_Specular_BlinnPhong( directLight, geometry, material.specularColor, material.specularShininess ) * material.specularStrength;

}

void RE_IndirectDiffuse_BlinnPhong( const in vec3 irradiance, const in GeometricContext geometry, const in BlinnPhongMaterial material, inout ReflectedLight reflectedLight ) {

	reflectedLight.indirectDiffuse += irradiance * BRDF_Diffuse_Lambert( material.diffuseColor );

}

#define RE_Direct				RE_Direct_BlinnPhong
#define RE_IndirectDiffuse		RE_IndirectDiffuse_BlinnPhong

#define Material_LightProbeLOD( material )	(0)
`;var pu=`
PhysicalMaterial material;
material.diffuseColor = diffuseColor.rgb * ( 1.0 - metalnessFactor );
material.specularRoughness = clamp( roughnessFactor, 0.04, 1.0 );
#ifdef STANDARD
	material.specularColor = mix( vec3( DEFAULT_SPECULAR_COEFFICIENT ), diffuseColor.rgb, metalnessFactor );
#else
	material.specularColor = mix( vec3( MAXIMUM_SPECULAR_COEFFICIENT * pow2( reflectivity ) ), diffuseColor.rgb, metalnessFactor );
	material.clearCoat = saturate( clearCoat ); // Burley clearcoat model
	material.clearCoatRoughness = clamp( clearCoatRoughness, 0.04, 1.0 );
#endif
`;var du=`
struct PhysicalMaterial {

	vec3	diffuseColor;
	float	specularRoughness;
	vec3	specularColor;

	#ifndef STANDARD
		float clearCoat;
		float clearCoatRoughness;
	#endif

};

#define MAXIMUM_SPECULAR_COEFFICIENT 0.16
#define DEFAULT_SPECULAR_COEFFICIENT 0.04

// Clear coat directional hemishperical reflectance (this approximation should be improved)
float clearCoatDHRApprox( const in float roughness, const in float dotNL ) {

	return DEFAULT_SPECULAR_COEFFICIENT + ( 1.0 - DEFAULT_SPECULAR_COEFFICIENT ) * ( pow( 1.0 - dotNL, 5.0 ) * pow( 1.0 - roughness, 2.0 ) );

}

#if NUM_RECT_AREA_LIGHTS > 0

	void RE_Direct_RectArea_Physical( const in RectAreaLight rectAreaLight, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {

		vec3 normal = geometry.normal;
		vec3 viewDir = geometry.viewDir;
		vec3 position = geometry.position;
		vec3 lightPos = rectAreaLight.position;
		vec3 halfWidth = rectAreaLight.halfWidth;
		vec3 halfHeight = rectAreaLight.halfHeight;
		vec3 lightColor = rectAreaLight.color;
		float roughness = material.specularRoughness;

		vec3 rectCoords[ 4 ];
		rectCoords[ 0 ] = lightPos + halfWidth - halfHeight; // counterclockwise; light shines in local neg z direction
		rectCoords[ 1 ] = lightPos - halfWidth - halfHeight;
		rectCoords[ 2 ] = lightPos - halfWidth + halfHeight;
		rectCoords[ 3 ] = lightPos + halfWidth + halfHeight;

		vec2 uv = LTC_Uv( normal, viewDir, roughness );

		vec4 t1 = texture2D( ltc_1, uv );
		vec4 t2 = texture2D( ltc_2, uv );

		mat3 mInv = mat3(
			vec3( t1.x, 0, t1.y ),
			vec3(    0, 1,    0 ),
			vec3( t1.z, 0, t1.w )
		);

		// LTC Fresnel Approximation by Stephen Hill
		// http://blog.selfshadow.com/publications/s2016-advances/s2016_ltc_fresnel.pdf
		vec3 fresnel = ( material.specularColor * t2.x + ( vec3( 1.0 ) - material.specularColor ) * t2.y );

		reflectedLight.directSpecular += lightColor * fresnel * LTC_Evaluate( normal, viewDir, position, mInv, rectCoords );

		reflectedLight.directDiffuse += lightColor * material.diffuseColor * LTC_Evaluate( normal, viewDir, position, mat3( 1.0 ), rectCoords );

	}

#endif

void RE_Direct_Physical( const in IncidentLight directLight, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {

	float dotNL = saturate( dot( geometry.normal, directLight.direction ) );

	vec3 irradiance = dotNL * directLight.color;

	#ifndef PHYSICALLY_CORRECT_LIGHTS

		irradiance *= PI; // punctual light

	#endif

	#ifndef STANDARD
		float clearCoatDHR = material.clearCoat * clearCoatDHRApprox( material.clearCoatRoughness, dotNL );
	#else
		float clearCoatDHR = 0.0;
	#endif

	reflectedLight.directSpecular += ( 1.0 - clearCoatDHR ) * irradiance * BRDF_Specular_GGX( directLight, geometry, material.specularColor, material.specularRoughness );

	reflectedLight.directDiffuse += ( 1.0 - clearCoatDHR ) * irradiance * BRDF_Diffuse_Lambert( material.diffuseColor );

	#ifndef STANDARD

		reflectedLight.directSpecular += irradiance * material.clearCoat * BRDF_Specular_GGX( directLight, geometry, vec3( DEFAULT_SPECULAR_COEFFICIENT ), material.clearCoatRoughness );

	#endif

}

void RE_IndirectDiffuse_Physical( const in vec3 irradiance, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {

	reflectedLight.indirectDiffuse += irradiance * BRDF_Diffuse_Lambert( material.diffuseColor );

}

void RE_IndirectSpecular_Physical( const in vec3 radiance, const in vec3 clearCoatRadiance, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {

	#ifndef STANDARD
		float dotNV = saturate( dot( geometry.normal, geometry.viewDir ) );
		float dotNL = dotNV;
		float clearCoatDHR = material.clearCoat * clearCoatDHRApprox( material.clearCoatRoughness, dotNL );
	#else
		float clearCoatDHR = 0.0;
	#endif

	reflectedLight.indirectSpecular += ( 1.0 - clearCoatDHR ) * radiance * BRDF_Specular_GGX_Environment( geometry, material.specularColor, material.specularRoughness );

	#ifndef STANDARD

		reflectedLight.indirectSpecular += clearCoatRadiance * material.clearCoat * BRDF_Specular_GGX_Environment( geometry, vec3( DEFAULT_SPECULAR_COEFFICIENT ), material.clearCoatRoughness );

	#endif

}

#define RE_Direct				RE_Direct_Physical
#define RE_Direct_RectArea		RE_Direct_RectArea_Physical
#define RE_IndirectDiffuse		RE_IndirectDiffuse_Physical
#define RE_IndirectSpecular		RE_IndirectSpecular_Physical

#define Material_BlinnShininessExponent( material )   GGXRoughnessToBlinnExponent( material.specularRoughness )
#define Material_ClearCoat_BlinnShininessExponent( material )   GGXRoughnessToBlinnExponent( material.clearCoatRoughness )

// ref: https://seblagarde.files.wordpress.com/2015/07/course_notes_moving_frostbite_to_pbr_v32.pdf
float computeSpecularOcclusion( const in float dotNV, const in float ambientOcclusion, const in float roughness ) {

	return saturate( pow( dotNV + ambientOcclusion, exp2( - 16.0 * roughness - 1.0 ) ) - 1.0 + ambientOcclusion );

}
`;var mu=`
/**
 * This is a template that can be used to light a material, it uses pluggable
 * RenderEquations (RE)for specific lighting scenarios.
 *
 * Instructions for use:
 * - Ensure that both RE_Direct, RE_IndirectDiffuse and RE_IndirectSpecular are defined
 * - If you have defined an RE_IndirectSpecular, you need to also provide a Material_LightProbeLOD. <---- ???
 * - Create a material parameter that is to be passed as the third parameter to your lighting functions.
 *
 * TODO:
 * - Add area light support.
 * - Add sphere light support.
 * - Add diffuse light probe (irradiance cubemap) support.
 */

GeometricContext geometry;

geometry.position = - vViewPosition;
geometry.normal = normal;
geometry.viewDir = normalize( vViewPosition );

IncidentLight directLight;

#if ( NUM_POINT_LIGHTS > 0 ) && defined( RE_Direct )

	PointLight pointLight;

	#pragma unroll_loop
	for ( int i = 0; i < NUM_POINT_LIGHTS; i ++ ) {

		pointLight = pointLights[ i ];

		getPointDirectLightIrradiance( pointLight, geometry, directLight );

		#ifdef USE_SHADOWMAP
		directLight.color *= all( bvec2( pointLight.shadow, directLight.visible ) ) ? getPointShadow( pointShadowMap[ i ], pointLight.shadowMapSize, pointLight.shadowBias, pointLight.shadowRadius, vPointShadowCoord[ i ], pointLight.shadowCameraNear, pointLight.shadowCameraFar ) : 1.0;
		#endif

		RE_Direct( directLight, geometry, material, reflectedLight );

	}

#endif

#if ( NUM_SPOT_LIGHTS > 0 ) && defined( RE_Direct )

	SpotLight spotLight;

	#pragma unroll_loop
	for ( int i = 0; i < NUM_SPOT_LIGHTS; i ++ ) {

		spotLight = spotLights[ i ];

		getSpotDirectLightIrradiance( spotLight, geometry, directLight );

		#ifdef USE_SHADOWMAP
		directLight.color *= all( bvec2( spotLight.shadow, directLight.visible ) ) ? getShadow( spotShadowMap[ i ], spotLight.shadowMapSize, spotLight.shadowBias, spotLight.shadowRadius, vSpotShadowCoord[ i ] ) : 1.0;
		#endif

		RE_Direct( directLight, geometry, material, reflectedLight );

	}

#endif

#if ( NUM_DIR_LIGHTS > 0 ) && defined( RE_Direct )

	DirectionalLight directionalLight;

	#pragma unroll_loop
	for ( int i = 0; i < NUM_DIR_LIGHTS; i ++ ) {

		directionalLight = directionalLights[ i ];

		getDirectionalDirectLightIrradiance( directionalLight, geometry, directLight );

		#ifdef USE_SHADOWMAP
		directLight.color *= all( bvec2( directionalLight.shadow, directLight.visible ) ) ? getShadow( directionalShadowMap[ i ], directionalLight.shadowMapSize, directionalLight.shadowBias, directionalLight.shadowRadius, vDirectionalShadowCoord[ i ] ) : 1.0;
		#endif

		RE_Direct( directLight, geometry, material, reflectedLight );

	}

#endif

#if ( NUM_RECT_AREA_LIGHTS > 0 ) && defined( RE_Direct_RectArea )

	RectAreaLight rectAreaLight;

	#pragma unroll_loop
	for ( int i = 0; i < NUM_RECT_AREA_LIGHTS; i ++ ) {

		rectAreaLight = rectAreaLights[ i ];
		RE_Direct_RectArea( rectAreaLight, geometry, material, reflectedLight );

	}

#endif

#if defined( RE_IndirectDiffuse )

	vec3 irradiance = getAmbientLightIrradiance( ambientLightColor );

	#if ( NUM_HEMI_LIGHTS > 0 )

		#pragma unroll_loop
		for ( int i = 0; i < NUM_HEMI_LIGHTS; i ++ ) {

			irradiance += getHemisphereLightIrradiance( hemisphereLights[ i ], geometry );

		}

	#endif

#endif

#if defined( RE_IndirectSpecular )

	vec3 radiance = vec3( 0.0 );
	vec3 clearCoatRadiance = vec3( 0.0 );

#endif
`;var vu=`
#if defined( RE_IndirectDiffuse )

	#ifdef USE_LIGHTMAP

		vec3 lightMapIrradiance = texture2D( lightMap, vUv2 ).xyz * lightMapIntensity;

		#ifndef PHYSICALLY_CORRECT_LIGHTS

			lightMapIrradiance *= PI; // factor of PI should not be present; included here to prevent breakage

		#endif

		irradiance += lightMapIrradiance;

	#endif

	#if defined( USE_ENVMAP ) && defined( PHYSICAL ) && defined( ENVMAP_TYPE_CUBE_UV )

		irradiance += getLightProbeIndirectIrradiance( /*lightProbe,*/ geometry, maxMipLevel );

	#endif

#endif

#if defined( USE_ENVMAP ) && defined( RE_IndirectSpecular )

	radiance += getLightProbeIndirectRadiance( /*specularLightProbe,*/ geometry, Material_BlinnShininessExponent( material ), maxMipLevel );

	#ifndef STANDARD
		clearCoatRadiance += getLightProbeIndirectRadiance( /*specularLightProbe,*/ geometry, Material_ClearCoat_BlinnShininessExponent( material ), maxMipLevel );
	#endif

#endif
`;var gu=`
#if defined( RE_IndirectDiffuse )

	RE_IndirectDiffuse( irradiance, geometry, material, reflectedLight );

#endif

#if defined( RE_IndirectSpecular )

	RE_IndirectSpecular( radiance, clearCoatRadiance, geometry, material, reflectedLight );

#endif
`;var yu=`
#if defined( USE_LOGDEPTHBUF ) && defined( USE_LOGDEPTHBUF_EXT )

	gl_FragDepthEXT = log2( vFragDepth ) * logDepthBufFC * 0.5;

#endif
`;var xu=`
#if defined( USE_LOGDEPTHBUF ) && defined( USE_LOGDEPTHBUF_EXT )

	uniform float logDepthBufFC;
	varying float vFragDepth;

#endif
`;var _u=`
#ifdef USE_LOGDEPTHBUF

	#ifdef USE_LOGDEPTHBUF_EXT

		varying float vFragDepth;

	#else

		uniform float logDepthBufFC;

	#endif

#endif
`;var bu=`
#ifdef USE_LOGDEPTHBUF

	#ifdef USE_LOGDEPTHBUF_EXT

		vFragDepth = 1.0 + gl_Position.w;

	#else

		gl_Position.z = log2( max( EPSILON, gl_Position.w + 1.0 ) ) * logDepthBufFC - 1.0;

		gl_Position.z *= gl_Position.w;

	#endif

#endif
`;var wu=`
#ifdef USE_MAP

	vec4 texelColor = texture2D( map, vUv );

	texelColor = mapTexelToLinear( texelColor );
	diffuseColor *= texelColor;

#endif
`;var Mu=`
#ifdef USE_MAP

	uniform sampler2D map;

#endif
`;var Eu=`
#ifdef USE_MAP

	vec2 uv = ( uvTransform * vec3( gl_PointCoord.x, 1.0 - gl_PointCoord.y, 1 ) ).xy;
	vec4 mapTexel = texture2D( map, uv );
	diffuseColor *= mapTexelToLinear( mapTexel );

#endif
`;var Tu=`
#ifdef USE_MAP

	uniform mat3 uvTransform;
	uniform sampler2D map;

#endif
`;var Su=`
float metalnessFactor = metalness;

#ifdef USE_METALNESSMAP

	vec4 texelMetalness = texture2D( metalnessMap, vUv );

	// reads channel B, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
	metalnessFactor *= texelMetalness.b;

#endif
`;var Au=`
#ifdef USE_METALNESSMAP

	uniform sampler2D metalnessMap;

#endif
`;var Lu=`
#ifdef USE_MORPHNORMALS

	objectNormal += ( morphNormal0 - normal ) * morphTargetInfluences[ 0 ];
	objectNormal += ( morphNormal1 - normal ) * morphTargetInfluences[ 1 ];
	objectNormal += ( morphNormal2 - normal ) * morphTargetInfluences[ 2 ];
	objectNormal += ( morphNormal3 - normal ) * morphTargetInfluences[ 3 ];

#endif
`;var Ru=`
#ifdef USE_MORPHTARGETS

	#ifndef USE_MORPHNORMALS

	uniform float morphTargetInfluences[ 8 ];

	#else

	uniform float morphTargetInfluences[ 4 ];

	#endif

#endif
`;var Cu=`
#ifdef USE_MORPHTARGETS

	transformed += ( morphTarget0 - position ) * morphTargetInfluences[ 0 ];
	transformed += ( morphTarget1 - position ) * morphTargetInfluences[ 1 ];
	transformed += ( morphTarget2 - position ) * morphTargetInfluences[ 2 ];
	transformed += ( morphTarget3 - position ) * morphTargetInfluences[ 3 ];

	#ifndef USE_MORPHNORMALS

	transformed += ( morphTarget4 - position ) * morphTargetInfluences[ 4 ];
	transformed += ( morphTarget5 - position ) * morphTargetInfluences[ 5 ];
	transformed += ( morphTarget6 - position ) * morphTargetInfluences[ 6 ];
	transformed += ( morphTarget7 - position ) * morphTargetInfluences[ 7 ];

	#endif

#endif
`;var Pu=`
#ifdef FLAT_SHADED

	// Workaround for Adreno/Nexus5 not able able to do dFdx( vViewPosition ) ...

	vec3 fdx = vec3( dFdx( vViewPosition.x ), dFdx( vViewPosition.y ), dFdx( vViewPosition.z ) );
	vec3 fdy = vec3( dFdy( vViewPosition.x ), dFdy( vViewPosition.y ), dFdy( vViewPosition.z ) );
	vec3 normal = normalize( cross( fdx, fdy ) );

#else

	vec3 normal = normalize( vNormal );

	#ifdef DOUBLE_SIDED

		normal = normal * ( float( gl_FrontFacing ) * 2.0 - 1.0 );

	#endif

#endif
`;var Bu=`
#ifdef USE_NORMALMAP

	#ifdef OBJECTSPACE_NORMALMAP

		normal = texture2D( normalMap, vUv ).xyz * 2.0 - 1.0; // overrides both flatShading and attribute normals

		#ifdef FLIP_SIDED

			normal = - normal;

		#endif

		#ifdef DOUBLE_SIDED

			normal = normal * ( float( gl_FrontFacing ) * 2.0 - 1.0 );

		#endif

		normal = normalize( normalMatrix * normal );

	#else // tangent-space normal map

		normal = perturbNormal2Arb( -vViewPosition, normal );

	#endif

#elif defined( USE_BUMPMAP )

	normal = perturbNormalArb( -vViewPosition, normal, dHdxy_fwd() );

#endif
`;var Fu=`
#ifdef USE_NORMALMAP

	uniform sampler2D normalMap;
	uniform vec2 normalScale;

	#ifdef OBJECTSPACE_NORMALMAP

		uniform mat3 normalMatrix;

	#else

		// Per-Pixel Tangent Space Normal Mapping
		// http://hacksoflife.blogspot.ch/2009/11/per-pixel-tangent-space-normal-mapping.html

		vec3 perturbNormal2Arb( vec3 eye_pos, vec3 surf_norm ) {

			// Workaround for Adreno 3XX dFd*( vec3 ) bug. See #9988

			vec3 q0 = vec3( dFdx( eye_pos.x ), dFdx( eye_pos.y ), dFdx( eye_pos.z ) );
			vec3 q1 = vec3( dFdy( eye_pos.x ), dFdy( eye_pos.y ), dFdy( eye_pos.z ) );
			vec2 st0 = dFdx( vUv.st );
			vec2 st1 = dFdy( vUv.st );

			float scale = sign( st1.t * st0.s - st0.t * st1.s ); // we do not care about the magnitude

			vec3 S = normalize( ( q0 * st1.t - q1 * st0.t ) * scale );
			vec3 T = normalize( ( - q0 * st1.s + q1 * st0.s ) * scale );
			vec3 N = normalize( surf_norm );
			mat3 tsn = mat3( S, T, N );

			vec3 mapN = texture2D( normalMap, vUv ).xyz * 2.0 - 1.0;

			mapN.xy *= normalScale;
			mapN.xy *= ( float( gl_FrontFacing ) * 2.0 - 1.0 );

			return normalize( tsn * mapN );

		}

	#endif

#endif
`;var Du=`
vec3 packNormalToRGB( const in vec3 normal ) {
	return normalize( normal ) * 0.5 + 0.5;
}

vec3 unpackRGBToNormal( const in vec3 rgb ) {
	return 2.0 * rgb.xyz - 1.0;
}

const float PackUpscale = 256. / 255.; // fraction -> 0..1 (including 1)
const float UnpackDownscale = 255. / 256.; // 0..1 -> fraction (excluding 1)

const vec3 PackFactors = vec3( 256. * 256. * 256., 256. * 256.,  256. );
const vec4 UnpackFactors = UnpackDownscale / vec4( PackFactors, 1. );

const float ShiftRight8 = 1. / 256.;

vec4 packDepthToRGBA( const in float v ) {
	vec4 r = vec4( fract( v * PackFactors ), v );
	r.yzw -= r.xyz * ShiftRight8; // tidy overflow
	return r * PackUpscale;
}

float unpackRGBAToDepth( const in vec4 v ) {
	return dot( v, UnpackFactors );
}

// NOTE: viewZ/eyeZ is < 0 when in front of the camera per OpenGL conventions

float viewZToOrthographicDepth( const in float viewZ, const in float near, const in float far ) {
	return ( viewZ + near ) / ( near - far );
}
float orthographicDepthToViewZ( const in float linearClipZ, const in float near, const in float far ) {
	return linearClipZ * ( near - far ) - near;
}

float viewZToPerspectiveDepth( const in float viewZ, const in float near, const in float far ) {
	return (( near + viewZ ) * far ) / (( far - near ) * viewZ );
}
float perspectiveDepthToViewZ( const in float invClipZ, const in float near, const in float far ) {
	return ( near * far ) / ( ( far - near ) * invClipZ - far );
}
`;var Iu=`
#ifdef PREMULTIPLIED_ALPHA

	// Get get normal blending with premultipled, use with CustomBlending, OneFactor, OneMinusSrcAlphaFactor, AddEquation.
	gl_FragColor.rgb *= gl_FragColor.a;

#endif
`;var Ou=`
vec4 mvPosition = modelViewMatrix * vec4( transformed, 1.0 );

gl_Position = projectionMatrix * mvPosition;
`;var Uu=`
#if defined( DITHERING )

  gl_FragColor.rgb = dithering( gl_FragColor.rgb );

#endif
`;var Nu=`
#if defined( DITHERING )

	// based on https://www.shadertoy.com/view/MslGR8
	vec3 dithering( vec3 color ) {
		//Calculate grid position
		float grid_position = rand( gl_FragCoord.xy );

		//Shift the individual colors differently, thus making it even harder to see the dithering pattern
		vec3 dither_shift_RGB = vec3( 0.25 / 255.0, -0.25 / 255.0, 0.25 / 255.0 );

		//modify shift acording to grid position.
		dither_shift_RGB = mix( 2.0 * dither_shift_RGB, -2.0 * dither_shift_RGB, grid_position );

		//shift the color by dither_shift
		return color + dither_shift_RGB;
	}

#endif
`;var Gu=`
float roughnessFactor = roughness;

#ifdef USE_ROUGHNESSMAP

	vec4 texelRoughness = texture2D( roughnessMap, vUv );

	// reads channel G, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
	roughnessFactor *= texelRoughness.g;

#endif
`;var zu=`
#ifdef USE_ROUGHNESSMAP

	uniform sampler2D roughnessMap;

#endif
`;var Hu=`
#ifdef USE_SHADOWMAP

	#if NUM_DIR_LIGHTS > 0

		uniform sampler2D directionalShadowMap[ NUM_DIR_LIGHTS ];
		varying vec4 vDirectionalShadowCoord[ NUM_DIR_LIGHTS ];

	#endif

	#if NUM_SPOT_LIGHTS > 0

		uniform sampler2D spotShadowMap[ NUM_SPOT_LIGHTS ];
		varying vec4 vSpotShadowCoord[ NUM_SPOT_LIGHTS ];

	#endif

	#if NUM_POINT_LIGHTS > 0

		uniform sampler2D pointShadowMap[ NUM_POINT_LIGHTS ];
		varying vec4 vPointShadowCoord[ NUM_POINT_LIGHTS ];

	#endif

	/*
	#if NUM_RECT_AREA_LIGHTS > 0

		// TODO (abelnation): create uniforms for area light shadows

	#endif
	*/

	float texture2DCompare( sampler2D depths, vec2 uv, float compare ) {

		return step( compare, unpackRGBAToDepth( texture2D( depths, uv ) ) );

	}

	float texture2DShadowLerp( sampler2D depths, vec2 size, vec2 uv, float compare ) {

		const vec2 offset = vec2( 0.0, 1.0 );

		vec2 texelSize = vec2( 1.0 ) / size;
		vec2 centroidUV = floor( uv * size + 0.5 ) / size;

		float lb = texture2DCompare( depths, centroidUV + texelSize * offset.xx, compare );
		float lt = texture2DCompare( depths, centroidUV + texelSize * offset.xy, compare );
		float rb = texture2DCompare( depths, centroidUV + texelSize * offset.yx, compare );
		float rt = texture2DCompare( depths, centroidUV + texelSize * offset.yy, compare );

		vec2 f = fract( uv * size + 0.5 );

		float a = mix( lb, lt, f.y );
		float b = mix( rb, rt, f.y );
		float c = mix( a, b, f.x );

		return c;

	}

	float getShadow( sampler2D shadowMap, vec2 shadowMapSize, float shadowBias, float shadowRadius, vec4 shadowCoord ) {

		float shadow = 1.0;

		shadowCoord.xyz /= shadowCoord.w;
		shadowCoord.z += shadowBias;

		// if ( something && something ) breaks ATI OpenGL shader compiler
		// if ( all( something, something ) ) using this instead

		bvec4 inFrustumVec = bvec4 ( shadowCoord.x >= 0.0, shadowCoord.x <= 1.0, shadowCoord.y >= 0.0, shadowCoord.y <= 1.0 );
		bool inFrustum = all( inFrustumVec );

		bvec2 frustumTestVec = bvec2( inFrustum, shadowCoord.z <= 1.0 );

		bool frustumTest = all( frustumTestVec );

		if ( frustumTest ) {

		#if defined( SHADOWMAP_TYPE_PCF )

			vec2 texelSize = vec2( 1.0 ) / shadowMapSize;

			float dx0 = - texelSize.x * shadowRadius;
			float dy0 = - texelSize.y * shadowRadius;
			float dx1 = + texelSize.x * shadowRadius;
			float dy1 = + texelSize.y * shadowRadius;

			shadow = (
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, dy0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, dy0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, 0.0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy, shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, 0.0 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, dy1 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy1 ), shadowCoord.z ) +
				texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, dy1 ), shadowCoord.z )
			) * ( 1.0 / 9.0 );

		#elif defined( SHADOWMAP_TYPE_PCF_SOFT )

			vec2 texelSize = vec2( 1.0 ) / shadowMapSize;

			float dx0 = - texelSize.x * shadowRadius;
			float dy0 = - texelSize.y * shadowRadius;
			float dx1 = + texelSize.x * shadowRadius;
			float dy1 = + texelSize.y * shadowRadius;

			shadow = (
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy + vec2( dx0, dy0 ), shadowCoord.z ) +
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy + vec2( 0.0, dy0 ), shadowCoord.z ) +
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy + vec2( dx1, dy0 ), shadowCoord.z ) +
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy + vec2( dx0, 0.0 ), shadowCoord.z ) +
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy, shadowCoord.z ) +
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy + vec2( dx1, 0.0 ), shadowCoord.z ) +
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy + vec2( dx0, dy1 ), shadowCoord.z ) +
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy + vec2( 0.0, dy1 ), shadowCoord.z ) +
				texture2DShadowLerp( shadowMap, shadowMapSize, shadowCoord.xy + vec2( dx1, dy1 ), shadowCoord.z )
			) * ( 1.0 / 9.0 );

		#else // no percentage-closer filtering:

			shadow = texture2DCompare( shadowMap, shadowCoord.xy, shadowCoord.z );

		#endif

		}

		return shadow;

	}

	// cubeToUV() maps a 3D direction vector suitable for cube texture mapping to a 2D
	// vector suitable for 2D texture mapping. This code uses the following layout for the
	// 2D texture:
	//
	// xzXZ
	//  y Y
	//
	// Y - Positive y direction
	// y - Negative y direction
	// X - Positive x direction
	// x - Negative x direction
	// Z - Positive z direction
	// z - Negative z direction
	//
	// Source and test bed:
	// https://gist.github.com/tschw/da10c43c467ce8afd0c4

	vec2 cubeToUV( vec3 v, float texelSizeY ) {

		// Number of texels to avoid at the edge of each square

		vec3 absV = abs( v );

		// Intersect unit cube

		float scaleToCube = 1.0 / max( absV.x, max( absV.y, absV.z ) );
		absV *= scaleToCube;

		// Apply scale to avoid seams

		// two texels less per square (one texel will do for NEAREST)
		v *= scaleToCube * ( 1.0 - 2.0 * texelSizeY );

		// Unwrap

		// space: -1 ... 1 range for each square
		//
		// #X##		dim    := ( 4 , 2 )
		//  # #		center := ( 1 , 1 )

		vec2 planar = v.xy;

		float almostATexel = 1.5 * texelSizeY;
		float almostOne = 1.0 - almostATexel;

		if ( absV.z >= almostOne ) {

			if ( v.z > 0.0 )
				planar.x = 4.0 - v.x;

		} else if ( absV.x >= almostOne ) {

			float signX = sign( v.x );
			planar.x = v.z * signX + 2.0 * signX;

		} else if ( absV.y >= almostOne ) {

			float signY = sign( v.y );
			planar.x = v.x + 2.0 * signY + 2.0;
			planar.y = v.z * signY - 2.0;

		}

		// Transform to UV space

		// scale := 0.5 / dim
		// translate := ( center + 0.5 ) / dim
		return vec2( 0.125, 0.25 ) * planar + vec2( 0.375, 0.75 );

	}

	float getPointShadow( sampler2D shadowMap, vec2 shadowMapSize, float shadowBias, float shadowRadius, vec4 shadowCoord, float shadowCameraNear, float shadowCameraFar ) {

		vec2 texelSize = vec2( 1.0 ) / ( shadowMapSize * vec2( 4.0, 2.0 ) );

		// for point lights, the uniform @vShadowCoord is re-purposed to hold
		// the vector from the light to the world-space position of the fragment.
		vec3 lightToPosition = shadowCoord.xyz;

		// dp = normalized distance from light to fragment position
		float dp = ( length( lightToPosition ) - shadowCameraNear ) / ( shadowCameraFar - shadowCameraNear ); // need to clamp?
		dp += shadowBias;

		// bd3D = base direction 3D
		vec3 bd3D = normalize( lightToPosition );

		#if defined( SHADOWMAP_TYPE_PCF ) || defined( SHADOWMAP_TYPE_PCF_SOFT )

			vec2 offset = vec2( - 1, 1 ) * shadowRadius * texelSize.y;

			return (
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xyy, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yyy, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xyx, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yyx, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xxy, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yxy, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xxx, texelSize.y ), dp ) +
				texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yxx, texelSize.y ), dp )
			) * ( 1.0 / 9.0 );

		#else // no percentage-closer filtering

			return texture2DCompare( shadowMap, cubeToUV( bd3D, texelSize.y ), dp );

		#endif

	}

#endif
`;var Vu=`
#ifdef USE_SHADOWMAP

	#if NUM_DIR_LIGHTS > 0

		uniform mat4 directionalShadowMatrix[ NUM_DIR_LIGHTS ];
		varying vec4 vDirectionalShadowCoord[ NUM_DIR_LIGHTS ];

	#endif

	#if NUM_SPOT_LIGHTS > 0

		uniform mat4 spotShadowMatrix[ NUM_SPOT_LIGHTS ];
		varying vec4 vSpotShadowCoord[ NUM_SPOT_LIGHTS ];

	#endif

	#if NUM_POINT_LIGHTS > 0

		uniform mat4 pointShadowMatrix[ NUM_POINT_LIGHTS ];
		varying vec4 vPointShadowCoord[ NUM_POINT_LIGHTS ];

	#endif

	/*
	#if NUM_RECT_AREA_LIGHTS > 0

		// TODO (abelnation): uniforms for area light shadows

	#endif
	*/

#endif
`;var ku=`
#ifdef USE_SHADOWMAP

	#if NUM_DIR_LIGHTS > 0

	#pragma unroll_loop
	for ( int i = 0; i < NUM_DIR_LIGHTS; i ++ ) {

		vDirectionalShadowCoord[ i ] = directionalShadowMatrix[ i ] * worldPosition;

	}

	#endif

	#if NUM_SPOT_LIGHTS > 0

	#pragma unroll_loop
	for ( int i = 0; i < NUM_SPOT_LIGHTS; i ++ ) {

		vSpotShadowCoord[ i ] = spotShadowMatrix[ i ] * worldPosition;

	}

	#endif

	#if NUM_POINT_LIGHTS > 0

	#pragma unroll_loop
	for ( int i = 0; i < NUM_POINT_LIGHTS; i ++ ) {

		vPointShadowCoord[ i ] = pointShadowMatrix[ i ] * worldPosition;

	}

	#endif

	/*
	#if NUM_RECT_AREA_LIGHTS > 0

		// TODO (abelnation): update vAreaShadowCoord with area light info

	#endif
	*/

#endif
`;var Wu=`
float getShadowMask() {

	float shadow = 1.0;

	#ifdef USE_SHADOWMAP

	#if NUM_DIR_LIGHTS > 0

	DirectionalLight directionalLight;

	#pragma unroll_loop
	for ( int i = 0; i < NUM_DIR_LIGHTS; i ++ ) {

		directionalLight = directionalLights[ i ];
		shadow *= bool( directionalLight.shadow ) ? getShadow( directionalShadowMap[ i ], directionalLight.shadowMapSize, directionalLight.shadowBias, directionalLight.shadowRadius, vDirectionalShadowCoord[ i ] ) : 1.0;

	}

	#endif

	#if NUM_SPOT_LIGHTS > 0

	SpotLight spotLight;

	#pragma unroll_loop
	for ( int i = 0; i < NUM_SPOT_LIGHTS; i ++ ) {

		spotLight = spotLights[ i ];
		shadow *= bool( spotLight.shadow ) ? getShadow( spotShadowMap[ i ], spotLight.shadowMapSize, spotLight.shadowBias, spotLight.shadowRadius, vSpotShadowCoord[ i ] ) : 1.0;

	}

	#endif

	#if NUM_POINT_LIGHTS > 0

	PointLight pointLight;

	#pragma unroll_loop
	for ( int i = 0; i < NUM_POINT_LIGHTS; i ++ ) {

		pointLight = pointLights[ i ];
		shadow *= bool( pointLight.shadow ) ? getPointShadow( pointShadowMap[ i ], pointLight.shadowMapSize, pointLight.shadowBias, pointLight.shadowRadius, vPointShadowCoord[ i ], pointLight.shadowCameraNear, pointLight.shadowCameraFar ) : 1.0;

	}

	#endif

	/*
	#if NUM_RECT_AREA_LIGHTS > 0

		// TODO (abelnation): update shadow for Area light

	#endif
	*/

	#endif

	return shadow;

}
`;var Xu=`
#ifdef USE_SKINNING

	mat4 boneMatX = getBoneMatrix( skinIndex.x );
	mat4 boneMatY = getBoneMatrix( skinIndex.y );
	mat4 boneMatZ = getBoneMatrix( skinIndex.z );
	mat4 boneMatW = getBoneMatrix( skinIndex.w );

#endif
`;var ju=`
#ifdef USE_SKINNING

	uniform mat4 bindMatrix;
	uniform mat4 bindMatrixInverse;

	#ifdef BONE_TEXTURE

		uniform sampler2D boneTexture;
		uniform int boneTextureSize;

		mat4 getBoneMatrix( const in float i ) {

			float j = i * 4.0;
			float x = mod( j, float( boneTextureSize ) );
			float y = floor( j / float( boneTextureSize ) );

			float dx = 1.0 / float( boneTextureSize );
			float dy = 1.0 / float( boneTextureSize );

			y = dy * ( y + 0.5 );

			vec4 v1 = texture2D( boneTexture, vec2( dx * ( x + 0.5 ), y ) );
			vec4 v2 = texture2D( boneTexture, vec2( dx * ( x + 1.5 ), y ) );
			vec4 v3 = texture2D( boneTexture, vec2( dx * ( x + 2.5 ), y ) );
			vec4 v4 = texture2D( boneTexture, vec2( dx * ( x + 3.5 ), y ) );

			mat4 bone = mat4( v1, v2, v3, v4 );

			return bone;

		}

	#else

		uniform mat4 boneMatrices[ MAX_BONES ];

		mat4 getBoneMatrix( const in float i ) {

			mat4 bone = boneMatrices[ int(i) ];
			return bone;

		}

	#endif

#endif
`;var qu=`
#ifdef USE_SKINNING

	vec4 skinVertex = bindMatrix * vec4( transformed, 1.0 );

	vec4 skinned = vec4( 0.0 );
	skinned += boneMatX * skinVertex * skinWeight.x;
	skinned += boneMatY * skinVertex * skinWeight.y;
	skinned += boneMatZ * skinVertex * skinWeight.z;
	skinned += boneMatW * skinVertex * skinWeight.w;

	transformed = ( bindMatrixInverse * skinned ).xyz;

#endif
`;var Yu=`
#ifdef USE_SKINNING

	mat4 skinMatrix = mat4( 0.0 );
	skinMatrix += skinWeight.x * boneMatX;
	skinMatrix += skinWeight.y * boneMatY;
	skinMatrix += skinWeight.z * boneMatZ;
	skinMatrix += skinWeight.w * boneMatW;
	skinMatrix  = bindMatrixInverse * skinMatrix * bindMatrix;

	objectNormal = vec4( skinMatrix * vec4( objectNormal, 0.0 ) ).xyz;

#endif
`;var Zu=`
float specularStrength;

#ifdef USE_SPECULARMAP

	vec4 texelSpecular = texture2D( specularMap, vUv );
	specularStrength = texelSpecular.r;

#else

	specularStrength = 1.0;

#endif
`;var Ju=`
#ifdef USE_SPECULARMAP

	uniform sampler2D specularMap;

#endif
`;var Qu=`
#if defined( TONE_MAPPING )

  gl_FragColor.rgb = toneMapping( gl_FragColor.rgb );

#endif
`;var Ku=`
#ifndef saturate
	#define saturate(a) clamp( a, 0.0, 1.0 )
#endif

uniform float toneMappingExposure;
uniform float toneMappingWhitePoint;

// exposure only
vec3 LinearToneMapping( vec3 color ) {

	return toneMappingExposure * color;

}

// source: https://www.cs.utah.edu/~reinhard/cdrom/
vec3 ReinhardToneMapping( vec3 color ) {

	color *= toneMappingExposure;
	return saturate( color / ( vec3( 1.0 ) + color ) );

}

// source: http://filmicgames.com/archives/75
#define Uncharted2Helper( x ) max( ( ( x * ( 0.15 * x + 0.10 * 0.50 ) + 0.20 * 0.02 ) / ( x * ( 0.15 * x + 0.50 ) + 0.20 * 0.30 ) ) - 0.02 / 0.30, vec3( 0.0 ) )
vec3 Uncharted2ToneMapping( vec3 color ) {

	// John Hable's filmic operator from Uncharted 2 video game
	color *= toneMappingExposure;
	return saturate( Uncharted2Helper( color ) / Uncharted2Helper( vec3( toneMappingWhitePoint ) ) );

}

// source: http://filmicgames.com/archives/75
vec3 OptimizedCineonToneMapping( vec3 color ) {

	// optimized filmic operator by Jim Hejl and Richard Burgess-Dawson
	color *= toneMappingExposure;
	color = max( vec3( 0.0 ), color - 0.004 );
	return pow( ( color * ( 6.2 * color + 0.5 ) ) / ( color * ( 6.2 * color + 1.7 ) + 0.06 ), vec3( 2.2 ) );

}

// source: https://knarkowicz.wordpress.com/2016/01/06/aces-filmic-tone-mapping-curve/
vec3 ACESFilmicToneMapping( vec3 color ) {

	color *= toneMappingExposure;
	return saturate( ( color * ( 2.51 * color + 0.03 ) ) / ( color * ( 2.43 * color + 0.59 ) + 0.14 ) );

}
`;var $u=`
#if defined( USE_MAP ) || defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( USE_SPECULARMAP ) || defined( USE_ALPHAMAP ) || defined( USE_EMISSIVEMAP ) || defined( USE_ROUGHNESSMAP ) || defined( USE_METALNESSMAP )

	varying vec2 vUv;

#endif
`;var ec=`
#if defined( USE_MAP ) || defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( USE_SPECULARMAP ) || defined( USE_ALPHAMAP ) || defined( USE_EMISSIVEMAP ) || defined( USE_ROUGHNESSMAP ) || defined( USE_METALNESSMAP )

	varying vec2 vUv;
	uniform mat3 uvTransform;

#endif
`;var tc=`
#if defined( USE_MAP ) || defined( USE_BUMPMAP ) || defined( USE_NORMALMAP ) || defined( USE_SPECULARMAP ) || defined( USE_ALPHAMAP ) || defined( USE_EMISSIVEMAP ) || defined( USE_ROUGHNESSMAP ) || defined( USE_METALNESSMAP )

	vUv = ( uvTransform * vec3( uv, 1 ) ).xy;

#endif
`;var rc=`
#if defined( USE_LIGHTMAP ) || defined( USE_AOMAP )

	varying vec2 vUv2;

#endif
`;var ic=`
#if defined( USE_LIGHTMAP ) || defined( USE_AOMAP )

	attribute vec2 uv2;
	varying vec2 vUv2;

#endif
`;var nc=`
#if defined( USE_LIGHTMAP ) || defined( USE_AOMAP )

	vUv2 = uv2;

#endif
`;var oc=`
#if defined( USE_ENVMAP ) || defined( DISTANCE ) || defined ( USE_SHADOWMAP )

	vec4 worldPosition = modelMatrix * vec4( transformed, 1.0 );

#endif
`;var ac=`
uniform sampler2D t2D;

varying vec2 vUv;

void main() {

	vec4 texColor = texture2D( t2D, vUv );

	gl_FragColor = mapTexelToLinear( texColor );

	#include <tonemapping_fragment>
	#include <encodings_fragment>

}
`;var sc=`
varying vec2 vUv;
uniform mat3 uvTransform;

void main() {

	vUv = ( uvTransform * vec3( uv, 1 ) ).xy;

	gl_Position = vec4( position.xy, 1.0, 1.0 );

}
`;var fc=`
uniform samplerCube tCube;
uniform float tFlip;
uniform float opacity;

varying vec3 vWorldDirection;

void main() {

	vec4 texColor = textureCube( tCube, vec3( tFlip * vWorldDirection.x, vWorldDirection.yz ) );

	gl_FragColor = mapTexelToLinear( texColor );
	gl_FragColor.a *= opacity;

	#include <tonemapping_fragment>
	#include <encodings_fragment>

}
`;var uc=`
varying vec3 vWorldDirection;

#include <common>

void main() {

	vWorldDirection = transformDirection( position, modelMatrix );

	#include <begin_vertex>
	#include <project_vertex>

	gl_Position.z = gl_Position.w; // set z to camera.far

}
`;var cc=`
#if DEPTH_PACKING == 3200

	uniform float opacity;

#endif

#include <common>
#include <packing>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( 1.0 );

	#if DEPTH_PACKING == 3200

		diffuseColor.a = opacity;

	#endif

	#include <map_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>

	#include <logdepthbuf_fragment>

	#if DEPTH_PACKING == 3200

		gl_FragColor = vec4( vec3( 1.0 - gl_FragCoord.z ), opacity );

	#elif DEPTH_PACKING == 3201

		gl_FragColor = packDepthToRGBA( gl_FragCoord.z );

	#endif

}
`;var hc=`
#include <common>
#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex>

	#include <skinbase_vertex>

	#ifdef USE_DISPLACEMENTMAP

		#include <beginnormal_vertex>
		#include <morphnormal_vertex>
		#include <skinnormal_vertex>

	#endif

	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>

}
`;var lc=`
#define DISTANCE

uniform vec3 referencePosition;
uniform float nearDistance;
uniform float farDistance;
varying vec3 vWorldPosition;

#include <common>
#include <packing>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <clipping_planes_pars_fragment>

void main () {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( 1.0 );

	#include <map_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>

	float dist = length( vWorldPosition - referencePosition );
	dist = ( dist - nearDistance ) / ( farDistance - nearDistance );
	dist = saturate( dist ); // clamp to [ 0, 1 ]

	gl_FragColor = packDepthToRGBA( dist );

}
`;var pc=`
#define DISTANCE

varying vec3 vWorldPosition;

#include <common>
#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex>

	#include <skinbase_vertex>

	#ifdef USE_DISPLACEMENTMAP

		#include <beginnormal_vertex>
		#include <morphnormal_vertex>
		#include <skinnormal_vertex>

	#endif

	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <worldpos_vertex>
	#include <clipping_planes_vertex>

	vWorldPosition = worldPosition.xyz;

}
`;var dc=`
uniform sampler2D tEquirect;

varying vec3 vWorldDirection;

#include <common>

void main() {

	vec3 direction = normalize( vWorldDirection );

	vec2 sampleUV;

	sampleUV.y = asin( clamp( direction.y, - 1.0, 1.0 ) ) * RECIPROCAL_PI + 0.5;

	sampleUV.x = atan( direction.z, direction.x ) * RECIPROCAL_PI2 + 0.5;

	vec4 texColor = texture2D( tEquirect, sampleUV );

	gl_FragColor = mapTexelToLinear( texColor );

	#include <tonemapping_fragment>
	#include <encodings_fragment>

}
`;var mc=`
varying vec3 vWorldDirection;

#include <common>

void main() {

	vWorldDirection = transformDirection( position, modelMatrix );

	#include <begin_vertex>
	#include <project_vertex>

}
`;var vc=`
uniform vec3 diffuse;
uniform float opacity;

uniform float dashSize;
uniform float totalSize;

varying float vLineDistance;

#include <common>
#include <color_pars_fragment>
#include <fog_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	if ( mod( vLineDistance, totalSize ) > dashSize ) {

		discard;

	}

	vec3 outgoingLight = vec3( 0.0 );
	vec4 diffuseColor = vec4( diffuse, opacity );

	#include <logdepthbuf_fragment>
	#include <color_fragment>

	outgoingLight = diffuseColor.rgb; // simple shader

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <premultiplied_alpha_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>

}
`;var gc=`
uniform float scale;
attribute float lineDistance;

varying float vLineDistance;

#include <common>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <color_vertex>

	vLineDistance = scale * lineDistance;

	vec4 mvPosition = modelViewMatrix * vec4( position, 1.0 );
	gl_Position = projectionMatrix * mvPosition;

	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <fog_vertex>

}
`;var yc=`
uniform vec3 diffuse;
uniform float opacity;

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <common>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <envmap_pars_fragment>
#include <fog_pars_fragment>
#include <specularmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( diffuse, opacity );

	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <specularmap_fragment>

	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );

	// accumulation (baked indirect lighting only)
	#ifdef USE_LIGHTMAP

		reflectedLight.indirectDiffuse += texture2D( lightMap, vUv2 ).xyz * lightMapIntensity;

	#else

		reflectedLight.indirectDiffuse += vec3( 1.0 );

	#endif

	// modulation
	#include <aomap_fragment>

	reflectedLight.indirectDiffuse *= diffuseColor.rgb;

	vec3 outgoingLight = reflectedLight.indirectDiffuse;

	#include <envmap_fragment>

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <premultiplied_alpha_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>

}
`;var xc=`
#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <envmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>
	#include <skinbase_vertex>

	#ifdef USE_ENVMAP

	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>

	#endif

	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>

	#include <worldpos_vertex>
	#include <clipping_planes_vertex>
	#include <envmap_vertex>
	#include <fog_vertex>

}
`;var _c=`
uniform vec3 diffuse;
uniform vec3 emissive;
uniform float opacity;

varying vec3 vLightFront;

#ifdef DOUBLE_SIDED

	varying vec3 vLightBack;

#endif

#include <common>
#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <envmap_pars_fragment>
#include <bsdfs>
#include <lights_pars_begin>
#include <fog_pars_fragment>
#include <shadowmap_pars_fragment>
#include <shadowmask_pars_fragment>
#include <specularmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( diffuse, opacity );
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive;

	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <specularmap_fragment>
	#include <emissivemap_fragment>

	// accumulation
	reflectedLight.indirectDiffuse = getAmbientLightIrradiance( ambientLightColor );

	#include <lightmap_fragment>

	reflectedLight.indirectDiffuse *= BRDF_Diffuse_Lambert( diffuseColor.rgb );

	#ifdef DOUBLE_SIDED

		reflectedLight.directDiffuse = ( gl_FrontFacing ) ? vLightFront : vLightBack;

	#else

		reflectedLight.directDiffuse = vLightFront;

	#endif

	reflectedLight.directDiffuse *= BRDF_Diffuse_Lambert( diffuseColor.rgb ) * getShadowMask();

	// modulation
	#include <aomap_fragment>

	vec3 outgoingLight = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse + totalEmissiveRadiance;

	#include <envmap_fragment>

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>

}
`;var bc=`
#define LAMBERT

varying vec3 vLightFront;

#ifdef DOUBLE_SIDED

	varying vec3 vLightBack;

#endif

#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <envmap_pars_vertex>
#include <bsdfs>
#include <lights_pars_begin>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>

	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>

	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>

	#include <worldpos_vertex>
	#include <envmap_vertex>
	#include <lights_lambert_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>

}
`;var wc=`
#define MATCAP

uniform vec3 diffuse;
uniform float opacity;
uniform sampler2D matcap;

varying vec3 vViewPosition;

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <common>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>

#include <fog_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( diffuse, opacity );

	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>

	vec3 viewDir = normalize( vViewPosition );
	vec3 x = normalize( vec3( viewDir.z, 0.0, - viewDir.x ) );
	vec3 y = cross( viewDir, x );
	vec2 uv = vec2( dot( x, normal ), dot( y, normal ) ) * 0.495 + 0.5; // 0.495 to remove artifacts caused by undersized matcap disks

	#ifdef USE_MATCAP

		vec4 matcapColor = texture2D( matcap, uv );
		matcapColor = matcapTexelToLinear( matcapColor );

	#else

		vec4 matcapColor = vec4( 1.0 );

	#endif

	vec3 outgoingLight = diffuseColor.rgb * matcapColor.rgb;

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <premultiplied_alpha_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>

}
`;var Mc=`
#define MATCAP

varying vec3 vViewPosition;

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <common>
#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>

#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex>

	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>

	#ifndef FLAT_SHADED // Normal computed with derivatives when FLAT_SHADED

		vNormal = normalize( transformedNormal );

	#endif

	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>

	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <fog_vertex>

	vViewPosition = - mvPosition.xyz;

}
`;var Ec=`
#define PHONG

uniform vec3 diffuse;
uniform vec3 emissive;
uniform vec3 specular;
uniform float shininess;
uniform float opacity;

#include <common>
#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <envmap_pars_fragment>
#include <gradientmap_pars_fragment>
#include <fog_pars_fragment>
#include <bsdfs>
#include <lights_pars_begin>
#include <lights_phong_pars_fragment>
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <specularmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( diffuse, opacity );
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive;

	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <specularmap_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	#include <emissivemap_fragment>

	// accumulation
	#include <lights_phong_fragment>
	#include <lights_fragment_begin>
	#include <lights_fragment_maps>
	#include <lights_fragment_end>

	// modulation
	#include <aomap_fragment>

	vec3 outgoingLight = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse + reflectedLight.directSpecular + reflectedLight.indirectSpecular + totalEmissiveRadiance;

	#include <envmap_fragment>

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>

}
`;var Tc=`
#define PHONG

varying vec3 vViewPosition;

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <displacementmap_pars_vertex>
#include <envmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>

	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>

#ifndef FLAT_SHADED // Normal computed with derivatives when FLAT_SHADED

	vNormal = normalize( transformedNormal );

#endif

	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>

	vViewPosition = - mvPosition.xyz;

	#include <worldpos_vertex>
	#include <envmap_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>

}
`;var Sc=`
#define PHYSICAL

uniform vec3 diffuse;
uniform vec3 emissive;
uniform float roughness;
uniform float metalness;
uniform float opacity;

#ifndef STANDARD
	uniform float clearCoat;
	uniform float clearCoatRoughness;
#endif

varying vec3 vViewPosition;

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <common>
#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <bsdfs>
#include <cube_uv_reflection_fragment>
#include <envmap_pars_fragment>
#include <envmap_physical_pars_fragment>
#include <fog_pars_fragment>
#include <lights_pars_begin>
#include <lights_physical_pars_fragment>
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <roughnessmap_pars_fragment>
#include <metalnessmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec4 diffuseColor = vec4( diffuse, opacity );
	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive;

	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	#include <roughnessmap_fragment>
	#include <metalnessmap_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	#include <emissivemap_fragment>

	// accumulation
	#include <lights_physical_fragment>
	#include <lights_fragment_begin>
	#include <lights_fragment_maps>
	#include <lights_fragment_end>

	// modulation
	#include <aomap_fragment>

	vec3 outgoingLight = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse + reflectedLight.directSpecular + reflectedLight.indirectSpecular + totalEmissiveRadiance;

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>

}
`;var Ac=`
#define PHYSICAL

varying vec3 vViewPosition;

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <common>
#include <uv_pars_vertex>
#include <uv2_pars_vertex>
#include <displacementmap_pars_vertex>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <shadowmap_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex>
	#include <uv2_vertex>
	#include <color_vertex>

	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>

#ifndef FLAT_SHADED // Normal computed with derivatives when FLAT_SHADED

	vNormal = normalize( transformedNormal );

#endif

	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>

	vViewPosition = - mvPosition.xyz;

	#include <worldpos_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>

}
`;var Lc=`
#define NORMAL

uniform float opacity;

#if defined( FLAT_SHADED ) || defined( USE_BUMPMAP ) || ( defined( USE_NORMALMAP ) && ! defined( OBJECTSPACE_NORMALMAP ) )

	varying vec3 vViewPosition;

#endif

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <packing>
#include <uv_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <logdepthbuf_pars_fragment>

void main() {

	#include <logdepthbuf_fragment>
	#include <normal_fragment_begin>
	#include <normal_fragment_maps>

	gl_FragColor = vec4( packNormalToRGB( normal ), opacity );

}
`;var Rc=`
#define NORMAL

#if defined( FLAT_SHADED ) || defined( USE_BUMPMAP ) || ( defined( USE_NORMALMAP ) && ! defined( OBJECTSPACE_NORMALMAP ) )

	varying vec3 vViewPosition;

#endif

#ifndef FLAT_SHADED

	varying vec3 vNormal;

#endif

#include <uv_pars_vertex>
#include <displacementmap_pars_vertex>
#include <morphtarget_pars_vertex>
#include <skinning_pars_vertex>
#include <logdepthbuf_pars_vertex>

void main() {

	#include <uv_vertex>

	#include <beginnormal_vertex>
	#include <morphnormal_vertex>
	#include <skinbase_vertex>
	#include <skinnormal_vertex>
	#include <defaultnormal_vertex>

#ifndef FLAT_SHADED // Normal computed with derivatives when FLAT_SHADED

	vNormal = normalize( transformedNormal );

#endif

	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <skinning_vertex>
	#include <displacementmap_vertex>
	#include <project_vertex>
	#include <logdepthbuf_vertex>

#if defined( FLAT_SHADED ) || defined( USE_BUMPMAP ) || ( defined( USE_NORMALMAP ) && ! defined( OBJECTSPACE_NORMALMAP ) )

	vViewPosition = - mvPosition.xyz;

#endif

}
`;var Cc=`
uniform vec3 diffuse;
uniform float opacity;

#include <common>
#include <color_pars_fragment>
#include <map_particle_pars_fragment>
#include <fog_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec3 outgoingLight = vec3( 0.0 );
	vec4 diffuseColor = vec4( diffuse, opacity );

	#include <logdepthbuf_fragment>
	#include <map_particle_fragment>
	#include <color_fragment>
	#include <alphatest_fragment>

	outgoingLight = diffuseColor.rgb;

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <premultiplied_alpha_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>

}
`;var Pc=`
uniform float size;
uniform float scale;

#include <common>
#include <color_pars_vertex>
#include <fog_pars_vertex>
#include <morphtarget_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <color_vertex>
	#include <begin_vertex>
	#include <morphtarget_vertex>
	#include <project_vertex>

	gl_PointSize = size;

	#ifdef USE_SIZEATTENUATION

		bool isPerspective = ( projectionMatrix[ 2 ][ 3 ] == - 1.0 );

		if ( isPerspective ) gl_PointSize *= ( scale / - mvPosition.z );

	#endif

	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <worldpos_vertex>
	#include <fog_vertex>

}
`;var Bc=`
uniform vec3 color;
uniform float opacity;

#include <common>
#include <packing>
#include <fog_pars_fragment>
#include <bsdfs>
#include <lights_pars_begin>
#include <shadowmap_pars_fragment>
#include <shadowmask_pars_fragment>

void main() {

	gl_FragColor = vec4( color, opacity * ( 1.0 - getShadowMask() ) );

	#include <fog_fragment>

}
`;var Fc=`
#include <fog_pars_vertex>
#include <shadowmap_pars_vertex>

void main() {

	#include <begin_vertex>
	#include <project_vertex>
	#include <worldpos_vertex>
	#include <shadowmap_vertex>
	#include <fog_vertex>

}
`;var Dc=`
uniform vec3 diffuse;
uniform float opacity;

#include <common>
#include <uv_pars_fragment>
#include <map_pars_fragment>
#include <fog_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>

void main() {

	#include <clipping_planes_fragment>

	vec3 outgoingLight = vec3( 0.0 );
	vec4 diffuseColor = vec4( diffuse, opacity );

	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <alphatest_fragment>

	outgoingLight = diffuseColor.rgb;

	gl_FragColor = vec4( outgoingLight, diffuseColor.a );

	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>

}
`;var Ic=`
uniform float rotation;
uniform vec2 center;

#include <common>
#include <uv_pars_vertex>
#include <fog_pars_vertex>
#include <logdepthbuf_pars_vertex>
#include <clipping_planes_pars_vertex>

void main() {

	#include <uv_vertex>

	vec4 mvPosition = modelViewMatrix * vec4( 0.0, 0.0, 0.0, 1.0 );

	vec2 scale;
	scale.x = length( vec3( modelMatrix[ 0 ].x, modelMatrix[ 0 ].y, modelMatrix[ 0 ].z ) );
	scale.y = length( vec3( modelMatrix[ 1 ].x, modelMatrix[ 1 ].y, modelMatrix[ 1 ].z ) );

	#ifndef USE_SIZEATTENUATION

		bool isPerspective = ( projectionMatrix[ 2 ][ 3 ] == - 1.0 );

		if ( isPerspective ) scale *= - mvPosition.z;

	#endif

	vec2 alignedPosition = ( position.xy - ( center - vec2( 0.5 ) ) ) * scale;

	vec2 rotatedPosition;
	rotatedPosition.x = cos( rotation ) * alignedPosition.x - sin( rotation ) * alignedPosition.y;
	rotatedPosition.y = sin( rotation ) * alignedPosition.x + cos( rotation ) * alignedPosition.y;

	mvPosition.xy += rotatedPosition;

	gl_Position = projectionMatrix * mvPosition;

	#include <logdepthbuf_vertex>
	#include <clipping_planes_vertex>
	#include <fog_vertex>

}
`;var Me={alphamap_fragment:Tf,alphamap_pars_fragment:Sf,alphatest_fragment:Af,aomap_fragment:Lf,aomap_pars_fragment:Rf,begin_vertex:Cf,beginnormal_vertex:Pf,bsdfs:Bf,bumpmap_pars_fragment:Ff,clipping_planes_fragment:Df,clipping_planes_pars_fragment:If,clipping_planes_pars_vertex:Of,clipping_planes_vertex:Uf,color_fragment:Nf,color_pars_fragment:Gf,color_pars_vertex:zf,color_vertex:Hf,common:Vf,cube_uv_reflection_fragment:kf,defaultnormal_vertex:Wf,displacementmap_pars_vertex:Xf,displacementmap_vertex:jf,emissivemap_fragment:qf,emissivemap_pars_fragment:Yf,encodings_fragment:Zf,encodings_pars_fragment:Jf,envmap_fragment:Qf,envmap_pars_fragment:Kf,envmap_pars_vertex:$f,envmap_physical_pars_fragment:cu,envmap_vertex:eu,fog_vertex:tu,fog_pars_vertex:ru,fog_fragment:iu,fog_pars_fragment:nu,gradientmap_pars_fragment:ou,lightmap_fragment:au,lightmap_pars_fragment:su,lights_lambert_vertex:fu,lights_pars_begin:uu,lights_phong_fragment:hu,lights_phong_pars_fragment:lu,lights_physical_fragment:pu,lights_physical_pars_fragment:du,lights_fragment_begin:mu,lights_fragment_maps:vu,lights_fragment_end:gu,logdepthbuf_fragment:yu,logdepthbuf_pars_fragment:xu,logdepthbuf_pars_vertex:_u,logdepthbuf_vertex:bu,map_fragment:wu,map_pars_fragment:Mu,map_particle_fragment:Eu,map_particle_pars_fragment:Tu,metalnessmap_fragment:Su,metalnessmap_pars_fragment:Au,morphnormal_vertex:Lu,morphtarget_pars_vertex:Ru,morphtarget_vertex:Cu,normal_fragment_begin:Pu,normal_fragment_maps:Bu,normalmap_pars_fragment:Fu,packing:Du,premultiplied_alpha_fragment:Iu,project_vertex:Ou,dithering_fragment:Uu,dithering_pars_fragment:Nu,roughnessmap_fragment:Gu,roughnessmap_pars_fragment:zu,shadowmap_pars_fragment:Hu,shadowmap_pars_vertex:Vu,shadowmap_vertex:ku,shadowmask_pars_fragment:Wu,skinbase_vertex:Xu,skinning_pars_vertex:ju,skinning_vertex:qu,skinnormal_vertex:Yu,specularmap_fragment:Zu,specularmap_pars_fragment:Ju,tonemapping_fragment:Qu,tonemapping_pars_fragment:Ku,uv_pars_fragment:$u,uv_pars_vertex:ec,uv_vertex:tc,uv2_pars_fragment:rc,uv2_pars_vertex:ic,uv2_vertex:nc,worldpos_vertex:oc,background_frag:ac,background_vert:sc,cube_frag:fc,cube_vert:uc,depth_frag:cc,depth_vert:hc,distanceRGBA_frag:lc,distanceRGBA_vert:pc,equirect_frag:dc,equirect_vert:mc,linedashed_frag:vc,linedashed_vert:gc,meshbasic_frag:yc,meshbasic_vert:xc,meshlambert_frag:_c,meshlambert_vert:bc,meshmatcap_frag:wc,meshmatcap_vert:Mc,meshphong_frag:Ec,meshphong_vert:Tc,meshphysical_frag:Sc,meshphysical_vert:Ac,normal_frag:Lc,normal_vert:Rc,points_frag:Cc,points_vert:Pc,shadow_frag:Bc,shadow_vert:Fc,sprite_frag:Dc,sprite_vert:Ic};function Nr(e){var t={};for(var r in e){t[r]={};for(var i in e[r]){var n=e[r][i];n&&(n.isColor||n.isMatrix3||n.isMatrix4||n.isVector2||n.isVector3||n.isVector4||n.isTexture)?t[r][i]=n.clone():Array.isArray(n)?t[r][i]=n.slice():t[r][i]=n}}return t}function Bt(e){for(var t={},r=0;r<e.length;r++){var i=Nr(e[r]);for(var n in i)t[n]=i[n]}return t}var ol={aliceblue:15792383,antiquewhite:16444375,aqua:65535,aquamarine:8388564,azure:15794175,beige:16119260,bisque:16770244,black:0,blanchedalmond:16772045,blue:255,blueviolet:9055202,brown:10824234,burlywood:14596231,cadetblue:6266528,chartreuse:8388352,chocolate:13789470,coral:16744272,cornflowerblue:6591981,cornsilk:16775388,crimson:14423100,cyan:65535,darkblue:139,darkcyan:35723,darkgoldenrod:12092939,darkgray:11119017,darkgreen:25600,darkgrey:11119017,darkkhaki:12433259,darkmagenta:9109643,darkolivegreen:5597999,darkorange:16747520,darkorchid:10040012,darkred:9109504,darksalmon:15308410,darkseagreen:9419919,darkslateblue:4734347,darkslategray:3100495,darkslategrey:3100495,darkturquoise:52945,darkviolet:9699539,deeppink:16716947,deepskyblue:49151,dimgray:6908265,dimgrey:6908265,dodgerblue:2003199,firebrick:11674146,floralwhite:16775920,forestgreen:2263842,fuchsia:16711935,gainsboro:14474460,ghostwhite:16316671,gold:16766720,goldenrod:14329120,gray:8421504,green:32768,greenyellow:11403055,grey:8421504,honeydew:15794160,hotpink:16738740,indianred:13458524,indigo:4915330,ivory:16777200,khaki:15787660,lavender:15132410,lavenderblush:16773365,lawngreen:8190976,lemonchiffon:16775885,lightblue:11393254,lightcoral:15761536,lightcyan:14745599,lightgoldenrodyellow:16448210,lightgray:13882323,lightgreen:9498256,lightgrey:13882323,lightpink:16758465,lightsalmon:16752762,lightseagreen:2142890,lightskyblue:8900346,lightslategray:7833753,lightslategrey:7833753,lightsteelblue:11584734,lightyellow:16777184,lime:65280,limegreen:3329330,linen:16445670,magenta:16711935,maroon:8388608,mediumaquamarine:6737322,mediumblue:205,mediumorchid:12211667,mediumpurple:9662683,mediumseagreen:3978097,mediumslateblue:8087790,mediumspringgreen:64154,mediumturquoise:4772300,mediumvioletred:13047173,midnightblue:1644912,mintcream:16121850,mistyrose:16770273,moccasin:16770229,navajowhite:16768685,navy:128,oldlace:16643558,olive:8421376,olivedrab:7048739,orange:16753920,orangered:16729344,orchid:14315734,palegoldenrod:15657130,palegreen:10025880,paleturquoise:11529966,palevioletred:14381203,papayawhip:16773077,peachpuff:16767673,peru:13468991,pink:16761035,plum:14524637,powderblue:11591910,purple:8388736,rebeccapurple:6697881,red:16711680,rosybrown:12357519,royalblue:4286945,saddlebrown:9127187,salmon:16416882,sandybrown:16032864,seagreen:3050327,seashell:16774638,sienna:10506797,silver:12632256,skyblue:8900331,slateblue:6970061,slategray:7372944,slategrey:7372944,snow:16775930,springgreen:65407,steelblue:4620980,tan:13808780,teal:32896,thistle:14204888,tomato:16737095,turquoise:4251856,violet:15631086,wheat:16113331,white:16777215,whitesmoke:16119285,yellow:16776960,yellowgreen:10145074};function J(e,t,r){return t===void 0&&r===void 0?this.set(e):this.setRGB(e,t,r)}Object.assign(J.prototype,{isColor:!0,r:1,g:1,b:1,set:function(e){return e&&e.isColor?this.copy(e):typeof e=="number"?this.setHex(e):typeof e=="string"&&this.setStyle(e),this},setScalar:function(e){return this.r=e,this.g=e,this.b=e,this},setHex:function(e){return e=Math.floor(e),this.r=(e>>16&255)/255,this.g=(e>>8&255)/255,this.b=(e&255)/255,this},setRGB:function(e,t,r){return this.r=e,this.g=t,this.b=r,this},setHSL:function(){function e(t,r,i){return i<0&&(i+=1),i>1&&(i-=1),i<1/6?t+(r-t)*6*i:i<1/2?r:i<2/3?t+(r-t)*6*(2/3-i):t}return function(r,i,n){if(r=ie.euclideanModulo(r,1),i=ie.clamp(i,0,1),n=ie.clamp(n,0,1),i===0)this.r=this.g=this.b=n;else{var o=n<=.5?n*(1+i):n+i-n*i,a=2*n-o;this.r=e(a,o,r+1/3),this.g=e(a,o,r),this.b=e(a,o,r-1/3)}return this}}(),setStyle:function(e){function t(h){h!==void 0&&parseFloat(h)<1&&console.warn("THREE.Color: Alpha component of "+e+" will be ignored.")}var r;if(r=/^((?:rgb|hsl)a?)\(\s*([^\)]*)\)/.exec(e)){var i,n=r[1],o=r[2];switch(n){case"rgb":case"rgba":if(i=/^(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(,\s*([0-9]*\.?[0-9]+)\s*)?$/.exec(o))return this.r=Math.min(255,parseInt(i[1],10))/255,this.g=Math.min(255,parseInt(i[2],10))/255,this.b=Math.min(255,parseInt(i[3],10))/255,t(i[5]),this;if(i=/^(\d+)\%\s*,\s*(\d+)\%\s*,\s*(\d+)\%\s*(,\s*([0-9]*\.?[0-9]+)\s*)?$/.exec(o))return this.r=Math.min(100,parseInt(i[1],10))/100,this.g=Math.min(100,parseInt(i[2],10))/100,this.b=Math.min(100,parseInt(i[3],10))/100,t(i[5]),this;break;case"hsl":case"hsla":if(i=/^([0-9]*\.?[0-9]+)\s*,\s*(\d+)\%\s*,\s*(\d+)\%\s*(,\s*([0-9]*\.?[0-9]+)\s*)?$/.exec(o)){var a=parseFloat(i[1])/360,s=parseInt(i[2],10)/100,f=parseInt(i[3],10)/100;return t(i[5]),this.setHSL(a,s,f)}break}}else if(r=/^\#([A-Fa-f0-9]+)$/.exec(e)){var u=r[1],c=u.length;if(c===3)return this.r=parseInt(u.charAt(0)+u.charAt(0),16)/255,this.g=parseInt(u.charAt(1)+u.charAt(1),16)/255,this.b=parseInt(u.charAt(2)+u.charAt(2),16)/255,this;if(c===6)return this.r=parseInt(u.charAt(0)+u.charAt(1),16)/255,this.g=parseInt(u.charAt(2)+u.charAt(3),16)/255,this.b=parseInt(u.charAt(4)+u.charAt(5),16)/255,this}if(e&&e.length>0){var u=ol[e];u!==void 0?this.setHex(u):console.warn("THREE.Color: Unknown color "+e)}return this},clone:function(){return new this.constructor(this.r,this.g,this.b)},copy:function(e){return this.r=e.r,this.g=e.g,this.b=e.b,this},copyGammaToLinear:function(e,t){return t===void 0&&(t=2),this.r=Math.pow(e.r,t),this.g=Math.pow(e.g,t),this.b=Math.pow(e.b,t),this},copyLinearToGamma:function(e,t){t===void 0&&(t=2);var r=t>0?1/t:1;return this.r=Math.pow(e.r,r),this.g=Math.pow(e.g,r),this.b=Math.pow(e.b,r),this},convertGammaToLinear:function(e){return this.copyGammaToLinear(this,e),this},convertLinearToGamma:function(e){return this.copyLinearToGamma(this,e),this},copySRGBToLinear:function(){function e(t){return t<.04045?t*.0773993808:Math.pow(t*.9478672986+.0521327014,2.4)}return function(r){return this.r=e(r.r),this.g=e(r.g),this.b=e(r.b),this}}(),copyLinearToSRGB:function(){function e(t){return t<.0031308?t*12.92:1.055*Math.pow(t,.41666)-.055}return function(r){return this.r=e(r.r),this.g=e(r.g),this.b=e(r.b),this}}(),convertSRGBToLinear:function(){return this.copySRGBToLinear(this),this},convertLinearToSRGB:function(){return this.copyLinearToSRGB(this),this},getHex:function(){return this.r*255<<16^this.g*255<<8^this.b*255<<0},getHexString:function(){return("000000"+this.getHex().toString(16)).slice(-6)},getHSL:function(e){e===void 0&&(console.warn("THREE.Color: .getHSL() target is now required"),e={h:0,s:0,l:0});var t=this.r,r=this.g,i=this.b,n=Math.max(t,r,i),o=Math.min(t,r,i),a,s,f=(o+n)/2;if(o===n)a=0,s=0;else{var u=n-o;switch(s=f<=.5?u/(n+o):u/(2-n-o),n){case t:a=(r-i)/u+(r<i?6:0);break;case r:a=(i-t)/u+2;break;case i:a=(t-r)/u+4;break}a/=6}return e.h=a,e.s=s,e.l=f,e},getStyle:function(){return"rgb("+(this.r*255|0)+","+(this.g*255|0)+","+(this.b*255|0)+")"},offsetHSL:function(){var e={};return function(t,r,i){return this.getHSL(e),e.h+=t,e.s+=r,e.l+=i,this.setHSL(e.h,e.s,e.l),this}}(),add:function(e){return this.r+=e.r,this.g+=e.g,this.b+=e.b,this},addColors:function(e,t){return this.r=e.r+t.r,this.g=e.g+t.g,this.b=e.b+t.b,this},addScalar:function(e){return this.r+=e,this.g+=e,this.b+=e,this},sub:function(e){return this.r=Math.max(0,this.r-e.r),this.g=Math.max(0,this.g-e.g),this.b=Math.max(0,this.b-e.b),this},multiply:function(e){return this.r*=e.r,this.g*=e.g,this.b*=e.b,this},multiplyScalar:function(e){return this.r*=e,this.g*=e,this.b*=e,this},lerp:function(e,t){return this.r+=(e.r-this.r)*t,this.g+=(e.g-this.g)*t,this.b+=(e.b-this.b)*t,this},lerpHSL:function(){var e={h:0,s:0,l:0},t={h:0,s:0,l:0};return function(i,n){this.getHSL(e),i.getHSL(t);var o=ie.lerp(e.h,t.h,n),a=ie.lerp(e.s,t.s,n),s=ie.lerp(e.l,t.l,n);return this.setHSL(o,a,s),this}}(),equals:function(e){return e.r===this.r&&e.g===this.g&&e.b===this.b},fromArray:function(e,t){return t===void 0&&(t=0),this.r=e[t],this.g=e[t+1],this.b=e[t+2],this},toArray:function(e,t){return e===void 0&&(e=[]),t===void 0&&(t=0),e[t]=this.r,e[t+1]=this.g,e[t+2]=this.b,e},toJSON:function(){return this.getHex()}});var ae={common:{diffuse:{value:new J(15658734)},opacity:{value:1},map:{value:null},uvTransform:{value:new Oe},alphaMap:{value:null}},specularmap:{specularMap:{value:null}},envmap:{envMap:{value:null},flipEnvMap:{value:-1},reflectivity:{value:1},refractionRatio:{value:.98},maxMipLevel:{value:0}},aomap:{aoMap:{value:null},aoMapIntensity:{value:1}},lightmap:{lightMap:{value:null},lightMapIntensity:{value:1}},emissivemap:{emissiveMap:{value:null}},bumpmap:{bumpMap:{value:null},bumpScale:{value:1}},normalmap:{normalMap:{value:null},normalScale:{value:new O(1,1)}},displacementmap:{displacementMap:{value:null},displacementScale:{value:1},displacementBias:{value:0}},roughnessmap:{roughnessMap:{value:null}},metalnessmap:{metalnessMap:{value:null}},gradientmap:{gradientMap:{value:null}},fog:{fogDensity:{value:25e-5},fogNear:{value:1},fogFar:{value:2e3},fogColor:{value:new J(16777215)}},lights:{ambientLightColor:{value:[]},directionalLights:{value:[],properties:{direction:{},color:{},shadow:{},shadowBias:{},shadowRadius:{},shadowMapSize:{}}},directionalShadowMap:{value:[]},directionalShadowMatrix:{value:[]},spotLights:{value:[],properties:{color:{},position:{},direction:{},distance:{},coneCos:{},penumbraCos:{},decay:{},shadow:{},shadowBias:{},shadowRadius:{},shadowMapSize:{}}},spotShadowMap:{value:[]},spotShadowMatrix:{value:[]},pointLights:{value:[],properties:{color:{},position:{},decay:{},distance:{},shadow:{},shadowBias:{},shadowRadius:{},shadowMapSize:{},shadowCameraNear:{},shadowCameraFar:{}}},pointShadowMap:{value:[]},pointShadowMatrix:{value:[]},hemisphereLights:{value:[],properties:{direction:{},skyColor:{},groundColor:{}}},rectAreaLights:{value:[],properties:{color:{},position:{},width:{},height:{}}}},points:{diffuse:{value:new J(15658734)},opacity:{value:1},size:{value:1},scale:{value:1},map:{value:null},uvTransform:{value:new Oe}},sprite:{diffuse:{value:new J(15658734)},opacity:{value:1},center:{value:new O(.5,.5)},rotation:{value:0},map:{value:null},uvTransform:{value:new Oe}}};var Vt={basic:{uniforms:Bt([ae.common,ae.specularmap,ae.envmap,ae.aomap,ae.lightmap,ae.fog]),vertexShader:Me.meshbasic_vert,fragmentShader:Me.meshbasic_frag},lambert:{uniforms:Bt([ae.common,ae.specularmap,ae.envmap,ae.aomap,ae.lightmap,ae.emissivemap,ae.fog,ae.lights,{emissive:{value:new J(0)}}]),vertexShader:Me.meshlambert_vert,fragmentShader:Me.meshlambert_frag},phong:{uniforms:Bt([ae.common,ae.specularmap,ae.envmap,ae.aomap,ae.lightmap,ae.emissivemap,ae.bumpmap,ae.normalmap,ae.displacementmap,ae.gradientmap,ae.fog,ae.lights,{emissive:{value:new J(0)},specular:{value:new J(1118481)},shininess:{value:30}}]),vertexShader:Me.meshphong_vert,fragmentShader:Me.meshphong_frag},standard:{uniforms:Bt([ae.common,ae.envmap,ae.aomap,ae.lightmap,ae.emissivemap,ae.bumpmap,ae.normalmap,ae.displacementmap,ae.roughnessmap,ae.metalnessmap,ae.fog,ae.lights,{emissive:{value:new J(0)},roughness:{value:.5},metalness:{value:.5},envMapIntensity:{value:1}}]),vertexShader:Me.meshphysical_vert,fragmentShader:Me.meshphysical_frag},matcap:{uniforms:Bt([ae.common,ae.bumpmap,ae.normalmap,ae.displacementmap,ae.fog,{matcap:{value:null}}]),vertexShader:Me.meshmatcap_vert,fragmentShader:Me.meshmatcap_frag},points:{uniforms:Bt([ae.points,ae.fog]),vertexShader:Me.points_vert,fragmentShader:Me.points_frag},dashed:{uniforms:Bt([ae.common,ae.fog,{scale:{value:1},dashSize:{value:1},totalSize:{value:2}}]),vertexShader:Me.linedashed_vert,fragmentShader:Me.linedashed_frag},depth:{uniforms:Bt([ae.common,ae.displacementmap]),vertexShader:Me.depth_vert,fragmentShader:Me.depth_frag},normal:{uniforms:Bt([ae.common,ae.bumpmap,ae.normalmap,ae.displacementmap,{opacity:{value:1}}]),vertexShader:Me.normal_vert,fragmentShader:Me.normal_frag},sprite:{uniforms:Bt([ae.sprite,ae.fog]),vertexShader:Me.sprite_vert,fragmentShader:Me.sprite_frag},background:{uniforms:{uvTransform:{value:new Oe},t2D:{value:null}},vertexShader:Me.background_vert,fragmentShader:Me.background_frag},cube:{uniforms:{tCube:{value:null},tFlip:{value:-1},opacity:{value:1}},vertexShader:Me.cube_vert,fragmentShader:Me.cube_frag},equirect:{uniforms:{tEquirect:{value:null}},vertexShader:Me.equirect_vert,fragmentShader:Me.equirect_frag},distanceRGBA:{uniforms:Bt([ae.common,ae.displacementmap,{referencePosition:{value:new x},nearDistance:{value:1},farDistance:{value:1e3}}]),vertexShader:Me.distanceRGBA_vert,fragmentShader:Me.distanceRGBA_frag},shadow:{uniforms:Bt([ae.lights,ae.fog,{color:{value:new J(0)},opacity:{value:1}}]),vertexShader:Me.shadow_vert,fragmentShader:Me.shadow_frag}};Vt.physical={uniforms:Bt([Vt.standard.uniforms,{clearCoat:{value:0},clearCoatRoughness:{value:0}}]),vertexShader:Me.meshphysical_vert,fragmentShader:Me.meshphysical_frag};function Ni(){var e=null,t=!1,r=null;function i(n,o){t!==!1&&(r(n,o),e.requestAnimationFrame(i))}return{start:function(){t!==!0&&r!==null&&(e.requestAnimationFrame(i),t=!0)},stop:function(){t=!1},setAnimationLoop:function(n){r=n},setContext:function(n){e=n}}}function Oc(e){var t=new WeakMap;function r(s,f){var u=s.array,c=s.dynamic?e.DYNAMIC_DRAW:e.STATIC_DRAW,h=e.createBuffer();e.bindBuffer(f,h),e.bufferData(f,u,c),s.onUploadCallback();var l=e.FLOAT;return u instanceof Float32Array?l=e.FLOAT:u instanceof Float64Array?console.warn("THREE.WebGLAttributes: Unsupported data buffer format: Float64Array."):u instanceof Uint16Array?l=e.UNSIGNED_SHORT:u instanceof Int16Array?l=e.SHORT:u instanceof Uint32Array?l=e.UNSIGNED_INT:u instanceof Int32Array?l=e.INT:u instanceof Int8Array?l=e.BYTE:u instanceof Uint8Array&&(l=e.UNSIGNED_BYTE),{buffer:h,type:l,bytesPerElement:u.BYTES_PER_ELEMENT,version:s.version}}function i(s,f,u){var c=f.array,h=f.updateRange;e.bindBuffer(u,s),f.dynamic===!1?e.bufferData(u,c,e.STATIC_DRAW):h.count===-1?e.bufferSubData(u,0,c):h.count===0?console.error("THREE.WebGLObjects.updateBuffer: dynamic THREE.BufferAttribute marked as needsUpdate but updateRange.count is 0, ensure you are using set methods or updating manually."):(e.bufferSubData(u,h.offset*c.BYTES_PER_ELEMENT,c.subarray(h.offset,h.offset+h.count)),h.count=-1)}function n(s){return s.isInterleavedBufferAttribute&&(s=s.data),t.get(s)}function o(s){s.isInterleavedBufferAttribute&&(s=s.data);var f=t.get(s);f&&(e.deleteBuffer(f.buffer),t.delete(s))}function a(s,f){s.isInterleavedBufferAttribute&&(s=s.data);var u=t.get(s);u===void 0?t.set(s,r(s,f)):u.version<s.version&&(i(u.buffer,s,f),u.version=s.version)}return{get:n,remove:o,update:a}}function Gr(e,t,r,i,n,o){this.a=e,this.b=t,this.c=r,this.normal=i&&i.isVector3?i:new x,this.vertexNormals=Array.isArray(i)?i:[],this.color=n&&n.isColor?n:new J,this.vertexColors=Array.isArray(n)?n:[],this.materialIndex=o!==void 0?o:0}Object.assign(Gr.prototype,{clone:function(){return new this.constructor().copy(this)},copy:function(e){this.a=e.a,this.b=e.b,this.c=e.c,this.normal.copy(e.normal),this.color.copy(e.color),this.materialIndex=e.materialIndex;for(var t=0,r=e.vertexNormals.length;t<r;t++)this.vertexNormals[t]=e.vertexNormals[t].clone();for(var t=0,r=e.vertexColors.length;t<r;t++)this.vertexColors[t]=e.vertexColors[t].clone();return this}});function zr(e,t,r,i){this._x=e||0,this._y=t||0,this._z=r||0,this._order=i||zr.DefaultOrder}zr.RotationOrders=["XYZ","YZX","ZXY","XZY","YXZ","ZYX"];zr.DefaultOrder="XYZ";Object.defineProperties(zr.prototype,{x:{get:function(){return this._x},set:function(e){this._x=e,this.onChangeCallback()}},y:{get:function(){return this._y},set:function(e){this._y=e,this.onChangeCallback()}},z:{get:function(){return this._z},set:function(e){this._z=e,this.onChangeCallback()}},order:{get:function(){return this._order},set:function(e){this._order=e,this.onChangeCallback()}}});Object.assign(zr.prototype,{isEuler:!0,set:function(e,t,r,i){return this._x=e,this._y=t,this._z=r,this._order=i||this._order,this.onChangeCallback(),this},clone:function(){return new this.constructor(this._x,this._y,this._z,this._order)},copy:function(e){return this._x=e._x,this._y=e._y,this._z=e._z,this._order=e._order,this.onChangeCallback(),this},setFromRotationMatrix:function(e,t,r){var i=ie.clamp,n=e.elements,o=n[0],a=n[4],s=n[8],f=n[1],u=n[5],c=n[9],h=n[2],l=n[6],p=n[10];return t=t||this._order,t==="XYZ"?(this._y=Math.asin(i(s,-1,1)),Math.abs(s)<.99999?(this._x=Math.atan2(-c,p),this._z=Math.atan2(-a,o)):(this._x=Math.atan2(l,u),this._z=0)):t==="YXZ"?(this._x=Math.asin(-i(c,-1,1)),Math.abs(c)<.99999?(this._y=Math.atan2(s,p),this._z=Math.atan2(f,u)):(this._y=Math.atan2(-h,o),this._z=0)):t==="ZXY"?(this._x=Math.asin(i(l,-1,1)),Math.abs(l)<.99999?(this._y=Math.atan2(-h,p),this._z=Math.atan2(-a,u)):(this._y=0,this._z=Math.atan2(f,o))):t==="ZYX"?(this._y=Math.asin(-i(h,-1,1)),Math.abs(h)<.99999?(this._x=Math.atan2(l,p),this._z=Math.atan2(f,o)):(this._x=0,this._z=Math.atan2(-a,u))):t==="YZX"?(this._z=Math.asin(i(f,-1,1)),Math.abs(f)<.99999?(this._x=Math.atan2(-c,u),this._y=Math.atan2(-h,o)):(this._x=0,this._y=Math.atan2(s,p))):t==="XZY"?(this._z=Math.asin(-i(a,-1,1)),Math.abs(a)<.99999?(this._x=Math.atan2(l,u),this._y=Math.atan2(s,o)):(this._x=Math.atan2(-c,p),this._y=0)):console.warn("THREE.Euler: .setFromRotationMatrix() given unsupported order: "+t),this._order=t,r!==!1&&this.onChangeCallback(),this},setFromQuaternion:function(){var e=new ee;return function(r,i,n){return e.makeRotationFromQuaternion(r),this.setFromRotationMatrix(e,i,n)}}(),setFromVector3:function(e,t){return this.set(e.x,e.y,e.z,t||this._order)},reorder:function(){var e=new Ge;return function(r){return e.setFromEuler(this),this.setFromQuaternion(e,r)}}(),equals:function(e){return e._x===this._x&&e._y===this._y&&e._z===this._z&&e._order===this._order},fromArray:function(e){return this._x=e[0],this._y=e[1],this._z=e[2],e[3]!==void 0&&(this._order=e[3]),this.onChangeCallback(),this},toArray:function(e,t){return e===void 0&&(e=[]),t===void 0&&(t=0),e[t]=this._x,e[t+1]=this._y,e[t+2]=this._z,e[t+3]=this._order,e},toVector3:function(e){return e?e.set(this._x,this._y,this._z):new x(this._x,this._y,this._z)},onChange:function(e){return this.onChangeCallback=e,this},onChangeCallback:function(){}});function jo(){this.mask=1}Object.assign(jo.prototype,{set:function(e){this.mask=1<<e|0},enable:function(e){this.mask|=1<<e|0},toggle:function(e){this.mask^=1<<e|0},disable:function(e){this.mask&=~(1<<e|0)},test:function(e){return(this.mask&e.mask)!==0}});var al=0;function k(){Object.defineProperty(this,"id",{value:al++}),this.uuid=ie.generateUUID(),this.name="",this.type="Object3D",this.parent=null,this.children=[],this.up=k.DefaultUp.clone();var e=new x,t=new zr,r=new Ge,i=new x(1,1,1);function n(){r.setFromEuler(t,!1)}function o(){t.setFromQuaternion(r,void 0,!1)}t.onChange(n),r.onChange(o),Object.defineProperties(this,{position:{configurable:!0,enumerable:!0,value:e},rotation:{configurable:!0,enumerable:!0,value:t},quaternion:{configurable:!0,enumerable:!0,value:r},scale:{configurable:!0,enumerable:!0,value:i},modelViewMatrix:{value:new ee},normalMatrix:{value:new Oe}}),this.matrix=new ee,this.matrixWorld=new ee,this.matrixAutoUpdate=k.DefaultMatrixAutoUpdate,this.matrixWorldNeedsUpdate=!1,this.layers=new jo,this.visible=!0,this.castShadow=!1,this.receiveShadow=!1,this.frustumCulled=!0,this.renderOrder=0,this.userData={}}k.DefaultUp=new x(0,1,0);k.DefaultMatrixAutoUpdate=!0;k.prototype=Object.assign(Object.create(bt.prototype),{constructor:k,isObject3D:!0,onBeforeRender:function(){},onAfterRender:function(){},applyMatrix:function(e){this.matrix.multiplyMatrices(e,this.matrix),this.matrix.decompose(this.position,this.quaternion,this.scale)},applyQuaternion:function(e){return this.quaternion.premultiply(e),this},setRotationFromAxisAngle:function(e,t){this.quaternion.setFromAxisAngle(e,t)},setRotationFromEuler:function(e){this.quaternion.setFromEuler(e,!0)},setRotationFromMatrix:function(e){this.quaternion.setFromRotationMatrix(e)},setRotationFromQuaternion:function(e){this.quaternion.copy(e)},rotateOnAxis:function(){var e=new Ge;return function(r,i){return e.setFromAxisAngle(r,i),this.quaternion.multiply(e),this}}(),rotateOnWorldAxis:function(){var e=new Ge;return function(r,i){return e.setFromAxisAngle(r,i),this.quaternion.premultiply(e),this}}(),rotateX:function(){var e=new x(1,0,0);return function(r){return this.rotateOnAxis(e,r)}}(),rotateY:function(){var e=new x(0,1,0);return function(r){return this.rotateOnAxis(e,r)}}(),rotateZ:function(){var e=new x(0,0,1);return function(r){return this.rotateOnAxis(e,r)}}(),translateOnAxis:function(){var e=new x;return function(r,i){return e.copy(r).applyQuaternion(this.quaternion),this.position.add(e.multiplyScalar(i)),this}}(),translateX:function(){var e=new x(1,0,0);return function(r){return this.translateOnAxis(e,r)}}(),translateY:function(){var e=new x(0,1,0);return function(r){return this.translateOnAxis(e,r)}}(),translateZ:function(){var e=new x(0,0,1);return function(r){return this.translateOnAxis(e,r)}}(),localToWorld:function(e){return e.applyMatrix4(this.matrixWorld)},worldToLocal:function(){var e=new ee;return function(r){return r.applyMatrix4(e.getInverse(this.matrixWorld))}}(),lookAt:function(){var e=new Ge,t=new ee,r=new x,i=new x;return function(o,a,s){o.isVector3?r.copy(o):r.set(o,a,s);var f=this.parent;this.updateWorldMatrix(!0,!1),i.setFromMatrixPosition(this.matrixWorld),this.isCamera||this.isLight?t.lookAt(i,r,this.up):t.lookAt(r,i,this.up),this.quaternion.setFromRotationMatrix(t),f&&(t.extractRotation(f.matrixWorld),e.setFromRotationMatrix(t),this.quaternion.premultiply(e.inverse()))}}(),add:function(e){if(arguments.length>1){for(var t=0;t<arguments.length;t++)this.add(arguments[t]);return this}return e===this?(console.error("THREE.Object3D.add: object can't be added as a child of itself.",e),this):(e&&e.isObject3D?(e.parent!==null&&e.parent.remove(e),e.parent=this,e.dispatchEvent({type:"added"}),this.children.push(e)):console.error("THREE.Object3D.add: object not an instance of THREE.Object3D.",e),this)},remove:function(e){if(arguments.length>1){for(var t=0;t<arguments.length;t++)this.remove(arguments[t]);return this}var r=this.children.indexOf(e);return r!==-1&&(e.parent=null,e.dispatchEvent({type:"removed"}),this.children.splice(r,1)),this},getObjectById:function(e){return this.getObjectByProperty("id",e)},getObjectByName:function(e){return this.getObjectByProperty("name",e)},getObjectByProperty:function(e,t){if(this[e]===t)return this;for(var r=0,i=this.children.length;r<i;r++){var n=this.children[r],o=n.getObjectByProperty(e,t);if(o!==void 0)return o}},getWorldPosition:function(e){return e===void 0&&(console.warn("THREE.Object3D: .getWorldPosition() target is now required"),e=new x),this.updateMatrixWorld(!0),e.setFromMatrixPosition(this.matrixWorld)},getWorldQuaternion:function(){var e=new x,t=new x;return function(i){return i===void 0&&(console.warn("THREE.Object3D: .getWorldQuaternion() target is now required"),i=new Ge),this.updateMatrixWorld(!0),this.matrixWorld.decompose(e,i,t),i}}(),getWorldScale:function(){var e=new x,t=new Ge;return function(i){return i===void 0&&(console.warn("THREE.Object3D: .getWorldScale() target is now required"),i=new x),this.updateMatrixWorld(!0),this.matrixWorld.decompose(e,t,i),i}}(),getWorldDirection:function(e){e===void 0&&(console.warn("THREE.Object3D: .getWorldDirection() target is now required"),e=new x),this.updateMatrixWorld(!0);var t=this.matrixWorld.elements;return e.set(t[8],t[9],t[10]).normalize()},raycast:function(){},traverse:function(e){e(this);for(var t=this.children,r=0,i=t.length;r<i;r++)t[r].traverse(e)},traverseVisible:function(e){if(this.visible!==!1){e(this);for(var t=this.children,r=0,i=t.length;r<i;r++)t[r].traverseVisible(e)}},traverseAncestors:function(e){var t=this.parent;t!==null&&(e(t),t.traverseAncestors(e))},updateMatrix:function(){this.matrix.compose(this.position,this.quaternion,this.scale),this.matrixWorldNeedsUpdate=!0},updateMatrixWorld:function(e){this.matrixAutoUpdate&&this.updateMatrix(),(this.matrixWorldNeedsUpdate||e)&&(this.parent===null?this.matrixWorld.copy(this.matrix):this.matrixWorld.multiplyMatrices(this.parent.matrixWorld,this.matrix),this.matrixWorldNeedsUpdate=!1,e=!0);for(var t=this.children,r=0,i=t.length;r<i;r++)t[r].updateMatrixWorld(e)},updateWorldMatrix:function(e,t){var r=this.parent;if(e===!0&&r!==null&&r.updateWorldMatrix(!0,!1),this.matrixAutoUpdate&&this.updateMatrix(),this.parent===null?this.matrixWorld.copy(this.matrix):this.matrixWorld.multiplyMatrices(this.parent.matrixWorld,this.matrix),t===!0)for(var i=this.children,n=0,o=i.length;n<o;n++)i[n].updateWorldMatrix(!1,!0)},toJSON:function(e){var t=e===void 0||typeof e=="string",r={};t&&(e={geometries:{},materials:{},textures:{},images:{},shapes:{}},r.metadata={version:4.5,type:"Object",generator:"Object3D.toJSON"});var i={};i.uuid=this.uuid,i.type=this.type,this.name!==""&&(i.name=this.name),this.castShadow===!0&&(i.castShadow=!0),this.receiveShadow===!0&&(i.receiveShadow=!0),this.visible===!1&&(i.visible=!1),this.frustumCulled===!1&&(i.frustumCulled=!1),this.renderOrder!==0&&(i.renderOrder=this.renderOrder),JSON.stringify(this.userData)!=="{}"&&(i.userData=this.userData),i.layers=this.layers.mask,i.matrix=this.matrix.toArray(),this.matrixAutoUpdate===!1&&(i.matrixAutoUpdate=!1);function n(v,g){return v[g.uuid]===void 0&&(v[g.uuid]=g.toJSON(e)),g.uuid}if(this.isMesh||this.isLine||this.isPoints){i.geometry=n(e.geometries,this.geometry);var o=this.geometry.parameters;if(o!==void 0&&o.shapes!==void 0){var a=o.shapes;if(Array.isArray(a))for(var s=0,f=a.length;s<f;s++){var u=a[s];n(e.shapes,u)}else n(e.shapes,a)}}if(this.material!==void 0)if(Array.isArray(this.material)){for(var c=[],s=0,f=this.material.length;s<f;s++)c.push(n(e.materials,this.material[s]));i.material=c}else i.material=n(e.materials,this.material);if(this.children.length>0){i.children=[];for(var s=0;s<this.children.length;s++)i.children.push(this.children[s].toJSON(e).object)}if(t){var h=m(e.geometries),l=m(e.materials),p=m(e.textures),d=m(e.images),a=m(e.shapes);h.length>0&&(r.geometries=h),l.length>0&&(r.materials=l),p.length>0&&(r.textures=p),d.length>0&&(r.images=d),a.length>0&&(r.shapes=a)}return r.object=i,r;function m(v){var g=[];for(var b in v){var w=v[b];delete w.metadata,g.push(w)}return g}},clone:function(e){return new this.constructor().copy(this,e)},copy:function(e,t){if(t===void 0&&(t=!0),this.name=e.name,this.up.copy(e.up),this.position.copy(e.position),this.quaternion.copy(e.quaternion),this.scale.copy(e.scale),this.matrix.copy(e.matrix),this.matrixWorld.copy(e.matrixWorld),this.matrixAutoUpdate=e.matrixAutoUpdate,this.matrixWorldNeedsUpdate=e.matrixWorldNeedsUpdate,this.layers.mask=e.layers.mask,this.visible=e.visible,this.castShadow=e.castShadow,this.receiveShadow=e.receiveShadow,this.frustumCulled=e.frustumCulled,this.renderOrder=e.renderOrder,this.userData=JSON.parse(JSON.stringify(e.userData)),t===!0)for(var r=0;r<e.children.length;r++){var i=e.children[r];this.add(i.clone())}return this}});var sl=0;function re(){Object.defineProperty(this,"id",{value:sl+=2}),this.uuid=ie.generateUUID(),this.name="",this.type="Geometry",this.vertices=[],this.colors=[],this.faces=[],this.faceVertexUvs=[[]],this.morphTargets=[],this.morphNormals=[],this.skinWeights=[],this.skinIndices=[],this.lineDistances=[],this.boundingBox=null,this.boundingSphere=null,this.elementsNeedUpdate=!1,this.verticesNeedUpdate=!1,this.uvsNeedUpdate=!1,this.normalsNeedUpdate=!1,this.colorsNeedUpdate=!1,this.lineDistancesNeedUpdate=!1,this.groupsNeedUpdate=!1}re.prototype=Object.assign(Object.create(bt.prototype),{constructor:re,isGeometry:!0,applyMatrix:function(e){for(var t=new Oe().getNormalMatrix(e),r=0,i=this.vertices.length;r<i;r++){var n=this.vertices[r];n.applyMatrix4(e)}for(var r=0,i=this.faces.length;r<i;r++){var o=this.faces[r];o.normal.applyMatrix3(t).normalize();for(var a=0,s=o.vertexNormals.length;a<s;a++)o.vertexNormals[a].applyMatrix3(t).normalize()}return this.boundingBox!==null&&this.computeBoundingBox(),this.boundingSphere!==null&&this.computeBoundingSphere(),this.verticesNeedUpdate=!0,this.normalsNeedUpdate=!0,this},rotateX:function(){var e=new ee;return function(r){return e.makeRotationX(r),this.applyMatrix(e),this}}(),rotateY:function(){var e=new ee;return function(r){return e.makeRotationY(r),this.applyMatrix(e),this}}(),rotateZ:function(){var e=new ee;return function(r){return e.makeRotationZ(r),this.applyMatrix(e),this}}(),translate:function(){var e=new ee;return function(r,i,n){return e.makeTranslation(r,i,n),this.applyMatrix(e),this}}(),scale:function(){var e=new ee;return function(r,i,n){return e.makeScale(r,i,n),this.applyMatrix(e),this}}(),lookAt:function(){var e=new k;return function(r){e.lookAt(r),e.updateMatrix(),this.applyMatrix(e.matrix)}}(),fromBufferGeometry:function(e){var t=this,r=e.index!==null?e.index.array:void 0,i=e.attributes,n=i.position.array,o=i.normal!==void 0?i.normal.array:void 0,a=i.color!==void 0?i.color.array:void 0,s=i.uv!==void 0?i.uv.array:void 0,f=i.uv2!==void 0?i.uv2.array:void 0;f!==void 0&&(this.faceVertexUvs[1]=[]);for(var u=0,c=0;u<n.length;u+=3,c+=2)t.vertices.push(new x().fromArray(n,u)),a!==void 0&&t.colors.push(new J().fromArray(a,u));function h(g,b,w,y){var S=a===void 0?[]:[t.colors[g].clone(),t.colors[b].clone(),t.colors[w].clone()],R=o===void 0?[]:[new x().fromArray(o,g*3),new x().fromArray(o,b*3),new x().fromArray(o,w*3)],B=new Gr(g,b,w,R,S,y);t.faces.push(B),s!==void 0&&t.faceVertexUvs[0].push([new O().fromArray(s,g*2),new O().fromArray(s,b*2),new O().fromArray(s,w*2)]),f!==void 0&&t.faceVertexUvs[1].push([new O().fromArray(f,g*2),new O().fromArray(f,b*2),new O().fromArray(f,w*2)])}var l=e.groups;if(l.length>0)for(var u=0;u<l.length;u++)for(var p=l[u],d=p.start,m=p.count,c=d,v=d+m;c<v;c+=3)r!==void 0?h(r[c],r[c+1],r[c+2],p.materialIndex):h(c,c+1,c+2,p.materialIndex);else if(r!==void 0)for(var u=0;u<r.length;u+=3)h(r[u],r[u+1],r[u+2]);else for(var u=0;u<n.length/3;u+=3)h(u,u+1,u+2);return this.computeFaceNormals(),e.boundingBox!==null&&(this.boundingBox=e.boundingBox.clone()),e.boundingSphere!==null&&(this.boundingSphere=e.boundingSphere.clone()),this},center:function(){var e=new x;return function(){return this.computeBoundingBox(),this.boundingBox.getCenter(e).negate(),this.translate(e.x,e.y,e.z),this}}(),normalize:function(){this.computeBoundingSphere();var e=this.boundingSphere.center,t=this.boundingSphere.radius,r=t===0?1:1/t,i=new ee;return i.set(r,0,0,-r*e.x,0,r,0,-r*e.y,0,0,r,-r*e.z,0,0,0,1),this.applyMatrix(i),this},computeFaceNormals:function(){for(var e=new x,t=new x,r=0,i=this.faces.length;r<i;r++){var n=this.faces[r],o=this.vertices[n.a],a=this.vertices[n.b],s=this.vertices[n.c];e.subVectors(s,a),t.subVectors(o,a),e.cross(t),e.normalize(),n.normal.copy(e)}},computeVertexNormals:function(e){e===void 0&&(e=!0);var t,r,i,n,o,a;for(a=new Array(this.vertices.length),t=0,r=this.vertices.length;t<r;t++)a[t]=new x;if(e){var s,f,u,c=new x,h=new x;for(i=0,n=this.faces.length;i<n;i++)o=this.faces[i],s=this.vertices[o.a],f=this.vertices[o.b],u=this.vertices[o.c],c.subVectors(u,f),h.subVectors(s,f),c.cross(h),a[o.a].add(c),a[o.b].add(c),a[o.c].add(c)}else for(this.computeFaceNormals(),i=0,n=this.faces.length;i<n;i++)o=this.faces[i],a[o.a].add(o.normal),a[o.b].add(o.normal),a[o.c].add(o.normal);for(t=0,r=this.vertices.length;t<r;t++)a[t].normalize();for(i=0,n=this.faces.length;i<n;i++){o=this.faces[i];var l=o.vertexNormals;l.length===3?(l[0].copy(a[o.a]),l[1].copy(a[o.b]),l[2].copy(a[o.c])):(l[0]=a[o.a].clone(),l[1]=a[o.b].clone(),l[2]=a[o.c].clone())}this.faces.length>0&&(this.normalsNeedUpdate=!0)},computeFlatVertexNormals:function(){var e,t,r;for(this.computeFaceNormals(),e=0,t=this.faces.length;e<t;e++){r=this.faces[e];var i=r.vertexNormals;i.length===3?(i[0].copy(r.normal),i[1].copy(r.normal),i[2].copy(r.normal)):(i[0]=r.normal.clone(),i[1]=r.normal.clone(),i[2]=r.normal.clone())}this.faces.length>0&&(this.normalsNeedUpdate=!0)},computeMorphNormals:function(){var e,t,r,i,n;for(r=0,i=this.faces.length;r<i;r++)for(n=this.faces[r],n.__originalFaceNormal?n.__originalFaceNormal.copy(n.normal):n.__originalFaceNormal=n.normal.clone(),n.__originalVertexNormals||(n.__originalVertexNormals=[]),e=0,t=n.vertexNormals.length;e<t;e++)n.__originalVertexNormals[e]?n.__originalVertexNormals[e].copy(n.vertexNormals[e]):n.__originalVertexNormals[e]=n.vertexNormals[e].clone();var o=new re;for(o.faces=this.faces,e=0,t=this.morphTargets.length;e<t;e++){if(!this.morphNormals[e]){this.morphNormals[e]={},this.morphNormals[e].faceNormals=[],this.morphNormals[e].vertexNormals=[];var a=this.morphNormals[e].faceNormals,s=this.morphNormals[e].vertexNormals,u,c;for(r=0,i=this.faces.length;r<i;r++)u=new x,c={a:new x,b:new x,c:new x},a.push(u),s.push(c)}var f=this.morphNormals[e];o.vertices=this.morphTargets[e].vertices,o.computeFaceNormals(),o.computeVertexNormals();var u,c;for(r=0,i=this.faces.length;r<i;r++)n=this.faces[r],u=f.faceNormals[r],c=f.vertexNormals[r],u.copy(n.normal),c.a.copy(n.vertexNormals[0]),c.b.copy(n.vertexNormals[1]),c.c.copy(n.vertexNormals[2])}for(r=0,i=this.faces.length;r<i;r++)n=this.faces[r],n.normal=n.__originalFaceNormal,n.vertexNormals=n.__originalVertexNormals},computeBoundingBox:function(){this.boundingBox===null&&(this.boundingBox=new Pt),this.boundingBox.setFromPoints(this.vertices)},computeBoundingSphere:function(){this.boundingSphere===null&&(this.boundingSphere=new it),this.boundingSphere.setFromPoints(this.vertices)},merge:function(e,t,r){if(!(e&&e.isGeometry)){console.error("THREE.Geometry.merge(): geometry not an instance of THREE.Geometry.",e);return}var i,n=this.vertices.length,o=this.vertices,a=e.vertices,s=this.faces,f=e.faces,u=this.faceVertexUvs[0],c=e.faceVertexUvs[0],h=this.colors,l=e.colors;r===void 0&&(r=0),t!==void 0&&(i=new Oe().getNormalMatrix(t));for(var p=0,d=a.length;p<d;p++){var m=a[p],v=m.clone();t!==void 0&&v.applyMatrix4(t),o.push(v)}for(var p=0,d=l.length;p<d;p++)h.push(l[p].clone());for(p=0,d=f.length;p<d;p++){var g=f[p],b,w,y,S=g.vertexNormals,R=g.vertexColors;b=new Gr(g.a+n,g.b+n,g.c+n),b.normal.copy(g.normal),i!==void 0&&b.normal.applyMatrix3(i).normalize();for(var B=0,P=S.length;B<P;B++)w=S[B].clone(),i!==void 0&&w.applyMatrix3(i).normalize(),b.vertexNormals.push(w);b.color.copy(g.color);for(var B=0,P=R.length;B<P;B++)y=R[B],b.vertexColors.push(y.clone());b.materialIndex=g.materialIndex+r,s.push(b)}for(p=0,d=c.length;p<d;p++){var A=c[p],D=[];if(A!==void 0){for(var B=0,P=A.length;B<P;B++)D.push(A[B].clone());u.push(D)}}},mergeMesh:function(e){if(!(e&&e.isMesh)){console.error("THREE.Geometry.mergeMesh(): mesh not an instance of THREE.Mesh.",e);return}e.matrixAutoUpdate&&e.updateMatrix(),this.merge(e.geometry,e.matrix)},mergeVertices:function(){var e={},t=[],r=[],i,n,o=4,a=Math.pow(10,o),s,f,u,c,h,l;for(s=0,f=this.vertices.length;s<f;s++)i=this.vertices[s],n=Math.round(i.x*a)+"_"+Math.round(i.y*a)+"_"+Math.round(i.z*a),e[n]===void 0?(e[n]=s,t.push(this.vertices[s]),r[s]=t.length-1):r[s]=r[e[n]];var p=[];for(s=0,f=this.faces.length;s<f;s++){u=this.faces[s],u.a=r[u.a],u.b=r[u.b],u.c=r[u.c],c=[u.a,u.b,u.c];for(var d=0;d<3;d++)if(c[d]===c[(d+1)%3]){p.push(s);break}}for(s=p.length-1;s>=0;s--){var m=p[s];for(this.faces.splice(m,1),h=0,l=this.faceVertexUvs.length;h<l;h++)this.faceVertexUvs[h].splice(m,1)}var v=this.vertices.length-t.length;return this.vertices=t,v},setFromPoints:function(e){this.vertices=[];for(var t=0,r=e.length;t<r;t++){var i=e[t];this.vertices.push(new x(i.x,i.y,i.z||0))}return this},sortFacesByMaterialIndex:function(){for(var e=this.faces,t=e.length,r=0;r<t;r++)e[r]._id=r;function i(u,c){return u.materialIndex-c.materialIndex}e.sort(i);var n=this.faceVertexUvs[0],o=this.faceVertexUvs[1],a,s;n&&n.length===t&&(a=[]),o&&o.length===t&&(s=[]);for(var r=0;r<t;r++){var f=e[r]._id;a&&a.push(n[f]),s&&s.push(o[f])}a&&(this.faceVertexUvs[0]=a),s&&(this.faceVertexUvs[1]=s)},toJSON:function(){var e={metadata:{version:4.5,type:"Geometry",generator:"Geometry.toJSON"}};if(e.uuid=this.uuid,e.type=this.type,this.name!==""&&(e.name=this.name),this.parameters!==void 0){var t=this.parameters;for(var r in t)t[r]!==void 0&&(e[r]=t[r]);return e}for(var i=[],n=0;n<this.vertices.length;n++){var o=this.vertices[n];i.push(o.x,o.y,o.z)}for(var a=[],s=[],f={},u=[],c={},h=[],l={},n=0;n<this.faces.length;n++){var p=this.faces[n],d=!0,m=!1,v=this.faceVertexUvs[0][n]!==void 0,g=p.normal.length()>0,b=p.vertexNormals.length>0,w=p.color.r!==1||p.color.g!==1||p.color.b!==1,y=p.vertexColors.length>0,S=0;if(S=A(S,0,0),S=A(S,1,d),S=A(S,2,m),S=A(S,3,v),S=A(S,4,g),S=A(S,5,b),S=A(S,6,w),S=A(S,7,y),a.push(S),a.push(p.a,p.b,p.c),a.push(p.materialIndex),v){var R=this.faceVertexUvs[0][n];a.push(H(R[0]),H(R[1]),H(R[2]))}if(g&&a.push(D(p.normal)),b){var B=p.vertexNormals;a.push(D(B[0]),D(B[1]),D(B[2]))}if(w&&a.push(I(p.color)),y){var P=p.vertexColors;a.push(I(P[0]),I(P[1]),I(P[2]))}}function A(X,j,V){return V?X|1<<j:X&~(1<<j)}function D(X){var j=X.x.toString()+X.y.toString()+X.z.toString();return f[j]!==void 0||(f[j]=s.length/3,s.push(X.x,X.y,X.z)),f[j]}function I(X){var j=X.r.toString()+X.g.toString()+X.b.toString();return c[j]!==void 0||(c[j]=u.length,u.push(X.getHex())),c[j]}function H(X){var j=X.x.toString()+X.y.toString();return l[j]!==void 0||(l[j]=h.length/2,h.push(X.x,X.y)),l[j]}return e.data={},e.data.vertices=i,e.data.normals=s,u.length>0&&(e.data.colors=u),h.length>0&&(e.data.uvs=[h]),e.data.faces=a,e},clone:function(){return new re().copy(this)},copy:function(e){var t,r,i,n,o,a;this.vertices=[],this.colors=[],this.faces=[],this.faceVertexUvs=[[]],this.morphTargets=[],this.morphNormals=[],this.skinWeights=[],this.skinIndices=[],this.lineDistances=[],this.boundingBox=null,this.boundingSphere=null,this.name=e.name;var s=e.vertices;for(t=0,r=s.length;t<r;t++)this.vertices.push(s[t].clone());var f=e.colors;for(t=0,r=f.length;t<r;t++)this.colors.push(f[t].clone());var u=e.faces;for(t=0,r=u.length;t<r;t++)this.faces.push(u[t].clone());for(t=0,r=e.faceVertexUvs.length;t<r;t++){var c=e.faceVertexUvs[t];for(this.faceVertexUvs[t]===void 0&&(this.faceVertexUvs[t]=[]),i=0,n=c.length;i<n;i++){var h=c[i],l=[];for(o=0,a=h.length;o<a;o++){var p=h[o];l.push(p.clone())}this.faceVertexUvs[t].push(l)}}var d=e.morphTargets;for(t=0,r=d.length;t<r;t++){var m={};if(m.name=d[t].name,d[t].vertices!==void 0)for(m.vertices=[],i=0,n=d[t].vertices.length;i<n;i++)m.vertices.push(d[t].vertices[i].clone());if(d[t].normals!==void 0)for(m.normals=[],i=0,n=d[t].normals.length;i<n;i++)m.normals.push(d[t].normals[i].clone());this.morphTargets.push(m)}var v=e.morphNormals;for(t=0,r=v.length;t<r;t++){var g={};if(v[t].vertexNormals!==void 0)for(g.vertexNormals=[],i=0,n=v[t].vertexNormals.length;i<n;i++){var b=v[t].vertexNormals[i],w={};w.a=b.a.clone(),w.b=b.b.clone(),w.c=b.c.clone(),g.vertexNormals.push(w)}if(v[t].faceNormals!==void 0)for(g.faceNormals=[],i=0,n=v[t].faceNormals.length;i<n;i++)g.faceNormals.push(v[t].faceNormals[i].clone());this.morphNormals.push(g)}var y=e.skinWeights;for(t=0,r=y.length;t<r;t++)this.skinWeights.push(y[t].clone());var S=e.skinIndices;for(t=0,r=S.length;t<r;t++)this.skinIndices.push(S[t].clone());var R=e.lineDistances;for(t=0,r=R.length;t<r;t++)this.lineDistances.push(R[t]);var B=e.boundingBox;B!==null&&(this.boundingBox=B.clone());var P=e.boundingSphere;return P!==null&&(this.boundingSphere=P.clone()),this.elementsNeedUpdate=e.elementsNeedUpdate,this.verticesNeedUpdate=e.verticesNeedUpdate,this.uvsNeedUpdate=e.uvsNeedUpdate,this.normalsNeedUpdate=e.normalsNeedUpdate,this.colorsNeedUpdate=e.colorsNeedUpdate,this.lineDistancesNeedUpdate=e.lineDistancesNeedUpdate,this.groupsNeedUpdate=e.groupsNeedUpdate,this},dispose:function(){this.dispatchEvent({type:"dispose"})}});function ye(e,t,r){if(Array.isArray(e))throw new TypeError("THREE.BufferAttribute: array should be a Typed Array.");this.name="",this.array=e,this.itemSize=t,this.count=e!==void 0?e.length/t:0,this.normalized=r===!0,this.dynamic=!1,this.updateRange={offset:0,count:-1},this.version=0}Object.defineProperty(ye.prototype,"needsUpdate",{set:function(e){e===!0&&this.version++}});Object.assign(ye.prototype,{isBufferAttribute:!0,onUploadCallback:function(){},setArray:function(e){if(Array.isArray(e))throw new TypeError("THREE.BufferAttribute: array should be a Typed Array.");return this.count=e!==void 0?e.length/this.itemSize:0,this.array=e,this},setDynamic:function(e){return this.dynamic=e,this},copy:function(e){return this.name=e.name,this.array=new e.array.constructor(e.array),this.itemSize=e.itemSize,this.count=e.count,this.normalized=e.normalized,this.dynamic=e.dynamic,this},copyAt:function(e,t,r){e*=this.itemSize,r*=t.itemSize;for(var i=0,n=this.itemSize;i<n;i++)this.array[e+i]=t.array[r+i];return this},copyArray:function(e){return this.array.set(e),this},copyColorsArray:function(e){for(var t=this.array,r=0,i=0,n=e.length;i<n;i++){var o=e[i];o===void 0&&(console.warn("THREE.BufferAttribute.copyColorsArray(): color is undefined",i),o=new J),t[r++]=o.r,t[r++]=o.g,t[r++]=o.b}return this},copyVector2sArray:function(e){for(var t=this.array,r=0,i=0,n=e.length;i<n;i++){var o=e[i];o===void 0&&(console.warn("THREE.BufferAttribute.copyVector2sArray(): vector is undefined",i),o=new O),t[r++]=o.x,t[r++]=o.y}return this},copyVector3sArray:function(e){for(var t=this.array,r=0,i=0,n=e.length;i<n;i++){var o=e[i];o===void 0&&(console.warn("THREE.BufferAttribute.copyVector3sArray(): vector is undefined",i),o=new x),t[r++]=o.x,t[r++]=o.y,t[r++]=o.z}return this},copyVector4sArray:function(e){for(var t=this.array,r=0,i=0,n=e.length;i<n;i++){var o=e[i];o===void 0&&(console.warn("THREE.BufferAttribute.copyVector4sArray(): vector is undefined",i),o=new we),t[r++]=o.x,t[r++]=o.y,t[r++]=o.z,t[r++]=o.w}return this},set:function(e,t){return t===void 0&&(t=0),this.array.set(e,t),this},getX:function(e){return this.array[e*this.itemSize]},setX:function(e,t){return this.array[e*this.itemSize]=t,this},getY:function(e){return this.array[e*this.itemSize+1]},setY:function(e,t){return this.array[e*this.itemSize+1]=t,this},getZ:function(e){return this.array[e*this.itemSize+2]},setZ:function(e,t){return this.array[e*this.itemSize+2]=t,this},getW:function(e){return this.array[e*this.itemSize+3]},setW:function(e,t){return this.array[e*this.itemSize+3]=t,this},setXY:function(e,t,r){return e*=this.itemSize,this.array[e+0]=t,this.array[e+1]=r,this},setXYZ:function(e,t,r,i){return e*=this.itemSize,this.array[e+0]=t,this.array[e+1]=r,this.array[e+2]=i,this},setXYZW:function(e,t,r,i,n){return e*=this.itemSize,this.array[e+0]=t,this.array[e+1]=r,this.array[e+2]=i,this.array[e+3]=n,this},onUpload:function(e){return this.onUploadCallback=e,this},clone:function(){return new this.constructor(this.array,this.itemSize).copy(this)}});function qo(e,t,r){ye.call(this,new Int8Array(e),t,r)}qo.prototype=Object.create(ye.prototype);qo.prototype.constructor=qo;function Yo(e,t,r){ye.call(this,new Uint8Array(e),t,r)}Yo.prototype=Object.create(ye.prototype);Yo.prototype.constructor=Yo;function Zo(e,t,r){ye.call(this,new Uint8ClampedArray(e),t,r)}Zo.prototype=Object.create(ye.prototype);Zo.prototype.constructor=Zo;function Jo(e,t,r){ye.call(this,new Int16Array(e),t,r)}Jo.prototype=Object.create(ye.prototype);Jo.prototype.constructor=Jo;function Hr(e,t,r){ye.call(this,new Uint16Array(e),t,r)}Hr.prototype=Object.create(ye.prototype);Hr.prototype.constructor=Hr;function Qo(e,t,r){ye.call(this,new Int32Array(e),t,r)}Qo.prototype=Object.create(ye.prototype);Qo.prototype.constructor=Qo;function Vr(e,t,r){ye.call(this,new Uint32Array(e),t,r)}Vr.prototype=Object.create(ye.prototype);Vr.prototype.constructor=Vr;function G(e,t,r){ye.call(this,new Float32Array(e),t,r)}G.prototype=Object.create(ye.prototype);G.prototype.constructor=G;function Ko(e,t,r){ye.call(this,new Float64Array(e),t,r)}Ko.prototype=Object.create(ye.prototype);Ko.prototype.constructor=Ko;function Ua(){this.vertices=[],this.normals=[],this.colors=[],this.uvs=[],this.uvs2=[],this.groups=[],this.morphTargets={},this.skinWeights=[],this.skinIndices=[],this.boundingBox=null,this.boundingSphere=null,this.verticesNeedUpdate=!1,this.normalsNeedUpdate=!1,this.colorsNeedUpdate=!1,this.uvsNeedUpdate=!1,this.groupsNeedUpdate=!1}Object.assign(Ua.prototype,{computeGroups:function(e){for(var t,r=[],i=void 0,n=e.faces,o=0;o<n.length;o++){var a=n[o];a.materialIndex!==i&&(i=a.materialIndex,t!==void 0&&(t.count=o*3-t.start,r.push(t)),t={start:o*3,materialIndex:i})}t!==void 0&&(t.count=o*3-t.start,r.push(t)),this.groups=r},fromGeometry:function(e){var t=e.faces,r=e.vertices,i=e.faceVertexUvs,n=i[0]&&i[0].length>0,o=i[1]&&i[1].length>0,a=e.morphTargets,s=a.length,f;if(s>0){f=[];for(var u=0;u<s;u++)f[u]={name:a[u].name,data:[]};this.morphTargets.position=f}var c=e.morphNormals,h=c.length,l;if(h>0){l=[];for(var u=0;u<h;u++)l[u]={name:c[u].name,data:[]};this.morphTargets.normal=l}var p=e.skinIndices,d=e.skinWeights,m=p.length===r.length,v=d.length===r.length;r.length>0&&t.length===0&&console.error("THREE.DirectGeometry: Faceless geometries are not supported.");for(var u=0;u<t.length;u++){var g=t[u];this.vertices.push(r[g.a],r[g.b],r[g.c]);var b=g.vertexNormals;if(b.length===3)this.normals.push(b[0],b[1],b[2]);else{var w=g.normal;this.normals.push(w,w,w)}var y=g.vertexColors;if(y.length===3)this.colors.push(y[0],y[1],y[2]);else{var S=g.color;this.colors.push(S,S,S)}if(n===!0){var R=i[0][u];R!==void 0?this.uvs.push(R[0],R[1],R[2]):(console.warn("THREE.DirectGeometry.fromGeometry(): Undefined vertexUv ",u),this.uvs.push(new O,new O,new O))}if(o===!0){var R=i[1][u];R!==void 0?this.uvs2.push(R[0],R[1],R[2]):(console.warn("THREE.DirectGeometry.fromGeometry(): Undefined vertexUv2 ",u),this.uvs2.push(new O,new O,new O))}for(var B=0;B<s;B++){var P=a[B].vertices;f[B].data.push(P[g.a],P[g.b],P[g.c])}for(var B=0;B<h;B++){var A=c[B].vertexNormals[u];l[B].data.push(A.a,A.b,A.c)}m&&this.skinIndices.push(p[g.a],p[g.b],p[g.c]),v&&this.skinWeights.push(d[g.a],d[g.b],d[g.c])}return this.computeGroups(e),this.verticesNeedUpdate=e.verticesNeedUpdate,this.normalsNeedUpdate=e.normalsNeedUpdate,this.colorsNeedUpdate=e.colorsNeedUpdate,this.uvsNeedUpdate=e.uvsNeedUpdate,this.groupsNeedUpdate=e.groupsNeedUpdate,this}});function $o(e){if(e.length===0)return-1/0;for(var t=e[0],r=1,i=e.length;r<i;++r)e[r]>t&&(t=e[r]);return t}var fl=1;function z(){Object.defineProperty(this,"id",{value:fl+=2}),this.uuid=ie.generateUUID(),this.name="",this.type="BufferGeometry",this.index=null,this.attributes={},this.morphAttributes={},this.groups=[],this.boundingBox=null,this.boundingSphere=null,this.drawRange={start:0,count:1/0},this.userData={}}z.prototype=Object.assign(Object.create(bt.prototype),{constructor:z,isBufferGeometry:!0,getIndex:function(){return this.index},setIndex:function(e){Array.isArray(e)?this.index=new($o(e)>65535?Vr:Hr)(e,1):this.index=e},addAttribute:function(e,t){return!(t&&t.isBufferAttribute)&&!(t&&t.isInterleavedBufferAttribute)?(console.warn("THREE.BufferGeometry: .addAttribute() now expects ( name, attribute )."),this.addAttribute(e,new ye(arguments[1],arguments[2]))):e==="index"?(console.warn("THREE.BufferGeometry.addAttribute: Use .setIndex() for index attribute."),this.setIndex(t),this):(this.attributes[e]=t,this)},getAttribute:function(e){return this.attributes[e]},removeAttribute:function(e){return delete this.attributes[e],this},addGroup:function(e,t,r){this.groups.push({start:e,count:t,materialIndex:r!==void 0?r:0})},clearGroups:function(){this.groups=[]},setDrawRange:function(e,t){this.drawRange.start=e,this.drawRange.count=t},applyMatrix:function(e){var t=this.attributes.position;t!==void 0&&(e.applyToBufferAttribute(t),t.needsUpdate=!0);var r=this.attributes.normal;if(r!==void 0){var i=new Oe().getNormalMatrix(e);i.applyToBufferAttribute(r),r.needsUpdate=!0}return this.boundingBox!==null&&this.computeBoundingBox(),this.boundingSphere!==null&&this.computeBoundingSphere(),this},rotateX:function(){var e=new ee;return function(r){return e.makeRotationX(r),this.applyMatrix(e),this}}(),rotateY:function(){var e=new ee;return function(r){return e.makeRotationY(r),this.applyMatrix(e),this}}(),rotateZ:function(){var e=new ee;return function(r){return e.makeRotationZ(r),this.applyMatrix(e),this}}(),translate:function(){var e=new ee;return function(r,i,n){return e.makeTranslation(r,i,n),this.applyMatrix(e),this}}(),scale:function(){var e=new ee;return function(r,i,n){return e.makeScale(r,i,n),this.applyMatrix(e),this}}(),lookAt:function(){var e=new k;return function(r){e.lookAt(r),e.updateMatrix(),this.applyMatrix(e.matrix)}}(),center:function(){var e=new x;return function(){return this.computeBoundingBox(),this.boundingBox.getCenter(e).negate(),this.translate(e.x,e.y,e.z),this}}(),setFromObject:function(e){var t=e.geometry;if(e.isPoints||e.isLine){var r=new G(t.vertices.length*3,3),i=new G(t.colors.length*3,3);if(this.addAttribute("position",r.copyVector3sArray(t.vertices)),this.addAttribute("color",i.copyColorsArray(t.colors)),t.lineDistances&&t.lineDistances.length===t.vertices.length){var n=new G(t.lineDistances.length,1);this.addAttribute("lineDistance",n.copyArray(t.lineDistances))}t.boundingSphere!==null&&(this.boundingSphere=t.boundingSphere.clone()),t.boundingBox!==null&&(this.boundingBox=t.boundingBox.clone())}else e.isMesh&&t&&t.isGeometry&&this.fromGeometry(t);return this},setFromPoints:function(e){for(var t=[],r=0,i=e.length;r<i;r++){var n=e[r];t.push(n.x,n.y,n.z||0)}return this.addAttribute("position",new G(t,3)),this},updateFromObject:function(e){var t=e.geometry;if(e.isMesh){var r=t.__directGeometry;if(t.elementsNeedUpdate===!0&&(r=void 0,t.elementsNeedUpdate=!1),r===void 0)return this.fromGeometry(t);r.verticesNeedUpdate=t.verticesNeedUpdate,r.normalsNeedUpdate=t.normalsNeedUpdate,r.colorsNeedUpdate=t.colorsNeedUpdate,r.uvsNeedUpdate=t.uvsNeedUpdate,r.groupsNeedUpdate=t.groupsNeedUpdate,t.verticesNeedUpdate=!1,t.normalsNeedUpdate=!1,t.colorsNeedUpdate=!1,t.uvsNeedUpdate=!1,t.groupsNeedUpdate=!1,t=r}var i;return t.verticesNeedUpdate===!0&&(i=this.attributes.position,i!==void 0&&(i.copyVector3sArray(t.vertices),i.needsUpdate=!0),t.verticesNeedUpdate=!1),t.normalsNeedUpdate===!0&&(i=this.attributes.normal,i!==void 0&&(i.copyVector3sArray(t.normals),i.needsUpdate=!0),t.normalsNeedUpdate=!1),t.colorsNeedUpdate===!0&&(i=this.attributes.color,i!==void 0&&(i.copyColorsArray(t.colors),i.needsUpdate=!0),t.colorsNeedUpdate=!1),t.uvsNeedUpdate&&(i=this.attributes.uv,i!==void 0&&(i.copyVector2sArray(t.uvs),i.needsUpdate=!0),t.uvsNeedUpdate=!1),t.lineDistancesNeedUpdate&&(i=this.attributes.lineDistance,i!==void 0&&(i.copyArray(t.lineDistances),i.needsUpdate=!0),t.lineDistancesNeedUpdate=!1),t.groupsNeedUpdate&&(t.computeGroups(e.geometry),this.groups=t.groups,t.groupsNeedUpdate=!1),this},fromGeometry:function(e){return e.__directGeometry=new Ua().fromGeometry(e),this.fromDirectGeometry(e.__directGeometry)},fromDirectGeometry:function(e){var t=new Float32Array(e.vertices.length*3);if(this.addAttribute("position",new ye(t,3).copyVector3sArray(e.vertices)),e.normals.length>0){var r=new Float32Array(e.normals.length*3);this.addAttribute("normal",new ye(r,3).copyVector3sArray(e.normals))}if(e.colors.length>0){var i=new Float32Array(e.colors.length*3);this.addAttribute("color",new ye(i,3).copyColorsArray(e.colors))}if(e.uvs.length>0){var n=new Float32Array(e.uvs.length*2);this.addAttribute("uv",new ye(n,2).copyVector2sArray(e.uvs))}if(e.uvs2.length>0){var o=new Float32Array(e.uvs2.length*2);this.addAttribute("uv2",new ye(o,2).copyVector2sArray(e.uvs2))}this.groups=e.groups;for(var a in e.morphTargets){for(var s=[],f=e.morphTargets[a],u=0,c=f.length;u<c;u++){var h=f[u],l=new G(h.data.length*3,3);l.name=h.name,s.push(l.copyVector3sArray(h.data))}this.morphAttributes[a]=s}if(e.skinIndices.length>0){var p=new G(e.skinIndices.length*4,4);this.addAttribute("skinIndex",p.copyVector4sArray(e.skinIndices))}if(e.skinWeights.length>0){var d=new G(e.skinWeights.length*4,4);this.addAttribute("skinWeight",d.copyVector4sArray(e.skinWeights))}return e.boundingSphere!==null&&(this.boundingSphere=e.boundingSphere.clone()),e.boundingBox!==null&&(this.boundingBox=e.boundingBox.clone()),this},computeBoundingBox:function(){this.boundingBox===null&&(this.boundingBox=new Pt);var e=this.attributes.position;e!==void 0?this.boundingBox.setFromBufferAttribute(e):this.boundingBox.makeEmpty(),(isNaN(this.boundingBox.min.x)||isNaN(this.boundingBox.min.y)||isNaN(this.boundingBox.min.z))&&console.error('THREE.BufferGeometry.computeBoundingBox: Computed min/max have NaN values. The "position" attribute is likely to have NaN values.',this)},computeBoundingSphere:function(){var e=new Pt,t=new x;return function(){this.boundingSphere===null&&(this.boundingSphere=new it);var i=this.attributes.position;if(i){var n=this.boundingSphere.center;e.setFromBufferAttribute(i),e.getCenter(n);for(var o=0,a=0,s=i.count;a<s;a++)t.x=i.getX(a),t.y=i.getY(a),t.z=i.getZ(a),o=Math.max(o,n.distanceToSquared(t));this.boundingSphere.radius=Math.sqrt(o),isNaN(this.boundingSphere.radius)&&console.error('THREE.BufferGeometry.computeBoundingSphere(): Computed radius is NaN. The "position" attribute is likely to have NaN values.',this)}}}(),computeFaceNormals:function(){},computeVertexNormals:function(){var e=this.index,t=this.attributes;if(t.position){var r=t.position.array;if(t.normal===void 0)this.addAttribute("normal",new ye(new Float32Array(r.length),3));else for(var i=t.normal.array,n=0,o=i.length;n<o;n++)i[n]=0;var a=t.normal.array,s,f,u,c=new x,h=new x,l=new x,p=new x,d=new x;if(e)for(var m=e.array,n=0,o=e.count;n<o;n+=3)s=m[n+0]*3,f=m[n+1]*3,u=m[n+2]*3,c.fromArray(r,s),h.fromArray(r,f),l.fromArray(r,u),p.subVectors(l,h),d.subVectors(c,h),p.cross(d),a[s]+=p.x,a[s+1]+=p.y,a[s+2]+=p.z,a[f]+=p.x,a[f+1]+=p.y,a[f+2]+=p.z,a[u]+=p.x,a[u+1]+=p.y,a[u+2]+=p.z;else for(var n=0,o=r.length;n<o;n+=9)c.fromArray(r,n),h.fromArray(r,n+3),l.fromArray(r,n+6),p.subVectors(l,h),d.subVectors(c,h),p.cross(d),a[n]=p.x,a[n+1]=p.y,a[n+2]=p.z,a[n+3]=p.x,a[n+4]=p.y,a[n+5]=p.z,a[n+6]=p.x,a[n+7]=p.y,a[n+8]=p.z;this.normalizeNormals(),t.normal.needsUpdate=!0}},merge:function(e,t){if(!(e&&e.isBufferGeometry)){console.error("THREE.BufferGeometry.merge(): geometry not an instance of THREE.BufferGeometry.",e);return}t===void 0&&(t=0,console.warn("THREE.BufferGeometry.merge(): Overwriting original geometry, starting at offset=0. Use BufferGeometryUtils.mergeBufferGeometries() for lossless merge."));var r=this.attributes;for(var i in r)if(e.attributes[i]!==void 0)for(var n=r[i],o=n.array,a=e.attributes[i],s=a.array,f=a.itemSize,u=0,c=f*t;u<s.length;u++,c++)o[c]=s[u];return this},normalizeNormals:function(){var e=new x;return function(){for(var r=this.attributes.normal,i=0,n=r.count;i<n;i++)e.x=r.getX(i),e.y=r.getY(i),e.z=r.getZ(i),e.normalize(),r.setXYZ(i,e.x,e.y,e.z)}}(),toNonIndexed:function(){function e(m,v){for(var g=m.array,b=m.itemSize,w=new g.constructor(v.length*b),y=0,S=0,R=0,B=v.length;R<B;R++){y=v[R]*b;for(var P=0;P<b;P++)w[S++]=g[y++]}return new ye(w,b)}if(this.index===null)return console.warn("THREE.BufferGeometry.toNonIndexed(): Geometry is already non-indexed."),this;var t=new z,r=this.index.array,i=this.attributes;for(var n in i){var o=i[n],a=e(o,r);t.addAttribute(n,a)}var s=this.morphAttributes;for(n in s){for(var f=[],u=s[n],c=0,h=u.length;c<h;c++){var o=u[c],a=e(o,r);f.push(a)}t.morphAttributes[n]=f}for(var l=this.groups,c=0,p=l.length;c<p;c++){var d=l[c];t.addGroup(d.start,d.count,d.materialIndex)}return t},toJSON:function(){var e={metadata:{version:4.5,type:"BufferGeometry",generator:"BufferGeometry.toJSON"}};if(e.uuid=this.uuid,e.type=this.type,this.name!==""&&(e.name=this.name),Object.keys(this.userData).length>0&&(e.userData=this.userData),this.parameters!==void 0){var t=this.parameters;for(var r in t)t[r]!==void 0&&(e[r]=t[r]);return e}e.data={attributes:{}};var i=this.index;if(i!==null){var n=Array.prototype.slice.call(i.array);e.data.index={type:i.array.constructor.name,array:n}}var o=this.attributes;for(var r in o){var a=o[r],n=Array.prototype.slice.call(a.array);e.data.attributes[r]={itemSize:a.itemSize,type:a.array.constructor.name,array:n,normalized:a.normalized}}var s=this.groups;s.length>0&&(e.data.groups=JSON.parse(JSON.stringify(s)));var f=this.boundingSphere;return f!==null&&(e.data.boundingSphere={center:f.center.toArray(),radius:f.radius}),e},clone:function(){return new z().copy(this)},copy:function(e){var t,r,i;this.index=null,this.attributes={},this.morphAttributes={},this.groups=[],this.boundingBox=null,this.boundingSphere=null,this.name=e.name;var n=e.index;n!==null&&this.setIndex(n.clone());var o=e.attributes;for(t in o){var a=o[t];this.addAttribute(t,a.clone())}var s=e.morphAttributes;for(t in s){var f=[],u=s[t];for(r=0,i=u.length;r<i;r++)f.push(u[r].clone());this.morphAttributes[t]=f}var c=e.groups;for(r=0,i=c.length;r<i;r++){var h=c[r];this.addGroup(h.start,h.count,h.materialIndex)}var l=e.boundingBox;l!==null&&(this.boundingBox=l.clone());var p=e.boundingSphere;return p!==null&&(this.boundingSphere=p.clone()),this.drawRange.start=e.drawRange.start,this.drawRange.count=e.drawRange.count,this.userData=e.userData,this},dispose:function(){this.dispatchEvent({type:"dispose"})}});function Gi(e,t,r,i,n,o){re.call(this),this.type="BoxGeometry",this.parameters={width:e,height:t,depth:r,widthSegments:i,heightSegments:n,depthSegments:o},this.fromBufferGeometry(new kr(e,t,r,i,n,o)),this.mergeVertices()}Gi.prototype=Object.create(re.prototype);Gi.prototype.constructor=Gi;function kr(e,t,r,i,n,o){z.call(this),this.type="BoxBufferGeometry",this.parameters={width:e,height:t,depth:r,widthSegments:i,heightSegments:n,depthSegments:o};var a=this;e=e||1,t=t||1,r=r||1,i=Math.floor(i)||1,n=Math.floor(n)||1,o=Math.floor(o)||1;var s=[],f=[],u=[],c=[],h=0,l=0;p("z","y","x",-1,-1,r,t,e,o,n,0),p("z","y","x",1,-1,r,t,-e,o,n,1),p("x","z","y",1,1,e,r,t,i,o,2),p("x","z","y",1,-1,e,r,-t,i,o,3),p("x","y","z",1,-1,e,t,r,i,n,4),p("x","y","z",-1,-1,e,t,-r,i,n,5),this.setIndex(s),this.addAttribute("position",new G(f,3)),this.addAttribute("normal",new G(u,3)),this.addAttribute("uv",new G(c,2));function p(d,m,v,g,b,w,y,S,R,B,P){var A=w/R,D=y/B,I=w/2,H=y/2,X=S/2,j=R+1,V=B+1,$=0,K=0,Q,E,T=new x;for(E=0;E<V;E++){var U=E*D-H;for(Q=0;Q<j;Q++){var L=Q*A-I;T[d]=L*g,T[m]=U*b,T[v]=X,f.push(T.x,T.y,T.z),T[d]=0,T[m]=0,T[v]=S>0?1:-1,u.push(T.x,T.y,T.z),c.push(Q/R),c.push(1-E/B),$+=1}}for(E=0;E<B;E++)for(Q=0;Q<R;Q++){var te=h+Q+j*E,N=h+Q+j*(E+1),q=h+(Q+1)+j*(E+1),Z=h+(Q+1)+j*E;s.push(te,N,Z),s.push(N,q,Z),K+=6}a.addGroup(l,K,P),l+=K,h+=$}}kr.prototype=Object.create(z.prototype);kr.prototype.constructor=kr;function Sn(e,t,r,i){re.call(this),this.type="PlaneGeometry",this.parameters={width:e,height:t,widthSegments:r,heightSegments:i},this.fromBufferGeometry(new Qt(e,t,r,i)),this.mergeVertices()}Sn.prototype=Object.create(re.prototype);Sn.prototype.constructor=Sn;function Qt(e,t,r,i){z.call(this),this.type="PlaneBufferGeometry",this.parameters={width:e,height:t,widthSegments:r,heightSegments:i},e=e||1,t=t||1;var n=e/2,o=t/2,a=Math.floor(r)||1,s=Math.floor(i)||1,f=a+1,u=s+1,c=e/a,h=t/s,l,p,d=[],m=[],v=[],g=[];for(p=0;p<u;p++){var b=p*h-o;for(l=0;l<f;l++){var w=l*c-n;m.push(w,-b,0),v.push(0,0,1),g.push(l/a),g.push(1-p/s)}}for(p=0;p<s;p++)for(l=0;l<a;l++){var y=l+f*p,S=l+f*(p+1),R=l+1+f*(p+1),B=l+1+f*p;d.push(y,S,B),d.push(S,R,B)}this.setIndex(d),this.addAttribute("position",new G(m,3)),this.addAttribute("normal",new G(v,3)),this.addAttribute("uv",new G(g,2))}Qt.prototype=Object.create(z.prototype);Qt.prototype.constructor=Qt;var ul=0;function he(){Object.defineProperty(this,"id",{value:ul++}),this.uuid=ie.generateUUID(),this.name="",this.type="Material",this.fog=!0,this.lights=!0,this.blending=yr,this.side=gr,this.flatShading=!1,this.vertexColors=Aa,this.opacity=1,this.transparent=!1,this.blendSrc=Io,this.blendDst=Oo,this.blendEquation=xr,this.blendSrcAlpha=null,this.blendDstAlpha=null,this.blendEquationAlpha=null,this.depthFunc=wn,this.depthTest=!0,this.depthWrite=!0,this.clippingPlanes=null,this.clipIntersection=!1,this.clipShadows=!1,this.shadowSide=null,this.colorWrite=!0,this.precision=null,this.polygonOffset=!1,this.polygonOffsetFactor=0,this.polygonOffsetUnits=0,this.dithering=!1,this.alphaTest=0,this.premultipliedAlpha=!1,this.visible=!0,this.userData={},this.needsUpdate=!0}he.prototype=Object.assign(Object.create(bt.prototype),{constructor:he,isMaterial:!0,onBeforeCompile:function(){},setValues:function(e){if(e!==void 0)for(var t in e){var r=e[t];if(r===void 0){console.warn("THREE.Material: '"+t+"' parameter is undefined.");continue}if(t==="shading"){console.warn("THREE."+this.type+": .shading has been removed. Use the boolean .flatShading instead."),this.flatShading=r===Co;continue}var i=this[t];if(i===void 0){console.warn("THREE."+this.type+": '"+t+"' is not a property of this material.");continue}i&&i.isColor?i.set(r):i&&i.isVector3&&r&&r.isVector3?i.copy(r):this[t]=r}},toJSON:function(e){var t=e===void 0||typeof e=="string";t&&(e={textures:{},images:{}});var r={metadata:{version:4.5,type:"Material",generator:"Material.toJSON"}};r.uuid=this.uuid,r.type=this.type,this.name!==""&&(r.name=this.name),this.color&&this.color.isColor&&(r.color=this.color.getHex()),this.roughness!==void 0&&(r.roughness=this.roughness),this.metalness!==void 0&&(r.metalness=this.metalness),this.emissive&&this.emissive.isColor&&(r.emissive=this.emissive.getHex()),this.emissiveIntensity!==1&&(r.emissiveIntensity=this.emissiveIntensity),this.specular&&this.specular.isColor&&(r.specular=this.specular.getHex()),this.shininess!==void 0&&(r.shininess=this.shininess),this.clearCoat!==void 0&&(r.clearCoat=this.clearCoat),this.clearCoatRoughness!==void 0&&(r.clearCoatRoughness=this.clearCoatRoughness),this.map&&this.map.isTexture&&(r.map=this.map.toJSON(e).uuid),this.alphaMap&&this.alphaMap.isTexture&&(r.alphaMap=this.alphaMap.toJSON(e).uuid),this.lightMap&&this.lightMap.isTexture&&(r.lightMap=this.lightMap.toJSON(e).uuid),this.aoMap&&this.aoMap.isTexture&&(r.aoMap=this.aoMap.toJSON(e).uuid,r.aoMapIntensity=this.aoMapIntensity),this.bumpMap&&this.bumpMap.isTexture&&(r.bumpMap=this.bumpMap.toJSON(e).uuid,r.bumpScale=this.bumpScale),this.normalMap&&this.normalMap.isTexture&&(r.normalMap=this.normalMap.toJSON(e).uuid,r.normalMapType=this.normalMapType,r.normalScale=this.normalScale.toArray()),this.displacementMap&&this.displacementMap.isTexture&&(r.displacementMap=this.displacementMap.toJSON(e).uuid,r.displacementScale=this.displacementScale,r.displacementBias=this.displacementBias),this.roughnessMap&&this.roughnessMap.isTexture&&(r.roughnessMap=this.roughnessMap.toJSON(e).uuid),this.metalnessMap&&this.metalnessMap.isTexture&&(r.metalnessMap=this.metalnessMap.toJSON(e).uuid),this.emissiveMap&&this.emissiveMap.isTexture&&(r.emissiveMap=this.emissiveMap.toJSON(e).uuid),this.specularMap&&this.specularMap.isTexture&&(r.specularMap=this.specularMap.toJSON(e).uuid),this.envMap&&this.envMap.isTexture&&(r.envMap=this.envMap.toJSON(e).uuid,r.reflectivity=this.reflectivity,this.combine!==void 0&&(r.combine=this.combine),this.envMapIntensity!==void 0&&(r.envMapIntensity=this.envMapIntensity)),this.gradientMap&&this.gradientMap.isTexture&&(r.gradientMap=this.gradientMap.toJSON(e).uuid),this.size!==void 0&&(r.size=this.size),this.sizeAttenuation!==void 0&&(r.sizeAttenuation=this.sizeAttenuation),this.blending!==yr&&(r.blending=this.blending),this.flatShading===!0&&(r.flatShading=this.flatShading),this.side!==gr&&(r.side=this.side),this.vertexColors!==Aa&&(r.vertexColors=this.vertexColors),this.opacity<1&&(r.opacity=this.opacity),this.transparent===!0&&(r.transparent=this.transparent),r.depthFunc=this.depthFunc,r.depthTest=this.depthTest,r.depthWrite=this.depthWrite,this.rotation!==0&&(r.rotation=this.rotation),this.polygonOffset===!0&&(r.polygonOffset=!0),this.polygonOffsetFactor!==0&&(r.polygonOffsetFactor=this.polygonOffsetFactor),this.polygonOffsetUnits!==0&&(r.polygonOffsetUnits=this.polygonOffsetUnits),this.linewidth!==1&&(r.linewidth=this.linewidth),this.dashSize!==void 0&&(r.dashSize=this.dashSize),this.gapSize!==void 0&&(r.gapSize=this.gapSize),this.scale!==void 0&&(r.scale=this.scale),this.dithering===!0&&(r.dithering=!0),this.alphaTest>0&&(r.alphaTest=this.alphaTest),this.premultipliedAlpha===!0&&(r.premultipliedAlpha=this.premultipliedAlpha),this.wireframe===!0&&(r.wireframe=this.wireframe),this.wireframeLinewidth>1&&(r.wireframeLinewidth=this.wireframeLinewidth),this.wireframeLinecap!=="round"&&(r.wireframeLinecap=this.wireframeLinecap),this.wireframeLinejoin!=="round"&&(r.wireframeLinejoin=this.wireframeLinejoin),this.morphTargets===!0&&(r.morphTargets=!0),this.skinning===!0&&(r.skinning=!0),this.visible===!1&&(r.visible=!1),JSON.stringify(this.userData)!=="{}"&&(r.userData=this.userData);function i(a){var s=[];for(var f in a){var u=a[f];delete u.metadata,s.push(u)}return s}if(t){var n=i(e.textures),o=i(e.images);n.length>0&&(r.textures=n),o.length>0&&(r.images=o)}return r},clone:function(){return new this.constructor().copy(this)},copy:function(e){this.name=e.name,this.fog=e.fog,this.lights=e.lights,this.blending=e.blending,this.side=e.side,this.flatShading=e.flatShading,this.vertexColors=e.vertexColors,this.opacity=e.opacity,this.transparent=e.transparent,this.blendSrc=e.blendSrc,this.blendDst=e.blendDst,this.blendEquation=e.blendEquation,this.blendSrcAlpha=e.blendSrcAlpha,this.blendDstAlpha=e.blendDstAlpha,this.blendEquationAlpha=e.blendEquationAlpha,this.depthFunc=e.depthFunc,this.depthTest=e.depthTest,this.depthWrite=e.depthWrite,this.colorWrite=e.colorWrite,this.precision=e.precision,this.polygonOffset=e.polygonOffset,this.polygonOffsetFactor=e.polygonOffsetFactor,this.polygonOffsetUnits=e.polygonOffsetUnits,this.dithering=e.dithering,this.alphaTest=e.alphaTest,this.premultipliedAlpha=e.premultipliedAlpha,this.visible=e.visible,this.userData=JSON.parse(JSON.stringify(e.userData)),this.clipShadows=e.clipShadows,this.clipIntersection=e.clipIntersection;var t=e.clippingPlanes,r=null;if(t!==null){var i=t.length;r=new Array(i);for(var n=0;n!==i;++n)r[n]=t[n].clone()}return this.clippingPlanes=r,this.shadowSide=e.shadowSide,this},dispose:function(){this.dispatchEvent({type:"dispose"})}});function ct(e){he.call(this),this.type="ShaderMaterial",this.defines={},this.uniforms={},this.vertexShader=`void main() {
	gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
}`,this.fragmentShader=`void main() {
	gl_FragColor = vec4( 1.0, 0.0, 0.0, 1.0 );
}`,this.linewidth=1,this.wireframe=!1,this.wireframeLinewidth=1,this.fog=!1,this.lights=!1,this.clipping=!1,this.skinning=!1,this.morphTargets=!1,this.morphNormals=!1,this.extensions={derivatives:!1,fragDepth:!1,drawBuffers:!1,shaderTextureLOD:!1},this.defaultAttributeValues={color:[1,1,1],uv:[0,0],uv2:[0,0]},this.index0AttributeName=void 0,this.uniformsNeedUpdate=!1,e!==void 0&&(e.attributes!==void 0&&console.error("THREE.ShaderMaterial: attributes should now be defined in THREE.BufferGeometry instead."),this.setValues(e))}ct.prototype=Object.create(he.prototype);ct.prototype.constructor=ct;ct.prototype.isShaderMaterial=!0;ct.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.fragmentShader=e.fragmentShader,this.vertexShader=e.vertexShader,this.uniforms=Nr(e.uniforms),this.defines=Object.assign({},e.defines),this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this.lights=e.lights,this.clipping=e.clipping,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this.morphNormals=e.morphNormals,this.extensions=e.extensions,this};ct.prototype.toJSON=function(e){var t=he.prototype.toJSON.call(this,e);t.uniforms={};for(var r in this.uniforms){var i=this.uniforms[r],n=i.value;n&&n.isTexture?t.uniforms[r]={type:"t",value:n.toJSON(e).uuid}:n&&n.isColor?t.uniforms[r]={type:"c",value:n.getHex()}:n&&n.isVector2?t.uniforms[r]={type:"v2",value:n.toArray()}:n&&n.isVector3?t.uniforms[r]={type:"v3",value:n.toArray()}:n&&n.isVector4?t.uniforms[r]={type:"v4",value:n.toArray()}:n&&n.isMatrix3?t.uniforms[r]={type:"m3",value:n.toArray()}:n&&n.isMatrix4?t.uniforms[r]={type:"m4",value:n.toArray()}:t.uniforms[r]={value:n}}Object.keys(this.defines).length>0&&(t.defines=this.defines),t.vertexShader=this.vertexShader,t.fragmentShader=this.fragmentShader;var o={};for(var a in this.extensions)this.extensions[a]===!0&&(o[a]=!0);return Object.keys(o).length>0&&(t.extensions=o),t};function kt(e,t){this.origin=e!==void 0?e:new x,this.direction=t!==void 0?t:new x}Object.assign(kt.prototype,{set:function(e,t){return this.origin.copy(e),this.direction.copy(t),this},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.origin.copy(e.origin),this.direction.copy(e.direction),this},at:function(e,t){return t===void 0&&(console.warn("THREE.Ray: .at() target is now required"),t=new x),t.copy(this.direction).multiplyScalar(e).add(this.origin)},lookAt:function(e){return this.direction.copy(e).sub(this.origin).normalize(),this},recast:function(){var e=new x;return function(r){return this.origin.copy(this.at(r,e)),this}}(),closestPointToPoint:function(e,t){t===void 0&&(console.warn("THREE.Ray: .closestPointToPoint() target is now required"),t=new x),t.subVectors(e,this.origin);var r=t.dot(this.direction);return r<0?t.copy(this.origin):t.copy(this.direction).multiplyScalar(r).add(this.origin)},distanceToPoint:function(e){return Math.sqrt(this.distanceSqToPoint(e))},distanceSqToPoint:function(){var e=new x;return function(r){var i=e.subVectors(r,this.origin).dot(this.direction);return i<0?this.origin.distanceToSquared(r):(e.copy(this.direction).multiplyScalar(i).add(this.origin),e.distanceToSquared(r))}}(),distanceSqToSegment:function(){var e=new x,t=new x,r=new x;return function(n,o,a,s){e.copy(n).add(o).multiplyScalar(.5),t.copy(o).sub(n).normalize(),r.copy(this.origin).sub(e);var f=n.distanceTo(o)*.5,u=-this.direction.dot(t),c=r.dot(this.direction),h=-r.dot(t),l=r.lengthSq(),p=Math.abs(1-u*u),d,m,v,g;if(p>0)if(d=u*h-c,m=u*c-h,g=f*p,d>=0)if(m>=-g)if(m<=g){var b=1/p;d*=b,m*=b,v=d*(d+u*m+2*c)+m*(u*d+m+2*h)+l}else m=f,d=Math.max(0,-(u*m+c)),v=-d*d+m*(m+2*h)+l;else m=-f,d=Math.max(0,-(u*m+c)),v=-d*d+m*(m+2*h)+l;else m<=-g?(d=Math.max(0,-(-u*f+c)),m=d>0?-f:Math.min(Math.max(-f,-h),f),v=-d*d+m*(m+2*h)+l):m<=g?(d=0,m=Math.min(Math.max(-f,-h),f),v=m*(m+2*h)+l):(d=Math.max(0,-(u*f+c)),m=d>0?f:Math.min(Math.max(-f,-h),f),v=-d*d+m*(m+2*h)+l);else m=u>0?-f:f,d=Math.max(0,-(u*m+c)),v=-d*d+m*(m+2*h)+l;return a&&a.copy(this.direction).multiplyScalar(d).add(this.origin),s&&s.copy(t).multiplyScalar(m).add(e),v}}(),intersectSphere:function(){var e=new x;return function(r,i){e.subVectors(r.center,this.origin);var n=e.dot(this.direction),o=e.dot(e)-n*n,a=r.radius*r.radius;if(o>a)return null;var s=Math.sqrt(a-o),f=n-s,u=n+s;return f<0&&u<0?null:f<0?this.at(u,i):this.at(f,i)}}(),intersectsSphere:function(e){return this.distanceSqToPoint(e.center)<=e.radius*e.radius},distanceToPlane:function(e){var t=e.normal.dot(this.direction);if(t===0)return e.distanceToPoint(this.origin)===0?0:null;var r=-(this.origin.dot(e.normal)+e.constant)/t;return r>=0?r:null},intersectPlane:function(e,t){var r=this.distanceToPlane(e);return r===null?null:this.at(r,t)},intersectsPlane:function(e){var t=e.distanceToPoint(this.origin);if(t===0)return!0;var r=e.normal.dot(this.direction);return r*t<0},intersectBox:function(e,t){var r,i,n,o,a,s,f=1/this.direction.x,u=1/this.direction.y,c=1/this.direction.z,h=this.origin;return f>=0?(r=(e.min.x-h.x)*f,i=(e.max.x-h.x)*f):(r=(e.max.x-h.x)*f,i=(e.min.x-h.x)*f),u>=0?(n=(e.min.y-h.y)*u,o=(e.max.y-h.y)*u):(n=(e.max.y-h.y)*u,o=(e.min.y-h.y)*u),r>o||n>i||((n>r||r!==r)&&(r=n),(o<i||i!==i)&&(i=o),c>=0?(a=(e.min.z-h.z)*c,s=(e.max.z-h.z)*c):(a=(e.max.z-h.z)*c,s=(e.min.z-h.z)*c),r>s||a>i)||((a>r||r!==r)&&(r=a),(s<i||i!==i)&&(i=s),i<0)?null:this.at(r>=0?r:i,t)},intersectsBox:function(){var e=new x;return function(r){return this.intersectBox(r,e)!==null}}(),intersectTriangle:function(){var e=new x,t=new x,r=new x,i=new x;return function(o,a,s,f,u){t.subVectors(a,o),r.subVectors(s,o),i.crossVectors(t,r);var c=this.direction.dot(i),h;if(c>0){if(f)return null;h=1}else if(c<0)h=-1,c=-c;else return null;e.subVectors(this.origin,o);var l=h*this.direction.dot(r.crossVectors(e,r));if(l<0)return null;var p=h*this.direction.dot(t.cross(e));if(p<0||l+p>c)return null;var d=-h*e.dot(i);return d<0?null:this.at(d/c,u)}}(),applyMatrix4:function(e){return this.origin.applyMatrix4(e),this.direction.transformDirection(e),this},equals:function(e){return e.origin.equals(this.origin)&&e.direction.equals(this.direction)}});function nt(e,t,r){this.a=e!==void 0?e:new x,this.b=t!==void 0?t:new x,this.c=r!==void 0?r:new x}Object.assign(nt,{getNormal:function(){var e=new x;return function(r,i,n,o){o===void 0&&(console.warn("THREE.Triangle: .getNormal() target is now required"),o=new x),o.subVectors(n,i),e.subVectors(r,i),o.cross(e);var a=o.lengthSq();return a>0?o.multiplyScalar(1/Math.sqrt(a)):o.set(0,0,0)}}(),getBarycoord:function(){var e=new x,t=new x,r=new x;return function(n,o,a,s,f){e.subVectors(s,o),t.subVectors(a,o),r.subVectors(n,o);var u=e.dot(e),c=e.dot(t),h=e.dot(r),l=t.dot(t),p=t.dot(r),d=u*l-c*c;if(f===void 0&&(console.warn("THREE.Triangle: .getBarycoord() target is now required"),f=new x),d===0)return f.set(-2,-1,-1);var m=1/d,v=(l*h-c*p)*m,g=(u*p-c*h)*m;return f.set(1-v-g,g,v)}}(),containsPoint:function(){var e=new x;return function(r,i,n,o){return nt.getBarycoord(r,i,n,o,e),e.x>=0&&e.y>=0&&e.x+e.y<=1}}(),getUV:function(){var e=new x;return function(r,i,n,o,a,s,f,u){return this.getBarycoord(r,i,n,o,e),u.set(0,0),u.addScaledVector(a,e.x),u.addScaledVector(s,e.y),u.addScaledVector(f,e.z),u}}()});Object.assign(nt.prototype,{set:function(e,t,r){return this.a.copy(e),this.b.copy(t),this.c.copy(r),this},setFromPointsAndIndices:function(e,t,r,i){return this.a.copy(e[t]),this.b.copy(e[r]),this.c.copy(e[i]),this},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.a.copy(e.a),this.b.copy(e.b),this.c.copy(e.c),this},getArea:function(){var e=new x,t=new x;return function(){return e.subVectors(this.c,this.b),t.subVectors(this.a,this.b),e.cross(t).length()*.5}}(),getMidpoint:function(e){return e===void 0&&(console.warn("THREE.Triangle: .getMidpoint() target is now required"),e=new x),e.addVectors(this.a,this.b).add(this.c).multiplyScalar(1/3)},getNormal:function(e){return nt.getNormal(this.a,this.b,this.c,e)},getPlane:function(e){return e===void 0&&(console.warn("THREE.Triangle: .getPlane() target is now required"),e=new x),e.setFromCoplanarPoints(this.a,this.b,this.c)},getBarycoord:function(e,t){return nt.getBarycoord(e,this.a,this.b,this.c,t)},containsPoint:function(e){return nt.containsPoint(e,this.a,this.b,this.c)},getUV:function(e,t,r,i,n){return nt.getUV(e,this.a,this.b,this.c,t,r,i,n)},intersectsBox:function(e){return e.intersectsTriangle(this)},closestPointToPoint:function(){var e=new x,t=new x,r=new x,i=new x,n=new x,o=new x;return function(s,f){f===void 0&&(console.warn("THREE.Triangle: .closestPointToPoint() target is now required"),f=new x);var u=this.a,c=this.b,h=this.c,l,p;e.subVectors(c,u),t.subVectors(h,u),i.subVectors(s,u);var d=e.dot(i),m=t.dot(i);if(d<=0&&m<=0)return f.copy(u);n.subVectors(s,c);var v=e.dot(n),g=t.dot(n);if(v>=0&&g<=v)return f.copy(c);var b=d*g-v*m;if(b<=0&&d>=0&&v<=0)return l=d/(d-v),f.copy(u).addScaledVector(e,l);o.subVectors(s,h);var w=e.dot(o),y=t.dot(o);if(y>=0&&w<=y)return f.copy(h);var S=w*m-d*y;if(S<=0&&m>=0&&y<=0)return p=m/(m-y),f.copy(u).addScaledVector(t,p);var R=v*y-w*g;if(R<=0&&g-v>=0&&w-y>=0)return r.subVectors(h,c),p=(g-v)/(g-v+(w-y)),f.copy(c).addScaledVector(r,p);var B=1/(R+S+b);return l=S*B,p=b*B,f.copy(u).addScaledVector(e,l).addScaledVector(t,p)}}(),equals:function(e){return e.a.equals(this.a)&&e.b.equals(this.b)&&e.c.equals(this.c)}});function ot(e){he.call(this),this.type="MeshBasicMaterial",this.color=new J(16777215),this.map=null,this.lightMap=null,this.lightMapIntensity=1,this.aoMap=null,this.aoMapIntensity=1,this.specularMap=null,this.alphaMap=null,this.envMap=null,this.combine=Cr,this.reflectivity=1,this.refractionRatio=.98,this.wireframe=!1,this.wireframeLinewidth=1,this.wireframeLinecap="round",this.wireframeLinejoin="round",this.skinning=!1,this.morphTargets=!1,this.lights=!1,this.setValues(e)}ot.prototype=Object.create(he.prototype);ot.prototype.constructor=ot;ot.prototype.isMeshBasicMaterial=!0;ot.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.color.copy(e.color),this.map=e.map,this.lightMap=e.lightMap,this.lightMapIntensity=e.lightMapIntensity,this.aoMap=e.aoMap,this.aoMapIntensity=e.aoMapIntensity,this.specularMap=e.specularMap,this.alphaMap=e.alphaMap,this.envMap=e.envMap,this.combine=e.combine,this.reflectivity=e.reflectivity,this.refractionRatio=e.refractionRatio,this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this.wireframeLinecap=e.wireframeLinecap,this.wireframeLinejoin=e.wireframeLinejoin,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this};function Xe(e,t){k.call(this),this.type="Mesh",this.geometry=e!==void 0?e:new z,this.material=t!==void 0?t:new ot({color:Math.random()*16777215}),this.drawMode=Wo,this.updateMorphTargets()}Xe.prototype=Object.assign(Object.create(k.prototype),{constructor:Xe,isMesh:!0,setDrawMode:function(e){this.drawMode=e},copy:function(e){return k.prototype.copy.call(this,e),this.drawMode=e.drawMode,e.morphTargetInfluences!==void 0&&(this.morphTargetInfluences=e.morphTargetInfluences.slice()),e.morphTargetDictionary!==void 0&&(this.morphTargetDictionary=Object.assign({},e.morphTargetDictionary)),this},updateMorphTargets:function(){var e=this.geometry,t,r,i;if(e.isBufferGeometry){var n=e.morphAttributes,o=Object.keys(n);if(o.length>0){var a=n[o[0]];if(a!==void 0)for(this.morphTargetInfluences=[],this.morphTargetDictionary={},t=0,r=a.length;t<r;t++)i=a[t].name||String(t),this.morphTargetInfluences.push(0),this.morphTargetDictionary[i]=t}}else{var s=e.morphTargets;s!==void 0&&s.length>0&&console.error("THREE.Mesh.updateMorphTargets() no longer supports THREE.Geometry. Use THREE.BufferGeometry instead.")}},raycast:function(){var e=new ee,t=new kt,r=new it,i=new x,n=new x,o=new x,a=new x,s=new x,f=new x,u=new O,c=new O,h=new O,l=new x,p=new x;function d(v,g,b,w,y,S,R,B){var P;if(g.side===Ze?P=w.intersectTriangle(R,S,y,!0,B):P=w.intersectTriangle(y,S,R,g.side!==or,B),P===null)return null;p.copy(B),p.applyMatrix4(v.matrixWorld);var A=b.ray.origin.distanceTo(p);return A<b.near||A>b.far?null:{distance:A,point:p.clone(),object:v}}function m(v,g,b,w,y,S,R,B,P){i.fromBufferAttribute(y,R),n.fromBufferAttribute(y,B),o.fromBufferAttribute(y,P);var A=d(v,g,b,w,i,n,o,l);if(A){S&&(u.fromBufferAttribute(S,R),c.fromBufferAttribute(S,B),h.fromBufferAttribute(S,P),A.uv=nt.getUV(l,i,n,o,u,c,h,new O));var D=new Gr(R,B,P);nt.getNormal(i,n,o,D.normal),A.face=D}return A}return function(g,b){var w=this.geometry,y=this.material,S=this.matrixWorld;if(y!==void 0&&(w.boundingSphere===null&&w.computeBoundingSphere(),r.copy(w.boundingSphere),r.applyMatrix4(S),g.ray.intersectsSphere(r)!==!1&&(e.getInverse(S),t.copy(g.ray).applyMatrix4(e),!(w.boundingBox!==null&&t.intersectsBox(w.boundingBox)===!1)))){var R;if(w.isBufferGeometry){var B,P,A,D=w.index,I=w.attributes.position,H=w.attributes.uv,X=w.groups,j=w.drawRange,V,$,K,Q,E,T,U,L;if(D!==null)if(Array.isArray(y))for(V=0,K=X.length;V<K;V++)for(E=X[V],T=y[E.materialIndex],U=Math.max(E.start,j.start),L=Math.min(E.start+E.count,j.start+j.count),$=U,Q=L;$<Q;$+=3)B=D.getX($),P=D.getX($+1),A=D.getX($+2),R=m(this,T,g,t,I,H,B,P,A),R&&(R.faceIndex=Math.floor($/3),b.push(R));else for(U=Math.max(0,j.start),L=Math.min(D.count,j.start+j.count),V=U,K=L;V<K;V+=3)B=D.getX(V),P=D.getX(V+1),A=D.getX(V+2),R=m(this,y,g,t,I,H,B,P,A),R&&(R.faceIndex=Math.floor(V/3),b.push(R));else if(I!==void 0)if(Array.isArray(y))for(V=0,K=X.length;V<K;V++)for(E=X[V],T=y[E.materialIndex],U=Math.max(E.start,j.start),L=Math.min(E.start+E.count,j.start+j.count),$=U,Q=L;$<Q;$+=3)B=$,P=$+1,A=$+2,R=m(this,T,g,t,I,H,B,P,A),R&&(R.faceIndex=Math.floor($/3),b.push(R));else for(U=Math.max(0,j.start),L=Math.min(I.count,j.start+j.count),V=U,K=L;V<K;V+=3)B=V,P=V+1,A=V+2,R=m(this,y,g,t,I,H,B,P,A),R&&(R.faceIndex=Math.floor(V/3),b.push(R))}else if(w.isGeometry){var te,N,q,Z=Array.isArray(y),ve=w.vertices,ge=w.faces,me,W=w.faceVertexUvs[0];W.length>0&&(me=W);for(var pe=0,Fe=ge.length;pe<Fe;pe++){var Ee=ge[pe],_t=Z?y[Ee.materialIndex]:y;if(_t!==void 0){if(te=ve[Ee.a],N=ve[Ee.b],q=ve[Ee.c],_t.morphTargets===!0){var Je=w.morphTargets,st=this.morphTargetInfluences;i.set(0,0,0),n.set(0,0,0),o.set(0,0,0);for(var dt=0,mr=Je.length;dt<mr;dt++){var Jt=st[dt];if(Jt!==0){var et=Je[dt].vertices;i.addScaledVector(a.subVectors(et[Ee.a],te),Jt),n.addScaledVector(s.subVectors(et[Ee.b],N),Jt),o.addScaledVector(f.subVectors(et[Ee.c],q),Jt)}}i.add(te),n.add(N),o.add(q),te=i,N=n,q=o}if(R=d(this,_t,g,t,te,N,q,l),R){if(me&&me[pe]){var ft=me[pe];u.copy(ft[0]),c.copy(ft[1]),h.copy(ft[2]),R.uv=nt.getUV(l,te,N,q,u,c,h,new O)}R.face=Ee,R.faceIndex=pe,b.push(R)}}}}}}}(),clone:function(){return new this.constructor(this.geometry,this.material).copy(this)}});function Uc(e,t,r,i){var n=new J(0),o=0,a,s,f=null,u=0;function c(l,p,d,m){var v=p.background;if(v===null?(h(n,o),f=null,u=0):v&&v.isColor&&(h(v,1),m=!0,f=null,u=0),(e.autoClear||m)&&e.clear(e.autoClearColor,e.autoClearDepth,e.autoClearStencil),v&&(v.isCubeTexture||v.isWebGLRenderTargetCube)){s===void 0&&(s=new Xe(new kr(1,1,1),new ct({type:"BackgroundCubeMaterial",uniforms:Nr(Vt.cube.uniforms),vertexShader:Vt.cube.vertexShader,fragmentShader:Vt.cube.fragmentShader,side:Ze,depthTest:!0,depthWrite:!1,fog:!1})),s.geometry.removeAttribute("normal"),s.geometry.removeAttribute("uv"),s.onBeforeRender=function(b,w,y){this.matrixWorld.copyPosition(y.matrixWorld)},Object.defineProperty(s.material,"map",{get:function(){return this.uniforms.tCube.value}}),r.update(s));var g=v.isWebGLRenderTargetCube?v.texture:v;s.material.uniforms.tCube.value=g,s.material.uniforms.tFlip.value=v.isWebGLRenderTargetCube?1:-1,(f!==v||u!==g.version)&&(s.material.needsUpdate=!0,f=v,u=g.version),l.unshift(s,s.geometry,s.material,0,0,null)}else v&&v.isTexture&&(a===void 0&&(a=new Xe(new Qt(2,2),new ct({type:"BackgroundMaterial",uniforms:Nr(Vt.background.uniforms),vertexShader:Vt.background.vertexShader,fragmentShader:Vt.background.fragmentShader,side:gr,depthTest:!1,depthWrite:!1,fog:!1})),a.geometry.removeAttribute("normal"),Object.defineProperty(a.material,"map",{get:function(){return this.uniforms.t2D.value}}),r.update(a)),a.material.uniforms.t2D.value=v,v.matrixAutoUpdate===!0&&v.updateMatrix(),a.material.uniforms.uvTransform.value.copy(v.matrix),(f!==v||u!==v.version)&&(a.material.needsUpdate=!0,f=v,u=v.version),l.unshift(a,a.geometry,a.material,0,0,null))}function h(l,p){t.buffers.color.setClear(l.r,l.g,l.b,p,i)}return{getClearColor:function(){return n},setClearColor:function(l,p){n.set(l),o=p!==void 0?p:1,h(n,o)},getClearAlpha:function(){return o},setClearAlpha:function(l){o=l,h(n,o)},render:c}}function Nc(e,t,r,i){var n;function o(f){n=f}function a(f,u){e.drawArrays(n,f,u),r.update(u,n)}function s(f,u,c){var h;if(i.isWebGL2)h=e;else if(h=t.get("ANGLE_instanced_arrays"),h===null){console.error("THREE.WebGLBufferRenderer: using THREE.InstancedBufferGeometry but hardware does not support extension ANGLE_instanced_arrays.");return}h[i.isWebGL2?"drawArraysInstanced":"drawArraysInstancedANGLE"](n,u,c,f.maxInstancedCount),r.update(c,n,f.maxInstancedCount)}this.setMode=o,this.render=a,this.renderInstances=s}function Gc(e,t,r){var i;function n(){if(i!==void 0)return i;var R=t.get("EXT_texture_filter_anisotropic");return R!==null?i=e.getParameter(R.MAX_TEXTURE_MAX_ANISOTROPY_EXT):i=0,i}function o(R){if(R==="highp"){if(e.getShaderPrecisionFormat(e.VERTEX_SHADER,e.HIGH_FLOAT).precision>0&&e.getShaderPrecisionFormat(e.FRAGMENT_SHADER,e.HIGH_FLOAT).precision>0)return"highp";R="mediump"}return R==="mediump"&&e.getShaderPrecisionFormat(e.VERTEX_SHADER,e.MEDIUM_FLOAT).precision>0&&e.getShaderPrecisionFormat(e.FRAGMENT_SHADER,e.MEDIUM_FLOAT).precision>0?"mediump":"lowp"}var a=typeof WebGL2RenderingContext<"u"&&e instanceof WebGL2RenderingContext,s=r.precision!==void 0?r.precision:"highp",f=o(s);f!==s&&(console.warn("THREE.WebGLRenderer:",s,"not supported, using",f,"instead."),s=f);var u=r.logarithmicDepthBuffer===!0,c=e.getParameter(e.MAX_TEXTURE_IMAGE_UNITS),h=e.getParameter(e.MAX_VERTEX_TEXTURE_IMAGE_UNITS),l=e.getParameter(e.MAX_TEXTURE_SIZE),p=e.getParameter(e.MAX_CUBE_MAP_TEXTURE_SIZE),d=e.getParameter(e.MAX_VERTEX_ATTRIBS),m=e.getParameter(e.MAX_VERTEX_UNIFORM_VECTORS),v=e.getParameter(e.MAX_VARYING_VECTORS),g=e.getParameter(e.MAX_FRAGMENT_UNIFORM_VECTORS),b=h>0,w=a||!!t.get("OES_texture_float"),y=b&&w,S=a?e.getParameter(e.MAX_SAMPLES):0;return{isWebGL2:a,getMaxAnisotropy:n,getMaxPrecision:o,precision:s,logarithmicDepthBuffer:u,maxTextures:c,maxVertexTextures:h,maxTextureSize:l,maxCubemapSize:p,maxAttributes:d,maxVertexUniforms:m,maxVaryings:v,maxFragmentUniforms:g,vertexTextures:b,floatFragmentTextures:w,floatVertexTextures:y,maxSamples:S}}function zc(){var e=this,t=null,r=0,i=!1,n=!1,o=new Ut,a=new Oe,s={value:null,needsUpdate:!1};this.uniform=s,this.numPlanes=0,this.numIntersection=0,this.init=function(c,h,l){var p=c.length!==0||h||r!==0||i;return i=h,t=u(c,l,0),r=c.length,p},this.beginShadows=function(){n=!0,u(null)},this.endShadows=function(){n=!1,f()},this.setState=function(c,h,l,p,d,m){if(!i||c===null||c.length===0||n&&!l)n?u(null):f();else{var v=n?0:r,g=v*4,b=d.clippingState||null;s.value=b,b=u(c,p,g,m);for(var w=0;w!==g;++w)b[w]=t[w];d.clippingState=b,this.numIntersection=h?this.numPlanes:0,this.numPlanes+=v}};function f(){s.value!==t&&(s.value=t,s.needsUpdate=r>0),e.numPlanes=r,e.numIntersection=0}function u(c,h,l,p){var d=c!==null?c.length:0,m=null;if(d!==0){if(m=s.value,p!==!0||m===null){var v=l+d*4,g=h.matrixWorldInverse;a.getNormalMatrix(g),(m===null||m.length<v)&&(m=new Float32Array(v));for(var b=0,w=l;b!==d;++b,w+=4)o.copy(c[b]).applyMatrix4(g,a),o.normal.toArray(m,w),m[w+3]=o.constant}s.value=m,s.needsUpdate=!0}return e.numPlanes=d,m}}function Hc(e){var t={};return{get:function(r){if(t[r]!==void 0)return t[r];var i;switch(r){case"WEBGL_depth_texture":i=e.getExtension("WEBGL_depth_texture")||e.getExtension("MOZ_WEBGL_depth_texture")||e.getExtension("WEBKIT_WEBGL_depth_texture");break;case"EXT_texture_filter_anisotropic":i=e.getExtension("EXT_texture_filter_anisotropic")||e.getExtension("MOZ_EXT_texture_filter_anisotropic")||e.getExtension("WEBKIT_EXT_texture_filter_anisotropic");break;case"WEBGL_compressed_texture_s3tc":i=e.getExtension("WEBGL_compressed_texture_s3tc")||e.getExtension("MOZ_WEBGL_compressed_texture_s3tc")||e.getExtension("WEBKIT_WEBGL_compressed_texture_s3tc");break;case"WEBGL_compressed_texture_pvrtc":i=e.getExtension("WEBGL_compressed_texture_pvrtc")||e.getExtension("WEBKIT_WEBGL_compressed_texture_pvrtc");break;default:i=e.getExtension(r)}return i===null&&console.warn("THREE.WebGLRenderer: "+r+" extension not supported."),t[r]=i,i}}}function Vc(e,t,r){var i={},n={};function o(u){var c=u.target,h=i[c.id];h.index!==null&&t.remove(h.index);for(var l in h.attributes)t.remove(h.attributes[l]);c.removeEventListener("dispose",o),delete i[c.id];var p=n[h.id];p&&(t.remove(p),delete n[h.id]),r.memory.geometries--}function a(u,c){var h=i[c.id];return h||(c.addEventListener("dispose",o),c.isBufferGeometry?h=c:c.isGeometry&&(c._bufferGeometry===void 0&&(c._bufferGeometry=new z().setFromObject(u)),h=c._bufferGeometry),i[c.id]=h,r.memory.geometries++,h)}function s(u){var c=u.index,h=u.attributes;c!==null&&t.update(c,e.ELEMENT_ARRAY_BUFFER);for(var l in h)t.update(h[l],e.ARRAY_BUFFER);var p=u.morphAttributes;for(var l in p)for(var d=p[l],m=0,v=d.length;m<v;m++)t.update(d[m],e.ARRAY_BUFFER)}function f(u){var c=n[u.id];if(c)return c;var h=[],l=u.index,p=u.attributes;if(l!==null)for(var d=l.array,m=0,v=d.length;m<v;m+=3){var g=d[m+0],b=d[m+1],w=d[m+2];h.push(g,b,b,w,w,g)}else for(var d=p.position.array,m=0,v=d.length/3-1;m<v;m+=3){var g=m+0,b=m+1,w=m+2;h.push(g,b,b,w,w,g)}return c=new($o(h)>65535?Vr:Hr)(h,1),t.update(c,e.ELEMENT_ARRAY_BUFFER),n[u.id]=c,c}return{get:a,update:s,getWireframeAttribute:f}}function kc(e,t,r,i){var n;function o(h){n=h}var a,s;function f(h){a=h.type,s=h.bytesPerElement}function u(h,l){e.drawElements(n,l,a,h*s),r.update(l,n)}function c(h,l,p){var d;if(i.isWebGL2)d=e;else{var d=t.get("ANGLE_instanced_arrays");if(d===null){console.error("THREE.WebGLIndexedBufferRenderer: using THREE.InstancedBufferGeometry but hardware does not support extension ANGLE_instanced_arrays.");return}}d[i.isWebGL2?"drawElementsInstanced":"drawElementsInstancedANGLE"](n,p,a,l*s,h.maxInstancedCount),r.update(p,n,h.maxInstancedCount)}this.setMode=o,this.setIndex=f,this.render=u,this.renderInstances=c}function Wc(e){var t={geometries:0,textures:0},r={frame:0,calls:0,triangles:0,points:0,lines:0};function i(o,a,s){switch(s=s||1,r.calls++,a){case e.TRIANGLES:r.triangles+=s*(o/3);break;case e.TRIANGLE_STRIP:case e.TRIANGLE_FAN:r.triangles+=s*(o-2);break;case e.LINES:r.lines+=s*(o/2);break;case e.LINE_STRIP:r.lines+=s*(o-1);break;case e.LINE_LOOP:r.lines+=s*o;break;case e.POINTS:r.points+=s*o;break;default:console.error("THREE.WebGLInfo: Unknown draw mode:",a);break}}function n(){r.frame++,r.calls=0,r.triangles=0,r.points=0,r.lines=0}return{memory:t,render:r,programs:null,autoReset:!0,reset:n,update:i}}function cl(e,t){return Math.abs(t[1])-Math.abs(e[1])}function Xc(e){var t={},r=new Float32Array(8);function i(n,o,a,s){var f=n.morphTargetInfluences,u=f.length,c=t[o.id];if(c===void 0){c=[];for(var h=0;h<u;h++)c[h]=[h,0];t[o.id]=c}for(var l=a.morphTargets&&o.morphAttributes.position,p=a.morphNormals&&o.morphAttributes.normal,h=0;h<u;h++){var d=c[h];d[1]!==0&&(l&&o.removeAttribute("morphTarget"+h),p&&o.removeAttribute("morphNormal"+h))}for(var h=0;h<u;h++){var d=c[h];d[0]=h,d[1]=f[h]}c.sort(cl);for(var h=0;h<8;h++){var d=c[h];if(d){var m=d[0],v=d[1];if(v){l&&o.addAttribute("morphTarget"+h,l[m]),p&&o.addAttribute("morphNormal"+h,p[m]),r[h]=v;continue}}r[h]=0}s.getUniforms().setValue(e,"morphTargetInfluences",r)}return{update:i}}function jc(e,t){var r={};function i(o){var a=t.render.frame,s=o.geometry,f=e.get(o,s);return r[f.id]!==a&&(s.isGeometry&&f.updateFromObject(o),e.update(f),r[f.id]=a),f}function n(){r={}}return{update:i,dispose:n}}function Wt(e,t,r,i,n,o,a,s,f,u){e=e!==void 0?e:[],t=t!==void 0?t:Li,_e.call(this,e,t,r,i,n,o,a,s,f,u),this.flipY=!1}Wt.prototype=Object.create(_e.prototype);Wt.prototype.constructor=Wt;Wt.prototype.isCubeTexture=!0;Object.defineProperty(Wt.prototype,"images",{get:function(){return this.image},set:function(e){this.image=e}});function oi(e,t,r,i){_e.call(this,null),this.image={data:e,width:t,height:r,depth:i},this.magFilter=ke,this.minFilter=ke,this.generateMipmaps=!1,this.flipY=!1}oi.prototype=Object.create(_e.prototype);oi.prototype.constructor=oi;oi.prototype.isDataTexture3D=!0;var $c=new _e,hl=new oi,eh=new Wt;function th(){this.seq=[],this.map={}}var qc=[],Yc=[],Zc=new Float32Array(16),Jc=new Float32Array(9),Qc=new Float32Array(4);function zi(e,t,r){var i=e[0];if(i<=0||i>0)return e;var n=t*r,o=qc[n];if(o===void 0&&(o=new Float32Array(n),qc[n]=o),t!==0){i.toArray(o,0);for(var a=1,s=0;a!==t;++a)s+=r,e[a].toArray(o,s)}return o}function Qe(e,t){if(e.length!==t.length)return!1;for(var r=0,i=e.length;r<i;r++)if(e[r]!==t[r])return!1;return!0}function gt(e,t){for(var r=0,i=t.length;r<i;r++)e[r]=t[r]}function rh(e,t){var r=Yc[t];r===void 0&&(r=new Int32Array(t),Yc[t]=r);for(var i=0;i!==t;++i)r[i]=e.allocTextureUnit();return r}function ll(e,t){var r=this.cache;r[0]!==t&&(e.uniform1f(this.addr,t),r[0]=t)}function pl(e,t){var r=this.cache;r[0]!==t&&(e.uniform1i(this.addr,t),r[0]=t)}function dl(e,t){var r=this.cache;if(t.x!==void 0)(r[0]!==t.x||r[1]!==t.y)&&(e.uniform2f(this.addr,t.x,t.y),r[0]=t.x,r[1]=t.y);else{if(Qe(r,t))return;e.uniform2fv(this.addr,t),gt(r,t)}}function ml(e,t){var r=this.cache;if(t.x!==void 0)(r[0]!==t.x||r[1]!==t.y||r[2]!==t.z)&&(e.uniform3f(this.addr,t.x,t.y,t.z),r[0]=t.x,r[1]=t.y,r[2]=t.z);else if(t.r!==void 0)(r[0]!==t.r||r[1]!==t.g||r[2]!==t.b)&&(e.uniform3f(this.addr,t.r,t.g,t.b),r[0]=t.r,r[1]=t.g,r[2]=t.b);else{if(Qe(r,t))return;e.uniform3fv(this.addr,t),gt(r,t)}}function vl(e,t){var r=this.cache;if(t.x!==void 0)(r[0]!==t.x||r[1]!==t.y||r[2]!==t.z||r[3]!==t.w)&&(e.uniform4f(this.addr,t.x,t.y,t.z,t.w),r[0]=t.x,r[1]=t.y,r[2]=t.z,r[3]=t.w);else{if(Qe(r,t))return;e.uniform4fv(this.addr,t),gt(r,t)}}function gl(e,t){var r=this.cache,i=t.elements;if(i===void 0){if(Qe(r,t))return;e.uniformMatrix2fv(this.addr,!1,t),gt(r,t)}else{if(Qe(r,i))return;Qc.set(i),e.uniformMatrix2fv(this.addr,!1,Qc),gt(r,i)}}function yl(e,t){var r=this.cache,i=t.elements;if(i===void 0){if(Qe(r,t))return;e.uniformMatrix3fv(this.addr,!1,t),gt(r,t)}else{if(Qe(r,i))return;Jc.set(i),e.uniformMatrix3fv(this.addr,!1,Jc),gt(r,i)}}function xl(e,t){var r=this.cache,i=t.elements;if(i===void 0){if(Qe(r,t))return;e.uniformMatrix4fv(this.addr,!1,t),gt(r,t)}else{if(Qe(r,i))return;Zc.set(i),e.uniformMatrix4fv(this.addr,!1,Zc),gt(r,i)}}function _l(e,t,r){var i=this.cache,n=r.allocTextureUnit();i[0]!==n&&(e.uniform1i(this.addr,n),i[0]=n),r.setTexture2D(t||$c,n)}function bl(e,t,r){var i=this.cache,n=r.allocTextureUnit();i[0]!==n&&(e.uniform1i(this.addr,n),i[0]=n),r.setTexture3D(t||hl,n)}function wl(e,t,r){var i=this.cache,n=r.allocTextureUnit();i[0]!==n&&(e.uniform1i(this.addr,n),i[0]=n),r.setTextureCube(t||eh,n)}function ih(e,t){var r=this.cache;Qe(r,t)||(e.uniform2iv(this.addr,t),gt(r,t))}function nh(e,t){var r=this.cache;Qe(r,t)||(e.uniform3iv(this.addr,t),gt(r,t))}function oh(e,t){var r=this.cache;Qe(r,t)||(e.uniform4iv(this.addr,t),gt(r,t))}function Ml(e){switch(e){case 5126:return ll;case 35664:return dl;case 35665:return ml;case 35666:return vl;case 35674:return gl;case 35675:return yl;case 35676:return xl;case 35678:case 36198:return _l;case 35679:return bl;case 35680:return wl;case 5124:case 35670:return pl;case 35667:case 35671:return ih;case 35668:case 35672:return nh;case 35669:case 35673:return oh}}function El(e,t){var r=this.cache;Qe(r,t)||(e.uniform1fv(this.addr,t),gt(r,t))}function Tl(e,t){var r=this.cache;Qe(r,t)||(e.uniform1iv(this.addr,t),gt(r,t))}function Sl(e,t){var r=this.cache,i=zi(t,this.size,2);Qe(r,i)||(e.uniform2fv(this.addr,i),this.updateCache(i))}function Al(e,t){var r=this.cache,i=zi(t,this.size,3);Qe(r,i)||(e.uniform3fv(this.addr,i),this.updateCache(i))}function Ll(e,t){var r=this.cache,i=zi(t,this.size,4);Qe(r,i)||(e.uniform4fv(this.addr,i),this.updateCache(i))}function Rl(e,t){var r=this.cache,i=zi(t,this.size,4);Qe(r,i)||(e.uniformMatrix2fv(this.addr,!1,i),this.updateCache(i))}function Cl(e,t){var r=this.cache,i=zi(t,this.size,9);Qe(r,i)||(e.uniformMatrix3fv(this.addr,!1,i),this.updateCache(i))}function Pl(e,t){var r=this.cache,i=zi(t,this.size,16);Qe(r,i)||(e.uniformMatrix4fv(this.addr,!1,i),this.updateCache(i))}function Bl(e,t,r){var i=this.cache,n=t.length,o=rh(r,n);Qe(i,o)===!1&&(e.uniform1iv(this.addr,o),gt(i,o));for(var a=0;a!==n;++a)r.setTexture2D(t[a]||$c,o[a])}function Fl(e,t,r){var i=this.cache,n=t.length,o=rh(r,n);Qe(i,o)===!1&&(e.uniform1iv(this.addr,o),gt(i,o));for(var a=0;a!==n;++a)r.setTextureCube(t[a]||eh,o[a])}function Dl(e){switch(e){case 5126:return El;case 35664:return Sl;case 35665:return Al;case 35666:return Ll;case 35674:return Rl;case 35675:return Cl;case 35676:return Pl;case 35678:return Bl;case 35680:return Fl;case 5124:case 35670:return Tl;case 35667:case 35671:return ih;case 35668:case 35672:return nh;case 35669:case 35673:return oh}}function Il(e,t,r){this.id=e,this.addr=r,this.cache=[],this.setValue=Ml(t.type)}function ah(e,t,r){this.id=e,this.addr=r,this.cache=[],this.size=t.size,this.setValue=Dl(t.type)}ah.prototype.updateCache=function(e){var t=this.cache;e instanceof Float32Array&&t.length!==e.length&&(this.cache=new Float32Array(e.length)),gt(t,e)};function sh(e){this.id=e,th.call(this)}sh.prototype.setValue=function(e,t,r){for(var i=this.seq,n=0,o=i.length;n!==o;++n){var a=i[n];a.setValue(e,t[a.id],r)}};var Na=/([\w\d_]+)(\])?(\[|\.)?/g;function Kc(e,t){e.seq.push(t),e.map[t.id]=t}function Ol(e,t,r){var i=e.name,n=i.length;for(Na.lastIndex=0;;){var o=Na.exec(i),a=Na.lastIndex,s=o[1],f=o[2]==="]",u=o[3];if(f&&(s=s|0),u===void 0||u==="["&&a+2===n){Kc(r,u===void 0?new Il(s,e,t):new ah(s,e,t));break}else{var c=r.map,h=c[s];h===void 0&&(h=new sh(s),Kc(r,h)),r=h}}}function fr(e,t,r){th.call(this),this.renderer=r;for(var i=e.getProgramParameter(t,e.ACTIVE_UNIFORMS),n=0;n<i;++n){var o=e.getActiveUniform(t,n),a=e.getUniformLocation(t,o.name);Ol(o,a,this)}}fr.prototype.setValue=function(e,t,r){var i=this.map[t];i!==void 0&&i.setValue(e,r,this.renderer)};fr.prototype.setOptional=function(e,t,r){var i=t[r];i!==void 0&&this.setValue(e,r,i)};fr.upload=function(e,t,r,i){for(var n=0,o=t.length;n!==o;++n){var a=t[n],s=r[a.id];s.needsUpdate!==!1&&a.setValue(e,s.value,i)}};fr.seqWithValue=function(e,t){for(var r=[],i=0,n=e.length;i!==n;++i){var o=e[i];o.id in t&&r.push(o)}return r};function Ul(e){for(var t=e.split(`
`),r=0;r<t.length;r++)t[r]=r+1+": "+t[r];return t.join(`
`)}function Ga(e,t,r){var i=e.createShader(t);return e.shaderSource(i,r),e.compileShader(i),e.getShaderParameter(i,e.COMPILE_STATUS)===!1&&console.error("THREE.WebGLShader: Shader couldn't compile."),e.getShaderInfoLog(i)!==""&&console.warn("THREE.WebGLShader: gl.getShaderInfoLog()",t===e.VERTEX_SHADER?"vertex":"fragment",e.getShaderInfoLog(i),Ul(r)),i}var Nl=0;function hh(e){switch(e){case ii:return["Linear","( value )"];case gf:return["sRGB","( value )"];case yf:return["RGBE","( value )"];case xf:return["RGBM","( value, 7.0 )"];case _f:return["RGBM","( value, 16.0 )"];case bf:return["RGBD","( value, 256.0 )"];case Xo:return["Gamma","( value, float( GAMMA_FACTOR ) )"];default:throw new Error("unsupported encoding: "+e)}}function ea(e,t){var r=hh(t);return"vec4 "+e+"( vec4 value ) { return "+r[0]+"ToLinear"+r[1]+"; }"}function Gl(e,t){var r=hh(t);return"vec4 "+e+"( vec4 value ) { return LinearTo"+r[0]+r[1]+"; }"}function zl(e,t){var r;switch(t){case No:r="Linear";break;case Os:r="Reinhard";break;case Us:r="Uncharted2";break;case Ns:r="OptimizedCineon";break;case Gs:r="ACESFilmic";break;default:throw new Error("unsupported toneMapping: "+t)}return"vec3 "+e+"( vec3 color ) { return "+r+"ToneMapping( color ); }"}function Hl(e,t,r){e=e||{};var i=[e.derivatives||t.envMapCubeUV||t.bumpMap||t.normalMap&&!t.objectSpaceNormalMap||t.flatShading?"#extension GL_OES_standard_derivatives : enable":"",(e.fragDepth||t.logarithmicDepthBuffer)&&r.get("EXT_frag_depth")?"#extension GL_EXT_frag_depth : enable":"",e.drawBuffers&&r.get("WEBGL_draw_buffers")?"#extension GL_EXT_draw_buffers : require":"",(e.shaderTextureLOD||t.envMap)&&r.get("EXT_shader_texture_lod")?"#extension GL_EXT_shader_texture_lod : enable":""];return i.filter(An).join(`
`)}function Vl(e){var t=[];for(var r in e){var i=e[r];i!==!1&&t.push("#define "+r+" "+i)}return t.join(`
`)}function kl(e,t){for(var r={},i=e.getProgramParameter(t,e.ACTIVE_ATTRIBUTES),n=0;n<i;n++){var o=e.getActiveAttrib(t,n),a=o.name;r[a]=e.getAttribLocation(t,a)}return r}function An(e){return e!==""}function fh(e,t){return e.replace(/NUM_DIR_LIGHTS/g,t.numDirLights).replace(/NUM_SPOT_LIGHTS/g,t.numSpotLights).replace(/NUM_RECT_AREA_LIGHTS/g,t.numRectAreaLights).replace(/NUM_POINT_LIGHTS/g,t.numPointLights).replace(/NUM_HEMI_LIGHTS/g,t.numHemiLights)}function uh(e,t){return e.replace(/NUM_CLIPPING_PLANES/g,t.numClippingPlanes).replace(/UNION_CLIPPING_PLANES/g,t.numClippingPlanes-t.numClipIntersection)}function za(e){var t=/^[ \t]*#include +<([\w\d./]+)>/gm;function r(i,n){var o=Me[n];if(o===void 0)throw new Error("Can not resolve #include <"+n+">");return za(o)}return e.replace(t,r)}function ch(e){var t=/#pragma unroll_loop[\s]+?for \( int i \= (\d+)\; i < (\d+)\; i \+\+ \) \{([\s\S]+?)(?=\})\}/g;function r(i,n,o,a){for(var s="",f=parseInt(n);f<parseInt(o);f++)s+=a.replace(/\[ i \]/g,"[ "+f+" ]");return s}return e.replace(t,r)}function lh(e,t,r,i,n,o,a){var s=e.context,f=i.defines,u=n.vertexShader,c=n.fragmentShader,h="SHADOWMAP_TYPE_BASIC";o.shadowMapType===Ro?h="SHADOWMAP_TYPE_PCF":o.shadowMapType===ms&&(h="SHADOWMAP_TYPE_PCF_SOFT");var l="ENVMAP_TYPE_CUBE",p="ENVMAP_MODE_REFLECTION",d="ENVMAP_BLENDING_MULTIPLY";if(o.envMap){switch(i.envMap.mapping){case Li:case En:l="ENVMAP_TYPE_CUBE";break;case Ri:case Ci:l="ENVMAP_TYPE_CUBE_UV";break;case Go:case Tn:l="ENVMAP_TYPE_EQUIREC";break;case zo:l="ENVMAP_TYPE_SPHERE";break}switch(i.envMap.mapping){case En:case Tn:p="ENVMAP_MODE_REFRACTION";break}switch(i.combine){case Cr:d="ENVMAP_BLENDING_MULTIPLY";break;case Ds:d="ENVMAP_BLENDING_MIX";break;case Is:d="ENVMAP_BLENDING_ADD";break}}var m=e.gammaFactor>0?e.gammaFactor:1,v=a.isWebGL2?"":Hl(i.extensions,o,t),g=Vl(f),b=s.createProgram(),w,y;if(i.isRawShaderMaterial?(w=[g].filter(An).join(`
`),w.length>0&&(w+=`
`),y=[v,g].filter(An).join(`
`),y.length>0&&(y+=`
`)):(w=["precision "+o.precision+" float;","precision "+o.precision+" int;","#define SHADER_NAME "+n.name,g,o.supportsVertexTextures?"#define VERTEX_TEXTURES":"","#define GAMMA_FACTOR "+m,"#define MAX_BONES "+o.maxBones,o.useFog&&o.fog?"#define USE_FOG":"",o.useFog&&o.fogExp?"#define FOG_EXP2":"",o.map?"#define USE_MAP":"",o.envMap?"#define USE_ENVMAP":"",o.envMap?"#define "+p:"",o.lightMap?"#define USE_LIGHTMAP":"",o.aoMap?"#define USE_AOMAP":"",o.emissiveMap?"#define USE_EMISSIVEMAP":"",o.bumpMap?"#define USE_BUMPMAP":"",o.normalMap?"#define USE_NORMALMAP":"",o.normalMap&&o.objectSpaceNormalMap?"#define OBJECTSPACE_NORMALMAP":"",o.displacementMap&&o.supportsVertexTextures?"#define USE_DISPLACEMENTMAP":"",o.specularMap?"#define USE_SPECULARMAP":"",o.roughnessMap?"#define USE_ROUGHNESSMAP":"",o.metalnessMap?"#define USE_METALNESSMAP":"",o.alphaMap?"#define USE_ALPHAMAP":"",o.vertexColors?"#define USE_COLOR":"",o.flatShading?"#define FLAT_SHADED":"",o.skinning?"#define USE_SKINNING":"",o.useVertexTexture?"#define BONE_TEXTURE":"",o.morphTargets?"#define USE_MORPHTARGETS":"",o.morphNormals&&o.flatShading===!1?"#define USE_MORPHNORMALS":"",o.doubleSided?"#define DOUBLE_SIDED":"",o.flipSided?"#define FLIP_SIDED":"",o.shadowMapEnabled?"#define USE_SHADOWMAP":"",o.shadowMapEnabled?"#define "+h:"",o.sizeAttenuation?"#define USE_SIZEATTENUATION":"",o.logarithmicDepthBuffer?"#define USE_LOGDEPTHBUF":"",o.logarithmicDepthBuffer&&(a.isWebGL2||t.get("EXT_frag_depth"))?"#define USE_LOGDEPTHBUF_EXT":"","uniform mat4 modelMatrix;","uniform mat4 modelViewMatrix;","uniform mat4 projectionMatrix;","uniform mat4 viewMatrix;","uniform mat3 normalMatrix;","uniform vec3 cameraPosition;","attribute vec3 position;","attribute vec3 normal;","attribute vec2 uv;","#ifdef USE_COLOR","	attribute vec3 color;","#endif","#ifdef USE_MORPHTARGETS","	attribute vec3 morphTarget0;","	attribute vec3 morphTarget1;","	attribute vec3 morphTarget2;","	attribute vec3 morphTarget3;","	#ifdef USE_MORPHNORMALS","		attribute vec3 morphNormal0;","		attribute vec3 morphNormal1;","		attribute vec3 morphNormal2;","		attribute vec3 morphNormal3;","	#else","		attribute vec3 morphTarget4;","		attribute vec3 morphTarget5;","		attribute vec3 morphTarget6;","		attribute vec3 morphTarget7;","	#endif","#endif","#ifdef USE_SKINNING","	attribute vec4 skinIndex;","	attribute vec4 skinWeight;","#endif",`
`].filter(An).join(`
`),y=[v,"precision "+o.precision+" float;","precision "+o.precision+" int;","#define SHADER_NAME "+n.name,g,o.alphaTest?"#define ALPHATEST "+o.alphaTest+(o.alphaTest%1?"":".0"):"","#define GAMMA_FACTOR "+m,o.useFog&&o.fog?"#define USE_FOG":"",o.useFog&&o.fogExp?"#define FOG_EXP2":"",o.map?"#define USE_MAP":"",o.matcap?"#define USE_MATCAP":"",o.envMap?"#define USE_ENVMAP":"",o.envMap?"#define "+l:"",o.envMap?"#define "+p:"",o.envMap?"#define "+d:"",o.lightMap?"#define USE_LIGHTMAP":"",o.aoMap?"#define USE_AOMAP":"",o.emissiveMap?"#define USE_EMISSIVEMAP":"",o.bumpMap?"#define USE_BUMPMAP":"",o.normalMap?"#define USE_NORMALMAP":"",o.normalMap&&o.objectSpaceNormalMap?"#define OBJECTSPACE_NORMALMAP":"",o.specularMap?"#define USE_SPECULARMAP":"",o.roughnessMap?"#define USE_ROUGHNESSMAP":"",o.metalnessMap?"#define USE_METALNESSMAP":"",o.alphaMap?"#define USE_ALPHAMAP":"",o.vertexColors?"#define USE_COLOR":"",o.gradientMap?"#define USE_GRADIENTMAP":"",o.flatShading?"#define FLAT_SHADED":"",o.doubleSided?"#define DOUBLE_SIDED":"",o.flipSided?"#define FLIP_SIDED":"",o.shadowMapEnabled?"#define USE_SHADOWMAP":"",o.shadowMapEnabled?"#define "+h:"",o.premultipliedAlpha?"#define PREMULTIPLIED_ALPHA":"",o.physicallyCorrectLights?"#define PHYSICALLY_CORRECT_LIGHTS":"",o.logarithmicDepthBuffer?"#define USE_LOGDEPTHBUF":"",o.logarithmicDepthBuffer&&(a.isWebGL2||t.get("EXT_frag_depth"))?"#define USE_LOGDEPTHBUF_EXT":"",o.envMap&&(a.isWebGL2||t.get("EXT_shader_texture_lod"))?"#define TEXTURE_LOD_EXT":"","uniform mat4 viewMatrix;","uniform vec3 cameraPosition;",o.toneMapping!==Uo?"#define TONE_MAPPING":"",o.toneMapping!==Uo?Me.tonemapping_pars_fragment:"",o.toneMapping!==Uo?zl("toneMapping",o.toneMapping):"",o.dithering?"#define DITHERING":"",o.outputEncoding||o.mapEncoding||o.matcapEncoding||o.envMapEncoding||o.emissiveMapEncoding?Me.encodings_pars_fragment:"",o.mapEncoding?ea("mapTexelToLinear",o.mapEncoding):"",o.matcapEncoding?ea("matcapTexelToLinear",o.matcapEncoding):"",o.envMapEncoding?ea("envMapTexelToLinear",o.envMapEncoding):"",o.emissiveMapEncoding?ea("emissiveMapTexelToLinear",o.emissiveMapEncoding):"",o.outputEncoding?Gl("linearToOutputTexel",o.outputEncoding):"",o.depthPacking?"#define DEPTH_PACKING "+i.depthPacking:"",`
`].filter(An).join(`
`)),u=za(u),u=fh(u,o),u=uh(u,o),c=za(c),c=fh(c,o),c=uh(c,o),u=ch(u),c=ch(c),a.isWebGL2&&!i.isRawShaderMaterial){var S=!1,R=/^\s*#version\s+300\s+es\s*\n/;i.isShaderMaterial&&u.match(R)!==null&&c.match(R)!==null&&(S=!0,u=u.replace(R,""),c=c.replace(R,"")),w=[`#version 300 es
`,"#define attribute in","#define varying out","#define texture2D texture"].join(`
`)+`
`+w,y=[`#version 300 es
`,"#define varying in",S?"":"out highp vec4 pc_fragColor;",S?"":"#define gl_FragColor pc_fragColor","#define gl_FragDepthEXT gl_FragDepth","#define texture2D texture","#define textureCube texture","#define texture2DProj textureProj","#define texture2DLodEXT textureLod","#define texture2DProjLodEXT textureProjLod","#define textureCubeLodEXT textureLod","#define texture2DGradEXT textureGrad","#define texture2DProjGradEXT textureProjGrad","#define textureCubeGradEXT textureGrad"].join(`
`)+`
`+y}var B=w+u,P=y+c,A=Ga(s,s.VERTEX_SHADER,B),D=Ga(s,s.FRAGMENT_SHADER,P);s.attachShader(b,A),s.attachShader(b,D),i.index0AttributeName!==void 0?s.bindAttribLocation(b,0,i.index0AttributeName):o.morphTargets===!0&&s.bindAttribLocation(b,0,"position"),s.linkProgram(b);var I=s.getProgramInfoLog(b).trim(),H=s.getShaderInfoLog(A).trim(),X=s.getShaderInfoLog(D).trim(),j=!0,V=!0;s.getProgramParameter(b,s.LINK_STATUS)===!1?(j=!1,console.error("THREE.WebGLProgram: shader error: ",s.getError(),"gl.VALIDATE_STATUS",s.getProgramParameter(b,s.VALIDATE_STATUS),"gl.getProgramInfoLog",I,H,X)):I!==""?console.warn("THREE.WebGLProgram: gl.getProgramInfoLog()",I):(H===""||X==="")&&(V=!1),V&&(this.diagnostics={runnable:j,material:i,programLog:I,vertexShader:{log:H,prefix:w},fragmentShader:{log:X,prefix:y}}),s.deleteShader(A),s.deleteShader(D);var $;this.getUniforms=function(){return $===void 0&&($=new fr(s,b,e)),$};var K;return this.getAttributes=function(){return K===void 0&&(K=kl(s,b)),K},this.destroy=function(){s.deleteProgram(b),this.program=void 0},Object.defineProperties(this,{uniforms:{get:function(){return console.warn("THREE.WebGLProgram: .uniforms is now .getUniforms()."),this.getUniforms()}},attributes:{get:function(){return console.warn("THREE.WebGLProgram: .attributes is now .getAttributes()."),this.getAttributes()}}}),this.name=n.name,this.id=Nl++,this.code=r,this.usedTimes=1,this.program=b,this.vertexShader=A,this.fragmentShader=D,this}function ph(e,t,r){var i=[],n={MeshDepthMaterial:"depth",MeshDistanceMaterial:"distanceRGBA",MeshNormalMaterial:"normal",MeshBasicMaterial:"basic",MeshLambertMaterial:"lambert",MeshPhongMaterial:"phong",MeshToonMaterial:"phong",MeshStandardMaterial:"physical",MeshPhysicalMaterial:"physical",MeshMatcapMaterial:"matcap",LineBasicMaterial:"basic",LineDashedMaterial:"dashed",PointsMaterial:"points",ShadowMaterial:"shadow",SpriteMaterial:"sprite"},o=["precision","supportsVertexTextures","map","mapEncoding","matcap","matcapEncoding","envMap","envMapMode","envMapEncoding","lightMap","aoMap","emissiveMap","emissiveMapEncoding","bumpMap","normalMap","objectSpaceNormalMap","displacementMap","specularMap","roughnessMap","metalnessMap","gradientMap","alphaMap","combine","vertexColors","fog","useFog","fogExp","flatShading","sizeAttenuation","logarithmicDepthBuffer","skinning","maxBones","useVertexTexture","morphTargets","morphNormals","maxMorphTargets","maxMorphNormals","premultipliedAlpha","numDirLights","numPointLights","numSpotLights","numHemiLights","numRectAreaLights","shadowMapEnabled","shadowMapType","toneMapping","physicallyCorrectLights","alphaTest","doubleSided","flipSided","numClippingPlanes","numClipIntersection","depthPacking","dithering"];function a(f){var u=f.skeleton,c=u.bones;if(r.floatVertexTextures)return 1024;var h=r.maxVertexUniforms,l=Math.floor((h-20)/4),p=Math.min(l,c.length);return p<c.length?(console.warn("THREE.WebGLRenderer: Skeleton has "+c.length+" bones. This GPU supports "+p+"."),0):p}function s(f,u){var c;return f?f.isTexture?c=f.encoding:f.isWebGLRenderTarget&&(console.warn("THREE.WebGLPrograms.getTextureEncodingFromMap: don't use render targets as textures. Use their .texture property instead."),c=f.texture.encoding):c=ii,c===ii&&u&&(c=Xo),c}this.getParameters=function(f,u,c,h,l,p,d){var m=n[f.type],v=d.isSkinnedMesh?a(d):0,g=r.precision;f.precision!==null&&(g=r.getMaxPrecision(f.precision),g!==f.precision&&console.warn("THREE.WebGLProgram.getParameters:",f.precision,"not supported, using",g,"instead."));var b=e.getRenderTarget(),w={shaderID:m,precision:g,supportsVertexTextures:r.vertexTextures,outputEncoding:s(b?b.texture:null,e.gammaOutput),map:!!f.map,mapEncoding:s(f.map,e.gammaInput),matcap:!!f.matcap,matcapEncoding:s(f.matcap,e.gammaInput),envMap:!!f.envMap,envMapMode:f.envMap&&f.envMap.mapping,envMapEncoding:s(f.envMap,e.gammaInput),envMapCubeUV:!!f.envMap&&(f.envMap.mapping===Ri||f.envMap.mapping===Ci),lightMap:!!f.lightMap,aoMap:!!f.aoMap,emissiveMap:!!f.emissiveMap,emissiveMapEncoding:s(f.emissiveMap,e.gammaInput),bumpMap:!!f.bumpMap,normalMap:!!f.normalMap,objectSpaceNormalMap:f.normalMapType===Ef,displacementMap:!!f.displacementMap,roughnessMap:!!f.roughnessMap,metalnessMap:!!f.metalnessMap,specularMap:!!f.specularMap,alphaMap:!!f.alphaMap,gradientMap:!!f.gradientMap,combine:f.combine,vertexColors:f.vertexColors,fog:!!h,useFog:f.fog,fogExp:h&&h.isFogExp2,flatShading:f.flatShading,sizeAttenuation:f.sizeAttenuation,logarithmicDepthBuffer:r.logarithmicDepthBuffer,skinning:f.skinning&&v>0,maxBones:v,useVertexTexture:r.floatVertexTextures,morphTargets:f.morphTargets,morphNormals:f.morphNormals,maxMorphTargets:e.maxMorphTargets,maxMorphNormals:e.maxMorphNormals,numDirLights:u.directional.length,numPointLights:u.point.length,numSpotLights:u.spot.length,numRectAreaLights:u.rectArea.length,numHemiLights:u.hemi.length,numClippingPlanes:l,numClipIntersection:p,dithering:f.dithering,shadowMapEnabled:e.shadowMap.enabled&&d.receiveShadow&&c.length>0,shadowMapType:e.shadowMap.type,toneMapping:e.toneMapping,physicallyCorrectLights:e.physicallyCorrectLights,premultipliedAlpha:f.premultipliedAlpha,alphaTest:f.alphaTest,doubleSided:f.side===or,flipSided:f.side===Ze,depthPacking:f.depthPacking!==void 0?f.depthPacking:!1};return w},this.getProgramCode=function(f,u){var c=[];if(u.shaderID?c.push(u.shaderID):(c.push(f.fragmentShader),c.push(f.vertexShader)),f.defines!==void 0)for(var h in f.defines)c.push(h),c.push(f.defines[h]);for(var l=0;l<o.length;l++)c.push(u[o[l]]);return c.push(f.onBeforeCompile.toString()),c.push(e.gammaOutput),c.push(e.gammaFactor),c.join()},this.acquireProgram=function(f,u,c,h){for(var l,p=0,d=i.length;p<d;p++){var m=i[p];if(m.code===h){l=m,++l.usedTimes;break}}return l===void 0&&(l=new lh(e,t,h,f,u,c,r),i.push(l)),l},this.releaseProgram=function(f){if(--f.usedTimes===0){var u=i.indexOf(f);i[u]=i[i.length-1],i.pop(),f.destroy()}},this.programs=i}function dh(){var e=new WeakMap;function t(o){var a=e.get(o);return a===void 0&&(a={},e.set(o,a)),a}function r(o){e.delete(o)}function i(o,a,s){e.get(o)[a]=s}function n(){e=new WeakMap}return{get:t,remove:r,update:i,dispose:n}}function Wl(e,t){return e.groupOrder!==t.groupOrder?e.groupOrder-t.groupOrder:e.renderOrder!==t.renderOrder?e.renderOrder-t.renderOrder:e.program&&t.program&&e.program!==t.program?e.program.id-t.program.id:e.material.id!==t.material.id?e.material.id-t.material.id:e.z!==t.z?e.z-t.z:e.id-t.id}function Xl(e,t){return e.groupOrder!==t.groupOrder?e.groupOrder-t.groupOrder:e.renderOrder!==t.renderOrder?e.renderOrder-t.renderOrder:e.z!==t.z?t.z-e.z:e.id-t.id}function mh(){var e=[],t=0,r=[],i=[];function n(){t=0,r.length=0,i.length=0}function o(u,c,h,l,p,d){var m=e[t];return m===void 0?(m={id:u.id,object:u,geometry:c,material:h,program:h.program,groupOrder:l,renderOrder:u.renderOrder,z:p,group:d},e[t]=m):(m.id=u.id,m.object=u,m.geometry=c,m.material=h,m.program=h.program,m.groupOrder=l,m.renderOrder=u.renderOrder,m.z=p,m.group=d),t++,m}function a(u,c,h,l,p,d){var m=o(u,c,h,l,p,d);(h.transparent===!0?i:r).push(m)}function s(u,c,h,l,p,d){var m=o(u,c,h,l,p,d);(h.transparent===!0?i:r).unshift(m)}function f(){r.length>1&&r.sort(Wl),i.length>1&&i.sort(Xl)}return{opaque:r,transparent:i,init:n,push:a,unshift:s,sort:f}}function vh(){var e={};function t(n){var o=n.target;o.removeEventListener("dispose",t),delete e[o.id]}function r(n,o){var a=e[n.id],s;return a===void 0?(s=new mh,e[n.id]={},e[n.id][o.id]=s,n.addEventListener("dispose",t)):(s=a[o.id],s===void 0&&(s=new mh,a[o.id]=s)),s}function i(){e={}}return{get:r,dispose:i}}function jl(){var e={};return{get:function(t){if(e[t.id]!==void 0)return e[t.id];var r;switch(t.type){case"DirectionalLight":r={direction:new x,color:new J,shadow:!1,shadowBias:0,shadowRadius:1,shadowMapSize:new O};break;case"SpotLight":r={position:new x,direction:new x,color:new J,distance:0,coneCos:0,penumbraCos:0,decay:0,shadow:!1,shadowBias:0,shadowRadius:1,shadowMapSize:new O};break;case"PointLight":r={position:new x,color:new J,distance:0,decay:0,shadow:!1,shadowBias:0,shadowRadius:1,shadowMapSize:new O,shadowCameraNear:1,shadowCameraFar:1e3};break;case"HemisphereLight":r={direction:new x,skyColor:new J,groundColor:new J};break;case"RectAreaLight":r={color:new J,position:new x,halfWidth:new x,halfHeight:new x};break}return e[t.id]=r,r}}}var ql=0;function gh(){var e=new jl,t={id:ql++,hash:{stateID:-1,directionalLength:-1,pointLength:-1,spotLength:-1,rectAreaLength:-1,hemiLength:-1,shadowsLength:-1},ambient:[0,0,0],directional:[],directionalShadowMap:[],directionalShadowMatrix:[],spot:[],spotShadowMap:[],spotShadowMatrix:[],rectArea:[],point:[],pointShadowMap:[],pointShadowMatrix:[],hemi:[]},r=new x,i=new ee,n=new ee;function o(a,s,f){for(var u=0,c=0,h=0,l=0,p=0,d=0,m=0,v=0,g=f.matrixWorldInverse,b=0,w=a.length;b<w;b++){var y=a[b],S=y.color,R=y.intensity,B=y.distance,P=y.shadow&&y.shadow.map?y.shadow.map.texture:null;if(y.isAmbientLight)u+=S.r*R,c+=S.g*R,h+=S.b*R;else if(y.isDirectionalLight){var A=e.get(y);if(A.color.copy(y.color).multiplyScalar(y.intensity),A.direction.setFromMatrixPosition(y.matrixWorld),r.setFromMatrixPosition(y.target.matrixWorld),A.direction.sub(r),A.direction.transformDirection(g),A.shadow=y.castShadow,y.castShadow){var D=y.shadow;A.shadowBias=D.bias,A.shadowRadius=D.radius,A.shadowMapSize=D.mapSize}t.directionalShadowMap[l]=P,t.directionalShadowMatrix[l]=y.shadow.matrix,t.directional[l]=A,l++}else if(y.isSpotLight){var A=e.get(y);if(A.position.setFromMatrixPosition(y.matrixWorld),A.position.applyMatrix4(g),A.color.copy(S).multiplyScalar(R),A.distance=B,A.direction.setFromMatrixPosition(y.matrixWorld),r.setFromMatrixPosition(y.target.matrixWorld),A.direction.sub(r),A.direction.transformDirection(g),A.coneCos=Math.cos(y.angle),A.penumbraCos=Math.cos(y.angle*(1-y.penumbra)),A.decay=y.decay,A.shadow=y.castShadow,y.castShadow){var D=y.shadow;A.shadowBias=D.bias,A.shadowRadius=D.radius,A.shadowMapSize=D.mapSize}t.spotShadowMap[d]=P,t.spotShadowMatrix[d]=y.shadow.matrix,t.spot[d]=A,d++}else if(y.isRectAreaLight){var A=e.get(y);A.color.copy(S).multiplyScalar(R),A.position.setFromMatrixPosition(y.matrixWorld),A.position.applyMatrix4(g),n.identity(),i.copy(y.matrixWorld),i.premultiply(g),n.extractRotation(i),A.halfWidth.set(y.width*.5,0,0),A.halfHeight.set(0,y.height*.5,0),A.halfWidth.applyMatrix4(n),A.halfHeight.applyMatrix4(n),t.rectArea[m]=A,m++}else if(y.isPointLight){var A=e.get(y);if(A.position.setFromMatrixPosition(y.matrixWorld),A.position.applyMatrix4(g),A.color.copy(y.color).multiplyScalar(y.intensity),A.distance=y.distance,A.decay=y.decay,A.shadow=y.castShadow,y.castShadow){var D=y.shadow;A.shadowBias=D.bias,A.shadowRadius=D.radius,A.shadowMapSize=D.mapSize,A.shadowCameraNear=D.camera.near,A.shadowCameraFar=D.camera.far}t.pointShadowMap[p]=P,t.pointShadowMatrix[p]=y.shadow.matrix,t.point[p]=A,p++}else if(y.isHemisphereLight){var A=e.get(y);A.direction.setFromMatrixPosition(y.matrixWorld),A.direction.transformDirection(g),A.direction.normalize(),A.skyColor.copy(y.color).multiplyScalar(R),A.groundColor.copy(y.groundColor).multiplyScalar(R),t.hemi[v]=A,v++}}t.ambient[0]=u,t.ambient[1]=c,t.ambient[2]=h,t.directional.length=l,t.spot.length=d,t.rectArea.length=m,t.point.length=p,t.hemi.length=v,t.hash.stateID=t.id,t.hash.directionalLength=l,t.hash.pointLength=p,t.hash.spotLength=d,t.hash.rectAreaLength=m,t.hash.hemiLength=v,t.hash.shadowsLength=s.length}return{setup:o,state:t}}function yh(){var e=new gh,t=[],r=[];function i(){t.length=0,r.length=0}function n(f){t.push(f)}function o(f){r.push(f)}function a(f){e.setup(t,r,f)}var s={lightsArray:t,shadowsArray:r,lights:e};return{init:i,state:s,setupLights:a,pushLight:n,pushShadow:o}}function xh(){var e={};function t(n){var o=n.target;o.removeEventListener("dispose",t),delete e[o.id]}function r(n,o){var a;return e[n.id]===void 0?(a=new yh,e[n.id]={},e[n.id][o.id]=a,n.addEventListener("dispose",t)):e[n.id][o.id]===void 0?(a=new yh,e[n.id][o.id]=a):a=e[n.id][o.id],a}function i(){e={}}return{get:r,dispose:i}}function wr(e){he.call(this),this.type="MeshDepthMaterial",this.depthPacking=wf,this.skinning=!1,this.morphTargets=!1,this.map=null,this.alphaMap=null,this.displacementMap=null,this.displacementScale=1,this.displacementBias=0,this.wireframe=!1,this.wireframeLinewidth=1,this.fog=!1,this.lights=!1,this.setValues(e)}wr.prototype=Object.create(he.prototype);wr.prototype.constructor=wr;wr.prototype.isMeshDepthMaterial=!0;wr.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.depthPacking=e.depthPacking,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this.map=e.map,this.alphaMap=e.alphaMap,this.displacementMap=e.displacementMap,this.displacementScale=e.displacementScale,this.displacementBias=e.displacementBias,this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this};function Mr(e){he.call(this),this.type="MeshDistanceMaterial",this.referencePosition=new x,this.nearDistance=1,this.farDistance=1e3,this.skinning=!1,this.morphTargets=!1,this.map=null,this.alphaMap=null,this.displacementMap=null,this.displacementScale=1,this.displacementBias=0,this.fog=!1,this.lights=!1,this.setValues(e)}Mr.prototype=Object.create(he.prototype);Mr.prototype.constructor=Mr;Mr.prototype.isMeshDistanceMaterial=!0;Mr.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.referencePosition.copy(e.referencePosition),this.nearDistance=e.nearDistance,this.farDistance=e.farDistance,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this.map=e.map,this.alphaMap=e.alphaMap,this.displacementMap=e.displacementMap,this.displacementScale=e.displacementScale,this.displacementBias=e.displacementBias,this};function ta(e,t,r){for(var i=new Ui,n=new ee,o=new O,a=new O(r,r),s=new x,f=new x,u=1,c=2,h=(u|c)+1,l=new Array(h),p=new Array(h),d={},m={0:Ze,1:gr,2:or},v=[new x(1,0,0),new x(-1,0,0),new x(0,0,1),new x(0,0,-1),new x(0,1,0),new x(0,-1,0)],g=[new x(0,1,0),new x(0,1,0),new x(0,1,0),new x(0,1,0),new x(0,0,1),new x(0,0,-1)],b=[new we,new we,new we,new we,new we,new we],w=0;w!==h;++w){var y=(w&u)!==0,S=(w&c)!==0,R=new wr({depthPacking:Mf,morphTargets:y,skinning:S});l[w]=R;var B=new Mr({morphTargets:y,skinning:S});p[w]=B}var P=this;this.enabled=!1,this.autoUpdate=!0,this.needsUpdate=!1,this.type=Ro,this.render=function(I,H,X){if(P.enabled!==!1&&!(P.autoUpdate===!1&&P.needsUpdate===!1)&&I.length!==0){var j=e.state;j.setBlending(Rr),j.buffers.color.setClear(1,1,1,1),j.buffers.depth.setTest(!0),j.setScissorTest(!1);for(var V,$=0,K=I.length;$<K;$++){var Q=I[$],E=Q.shadow,T=Q&&Q.isPointLight;if(E===void 0){console.warn("THREE.WebGLShadowMap:",Q,"has no shadow.");continue}var U=E.camera;if(o.copy(E.mapSize),o.min(a),T){var L=o.x,te=o.y;b[0].set(L*2,te,L,te),b[1].set(0,te,L,te),b[2].set(L*3,te,L,te),b[3].set(L,te,L,te),b[4].set(L*3,0,L,te),b[5].set(L,0,L,te),o.x*=4,o.y*=2}if(E.map===null){var N={minFilter:ke,magFilter:ke,format:wt};E.map=new Mt(o.x,o.y,N),E.map.texture.name=Q.name+".shadowMap",U.updateProjectionMatrix()}E.isSpotLightShadow&&E.update(Q);var q=E.map,Z=E.matrix;f.setFromMatrixPosition(Q.matrixWorld),U.position.copy(f),T?(V=6,Z.makeTranslation(-f.x,-f.y,-f.z)):(V=1,s.setFromMatrixPosition(Q.target.matrixWorld),U.lookAt(s),U.updateMatrixWorld(),Z.set(.5,0,0,.5,0,.5,0,.5,0,0,.5,.5,0,0,0,1),Z.multiply(U.projectionMatrix),Z.multiply(U.matrixWorldInverse)),e.setRenderTarget(q),e.clear();for(var ve=0;ve<V;ve++){if(T){s.copy(U.position),s.add(v[ve]),U.up.copy(g[ve]),U.lookAt(s),U.updateMatrixWorld();var ge=b[ve];j.viewport(ge)}n.multiplyMatrices(U.projectionMatrix,U.matrixWorldInverse),i.setFromMatrix(n),D(H,X,U,T)}}P.needsUpdate=!1}};function A(I,H,X,j,V,$){var K=I.geometry,Q=null,E=l,T=I.customDepthMaterial;if(X&&(E=p,T=I.customDistanceMaterial),T)Q=T;else{var U=!1;H.morphTargets&&(K&&K.isBufferGeometry?U=K.morphAttributes&&K.morphAttributes.position&&K.morphAttributes.position.length>0:K&&K.isGeometry&&(U=K.morphTargets&&K.morphTargets.length>0)),I.isSkinnedMesh&&H.skinning===!1&&console.warn("THREE.WebGLShadowMap: THREE.SkinnedMesh with material.skinning set to false:",I);var L=I.isSkinnedMesh&&H.skinning,te=0;U&&(te|=u),L&&(te|=c),Q=E[te]}if(e.localClippingEnabled&&H.clipShadows===!0&&H.clippingPlanes.length!==0){var N=Q.uuid,q=H.uuid,Z=d[N];Z===void 0&&(Z={},d[N]=Z);var ve=Z[q];ve===void 0&&(ve=Q.clone(),Z[q]=ve),Q=ve}return Q.visible=H.visible,Q.wireframe=H.wireframe,Q.side=H.shadowSide!=null?H.shadowSide:m[H.side],Q.clipShadows=H.clipShadows,Q.clippingPlanes=H.clippingPlanes,Q.clipIntersection=H.clipIntersection,Q.wireframeLinewidth=H.wireframeLinewidth,Q.linewidth=H.linewidth,X&&Q.isMeshDistanceMaterial&&(Q.referencePosition.copy(j),Q.nearDistance=V,Q.farDistance=$),Q}function D(I,H,X,j){if(I.visible!==!1){var V=I.layers.test(H.layers);if(V&&(I.isMesh||I.isLine||I.isPoints)&&I.castShadow&&(!I.frustumCulled||i.intersectsObject(I))){I.modelViewMatrix.multiplyMatrices(X.matrixWorldInverse,I.matrixWorld);var $=t.update(I),K=I.material;if(Array.isArray(K))for(var Q=$.groups,E=0,T=Q.length;E<T;E++){var U=Q[E],L=K[U.materialIndex];if(L&&L.visible){var te=A(I,L,j,f,X.near,X.far);e.renderBufferDirect(X,null,$,te,I,U)}}else if(K.visible){var te=A(I,K,j,f,X.near,X.far);e.renderBufferDirect(X,null,$,te,I,null)}}for(var N=I.children,q=0,Z=N.length;q<Z;q++)D(N[q],H,X,j)}}}function _h(e,t,r,i){function n(){var F=!1,se=new we,ce=null,Te=new we(0,0,0,0);return{setMask:function(le){ce!==le&&!F&&(e.colorMask(le,le,le,le),ce=le)},setLocked:function(le){F=le},setClear:function(le,Re,ze,Ne,Ct){Ct===!0&&(le*=Ne,Re*=Ne,ze*=Ne),se.set(le,Re,ze,Ne),Te.equals(se)===!1&&(e.clearColor(le,Re,ze,Ne),Te.copy(se))},reset:function(){F=!1,ce=null,Te.set(-1,0,0,0)}}}function o(){var F=!1,se=null,ce=null,Te=null;return{setTest:function(le){le?me(e.DEPTH_TEST):W(e.DEPTH_TEST)},setMask:function(le){se!==le&&!F&&(e.depthMask(le),se=le)},setFunc:function(le){if(ce!==le){if(le)switch(le){case As:e.depthFunc(e.NEVER);break;case Ls:e.depthFunc(e.ALWAYS);break;case Rs:e.depthFunc(e.LESS);break;case wn:e.depthFunc(e.LEQUAL);break;case Cs:e.depthFunc(e.EQUAL);break;case Ps:e.depthFunc(e.GEQUAL);break;case Bs:e.depthFunc(e.GREATER);break;case Fs:e.depthFunc(e.NOTEQUAL);break;default:e.depthFunc(e.LEQUAL)}else e.depthFunc(e.LEQUAL);ce=le}},setLocked:function(le){F=le},setClear:function(le){Te!==le&&(e.clearDepth(le),Te=le)},reset:function(){F=!1,se=null,ce=null,Te=null}}}function a(){var F=!1,se=null,ce=null,Te=null,le=null,Re=null,ze=null,Ne=null,Ct=null;return{setTest:function(He){He?me(e.STENCIL_TEST):W(e.STENCIL_TEST)},setMask:function(He){se!==He&&!F&&(e.stencilMask(He),se=He)},setFunc:function(He,It,rt){(ce!==He||Te!==It||le!==rt)&&(e.stencilFunc(He,It,rt),ce=He,Te=It,le=rt)},setOp:function(He,It,rt){(Re!==He||ze!==It||Ne!==rt)&&(e.stencilOp(He,It,rt),Re=He,ze=It,Ne=rt)},setLocked:function(He){F=He},setClear:function(He){Ct!==He&&(e.clearStencil(He),Ct=He)},reset:function(){F=!1,se=null,ce=null,Te=null,le=null,Re=null,ze=null,Ne=null,Ct=null}}}var s=new n,f=new o,u=new a,c=e.getParameter(e.MAX_VERTEX_ATTRIBS),h=new Uint8Array(c),l=new Uint8Array(c),p=new Uint8Array(c),d={},m=null,v=null,g=null,b=null,w=null,y=null,S=null,R=null,B=null,P=null,A=!1,D=null,I=null,H=null,X=null,j=null,V=e.getParameter(e.MAX_COMBINED_TEXTURE_IMAGE_UNITS),$=!1,K=0,Q=e.getParameter(e.VERSION);Q.indexOf("WebGL")!==-1?(K=parseFloat(/^WebGL\ ([0-9])/.exec(Q)[1]),$=K>=1):Q.indexOf("OpenGL ES")!==-1&&(K=parseFloat(/^OpenGL\ ES\ ([0-9])/.exec(Q)[1]),$=K>=2);var E=null,T={},U=new we,L=new we;function te(F,se,ce){var Te=new Uint8Array(4),le=e.createTexture();e.bindTexture(F,le),e.texParameteri(F,e.TEXTURE_MIN_FILTER,e.NEAREST),e.texParameteri(F,e.TEXTURE_MAG_FILTER,e.NEAREST);for(var Re=0;Re<ce;Re++)e.texImage2D(se+Re,0,e.RGBA,1,1,0,e.RGBA,e.UNSIGNED_BYTE,Te);return le}var N={};N[e.TEXTURE_2D]=te(e.TEXTURE_2D,e.TEXTURE_2D,1),N[e.TEXTURE_CUBE_MAP]=te(e.TEXTURE_CUBE_MAP,e.TEXTURE_CUBE_MAP_POSITIVE_X,6),s.setClear(0,0,0,1),f.setClear(1),u.setClear(0),me(e.DEPTH_TEST),f.setFunc(wn),Je(!1),st(Sa),me(e.CULL_FACE),Ee(Rr);function q(){for(var F=0,se=h.length;F<se;F++)h[F]=0}function Z(F){ve(F,0)}function ve(F,se){if(h[F]=1,l[F]===0&&(e.enableVertexAttribArray(F),l[F]=1),p[F]!==se){var ce=i.isWebGL2?e:t.get("ANGLE_instanced_arrays");ce[i.isWebGL2?"vertexAttribDivisor":"vertexAttribDivisorANGLE"](F,se),p[F]=se}}function ge(){for(var F=0,se=l.length;F!==se;++F)l[F]!==h[F]&&(e.disableVertexAttribArray(F),l[F]=0)}function me(F){d[F]!==!0&&(e.enable(F),d[F]=!0)}function W(F){d[F]!==!1&&(e.disable(F),d[F]=!1)}function pe(){if(m===null&&(m=[],t.get("WEBGL_compressed_texture_pvrtc")||t.get("WEBGL_compressed_texture_s3tc")||t.get("WEBGL_compressed_texture_etc1")||t.get("WEBGL_compressed_texture_astc")))for(var F=e.getParameter(e.COMPRESSED_TEXTURE_FORMATS),se=0;se<F.length;se++)m.push(F[se]);return m}function Fe(F){return v!==F?(e.useProgram(F),v=F,!0):!1}function Ee(F,se,ce,Te,le,Re,ze,Ne){if(F===Rr){g&&(W(e.BLEND),g=!1);return}if(g||(me(e.BLEND),g=!0),F!==Bo){if(F!==b||Ne!==A){if((w!==xr||R!==xr)&&(e.blendEquation(e.FUNC_ADD),w=xr,R=xr),Ne)switch(F){case yr:e.blendFuncSeparate(e.ONE,e.ONE_MINUS_SRC_ALPHA,e.ONE,e.ONE_MINUS_SRC_ALPHA);break;case xn:e.blendFunc(e.ONE,e.ONE);break;case _n:e.blendFuncSeparate(e.ZERO,e.ZERO,e.ONE_MINUS_SRC_COLOR,e.ONE_MINUS_SRC_ALPHA);break;case bn:e.blendFuncSeparate(e.ZERO,e.SRC_COLOR,e.ZERO,e.SRC_ALPHA);break;default:console.error("THREE.WebGLState: Invalid blending: ",F);break}else switch(F){case yr:e.blendFuncSeparate(e.SRC_ALPHA,e.ONE_MINUS_SRC_ALPHA,e.ONE,e.ONE_MINUS_SRC_ALPHA);break;case xn:e.blendFunc(e.SRC_ALPHA,e.ONE);break;case _n:e.blendFunc(e.ZERO,e.ONE_MINUS_SRC_COLOR);break;case bn:e.blendFunc(e.ZERO,e.SRC_COLOR);break;default:console.error("THREE.WebGLState: Invalid blending: ",F);break}y=null,S=null,B=null,P=null,b=F,A=Ne}return}le=le||se,Re=Re||ce,ze=ze||Te,(se!==w||le!==R)&&(e.blendEquationSeparate(r.convert(se),r.convert(le)),w=se,R=le),(ce!==y||Te!==S||Re!==B||ze!==P)&&(e.blendFuncSeparate(r.convert(ce),r.convert(Te),r.convert(Re),r.convert(ze)),y=ce,S=Te,B=Re,P=ze),b=F,A=null}function _t(F,se){F.side===or?W(e.CULL_FACE):me(e.CULL_FACE);var ce=F.side===Ze;se&&(ce=!ce),Je(ce),F.blending===yr&&F.transparent===!1?Ee(Rr):Ee(F.blending,F.blendEquation,F.blendSrc,F.blendDst,F.blendEquationAlpha,F.blendSrcAlpha,F.blendDstAlpha,F.premultipliedAlpha),f.setFunc(F.depthFunc),f.setTest(F.depthTest),f.setMask(F.depthWrite),s.setMask(F.colorWrite),mr(F.polygonOffset,F.polygonOffsetFactor,F.polygonOffsetUnits)}function Je(F){D!==F&&(F?e.frontFace(e.CW):e.frontFace(e.CCW),D=F)}function st(F){F!==ps?(me(e.CULL_FACE),F!==I&&(F===Sa?e.cullFace(e.BACK):F===ds?e.cullFace(e.FRONT):e.cullFace(e.FRONT_AND_BACK))):W(e.CULL_FACE),I=F}function dt(F){F!==H&&($&&e.lineWidth(F),H=F)}function mr(F,se,ce){F?(me(e.POLYGON_OFFSET_FILL),(X!==se||j!==ce)&&(e.polygonOffset(se,ce),X=se,j=ce)):W(e.POLYGON_OFFSET_FILL)}function Jt(F){F?me(e.SCISSOR_TEST):W(e.SCISSOR_TEST)}function et(F){F===void 0&&(F=e.TEXTURE0+V-1),E!==F&&(e.activeTexture(F),E=F)}function ft(F,se){E===null&&et();var ce=T[E];ce===void 0&&(ce={type:void 0,texture:void 0},T[E]=ce),(ce.type!==F||ce.texture!==se)&&(e.bindTexture(F,se||N[F]),ce.type=F,ce.texture=se)}function mt(){try{e.compressedTexImage2D.apply(e,arguments)}catch(F){console.error("THREE.WebGLState:",F)}}function Ai(){try{e.texImage2D.apply(e,arguments)}catch(F){console.error("THREE.WebGLState:",F)}}function Lt(){try{e.texImage3D.apply(e,arguments)}catch(F){console.error("THREE.WebGLState:",F)}}function Rt(F){U.equals(F)===!1&&(e.scissor(F.x,F.y,F.z,F.w),U.copy(F))}function Le(F){L.equals(F)===!1&&(e.viewport(F.x,F.y,F.z,F.w),L.copy(F))}function Pe(){for(var F=0;F<l.length;F++)l[F]===1&&(e.disableVertexAttribArray(F),l[F]=0);d={},m=null,E=null,T={},v=null,b=null,D=null,I=null,s.reset(),f.reset(),u.reset()}return{buffers:{color:s,depth:f,stencil:u},initAttributes:q,enableAttribute:Z,enableAttributeAndDivisor:ve,disableUnusedAttributes:ge,enable:me,disable:W,getCompressedTextureFormats:pe,useProgram:Fe,setBlending:Ee,setMaterial:_t,setFlipSided:Je,setCullFace:st,setLineWidth:dt,setPolygonOffset:mr,setScissorTest:Jt,activeTexture:et,bindTexture:ft,compressedTexImage2D:mt,texImage2D:Ai,texImage3D:Lt,scissor:Rt,viewport:Le,reset:Pe}}function bh(e,t,r,i,n,o,a){var s={},f;function u(E,T,U,L){var te=1;if((E.width>L||E.height>L)&&(te=L/Math.max(E.width,E.height)),te<1||T===!0)if(E instanceof HTMLImageElement||E instanceof HTMLCanvasElement||E instanceof ImageBitmap){f===void 0&&(f=document.createElementNS("http://www.w3.org/1999/xhtml","canvas"));var N=U?document.createElementNS("http://www.w3.org/1999/xhtml","canvas"):f,q=T?ie.floorPowerOfTwo:Math.floor;N.width=q(te*E.width),N.height=q(te*E.height);var Z=N.getContext("2d");return Z.drawImage(E,0,0,N.width,N.height),console.warn("THREE.WebGLRenderer: Texture has been resized from ("+E.width+"x"+E.height+") to ("+N.width+"x"+N.height+")."),N}else return"data"in E&&console.warn("THREE.WebGLRenderer: Image in DataTexture is too big ("+E.width+"x"+E.height+")."),E;return E}function c(E){return ie.isPowerOfTwo(E.width)&&ie.isPowerOfTwo(E.height)}function h(E){return n.isWebGL2?!1:E.wrapS!==vt||E.wrapT!==vt||E.minFilter!==ke&&E.minFilter!==qe}function l(E,T){return E.generateMipmaps&&T&&E.minFilter!==ke&&E.minFilter!==qe}function p(E,T,U,L){e.generateMipmap(E);var te=i.get(T);te.__maxMipLevel=Math.log(Math.max(U,L))*Math.LOG2E}function d(E,T){if(!n.isWebGL2)return E;var U=E;return E===e.RED&&(T===e.FLOAT&&(U=e.R32F),T===e.HALF_FLOAT&&(U=e.R16F),T===e.UNSIGNED_BYTE&&(U=e.R8)),E===e.RGB&&(T===e.FLOAT&&(U=e.RGB32F),T===e.HALF_FLOAT&&(U=e.RGB16F),T===e.UNSIGNED_BYTE&&(U=e.RGB8)),E===e.RGBA&&(T===e.FLOAT&&(U=e.RGBA32F),T===e.HALF_FLOAT&&(U=e.RGBA16F),T===e.UNSIGNED_BYTE&&(U=e.RGBA8)),U===e.R16F||U===e.R32F||U===e.RGBA16F||U===e.RGBA32F?t.get("EXT_color_buffer_float"):(U===e.RGB16F||U===e.RGB32F)&&console.warn("THREE.WebGLRenderer: Floating point textures with RGB format not supported. Please use RGBA instead."),U}function m(E){return E===ke||E===Pi||E===Bi?e.NEAREST:e.LINEAR}function v(E){var T=E.target;T.removeEventListener("dispose",v),b(T),T.isVideoTexture&&delete s[T.id],a.memory.textures--}function g(E){var T=E.target;T.removeEventListener("dispose",g),w(T),a.memory.textures--}function b(E){var T=i.get(E);if(E.image&&T.__image__webglTextureCube)e.deleteTexture(T.__image__webglTextureCube);else{if(T.__webglInit===void 0)return;e.deleteTexture(T.__webglTexture)}i.remove(E)}function w(E){var T=i.get(E),U=i.get(E.texture);if(E){if(U.__webglTexture!==void 0&&e.deleteTexture(U.__webglTexture),E.depthTexture&&E.depthTexture.dispose(),E.isWebGLRenderTargetCube)for(var L=0;L<6;L++)e.deleteFramebuffer(T.__webglFramebuffer[L]),T.__webglDepthbuffer&&e.deleteRenderbuffer(T.__webglDepthbuffer[L]);else e.deleteFramebuffer(T.__webglFramebuffer),T.__webglDepthbuffer&&e.deleteRenderbuffer(T.__webglDepthbuffer);i.remove(E.texture),i.remove(E)}}function y(E,T){var U=i.get(E);if(E.isVideoTexture&&Q(E),E.version>0&&U.__version!==E.version){var L=E.image;if(L===void 0)console.warn("THREE.WebGLRenderer: Texture marked for update but image is undefined");else if(L.complete===!1)console.warn("THREE.WebGLRenderer: Texture marked for update but image is incomplete");else{A(U,E,T);return}}r.activeTexture(e.TEXTURE0+T),r.bindTexture(e.TEXTURE_2D,U.__webglTexture)}function S(E,T){var U=i.get(E);if(E.version>0&&U.__version!==E.version){A(U,E,T);return}r.activeTexture(e.TEXTURE0+T),r.bindTexture(e.TEXTURE_3D,U.__webglTexture)}function R(E,T){var U=i.get(E);if(E.image.length===6)if(E.version>0&&U.__version!==E.version){U.__image__webglTextureCube||(E.addEventListener("dispose",v),U.__image__webglTextureCube=e.createTexture(),a.memory.textures++),r.activeTexture(e.TEXTURE0+T),r.bindTexture(e.TEXTURE_CUBE_MAP,U.__image__webglTextureCube),e.pixelStorei(e.UNPACK_FLIP_Y_WEBGL,E.flipY);for(var L=E&&E.isCompressedTexture,te=E.image[0]&&E.image[0].isDataTexture,N=[],q=0;q<6;q++)!L&&!te?N[q]=u(E.image[q],!1,!0,n.maxCubemapSize):N[q]=te?E.image[q].image:E.image[q];var Z=N[0],ve=c(Z),ge=o.convert(E.format),me=o.convert(E.type),W=d(ge,me);P(e.TEXTURE_CUBE_MAP,E,ve);for(var q=0;q<6;q++)if(!L)te?r.texImage2D(e.TEXTURE_CUBE_MAP_POSITIVE_X+q,0,W,N[q].width,N[q].height,0,ge,me,N[q].data):r.texImage2D(e.TEXTURE_CUBE_MAP_POSITIVE_X+q,0,W,ge,me,N[q]);else for(var pe,Fe=N[q].mipmaps,Ee=0,_t=Fe.length;Ee<_t;Ee++)pe=Fe[Ee],E.format!==wt&&E.format!==Ot?r.getCompressedTextureFormats().indexOf(ge)>-1?r.compressedTexImage2D(e.TEXTURE_CUBE_MAP_POSITIVE_X+q,Ee,W,pe.width,pe.height,0,pe.data):console.warn("THREE.WebGLRenderer: Attempt to load unsupported compressed texture format in .setTextureCube()"):r.texImage2D(e.TEXTURE_CUBE_MAP_POSITIVE_X+q,Ee,W,pe.width,pe.height,0,ge,me,pe.data);L?U.__maxMipLevel=Fe.length-1:U.__maxMipLevel=0,l(E,ve)&&p(e.TEXTURE_CUBE_MAP,E,Z.width,Z.height),U.__version=E.version,E.onUpdate&&E.onUpdate(E)}else r.activeTexture(e.TEXTURE0+T),r.bindTexture(e.TEXTURE_CUBE_MAP,U.__image__webglTextureCube)}function B(E,T){r.activeTexture(e.TEXTURE0+T),r.bindTexture(e.TEXTURE_CUBE_MAP,i.get(E).__webglTexture)}function P(E,T,U){var L;if(U?(e.texParameteri(E,e.TEXTURE_WRAP_S,o.convert(T.wrapS)),e.texParameteri(E,e.TEXTURE_WRAP_T,o.convert(T.wrapT)),e.texParameteri(E,e.TEXTURE_MAG_FILTER,o.convert(T.magFilter)),e.texParameteri(E,e.TEXTURE_MIN_FILTER,o.convert(T.minFilter))):(e.texParameteri(E,e.TEXTURE_WRAP_S,e.CLAMP_TO_EDGE),e.texParameteri(E,e.TEXTURE_WRAP_T,e.CLAMP_TO_EDGE),(T.wrapS!==vt||T.wrapT!==vt)&&console.warn("THREE.WebGLRenderer: Texture is not power of two. Texture.wrapS and Texture.wrapT should be set to THREE.ClampToEdgeWrapping."),e.texParameteri(E,e.TEXTURE_MAG_FILTER,m(T.magFilter)),e.texParameteri(E,e.TEXTURE_MIN_FILTER,m(T.minFilter)),T.minFilter!==ke&&T.minFilter!==qe&&console.warn("THREE.WebGLRenderer: Texture is not power of two. Texture.minFilter should be set to THREE.NearestFilter or THREE.LinearFilter.")),L=t.get("EXT_texture_filter_anisotropic"),L){if(T.type===Fr&&t.get("OES_texture_float_linear")===null||T.type===Fi&&(n.isWebGL2||t.get("OES_texture_half_float_linear"))===null)return;(T.anisotropy>1||i.get(T).__currentAnisotropy)&&(e.texParameterf(E,L.TEXTURE_MAX_ANISOTROPY_EXT,Math.min(T.anisotropy,n.getMaxAnisotropy())),i.get(T).__currentAnisotropy=T.anisotropy)}}function A(E,T,U){var L;T.isDataTexture3D?L=e.TEXTURE_3D:L=e.TEXTURE_2D,E.__webglInit===void 0&&(E.__webglInit=!0,T.addEventListener("dispose",v),E.__webglTexture=e.createTexture(),a.memory.textures++),r.activeTexture(e.TEXTURE0+U),r.bindTexture(L,E.__webglTexture),e.pixelStorei(e.UNPACK_FLIP_Y_WEBGL,T.flipY),e.pixelStorei(e.UNPACK_PREMULTIPLY_ALPHA_WEBGL,T.premultiplyAlpha),e.pixelStorei(e.UNPACK_ALIGNMENT,T.unpackAlignment);var te=h(T)&&c(T.image)===!1,N=u(T.image,te,!1,n.maxTextureSize),q=c(N),Z=o.convert(T.format),ve=o.convert(T.type),ge=d(Z,ve);P(L,T,q);var me,W=T.mipmaps;if(T.isDepthTexture){if(ge=e.DEPTH_COMPONENT,T.type===Fr){if(!n.isWebGL2)throw new Error("Float Depth Texture only supported in WebGL2.0");ge=e.DEPTH_COMPONENT32F}else n.isWebGL2&&(ge=e.DEPTH_COMPONENT16);T.format===_r&&ge===e.DEPTH_COMPONENT&&T.type!==ei&&T.type!==Vo&&(console.warn("THREE.WebGLRenderer: Use UnsignedShortType or UnsignedIntType for DepthFormat DepthTexture."),T.type=ei,ve=o.convert(T.type)),T.format===Dr&&(ge=e.DEPTH_STENCIL,T.type!==ti&&(console.warn("THREE.WebGLRenderer: Use UnsignedInt248Type for DepthStencilFormat DepthTexture."),T.type=ti,ve=o.convert(T.type))),r.texImage2D(e.TEXTURE_2D,0,ge,N.width,N.height,0,Z,ve,null)}else if(T.isDataTexture){if(W.length>0&&q){for(var pe=0,Fe=W.length;pe<Fe;pe++)me=W[pe],r.texImage2D(e.TEXTURE_2D,pe,ge,me.width,me.height,0,Z,ve,me.data);T.generateMipmaps=!1,E.__maxMipLevel=W.length-1}else r.texImage2D(e.TEXTURE_2D,0,ge,N.width,N.height,0,Z,ve,N.data),E.__maxMipLevel=0;T.isCfxTexture&&(e.texParameterf(e.TEXTURE_2D,e.TEXTURE_WRAP_T,e.CLAMP_TO_EDGE),e.texParameterf(e.TEXTURE_2D,e.TEXTURE_WRAP_T,e.MIRRORED_REPEAT),e.texParameterf(e.TEXTURE_2D,e.TEXTURE_WRAP_T,e.REPEAT))}else if(T.isCompressedTexture){for(var pe=0,Fe=W.length;pe<Fe;pe++)me=W[pe],T.format!==wt&&T.format!==Ot?r.getCompressedTextureFormats().indexOf(Z)>-1?r.compressedTexImage2D(e.TEXTURE_2D,pe,ge,me.width,me.height,0,me.data):console.warn("THREE.WebGLRenderer: Attempt to load unsupported compressed texture format in .uploadTexture()"):r.texImage2D(e.TEXTURE_2D,pe,ge,me.width,me.height,0,Z,ve,me.data);E.__maxMipLevel=W.length-1}else if(T.isDataTexture3D)r.texImage3D(e.TEXTURE_3D,0,ge,N.width,N.height,N.depth,0,Z,ve,N.data),E.__maxMipLevel=0;else if(W.length>0&&q){for(var pe=0,Fe=W.length;pe<Fe;pe++)me=W[pe],r.texImage2D(e.TEXTURE_2D,pe,ge,Z,ve,me);T.generateMipmaps=!1,E.__maxMipLevel=W.length-1}else r.texImage2D(e.TEXTURE_2D,0,ge,Z,ve,N),E.__maxMipLevel=0;l(T,q)&&p(e.TEXTURE_2D,T,N.width,N.height),E.__version=T.version,T.onUpdate&&T.onUpdate(T)}function D(E,T,U,L){var te=o.convert(T.texture.format),N=o.convert(T.texture.type),q=d(te,N);r.texImage2D(L,0,q,T.width,T.height,0,te,N,null),e.bindFramebuffer(e.FRAMEBUFFER,E),e.framebufferTexture2D(e.FRAMEBUFFER,U,L,i.get(T.texture).__webglTexture,0),e.bindFramebuffer(e.FRAMEBUFFER,null)}function I(E,T,U){if(e.bindRenderbuffer(e.RENDERBUFFER,E),T.depthBuffer&&!T.stencilBuffer){if(U){var L=K(T);e.renderbufferStorageMultisample(e.RENDERBUFFER,L,e.DEPTH_COMPONENT16,T.width,T.height)}else e.renderbufferStorage(e.RENDERBUFFER,e.DEPTH_COMPONENT16,T.width,T.height);e.framebufferRenderbuffer(e.FRAMEBUFFER,e.DEPTH_ATTACHMENT,e.RENDERBUFFER,E)}else if(T.depthBuffer&&T.stencilBuffer){if(U){var L=K(T);e.renderbufferStorageMultisample(e.RENDERBUFFER,L,e.DEPTH_STENCIL,T.width,T.height)}else e.renderbufferStorage(e.RENDERBUFFER,e.DEPTH_STENCIL,T.width,T.height);e.framebufferRenderbuffer(e.FRAMEBUFFER,e.DEPTH_STENCIL_ATTACHMENT,e.RENDERBUFFER,E)}else{var te=o.convert(T.texture.format),N=o.convert(T.texture.type),q=d(te,N);if(U){var L=K(T);e.renderbufferStorageMultisample(e.RENDERBUFFER,L,q,T.width,T.height)}else e.renderbufferStorage(e.RENDERBUFFER,q,T.width,T.height)}e.bindRenderbuffer(e.RENDERBUFFER,null)}function H(E,T){var U=T&&T.isWebGLRenderTargetCube;if(U)throw new Error("Depth Texture with cube render targets is not supported");if(e.bindFramebuffer(e.FRAMEBUFFER,E),!(T.depthTexture&&T.depthTexture.isDepthTexture))throw new Error("renderTarget.depthTexture must be an instance of THREE.DepthTexture");(!i.get(T.depthTexture).__webglTexture||T.depthTexture.image.width!==T.width||T.depthTexture.image.height!==T.height)&&(T.depthTexture.image.width=T.width,T.depthTexture.image.height=T.height,T.depthTexture.needsUpdate=!0),y(T.depthTexture,0);var L=i.get(T.depthTexture).__webglTexture;if(T.depthTexture.format===_r)e.framebufferTexture2D(e.FRAMEBUFFER,e.DEPTH_ATTACHMENT,e.TEXTURE_2D,L,0);else if(T.depthTexture.format===Dr)e.framebufferTexture2D(e.FRAMEBUFFER,e.DEPTH_STENCIL_ATTACHMENT,e.TEXTURE_2D,L,0);else throw new Error("Unknown depthTexture format")}function X(E){var T=i.get(E),U=E.isWebGLRenderTargetCube===!0;if(E.depthTexture){if(U)throw new Error("target.depthTexture not supported in Cube render targets");H(T.__webglFramebuffer,E)}else if(U){T.__webglDepthbuffer=[];for(var L=0;L<6;L++)e.bindFramebuffer(e.FRAMEBUFFER,T.__webglFramebuffer[L]),T.__webglDepthbuffer[L]=e.createRenderbuffer(),I(T.__webglDepthbuffer[L],E)}else e.bindFramebuffer(e.FRAMEBUFFER,T.__webglFramebuffer),T.__webglDepthbuffer=e.createRenderbuffer(),I(T.__webglDepthbuffer,E);e.bindFramebuffer(e.FRAMEBUFFER,null)}function j(E){var T=i.get(E),U=i.get(E.texture);E.addEventListener("dispose",g),U.__webglTexture=e.createTexture(),a.memory.textures++;var L=E.isWebGLRenderTargetCube===!0,te=E.isWebGLMultisampleRenderTarget===!0,N=c(E);if(L){T.__webglFramebuffer=[];for(var q=0;q<6;q++)T.__webglFramebuffer[q]=e.createFramebuffer()}else if(T.__webglFramebuffer=e.createFramebuffer(),te)if(n.isWebGL2){T.__webglMultisampledFramebuffer=e.createFramebuffer(),T.__webglColorRenderbuffer=e.createRenderbuffer(),e.bindRenderbuffer(e.RENDERBUFFER,T.__webglColorRenderbuffer);var Z=o.convert(E.texture.format),ve=o.convert(E.texture.type),ge=d(Z,ve),me=K(E);e.renderbufferStorageMultisample(e.RENDERBUFFER,me,ge,E.width,E.height),e.bindFramebuffer(e.FRAMEBUFFER,T.__webglMultisampledFramebuffer),e.framebufferRenderbuffer(e.FRAMEBUFFER,e.COLOR_ATTACHMENT0,e.RENDERBUFFER,T.__webglColorRenderbuffer),e.bindRenderbuffer(e.RENDERBUFFER,null),E.depthBuffer&&(T.__webglDepthRenderbuffer=e.createRenderbuffer(),I(T.__webglDepthRenderbuffer,E,!0)),e.bindFramebuffer(e.FRAMEBUFFER,null)}else console.warn("THREE.WebGLRenderer: WebGLMultisampleRenderTarget can only be used with WebGL2.");if(L){r.bindTexture(e.TEXTURE_CUBE_MAP,U.__webglTexture),P(e.TEXTURE_CUBE_MAP,E.texture,N);for(var q=0;q<6;q++)D(T.__webglFramebuffer[q],E,e.COLOR_ATTACHMENT0,e.TEXTURE_CUBE_MAP_POSITIVE_X+q);l(E.texture,N)&&p(e.TEXTURE_CUBE_MAP,E.texture,E.width,E.height),r.bindTexture(e.TEXTURE_CUBE_MAP,null)}else r.bindTexture(e.TEXTURE_2D,U.__webglTexture),P(e.TEXTURE_2D,E.texture,N),D(T.__webglFramebuffer,E,e.COLOR_ATTACHMENT0,e.TEXTURE_2D),l(E.texture,N)&&p(e.TEXTURE_2D,E.texture,E.width,E.height),r.bindTexture(e.TEXTURE_2D,null);E.depthBuffer&&X(E)}function V(E){var T=E.texture,U=c(E);if(l(T,U)){var L=E.isWebGLRenderTargetCube?e.TEXTURE_CUBE_MAP:e.TEXTURE_2D,te=i.get(T).__webglTexture;r.bindTexture(L,te),p(L,T,E.width,E.height),r.bindTexture(L,null)}}function $(E){if(E.isWebGLMultisampleRenderTarget)if(n.isWebGL2){var T=i.get(E);e.bindFramebuffer(e.READ_FRAMEBUFFER,T.__webglMultisampledFramebuffer),e.bindFramebuffer(e.DRAW_FRAMEBUFFER,T.__webglFramebuffer);var U=E.width,L=E.height,te=e.COLOR_BUFFER_BIT;E.depthBuffer&&(te|=e.DEPTH_BUFFER_BIT),E.stencilBuffer&&(te|=e.STENCIL_BUFFER_BIT),e.blitFramebuffer(0,0,U,L,0,0,U,L,te,e.NEAREST)}else console.warn("THREE.WebGLRenderer: WebGLMultisampleRenderTarget can only be used with WebGL2.")}function K(E){return n.isWebGL2&&E.isWebGLMultisampleRenderTarget?Math.min(n.maxSamples,E.samples):0}function Q(E){var T=E.id,U=a.render.frame;s[T]!==U&&(s[T]=U,E.update())}this.setTexture2D=y,this.setTexture3D=S,this.setTextureCube=R,this.setTextureCubeDynamic=B,this.setupRenderTarget=j,this.updateRenderTargetMipmap=V,this.updateMultisampleRenderTarget=$}function Ha(e,t,r){function i(n){var o;if(n===Ht)return e.REPEAT;if(n===vt)return e.CLAMP_TO_EDGE;if(n===ar)return e.MIRRORED_REPEAT;if(n===ke)return e.NEAREST;if(n===Pi)return e.NEAREST_MIPMAP_NEAREST;if(n===Bi)return e.NEAREST_MIPMAP_LINEAR;if(n===qe)return e.LINEAR;if(n===Ho)return e.LINEAR_MIPMAP_NEAREST;if(n===Pr)return e.LINEAR_MIPMAP_LINEAR;if(n===Br)return e.UNSIGNED_BYTE;if(n===ks)return e.UNSIGNED_SHORT_4_4_4_4;if(n===Ws)return e.UNSIGNED_SHORT_5_5_5_1;if(n===Xs)return e.UNSIGNED_SHORT_5_6_5;if(n===zs)return e.BYTE;if(n===Hs)return e.SHORT;if(n===ei)return e.UNSIGNED_SHORT;if(n===Vs)return e.INT;if(n===Vo)return e.UNSIGNED_INT;if(n===Fr)return e.FLOAT;if(n===Fi){if(r.isWebGL2)return e.HALF_FLOAT;if(o=t.get("OES_texture_half_float"),o!==null)return o.HALF_FLOAT_OES}if(n===js)return e.ALPHA;if(n===Ot)return e.RGB;if(n===wt)return e.RGBA;if(n===qs)return e.LUMINANCE;if(n===Ys)return e.LUMINANCE_ALPHA;if(n===_r)return e.DEPTH_COMPONENT;if(n===Dr)return e.DEPTH_STENCIL;if(n===Zs)return e.RED;if(n===xr)return e.FUNC_ADD;if(n===vs)return e.FUNC_SUBTRACT;if(n===gs)return e.FUNC_REVERSE_SUBTRACT;if(n===ys)return e.ZERO;if(n===xs)return e.ONE;if(n===_s)return e.SRC_COLOR;if(n===bs)return e.ONE_MINUS_SRC_COLOR;if(n===Io)return e.SRC_ALPHA;if(n===Oo)return e.ONE_MINUS_SRC_ALPHA;if(n===ws)return e.DST_ALPHA;if(n===Ms)return e.ONE_MINUS_DST_ALPHA;if(n===Es)return e.DST_COLOR;if(n===Ts)return e.ONE_MINUS_DST_COLOR;if(n===Ss)return e.SRC_ALPHA_SATURATE;if((n===La||n===Ra||n===Ca||n===Pa)&&(o=t.get("WEBGL_compressed_texture_s3tc"),o!==null)){if(n===La)return o.COMPRESSED_RGB_S3TC_DXT1_EXT;if(n===Ra)return o.COMPRESSED_RGBA_S3TC_DXT1_EXT;if(n===Ca)return o.COMPRESSED_RGBA_S3TC_DXT3_EXT;if(n===Pa)return o.COMPRESSED_RGBA_S3TC_DXT5_EXT}if((n===Ba||n===Fa||n===Da||n===Ia)&&(o=t.get("WEBGL_compressed_texture_pvrtc"),o!==null)){if(n===Ba)return o.COMPRESSED_RGB_PVRTC_4BPPV1_IMG;if(n===Fa)return o.COMPRESSED_RGB_PVRTC_2BPPV1_IMG;if(n===Da)return o.COMPRESSED_RGBA_PVRTC_4BPPV1_IMG;if(n===Ia)return o.COMPRESSED_RGBA_PVRTC_2BPPV1_IMG}if(n===Js&&(o=t.get("WEBGL_compressed_texture_etc1"),o!==null))return o.COMPRESSED_RGB_ETC1_WEBGL;if((n===Qs||n===Ks||n===$s||n===ef||n===tf||n===rf||n===nf||n===of||n===af||n===sf||n===ff||n===uf||n===cf||n===hf)&&(o=t.get("WEBGL_compressed_texture_astc"),o!==null))return n;if(n===Fo||n===Do){if(r.isWebGL2){if(n===Fo)return e.MIN;if(n===Do)return e.MAX}if(o=t.get("EXT_blend_minmax"),o!==null){if(n===Fo)return o.MIN_EXT;if(n===Do)return o.MAX_EXT}}if(n===ti){if(r.isWebGL2)return e.UNSIGNED_INT_24_8;if(o=t.get("WEBGL_depth_texture"),o!==null)return o.UNSIGNED_INT_24_8_WEBGL}return 0}return{convert:i}}function Er(){k.call(this),this.type="Group"}Er.prototype=Object.assign(Object.create(k.prototype),{constructor:Er,isGroup:!0});function Nt(){k.call(this),this.type="Camera",this.matrixWorldInverse=new ee,this.projectionMatrix=new ee,this.projectionMatrixInverse=new ee}Nt.prototype=Object.assign(Object.create(k.prototype),{constructor:Nt,isCamera:!0,copy:function(e,t){return k.prototype.copy.call(this,e,t),this.matrixWorldInverse.copy(e.matrixWorldInverse),this.projectionMatrix.copy(e.projectionMatrix),this.projectionMatrixInverse.copy(e.projectionMatrixInverse),this},getWorldDirection:function(e){e===void 0&&(console.warn("THREE.Camera: .getWorldDirection() target is now required"),e=new x),this.updateMatrixWorld(!0);var t=this.matrixWorld.elements;return e.set(-t[8],-t[9],-t[10]).normalize()},updateMatrixWorld:function(e){k.prototype.updateMatrixWorld.call(this,e),this.matrixWorldInverse.getInverse(this.matrixWorld)},clone:function(){return new this.constructor().copy(this)}});function De(e,t,r,i){Nt.call(this),this.type="PerspectiveCamera",this.fov=e!==void 0?e:50,this.zoom=1,this.near=r!==void 0?r:.1,this.far=i!==void 0?i:2e3,this.focus=10,this.aspect=t!==void 0?t:1,this.view=null,this.filmGauge=35,this.filmOffset=0,this.updateProjectionMatrix()}De.prototype=Object.assign(Object.create(Nt.prototype),{constructor:De,isPerspectiveCamera:!0,copy:function(e,t){return Nt.prototype.copy.call(this,e,t),this.fov=e.fov,this.zoom=e.zoom,this.near=e.near,this.far=e.far,this.focus=e.focus,this.aspect=e.aspect,this.view=e.view===null?null:Object.assign({},e.view),this.filmGauge=e.filmGauge,this.filmOffset=e.filmOffset,this},setFocalLength:function(e){var t=.5*this.getFilmHeight()/e;this.fov=ie.RAD2DEG*2*Math.atan(t),this.updateProjectionMatrix()},getFocalLength:function(){var e=Math.tan(ie.DEG2RAD*.5*this.fov);return .5*this.getFilmHeight()/e},getEffectiveFOV:function(){return ie.RAD2DEG*2*Math.atan(Math.tan(ie.DEG2RAD*.5*this.fov)/this.zoom)},getFilmWidth:function(){return this.filmGauge*Math.min(this.aspect,1)},getFilmHeight:function(){return this.filmGauge/Math.max(this.aspect,1)},setViewOffset:function(e,t,r,i,n,o){this.aspect=e/t,this.view===null&&(this.view={enabled:!0,fullWidth:1,fullHeight:1,offsetX:0,offsetY:0,width:1,height:1}),this.view.enabled=!0,this.view.fullWidth=e,this.view.fullHeight=t,this.view.offsetX=r,this.view.offsetY=i,this.view.width=n,this.view.height=o,this.updateProjectionMatrix()},clearViewOffset:function(){this.view!==null&&(this.view.enabled=!1),this.updateProjectionMatrix()},updateProjectionMatrix:function(){var e=this.near,t=e*Math.tan(ie.DEG2RAD*.5*this.fov)/this.zoom,r=2*t,i=this.aspect*r,n=-.5*i,o=this.view;if(this.view!==null&&this.view.enabled){var a=o.fullWidth,s=o.fullHeight;n+=o.offsetX*i/a,t-=o.offsetY*r/s,i*=o.width/a,r*=o.height/s}var f=this.filmOffset;f!==0&&(n+=e*f/this.getFilmWidth()),this.projectionMatrix.makePerspective(n,n+i,t,t-r,e,this.far),this.projectionMatrixInverse.getInverse(this.projectionMatrix)},toJSON:function(e){var t=k.prototype.toJSON.call(this,e);return t.object.fov=this.fov,t.object.zoom=this.zoom,t.object.near=this.near,t.object.far=this.far,t.object.focus=this.focus,t.object.aspect=this.aspect,this.view!==null&&(t.object.view=Object.assign({},this.view)),t.object.filmGauge=this.filmGauge,t.object.filmOffset=this.filmOffset,t}});function ai(e){De.call(this),this.cameras=e||[]}ai.prototype=Object.assign(Object.create(De.prototype),{constructor:ai,isArrayCamera:!0});var wh=new x,Mh=new x;function ra(e,t,r){wh.setFromMatrixPosition(t.matrixWorld),Mh.setFromMatrixPosition(r.matrixWorld);var i=wh.distanceTo(Mh),n=t.projectionMatrix.elements,o=r.projectionMatrix.elements,a=n[14]/(n[10]-1),s=n[14]/(n[10]+1),f=(n[9]+1)/n[5],u=(n[9]-1)/n[5],c=(n[8]-1)/n[0],h=(o[8]+1)/o[0],l=a*c,p=a*h,d=i/(-c+h),m=d*-c;t.matrixWorld.decompose(e.position,e.quaternion,e.scale),e.translateX(m),e.translateZ(d),e.matrixWorld.compose(e.position,e.quaternion,e.scale),e.matrixWorldInverse.getInverse(e.matrixWorld);var v=a+d,g=s+d,b=l-m,w=p+(i-m),y=f*s/g*v,S=u*s/g*v;e.projectionMatrix.makePerspective(b,w,y,S,v,g)}function ia(e){var t=this,r=null,i=null,n=null,o=[],a=new ee,s=new ee,f=1,u="stage";typeof window<"u"&&"VRFrameData"in window&&(i=new window.VRFrameData,window.addEventListener("vrdisplaypresentchange",w,!1));var c=new ee,h=new Ge,l=new x,p=new De;p.bounds=new we(0,0,.5,1),p.layers.enable(1);var d=new De;d.bounds=new we(.5,0,.5,1),d.layers.enable(2);var m=new ai([p,d]);m.layers.enable(1),m.layers.enable(2);function v(){return r!==null&&r.isPresenting===!0}var g,b;function w(){if(v()){var P=r.getEyeParameters("left"),A=P.renderWidth*f,D=P.renderHeight*f;b=e.getPixelRatio(),g=e.getSize(),e.setDrawingBufferSize(A*2,D,1),B.start()}else t.enabled&&e.setDrawingBufferSize(g.width,g.height,b),B.stop()}var y=[];function S(P){for(var A=navigator.getGamepads&&navigator.getGamepads(),D=0,I=0,H=A.length;D<H;D++){var X=A[D];if(X&&(X.id==="Daydream Controller"||X.id==="Gear VR Controller"||X.id==="Oculus Go Controller"||X.id==="OpenVR Gamepad"||X.id.startsWith("Oculus Touch")||X.id.startsWith("Spatial Controller"))){if(I===P)return X;I++}}}function R(){for(var P=0;P<o.length;P++){var A=o[P],D=S(P);if(D!==void 0&&D.pose!==void 0){if(D.pose===null)return;var I=D.pose;I.hasPosition===!1&&A.position.set(.2,-.6,-.05),I.position!==null&&A.position.fromArray(I.position),I.orientation!==null&&A.quaternion.fromArray(I.orientation),A.matrix.compose(A.position,A.quaternion,A.scale),A.matrix.premultiply(a),A.matrix.decompose(A.position,A.quaternion,A.scale),A.matrixWorldNeedsUpdate=!0,A.visible=!0;var H=D.id==="Daydream Controller"?0:1;y[P]!==D.buttons[H].pressed&&(y[P]=D.buttons[H].pressed,y[P]===!0?A.dispatchEvent({type:"selectstart"}):(A.dispatchEvent({type:"selectend"}),A.dispatchEvent({type:"select"})))}else A.visible=!1}}this.enabled=!1,this.getController=function(P){var A=o[P];return A===void 0&&(A=new Er,A.matrixAutoUpdate=!1,A.visible=!1,o[P]=A),A},this.getDevice=function(){return r},this.setDevice=function(P){P!==void 0&&(r=P),B.setContext(P)},this.setFramebufferScaleFactor=function(P){f=P},this.setFrameOfReferenceType=function(P){u=P},this.setPoseTarget=function(P){P!==void 0&&(n=P)},this.getCamera=function(P){var A=u==="stage"?1.6:0;if(r===null)return P.position.set(0,A,0),P;if(r.depthNear=P.near,r.depthFar=P.far,r.getFrameData(i),u==="stage"){var D=r.stageParameters;D?a.fromArray(D.sittingToStandingTransform):a.makeTranslation(0,A,0)}var I=i.pose,H=n!==null?n:P;if(H.matrix.copy(a),H.matrix.decompose(H.position,H.quaternion,H.scale),I.orientation!==null&&(h.fromArray(I.orientation),H.quaternion.multiply(h)),I.position!==null&&(h.setFromRotationMatrix(a),l.fromArray(I.position),l.applyQuaternion(h),H.position.add(l)),H.updateMatrixWorld(),r.isPresenting===!1)return P;p.near=P.near,d.near=P.near,p.far=P.far,d.far=P.far,p.matrixWorldInverse.fromArray(i.leftViewMatrix),d.matrixWorldInverse.fromArray(i.rightViewMatrix),s.getInverse(a),u==="stage"&&(p.matrixWorldInverse.multiply(s),d.matrixWorldInverse.multiply(s));var X=H.parent;X!==null&&(c.getInverse(X.matrixWorld),p.matrixWorldInverse.multiply(c),d.matrixWorldInverse.multiply(c)),p.matrixWorld.getInverse(p.matrixWorldInverse),d.matrixWorld.getInverse(d.matrixWorldInverse),p.projectionMatrix.fromArray(i.leftProjectionMatrix),d.projectionMatrix.fromArray(i.rightProjectionMatrix),ra(m,p,d);var j=r.getLayers();if(j.length){var V=j[0];V.leftBounds!==null&&V.leftBounds.length===4&&p.bounds.fromArray(V.leftBounds),V.rightBounds!==null&&V.rightBounds.length===4&&d.bounds.fromArray(V.rightBounds)}return R(),m},this.getStandingMatrix=function(){return a},this.isPresenting=v;var B=new Ni;this.setAnimationLoop=function(P){B.setAnimationLoop(P)},this.submitFrame=function(){v()&&r.submitFrame()},this.dispose=function(){typeof window<"u"&&window.removeEventListener("vrdisplaypresentchange",w)}}function Eh(e){var t=e.context,r=null,i=null,n=1,o=null,a="stage",s=null,f=[],u=[];function c(){return i!==null&&o!==null}var h=new De;h.layers.enable(1),h.viewport=new we;var l=new De;l.layers.enable(2),l.viewport=new we;var p=new ai([h,l]);p.layers.enable(1),p.layers.enable(2),this.enabled=!1,this.getController=function(y){var S=f[y];return S===void 0&&(S=new Er,S.matrixAutoUpdate=!1,S.visible=!1,f[y]=S),S},this.getDevice=function(){return r},this.setDevice=function(y){y!==void 0&&(r=y),y instanceof XRDevice&&t.setCompatibleXRDevice(y)};function d(y){var S=f[u.indexOf(y.inputSource)];S&&S.dispatchEvent({type:y.type})}function m(){e.setFramebuffer(null),w.stop()}this.setFramebufferScaleFactor=function(y){n=y},this.setFrameOfReferenceType=function(y){a=y},this.setSession=function(y){i=y,i!==null&&(i.addEventListener("select",d),i.addEventListener("selectstart",d),i.addEventListener("selectend",d),i.addEventListener("end",m),i.baseLayer=new XRWebGLLayer(i,t,{framebufferScaleFactor:n}),i.requestFrameOfReference(a).then(function(S){o=S,e.setFramebuffer(i.baseLayer.framebuffer),w.setContext(i),w.start()}),u=i.getInputSources(),i.addEventListener("inputsourceschange",function(){u=i.getInputSources(),console.log(u);for(var S=0;S<f.length;S++){var R=f[S];R.userData.inputSource=u[S]}}))};function v(y,S){S===null?y.matrixWorld.copy(y.matrix):y.matrixWorld.multiplyMatrices(S.matrixWorld,y.matrix),y.matrixWorldInverse.getInverse(y.matrixWorld)}this.getCamera=function(y){if(c()){var S=y.parent,R=p.cameras;v(p,S);for(var B=0;B<R.length;B++)v(R[B],S);y.matrixWorld.copy(p.matrixWorld);for(var P=y.children,B=0,A=P.length;B<A;B++)P[B].updateMatrixWorld(!0);return ra(p,h,l),p}return y},this.isPresenting=c;var g=null;function b(y,S){if(s=S.getDevicePose(o),s!==null)for(var R=i.baseLayer,B=S.views,P=0;P<B.length;P++){var A=B[P],D=R.getViewport(A),I=s.getViewMatrix(A),H=p.cameras[P];H.matrix.fromArray(I).getInverse(H.matrix),H.projectionMatrix.fromArray(A.projectionMatrix),H.viewport.set(D.x,D.y,D.width,D.height),P===0&&p.matrix.copy(H.matrix)}for(var P=0;P<f.length;P++){var X=f[P],j=u[P];if(j){var V=S.getInputPose(j,o);if(V!==null){"targetRay"in V?X.matrix.elements=V.targetRay.transformMatrix:"pointerMatrix"in V&&(X.matrix.elements=V.pointerMatrix),X.matrix.decompose(X.position,X.rotation,X.scale),X.visible=!0;continue}}X.visible=!1}g&&g(y)}var w=new Ni;w.setAnimationLoop(b),this.setAnimationLoop=function(y){g=y},this.dispose=function(){},this.getStandingMatrix=function(){return console.warn("THREE.WebXRManager: getStandingMatrix() is no longer needed."),new THREE.Matrix4},this.submitFrame=function(){}}function Hi(e){console.log("THREE.WebGLRenderer",ls),e=e||{};var t=e.canvas!==void 0?e.canvas:document.createElementNS("http://www.w3.org/1999/xhtml","canvas"),r=e.context!==void 0?e.context:null,i=e.alpha!==void 0?e.alpha:!1,n=e.depth!==void 0?e.depth:!0,o=e.stencil!==void 0?e.stencil:!0,a=e.antialias!==void 0?e.antialias:!1,s=e.premultipliedAlpha!==void 0?e.premultipliedAlpha:!0,f=e.preserveDrawingBuffer!==void 0?e.preserveDrawingBuffer:!1,u=e.powerPreference!==void 0?e.powerPreference:"default",c=null,h=null;this.domElement=t,this.context=null,this.autoClear=!0,this.autoClearColor=!0,this.autoClearDepth=!0,this.autoClearStencil=!0,this.sortObjects=!0,this.clippingPlanes=[],this.localClippingEnabled=!1,this.gammaFactor=2,this.gammaInput=!1,this.gammaOutput=!1,this.physicallyCorrectLights=!1,this.toneMapping=No,this.toneMappingExposure=1,this.toneMappingWhitePoint=1,this.maxMorphTargets=8,this.maxMorphNormals=4;var l=this,p=!1,d=null,m=null,v=null,g=-1,b={geometry:null,program:null,wireframe:!1},w=null,y=null,S=new we,R=new we,B=null,P=0,A=t.width,D=t.height,I=1,H=new we(0,0,A,D),X=new we(0,0,A,D),j=!1,V=new Ui,$=new zc,K=!1,Q=!1,E=new ee,T=new x;function U(){return m===null?I:1}var L;try{var te={alpha:i,depth:n,stencil:o,antialias:a,premultipliedAlpha:s,preserveDrawingBuffer:f,powerPreference:u};if(t.addEventListener("webglcontextlost",Lt,!1),t.addEventListener("webglcontextrestored",Rt,!1),L=r||t.getContext("webgl",te)||t.getContext("experimental-webgl",te),L===null)throw t.getContext("webgl")!==null?new Error("Error creating WebGL context with your selected attributes."):new Error("Error creating WebGL context.");L.getShaderPrecisionFormat===void 0&&(L.getShaderPrecisionFormat=function(){return{rangeMin:1,rangeMax:1,precision:1}})}catch(_){console.error("THREE.WebGLRenderer: "+_.message)}var N,q,Z,ve,ge,me,W,pe,Fe,Ee,_t,Je,st,dt,mr,Jt,et;function ft(){N=new Hc(L),q=new Gc(L,N,e),q.isWebGL2||(N.get("WEBGL_depth_texture"),N.get("OES_texture_float"),N.get("OES_texture_half_float"),N.get("OES_texture_half_float_linear"),N.get("OES_standard_derivatives"),N.get("OES_element_index_uint"),N.get("ANGLE_instanced_arrays")),N.get("OES_texture_float_linear"),et=new Ha(L,N,q),Z=new _h(L,N,et,q),Z.scissor(R.copy(X).multiplyScalar(I)),Z.viewport(S.copy(H).multiplyScalar(I)),ve=new Wc(L),ge=new dh,me=new bh(L,N,Z,ge,q,et,ve),W=new Oc(L),pe=new Vc(L,W,ve),Fe=new jc(pe,ve),dt=new Xc(L),Ee=new ph(l,N,q),_t=new vh,Je=new xh,st=new Uc(l,Z,Fe,s),mr=new Nc(L,N,ve,q),Jt=new kc(L,N,ve,q),ve.programs=Ee.programs,l.context=L,l.capabilities=q,l.extensions=N,l.properties=ge,l.renderLists=_t,l.state=Z,l.info=ve}ft();var mt=null;typeof navigator<"u"&&(mt="xr"in navigator?new Eh(l):new ia(l)),this.vr=mt;var Ai=new ta(l,Fe,q.maxTextureSize);this.shadowMap=Ai,this.getContext=function(){return L},this.getContextAttributes=function(){return L.getContextAttributes()},this.forceContextLoss=function(){var _=N.get("WEBGL_lose_context");_&&_.loseContext()},this.forceContextRestore=function(){var _=N.get("WEBGL_lose_context");_&&_.restoreContext()},this.getPixelRatio=function(){return I},this.setPixelRatio=function(_){_!==void 0&&(I=_,this.setSize(A,D,!1))},this.getSize=function(){return{width:A,height:D}},this.setSize=function(_,M,C){if(mt.isPresenting()){console.warn("THREE.WebGLRenderer: Can't change size while VR device is presenting.");return}A=_,D=M,t.width=_*I,t.height=M*I,C!==!1&&(t.style.width=_+"px",t.style.height=M+"px"),this.setViewport(0,0,_,M)},this.getDrawingBufferSize=function(){return{width:A*I,height:D*I}},this.setDrawingBufferSize=function(_,M,C){A=_,D=M,I=C,t.width=_*C,t.height=M*C,this.setViewport(0,0,_,M)},this.getCurrentViewport=function(){return S},this.setViewport=function(_,M,C,Y){H.set(_,D-M-Y,C,Y),Z.viewport(S.copy(H).multiplyScalar(I))},this.setScissor=function(_,M,C,Y){X.set(_,D-M-Y,C,Y),Z.scissor(R.copy(X).multiplyScalar(I))},this.setScissorTest=function(_){Z.setScissorTest(j=_)},this.getClearColor=function(){return st.getClearColor()},this.setClearColor=function(){st.setClearColor.apply(st,arguments)},this.getClearAlpha=function(){return st.getClearAlpha()},this.setClearAlpha=function(){st.setClearAlpha.apply(st,arguments)},this.clear=function(_,M,C){var Y=0;(_===void 0||_)&&(Y|=L.COLOR_BUFFER_BIT),(M===void 0||M)&&(Y|=L.DEPTH_BUFFER_BIT),(C===void 0||C)&&(Y|=L.STENCIL_BUFFER_BIT),L.clear(Y)},this.clearColor=function(){this.clear(!0,!1,!1)},this.clearDepth=function(){this.clear(!1,!0,!1)},this.clearStencil=function(){this.clear(!1,!1,!0)},this.dispose=function(){t.removeEventListener("webglcontextlost",Lt,!1),t.removeEventListener("webglcontextrestored",Rt,!1),_t.dispose(),Je.dispose(),ge.dispose(),Fe.dispose(),mt.dispose(),Re.stop()};function Lt(_){_.preventDefault(),console.log("THREE.WebGLRenderer: Context Lost."),p=!0}function Rt(){console.log("THREE.WebGLRenderer: Context Restored."),p=!1,ft()}function Le(_){var M=_.target;M.removeEventListener("dispose",Le),Pe(M)}function Pe(_){F(_),ge.remove(_)}function F(_){var M=ge.get(_).program;_.program=void 0,M!==void 0&&Ee.releaseProgram(M)}function se(_,M){_.render(function(C){l.renderBufferImmediate(C,M)})}this.renderBufferImmediate=function(_,M){Z.initAttributes();var C=ge.get(_);_.hasPositions&&!C.position&&(C.position=L.createBuffer()),_.hasNormals&&!C.normal&&(C.normal=L.createBuffer()),_.hasUvs&&!C.uv&&(C.uv=L.createBuffer()),_.hasColors&&!C.color&&(C.color=L.createBuffer());var Y=M.getAttributes();_.hasPositions&&(L.bindBuffer(L.ARRAY_BUFFER,C.position),L.bufferData(L.ARRAY_BUFFER,_.positionArray,L.DYNAMIC_DRAW),Z.enableAttribute(Y.position),L.vertexAttribPointer(Y.position,3,L.FLOAT,!1,0,0)),_.hasNormals&&(L.bindBuffer(L.ARRAY_BUFFER,C.normal),L.bufferData(L.ARRAY_BUFFER,_.normalArray,L.DYNAMIC_DRAW),Z.enableAttribute(Y.normal),L.vertexAttribPointer(Y.normal,3,L.FLOAT,!1,0,0)),_.hasUvs&&(L.bindBuffer(L.ARRAY_BUFFER,C.uv),L.bufferData(L.ARRAY_BUFFER,_.uvArray,L.DYNAMIC_DRAW),Z.enableAttribute(Y.uv),L.vertexAttribPointer(Y.uv,2,L.FLOAT,!1,0,0)),_.hasColors&&(L.bindBuffer(L.ARRAY_BUFFER,C.color),L.bufferData(L.ARRAY_BUFFER,_.colorArray,L.DYNAMIC_DRAW),Z.enableAttribute(Y.color),L.vertexAttribPointer(Y.color,3,L.FLOAT,!1,0,0)),Z.disableUnusedAttributes(),L.drawArrays(L.TRIANGLES,0,_.count),_.count=0},this.renderBufferDirect=function(_,M,C,Y,oe,Ce){var fe=oe.isMesh&&oe.normalMatrix.determinant()<0;Z.setMaterial(Y,fe);var ue=It(_,M,Y,oe),be=!1;(b.geometry!==C.id||b.program!==ue.id||b.wireframe!==(Y.wireframe===!0))&&(b.geometry=C.id,b.program=ue.id,b.wireframe=Y.wireframe===!0,be=!0),oe.morphTargetInfluences&&(dt.update(oe,C,Y,ue),be=!0);var Ve=C.index,Ie=C.attributes.position,je=1;Y.wireframe===!0&&(Ve=pe.getWireframeAttribute(C),je=2);var $e,Se=mr;Ve!==null&&($e=W.get(Ve),Se=Jt,Se.setIndex($e)),be&&(ce(Y,ue,C),Ve!==null&&L.bindBuffer(L.ELEMENT_ARRAY_BUFFER,$e.buffer));var de=1/0;Ve!==null?de=Ve.count:Ie!==void 0&&(de=Ie.count);var Be=C.drawRange.start*je,ut=C.drawRange.count*je,nr=Ce!==null?Ce.start*je:0,tt=Ce!==null?Ce.count*je:1/0,vr=Math.max(Be,nr),Lo=Math.min(de,Be+ut,nr+tt)-1,Ma=Math.max(0,Lo-vr+1);if(Ma!==0){if(oe.isMesh)if(Y.wireframe===!0)Z.setLineWidth(Y.wireframeLinewidth*U()),Se.setMode(L.LINES);else switch(oe.drawMode){case Wo:Se.setMode(L.TRIANGLES);break;case mf:Se.setMode(L.TRIANGLE_STRIP);break;case vf:Se.setMode(L.TRIANGLE_FAN);break}else if(oe.isLine){var Ea=Y.linewidth;Ea===void 0&&(Ea=1),Z.setLineWidth(Ea*U()),oe.isLineSegments?Se.setMode(L.LINES):oe.isLineLoop?Se.setMode(L.LINE_LOOP):Se.setMode(L.LINE_STRIP)}else oe.isPoints?Se.setMode(L.POINTS):oe.isSprite&&Se.setMode(L.TRIANGLES);C&&C.isInstancedBufferGeometry?C.maxInstancedCount>0&&Se.renderInstances(C,vr,Ma):Se.render(vr,Ma)}};function ce(_,M,C){if(C&&C.isInstancedBufferGeometry&!q.isWebGL2&&N.get("ANGLE_instanced_arrays")===null){console.error("THREE.WebGLRenderer.setupVertexAttributes: using THREE.InstancedBufferGeometry but hardware does not support extension ANGLE_instanced_arrays.");return}Z.initAttributes();var Y=C.attributes,oe=M.getAttributes(),Ce=_.defaultAttributeValues;for(var fe in oe){var ue=oe[fe];if(ue>=0){var be=Y[fe];if(be!==void 0){var Ve=be.normalized,Ie=be.itemSize,je=W.get(be);if(je===void 0)continue;var $e=je.buffer,Se=je.type,de=je.bytesPerElement;if(be.isInterleavedBufferAttribute){var Be=be.data,ut=Be.stride,nr=be.offset;Be&&Be.isInstancedInterleavedBuffer?(Z.enableAttributeAndDivisor(ue,Be.meshPerAttribute),C.maxInstancedCount===void 0&&(C.maxInstancedCount=Be.meshPerAttribute*Be.count)):Z.enableAttribute(ue),L.bindBuffer(L.ARRAY_BUFFER,$e),L.vertexAttribPointer(ue,Ie,Se,Ve,ut*de,nr*de)}else be.isInstancedBufferAttribute?(Z.enableAttributeAndDivisor(ue,be.meshPerAttribute),C.maxInstancedCount===void 0&&(C.maxInstancedCount=be.meshPerAttribute*be.count)):Z.enableAttribute(ue),L.bindBuffer(L.ARRAY_BUFFER,$e),L.vertexAttribPointer(ue,Ie,Se,Ve,0,0)}else if(Ce!==void 0){var tt=Ce[fe];if(tt!==void 0)switch(tt.length){case 2:L.vertexAttrib2fv(ue,tt);break;case 3:L.vertexAttrib3fv(ue,tt);break;case 4:L.vertexAttrib4fv(ue,tt);break;default:L.vertexAttrib1fv(ue,tt)}}}}Z.disableUnusedAttributes()}this.compile=function(_,M){h=Je.get(_,M),h.init(),_.traverse(function(C){C.isLight&&(h.pushLight(C),C.castShadow&&h.pushShadow(C))}),h.setupLights(M),_.traverse(function(C){if(C.material)if(Array.isArray(C.material))for(var Y=0;Y<C.material.length;Y++)He(C.material[Y],_.fog,C);else He(C.material,_.fog,C)})};var Te=null;function le(_){mt.isPresenting()||Te&&Te(_)}var Re=new Ni;Re.setAnimationLoop(le),typeof window<"u"&&Re.setContext(window),this.setAnimationLoop=function(_){Te=_,mt.setAnimationLoop(_),Re.start()},this.render=function(_,M,C,Y){if(!(M&&M.isCamera)){console.error("THREE.WebGLRenderer.render: camera is not an instance of THREE.Camera.");return}if(!p){b.geometry=null,b.program=null,b.wireframe=!1,g=-1,w=null,_.autoUpdate===!0&&_.updateMatrixWorld(),M.parent===null&&M.updateMatrixWorld(),mt.enabled&&(M=mt.getCamera(M)),h=Je.get(_,M),h.init(),_.onBeforeRender(l,_,M,C),E.multiplyMatrices(M.projectionMatrix,M.matrixWorldInverse),V.setFromMatrix(E),Q=this.localClippingEnabled,K=$.init(this.clippingPlanes,Q,M),c=_t.get(_,M),c.init(),ze(_,M,0,l.sortObjects),l.sortObjects===!0&&c.sort(),K&&$.beginShadows();var oe=h.state.shadowsArray;Ai.render(oe,_,M),h.setupLights(M),K&&$.endShadows(),this.info.autoReset&&this.info.reset(),C===void 0&&(C=null),this.setRenderTarget(C),st.render(c,_,M,Y);var Ce=c.opaque,fe=c.transparent;if(_.overrideMaterial){var ue=_.overrideMaterial;Ce.length&&Ne(Ce,_,M,ue),fe.length&&Ne(fe,_,M,ue)}else Ce.length&&Ne(Ce,_,M),fe.length&&Ne(fe,_,M);C&&(me.updateRenderTargetMipmap(C),me.updateMultisampleRenderTarget(C)),Z.buffers.depth.setTest(!0),Z.buffers.depth.setMask(!0),Z.buffers.color.setMask(!0),Z.setPolygonOffset(!1),_.onAfterRender(l,_,M),mt.enabled&&mt.submitFrame(),c=null,h=null}};function ze(_,M,C,Y){if(_.visible!==!1){var oe=_.layers.test(M.layers);if(oe){if(_.isGroup)C=_.renderOrder;else if(_.isLight)h.pushLight(_),_.castShadow&&h.pushShadow(_);else if(_.isSprite){if(!_.frustumCulled||V.intersectsSprite(_)){Y&&T.setFromMatrixPosition(_.matrixWorld).applyMatrix4(E);var Ce=Fe.update(_),fe=_.material;c.push(_,Ce,fe,C,T.z,null)}}else if(_.isImmediateRenderObject)Y&&T.setFromMatrixPosition(_.matrixWorld).applyMatrix4(E),c.push(_,null,_.material,C,T.z,null);else if((_.isMesh||_.isLine||_.isPoints)&&(_.isSkinnedMesh&&_.skeleton.update(),!_.frustumCulled||V.intersectsObject(_))){Y&&T.setFromMatrixPosition(_.matrixWorld).applyMatrix4(E);var Ce=Fe.update(_),fe=_.material;if(Array.isArray(fe))for(var ue=Ce.groups,be=0,Ve=ue.length;be<Ve;be++){var Ie=ue[be],je=fe[Ie.materialIndex];je&&je.visible&&c.push(_,Ce,je,C,T.z,Ie)}else fe.visible&&c.push(_,Ce,fe,C,T.z,null)}}for(var $e=_.children,be=0,Ve=$e.length;be<Ve;be++)ze($e[be],M,C,Y)}}function Ne(_,M,C,Y){for(var oe=0,Ce=_.length;oe<Ce;oe++){var fe=_[oe],ue=fe.object,be=fe.geometry,Ve=Y===void 0?fe.material:Y,Ie=fe.group;if(C.isArrayCamera){y=C;for(var je=C.cameras,$e=0,Se=je.length;$e<Se;$e++){var de=je[$e];if(ue.layers.test(de.layers)){if("viewport"in de)Z.viewport(S.copy(de.viewport));else{var Be=de.bounds,ut=Be.x*A,nr=Be.y*D,tt=Be.z*A,vr=Be.w*D;Z.viewport(S.set(ut,nr,tt,vr).multiplyScalar(I))}h.setupLights(de),Ct(ue,M,de,be,Ve,Ie)}}}else y=null,Ct(ue,M,C,be,Ve,Ie)}}function Ct(_,M,C,Y,oe,Ce){if(_.onBeforeRender(l,M,C,Y,oe,Ce),h=Je.get(M,y||C),_.modelViewMatrix.multiplyMatrices(C.matrixWorldInverse,_.matrixWorld),_.normalMatrix.getNormalMatrix(_.modelViewMatrix),_.isImmediateRenderObject){Z.setMaterial(oe);var fe=It(C,M.fog,oe,_);b.geometry=null,b.program=null,b.wireframe=!1,se(_,fe)}else l.renderBufferDirect(C,M.fog,Y,oe,_,Ce);_.onAfterRender(l,M,C,Y,oe,Ce),h=Je.get(M,y||C)}function He(_,M,C){var Y=ge.get(_),oe=h.state.lights,Ce=h.state.shadowsArray,fe=Y.lightsHash,ue=oe.state.hash,be=Ee.getParameters(_,oe.state,Ce,M,$.numPlanes,$.numIntersection,C),Ve=Ee.getProgramCode(_,be),Ie=Y.program,je=!0;if(Ie===void 0)_.addEventListener("dispose",Le);else if(Ie.code!==Ve)F(_);else if(fe.stateID!==ue.stateID||fe.directionalLength!==ue.directionalLength||fe.pointLength!==ue.pointLength||fe.spotLength!==ue.spotLength||fe.rectAreaLength!==ue.rectAreaLength||fe.hemiLength!==ue.hemiLength||fe.shadowsLength!==ue.shadowsLength)fe.stateID=ue.stateID,fe.directionalLength=ue.directionalLength,fe.pointLength=ue.pointLength,fe.spotLength=ue.spotLength,fe.rectAreaLength=ue.rectAreaLength,fe.hemiLength=ue.hemiLength,fe.shadowsLength=ue.shadowsLength,je=!1;else{if(be.shaderID!==void 0)return;je=!1}if(je){if(be.shaderID){var $e=Vt[be.shaderID];Y.shader={name:_.type,uniforms:Nr($e.uniforms),vertexShader:$e.vertexShader,fragmentShader:$e.fragmentShader}}else Y.shader={name:_.type,uniforms:_.uniforms,vertexShader:_.vertexShader,fragmentShader:_.fragmentShader};_.onBeforeCompile(Y.shader,l),Ve=Ee.getProgramCode(_,be),Ie=Ee.acquireProgram(_,Y.shader,be,Ve),Y.program=Ie,_.program=Ie}var Se=Ie.getAttributes();if(_.morphTargets){_.numSupportedMorphTargets=0;for(var de=0;de<l.maxMorphTargets;de++)Se["morphTarget"+de]>=0&&_.numSupportedMorphTargets++}if(_.morphNormals){_.numSupportedMorphNormals=0;for(var de=0;de<l.maxMorphNormals;de++)Se["morphNormal"+de]>=0&&_.numSupportedMorphNormals++}var Be=Y.shader.uniforms;(!_.isShaderMaterial&&!_.isRawShaderMaterial||_.clipping===!0)&&(Y.numClippingPlanes=$.numPlanes,Y.numIntersection=$.numIntersection,Be.clippingPlanes=$.uniform),Y.fog=M,fe===void 0&&(Y.lightsHash=fe={}),fe.stateID=ue.stateID,fe.directionalLength=ue.directionalLength,fe.pointLength=ue.pointLength,fe.spotLength=ue.spotLength,fe.rectAreaLength=ue.rectAreaLength,fe.hemiLength=ue.hemiLength,fe.shadowsLength=ue.shadowsLength,_.lights&&(Be.ambientLightColor.value=oe.state.ambient,Be.directionalLights.value=oe.state.directional,Be.spotLights.value=oe.state.spot,Be.rectAreaLights.value=oe.state.rectArea,Be.pointLights.value=oe.state.point,Be.hemisphereLights.value=oe.state.hemi,Be.directionalShadowMap.value=oe.state.directionalShadowMap,Be.directionalShadowMatrix.value=oe.state.directionalShadowMatrix,Be.spotShadowMap.value=oe.state.spotShadowMap,Be.spotShadowMatrix.value=oe.state.spotShadowMatrix,Be.pointShadowMap.value=oe.state.pointShadowMap,Be.pointShadowMatrix.value=oe.state.pointShadowMatrix);var ut=Y.program.getUniforms(),nr=fr.seqWithValue(ut.seq,Be);Y.uniformsList=nr}function It(_,M,C,Y){P=0;var oe=ge.get(C),Ce=h.state.lights,fe=oe.lightsHash,ue=Ce.state.hash;if(K&&(Q||_!==w)){var be=_===w&&C.id===g;$.setState(C.clippingPlanes,C.clipIntersection,C.clipShadows,_,oe,be)}C.needsUpdate===!1&&(oe.program===void 0||C.fog&&oe.fog!==M||C.lights&&(fe.stateID!==ue.stateID||fe.directionalLength!==ue.directionalLength||fe.pointLength!==ue.pointLength||fe.spotLength!==ue.spotLength||fe.rectAreaLength!==ue.rectAreaLength||fe.hemiLength!==ue.hemiLength||fe.shadowsLength!==ue.shadowsLength)||oe.numClippingPlanes!==void 0&&(oe.numClippingPlanes!==$.numPlanes||oe.numIntersection!==$.numIntersection))&&(C.needsUpdate=!0),C.needsUpdate&&(He(C,M,Y),C.needsUpdate=!1);var Ve=!1,Ie=!1,je=!1,$e=oe.program,Se=$e.getUniforms(),de=oe.shader.uniforms;if(Z.useProgram($e.program)&&(Ve=!0,Ie=!0,je=!0),C.id!==g&&(g=C.id,Ie=!0),Ve||w!==_){if(Se.setValue(L,"projectionMatrix",_.projectionMatrix),q.logarithmicDepthBuffer&&Se.setValue(L,"logDepthBufFC",2/(Math.log(_.far+1)/Math.LN2)),w!==_&&(w=_,Ie=!0,je=!0),C.isShaderMaterial||C.isMeshPhongMaterial||C.isMeshStandardMaterial||C.envMap){var Be=Se.map.cameraPosition;Be!==void 0&&Be.setValue(L,T.setFromMatrixPosition(_.matrixWorld))}(C.isMeshPhongMaterial||C.isMeshLambertMaterial||C.isMeshBasicMaterial||C.isMeshStandardMaterial||C.isShaderMaterial||C.skinning)&&Se.setValue(L,"viewMatrix",_.matrixWorldInverse)}if(C.skinning){Se.setOptional(L,Y,"bindMatrix"),Se.setOptional(L,Y,"bindMatrixInverse");var ut=Y.skeleton;if(ut){var nr=ut.bones;if(q.floatVertexTextures){if(ut.boneTexture===void 0){var tt=Math.sqrt(nr.length*4);tt=ie.ceilPowerOfTwo(tt),tt=Math.max(tt,4);var vr=new Float32Array(tt*tt*4);vr.set(ut.boneMatrices);var Lo=new br(vr,tt,tt,wt,Fr);Lo.needsUpdate=!0,ut.boneMatrices=vr,ut.boneTexture=Lo,ut.boneTextureSize=tt}Se.setValue(L,"boneTexture",ut.boneTexture),Se.setValue(L,"boneTextureSize",ut.boneTextureSize)}else Se.setOptional(L,ut,"boneMatrices")}}return Ie&&(Se.setValue(L,"toneMappingExposure",l.toneMappingExposure),Se.setValue(L,"toneMappingWhitePoint",l.toneMappingWhitePoint),C.lights&&tl(de,je),M&&C.fog&&So(de,M),C.isMeshBasicMaterial?rt(de,C):C.isMeshLambertMaterial?(rt(de,C),Ao(de,C)):C.isMeshPhongMaterial?(rt(de,C),C.isMeshToonMaterial?Zh(de,C):$r(de,C)):C.isMeshStandardMaterial?(rt(de,C),C.isMeshPhysicalMaterial?Jh(de,C):hs(de,C)):C.isMeshMatcapMaterial?(rt(de,C),Qh(de,C)):C.isMeshDepthMaterial?(rt(de,C),Kh(de,C)):C.isMeshDistanceMaterial?(rt(de,C),$h(de,C)):C.isMeshNormalMaterial?(rt(de,C),el(de,C)):C.isLineBasicMaterial?(Eo(de,C),C.isLineDashedMaterial&&To(de,C)):C.isPointsMaterial?ba(de,C):C.isSpriteMaterial?wa(de,C):C.isShadowMaterial&&(de.color.value=C.color,de.opacity.value=C.opacity),de.ltc_1!==void 0&&(de.ltc_1.value=ae.LTC_1),de.ltc_2!==void 0&&(de.ltc_2.value=ae.LTC_2),fr.upload(L,oe.uniformsList,de,l)),C.isShaderMaterial&&C.uniformsNeedUpdate===!0&&(fr.upload(L,oe.uniformsList,de,l),C.uniformsNeedUpdate=!1),C.isSpriteMaterial&&Se.setValue(L,"center",Y.center),Se.setValue(L,"modelViewMatrix",Y.modelViewMatrix),Se.setValue(L,"normalMatrix",Y.normalMatrix),Se.setValue(L,"modelMatrix",Y.matrixWorld),$e}function rt(_,M){_.opacity.value=M.opacity,M.color&&(_.diffuse.value=M.color),M.emissive&&_.emissive.value.copy(M.emissive).multiplyScalar(M.emissiveIntensity),M.map&&(_.map.value=M.map),M.alphaMap&&(_.alphaMap.value=M.alphaMap),M.specularMap&&(_.specularMap.value=M.specularMap),M.envMap&&(_.envMap.value=M.envMap,_.flipEnvMap.value=M.envMap.isCubeTexture?-1:1,_.reflectivity.value=M.reflectivity,_.refractionRatio.value=M.refractionRatio,_.maxMipLevel.value=ge.get(M.envMap).__maxMipLevel),M.lightMap&&(_.lightMap.value=M.lightMap,_.lightMapIntensity.value=M.lightMapIntensity),M.aoMap&&(_.aoMap.value=M.aoMap,_.aoMapIntensity.value=M.aoMapIntensity);var C;M.map?C=M.map:M.specularMap?C=M.specularMap:M.displacementMap?C=M.displacementMap:M.normalMap?C=M.normalMap:M.bumpMap?C=M.bumpMap:M.roughnessMap?C=M.roughnessMap:M.metalnessMap?C=M.metalnessMap:M.alphaMap?C=M.alphaMap:M.emissiveMap&&(C=M.emissiveMap),C!==void 0&&(C.isWebGLRenderTarget&&(C=C.texture),C.matrixAutoUpdate===!0&&C.updateMatrix(),_.uvTransform.value.copy(C.matrix))}function Eo(_,M){_.diffuse.value=M.color,_.opacity.value=M.opacity}function To(_,M){_.dashSize.value=M.dashSize,_.totalSize.value=M.dashSize+M.gapSize,_.scale.value=M.scale}function ba(_,M){_.diffuse.value=M.color,_.opacity.value=M.opacity,_.size.value=M.size*I,_.scale.value=D*.5,_.map.value=M.map,M.map!==null&&(M.map.matrixAutoUpdate===!0&&M.map.updateMatrix(),_.uvTransform.value.copy(M.map.matrix))}function wa(_,M){_.diffuse.value=M.color,_.opacity.value=M.opacity,_.rotation.value=M.rotation,_.map.value=M.map,M.map!==null&&(M.map.matrixAutoUpdate===!0&&M.map.updateMatrix(),_.uvTransform.value.copy(M.map.matrix))}function So(_,M){_.fogColor.value=M.color,M.isFog?(_.fogNear.value=M.near,_.fogFar.value=M.far):M.isFogExp2&&(_.fogDensity.value=M.density)}function Ao(_,M){M.emissiveMap&&(_.emissiveMap.value=M.emissiveMap)}function $r(_,M){_.specular.value=M.specular,_.shininess.value=Math.max(M.shininess,1e-4),M.emissiveMap&&(_.emissiveMap.value=M.emissiveMap),M.bumpMap&&(_.bumpMap.value=M.bumpMap,_.bumpScale.value=M.bumpScale,M.side===Ze&&(_.bumpScale.value*=-1)),M.normalMap&&(_.normalMap.value=M.normalMap,_.normalScale.value.copy(M.normalScale),M.side===Ze&&_.normalScale.value.negate()),M.displacementMap&&(_.displacementMap.value=M.displacementMap,_.displacementScale.value=M.displacementScale,_.displacementBias.value=M.displacementBias)}function Zh(_,M){$r(_,M),M.gradientMap&&(_.gradientMap.value=M.gradientMap)}function hs(_,M){_.roughness.value=M.roughness,_.metalness.value=M.metalness,M.roughnessMap&&(_.roughnessMap.value=M.roughnessMap),M.metalnessMap&&(_.metalnessMap.value=M.metalnessMap),M.emissiveMap&&(_.emissiveMap.value=M.emissiveMap),M.bumpMap&&(_.bumpMap.value=M.bumpMap,_.bumpScale.value=M.bumpScale,M.side===Ze&&(_.bumpScale.value*=-1)),M.normalMap&&(_.normalMap.value=M.normalMap,_.normalScale.value.copy(M.normalScale),M.side===Ze&&_.normalScale.value.negate()),M.displacementMap&&(_.displacementMap.value=M.displacementMap,_.displacementScale.value=M.displacementScale,_.displacementBias.value=M.displacementBias),M.envMap&&(_.envMapIntensity.value=M.envMapIntensity)}function Jh(_,M){hs(_,M),_.reflectivity.value=M.reflectivity,_.clearCoat.value=M.clearCoat,_.clearCoatRoughness.value=M.clearCoatRoughness}function Qh(_,M){M.matcap&&(_.matcap.value=M.matcap),M.bumpMap&&(_.bumpMap.value=M.bumpMap,_.bumpScale.value=M.bumpScale,M.side===Ze&&(_.bumpScale.value*=-1)),M.normalMap&&(_.normalMap.value=M.normalMap,_.normalScale.value.copy(M.normalScale),M.side===Ze&&_.normalScale.value.negate()),M.displacementMap&&(_.displacementMap.value=M.displacementMap,_.displacementScale.value=M.displacementScale,_.displacementBias.value=M.displacementBias)}function Kh(_,M){M.displacementMap&&(_.displacementMap.value=M.displacementMap,_.displacementScale.value=M.displacementScale,_.displacementBias.value=M.displacementBias)}function $h(_,M){M.displacementMap&&(_.displacementMap.value=M.displacementMap,_.displacementScale.value=M.displacementScale,_.displacementBias.value=M.displacementBias),_.referencePosition.value.copy(M.referencePosition),_.nearDistance.value=M.nearDistance,_.farDistance.value=M.farDistance}function el(_,M){M.bumpMap&&(_.bumpMap.value=M.bumpMap,_.bumpScale.value=M.bumpScale,M.side===Ze&&(_.bumpScale.value*=-1)),M.normalMap&&(_.normalMap.value=M.normalMap,_.normalScale.value.copy(M.normalScale),M.side===Ze&&_.normalScale.value.negate()),M.displacementMap&&(_.displacementMap.value=M.displacementMap,_.displacementScale.value=M.displacementScale,_.displacementBias.value=M.displacementBias)}function tl(_,M){_.ambientLightColor.needsUpdate=M,_.directionalLights.needsUpdate=M,_.pointLights.needsUpdate=M,_.spotLights.needsUpdate=M,_.rectAreaLights.needsUpdate=M,_.hemisphereLights.needsUpdate=M}function rl(){var _=P;return _>=q.maxTextures&&console.warn("THREE.WebGLRenderer: Trying to use "+_+" texture units while this GPU supports only "+q.maxTextures),P+=1,_}this.allocTextureUnit=rl,this.setTexture2D=function(){var _=!1;return function(C,Y){C&&C.isWebGLRenderTarget&&(_||(console.warn("THREE.WebGLRenderer.setTexture2D: don't use render targets as textures. Use their .texture property instead."),_=!0),C=C.texture),me.setTexture2D(C,Y)}}(),this.setTexture3D=function(){return function(M,C){me.setTexture3D(M,C)}}(),this.setTexture=function(){var _=!1;return function(C,Y){_||(console.warn("THREE.WebGLRenderer: .setTexture is deprecated, use setTexture2D instead."),_=!0),me.setTexture2D(C,Y)}}(),this.setTextureCube=function(){var _=!1;return function(C,Y){C&&C.isWebGLRenderTargetCube&&(_||(console.warn("THREE.WebGLRenderer.setTextureCube: don't use cube render targets as textures. Use their .texture property instead."),_=!0),C=C.texture),C&&C.isCubeTexture||Array.isArray(C.image)&&C.image.length===6?me.setTextureCube(C,Y):me.setTextureCubeDynamic(C,Y)}}(),this.setFramebuffer=function(_){d=_},this.getRenderTarget=function(){return m},this.setRenderTarget=function(_){m=_,_&&ge.get(_).__webglFramebuffer===void 0&&me.setupRenderTarget(_);var M=d,C=!1;if(_){var Y=ge.get(_).__webglFramebuffer;_.isWebGLRenderTargetCube?(M=Y[_.activeCubeFace],C=!0):_.isWebGLMultisampleRenderTarget?M=ge.get(_).__webglMultisampledFramebuffer:M=Y,S.copy(_.viewport),R.copy(_.scissor),B=_.scissorTest}else S.copy(H).multiplyScalar(I),R.copy(X).multiplyScalar(I),B=j;if(v!==M&&(L.bindFramebuffer(L.FRAMEBUFFER,M),v=M),Z.viewport(S),Z.scissor(R),Z.setScissorTest(B),C){var oe=ge.get(_.texture);L.framebufferTexture2D(L.FRAMEBUFFER,L.COLOR_ATTACHMENT0,L.TEXTURE_CUBE_MAP_POSITIVE_X+_.activeCubeFace,oe.__webglTexture,_.activeMipMapLevel)}},this.readRenderTargetPixels=function(_,M,C,Y,oe,Ce){if(!(_&&_.isWebGLRenderTarget)){console.error("THREE.WebGLRenderer.readRenderTargetPixels: renderTarget is not THREE.WebGLRenderTarget.");return}var fe=ge.get(_).__webglFramebuffer;if(fe){var ue=!1;fe!==v&&(L.bindFramebuffer(L.FRAMEBUFFER,fe),ue=!0);try{var be=_.texture,Ve=be.format,Ie=be.type;if(Ve!==wt&&et.convert(Ve)!==L.getParameter(L.IMPLEMENTATION_COLOR_READ_FORMAT)){console.error("THREE.WebGLRenderer.readRenderTargetPixels: renderTarget is not in RGBA or implementation defined format.");return}if(Ie!==Br&&et.convert(Ie)!==L.getParameter(L.IMPLEMENTATION_COLOR_READ_TYPE)&&!(Ie===Fr&&(q.isWebGL2||N.get("OES_texture_float")||N.get("WEBGL_color_buffer_float")))&&!(Ie===Fi&&(q.isWebGL2?N.get("EXT_color_buffer_float"):N.get("EXT_color_buffer_half_float")))){console.error("THREE.WebGLRenderer.readRenderTargetPixels: renderTarget is not in UnsignedByteType or implementation defined type.");return}L.checkFramebufferStatus(L.FRAMEBUFFER)===L.FRAMEBUFFER_COMPLETE?M>=0&&M<=_.width-Y&&C>=0&&C<=_.height-oe&&L.readPixels(M,C,Y,oe,et.convert(Ve),et.convert(Ie),Ce):console.error("THREE.WebGLRenderer.readRenderTargetPixels: readPixels from renderTarget failed. Framebuffer not complete.")}finally{ue&&L.bindFramebuffer(L.FRAMEBUFFER,v)}}},this.copyFramebufferToTexture=function(_,M,C){var Y=M.image.width,oe=M.image.height,Ce=et.convert(M.format);this.setTexture2D(M,0),L.copyTexImage2D(L.TEXTURE_2D,C||0,Ce,_.x,_.y,Y,oe,0)},this.copyTextureToTexture=function(_,M,C,Y){var oe=M.image.width,Ce=M.image.height,fe=et.convert(C.format),ue=et.convert(C.type);this.setTexture2D(C,0),M.isDataTexture?L.texSubImage2D(L.TEXTURE_2D,Y||0,_.x,_.y,oe,Ce,fe,ue,M.image.data):L.texSubImage2D(L.TEXTURE_2D,Y||0,_.x,_.y,fe,ue,M.image)}}function si(e,t){this.name="",this.color=new J(e),this.density=t!==void 0?t:25e-5}si.prototype.isFogExp2=!0;si.prototype.clone=function(){return new si(this.color,this.density)};si.prototype.toJSON=function(){return{type:"FogExp2",color:this.color.getHex(),density:this.density}};function fi(e,t,r){this.name="",this.color=new J(e),this.near=t!==void 0?t:1,this.far=r!==void 0?r:1e3}fi.prototype.isFog=!0;fi.prototype.clone=function(){return new fi(this.color,this.near,this.far)};fi.prototype.toJSON=function(){return{type:"Fog",color:this.color.getHex(),near:this.near,far:this.far}};function Wr(){k.call(this),this.type="Scene",this.background=null,this.fog=null,this.overrideMaterial=null,this.autoUpdate=!0}Wr.prototype=Object.assign(Object.create(k.prototype),{constructor:Wr,copy:function(e,t){return k.prototype.copy.call(this,e,t),e.background!==null&&(this.background=e.background.clone()),e.fog!==null&&(this.fog=e.fog.clone()),e.overrideMaterial!==null&&(this.overrideMaterial=e.overrideMaterial.clone()),this.autoUpdate=e.autoUpdate,this.matrixAutoUpdate=e.matrixAutoUpdate,this},toJSON:function(e){var t=k.prototype.toJSON.call(this,e);return this.background!==null&&(t.object.background=this.background.toJSON(e)),this.fog!==null&&(t.object.fog=this.fog.toJSON()),t},dispose:function(){this.dispatchEvent({type:"dispose"})}});function Tr(e,t){this.array=e,this.stride=t,this.count=e!==void 0?e.length/t:0,this.dynamic=!1,this.updateRange={offset:0,count:-1},this.version=0}Object.defineProperty(Tr.prototype,"needsUpdate",{set:function(e){e===!0&&this.version++}});Object.assign(Tr.prototype,{isInterleavedBuffer:!0,onUploadCallback:function(){},setArray:function(e){if(Array.isArray(e))throw new TypeError("THREE.BufferAttribute: array should be a Typed Array.");return this.count=e!==void 0?e.length/this.stride:0,this.array=e,this},setDynamic:function(e){return this.dynamic=e,this},copy:function(e){return this.array=new e.array.constructor(e.array),this.count=e.count,this.stride=e.stride,this.dynamic=e.dynamic,this},copyAt:function(e,t,r){e*=this.stride,r*=t.stride;for(var i=0,n=this.stride;i<n;i++)this.array[e+i]=t.array[r+i];return this},set:function(e,t){return t===void 0&&(t=0),this.array.set(e,t),this},clone:function(){return new this.constructor().copy(this)},onUpload:function(e){return this.onUploadCallback=e,this}});function Vi(e,t,r,i){this.data=e,this.itemSize=t,this.offset=r,this.normalized=i===!0}Object.defineProperties(Vi.prototype,{count:{get:function(){return this.data.count}},array:{get:function(){return this.data.array}}});Object.assign(Vi.prototype,{isInterleavedBufferAttribute:!0,setX:function(e,t){return this.data.array[e*this.data.stride+this.offset]=t,this},setY:function(e,t){return this.data.array[e*this.data.stride+this.offset+1]=t,this},setZ:function(e,t){return this.data.array[e*this.data.stride+this.offset+2]=t,this},setW:function(e,t){return this.data.array[e*this.data.stride+this.offset+3]=t,this},getX:function(e){return this.data.array[e*this.data.stride+this.offset]},getY:function(e){return this.data.array[e*this.data.stride+this.offset+1]},getZ:function(e){return this.data.array[e*this.data.stride+this.offset+2]},getW:function(e){return this.data.array[e*this.data.stride+this.offset+3]},setXY:function(e,t,r){return e=e*this.data.stride+this.offset,this.data.array[e+0]=t,this.data.array[e+1]=r,this},setXYZ:function(e,t,r,i){return e=e*this.data.stride+this.offset,this.data.array[e+0]=t,this.data.array[e+1]=r,this.data.array[e+2]=i,this},setXYZW:function(e,t,r,i,n){return e=e*this.data.stride+this.offset,this.data.array[e+0]=t,this.data.array[e+1]=r,this.data.array[e+2]=i,this.data.array[e+3]=n,this}});function Sr(e){he.call(this),this.type="SpriteMaterial",this.color=new J(16777215),this.map=null,this.rotation=0,this.sizeAttenuation=!0,this.lights=!1,this.transparent=!0,this.setValues(e)}Sr.prototype=Object.create(he.prototype);Sr.prototype.constructor=Sr;Sr.prototype.isSpriteMaterial=!0;Sr.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.color.copy(e.color),this.map=e.map,this.rotation=e.rotation,this.sizeAttenuation=e.sizeAttenuation,this};var ki;function Wi(e){if(k.call(this),this.type="Sprite",ki===void 0){ki=new z;var t=new Float32Array([-.5,-.5,0,0,0,.5,-.5,0,1,0,.5,.5,0,1,1,-.5,.5,0,0,1]),r=new Tr(t,5);ki.setIndex([0,1,2,0,2,3]),ki.addAttribute("position",new Vi(r,3,0,!1)),ki.addAttribute("uv",new Vi(r,2,3,!1))}this.geometry=ki,this.material=e!==void 0?e:new Sr,this.center=new O(.5,.5)}Wi.prototype=Object.assign(Object.create(k.prototype),{constructor:Wi,isSprite:!0,raycast:function(){var e=new x,t=new x,r=new x,i=new O,n=new O,o=new ee,a=new x,s=new x,f=new x,u=new O,c=new O,h=new O;function l(p,d,m,v,g,b){i.subVectors(p,m).addScalar(.5).multiply(v),g!==void 0?(n.x=b*i.x-g*i.y,n.y=g*i.x+b*i.y):n.copy(i),p.copy(d),p.x+=n.x,p.y+=n.y,p.applyMatrix4(o)}return function(d,m){t.setFromMatrixScale(this.matrixWorld),o.getInverse(this.modelViewMatrix).premultiply(this.matrixWorld),r.setFromMatrixPosition(this.modelViewMatrix);var v=this.material.rotation,g,b;v!==0&&(b=Math.cos(v),g=Math.sin(v));var w=this.center;l(a.set(-.5,-.5,0),r,w,t,g,b),l(s.set(.5,-.5,0),r,w,t,g,b),l(f.set(.5,.5,0),r,w,t,g,b),u.set(0,0),c.set(1,0),h.set(1,1);var y=d.ray.intersectTriangle(a,s,f,!1,e);if(!(y===null&&(l(s.set(-.5,.5,0),r,w,t,g,b),c.set(0,1),y=d.ray.intersectTriangle(a,f,s,!1,e),y===null))){var S=d.ray.origin.distanceTo(e);S<d.near||S>d.far||m.push({distance:S,point:e.clone(),uv:nt.getUV(e,a,s,f,u,c,h,new O),face:null,object:this})}}}(),clone:function(){return new this.constructor(this.material).copy(this)},copy:function(e){return k.prototype.copy.call(this,e),e.center!==void 0&&this.center.copy(e.center),this}});function ui(){k.call(this),this.type="LOD",Object.defineProperties(this,{levels:{enumerable:!0,value:[]}})}ui.prototype=Object.assign(Object.create(k.prototype),{constructor:ui,copy:function(e){k.prototype.copy.call(this,e,!1);for(var t=e.levels,r=0,i=t.length;r<i;r++){var n=t[r];this.addLevel(n.object.clone(),n.distance)}return this},addLevel:function(e,t){t===void 0&&(t=0),t=Math.abs(t);for(var r=this.levels,i=0;i<r.length&&!(t<r[i].distance);i++);r.splice(i,0,{distance:t,object:e}),this.add(e)},getObjectForDistance:function(e){for(var t=this.levels,r=1,i=t.length;r<i&&!(e<t[r].distance);r++);return t[r-1].object},raycast:function(){var e=new x;return function(r,i){e.setFromMatrixPosition(this.matrixWorld);var n=r.ray.origin.distanceTo(e);this.getObjectForDistance(n).raycast(r,i)}}(),update:function(){var e=new x,t=new x;return function(i){var n=this.levels;if(n.length>1){e.setFromMatrixPosition(i.matrixWorld),t.setFromMatrixPosition(this.matrixWorld);var o=e.distanceTo(t);n[0].object.visible=!0;for(var a=1,s=n.length;a<s&&o>=n[a].distance;a++)n[a-1].object.visible=!1,n[a].object.visible=!0;for(;a<s;a++)n[a].object.visible=!1}}}(),toJSON:function(e){var t=k.prototype.toJSON.call(this,e);t.object.levels=[];for(var r=this.levels,i=0,n=r.length;i<n;i++){var o=r[i];t.object.levels.push({object:o.object.uuid,distance:o.distance})}return t}});function ci(e,t){e&&e.isGeometry&&console.error("THREE.SkinnedMesh no longer supports THREE.Geometry. Use THREE.BufferGeometry instead."),Xe.call(this,e,t),this.type="SkinnedMesh",this.bindMode="attached",this.bindMatrix=new ee,this.bindMatrixInverse=new ee}ci.prototype=Object.assign(Object.create(Xe.prototype),{constructor:ci,isSkinnedMesh:!0,bind:function(e,t){this.skeleton=e,t===void 0&&(this.updateMatrixWorld(!0),this.skeleton.calculateInverses(),t=this.matrixWorld),this.bindMatrix.copy(t),this.bindMatrixInverse.getInverse(t)},pose:function(){this.skeleton.pose()},normalizeSkinWeights:function(){for(var e=new we,t=this.geometry.attributes.skinWeight,r=0,i=t.count;r<i;r++){e.x=t.getX(r),e.y=t.getY(r),e.z=t.getZ(r),e.w=t.getW(r);var n=1/e.manhattanLength();n!==1/0?e.multiplyScalar(n):e.set(1,0,0,0),t.setXYZW(r,e.x,e.y,e.z,e.w)}},updateMatrixWorld:function(e){Xe.prototype.updateMatrixWorld.call(this,e),this.bindMode==="attached"?this.bindMatrixInverse.getInverse(this.matrixWorld):this.bindMode==="detached"?this.bindMatrixInverse.getInverse(this.bindMatrix):console.warn("THREE.SkinnedMesh: Unrecognized bindMode: "+this.bindMode)},clone:function(){return new this.constructor(this.geometry,this.material).copy(this)}});function Ln(e,t){if(e=e||[],this.bones=e.slice(0),this.boneMatrices=new Float32Array(this.bones.length*16),t===void 0)this.calculateInverses();else if(this.bones.length===t.length)this.boneInverses=t.slice(0);else{console.warn("THREE.Skeleton boneInverses is the wrong length."),this.boneInverses=[];for(var r=0,i=this.bones.length;r<i;r++)this.boneInverses.push(new ee)}}Object.assign(Ln.prototype,{calculateInverses:function(){this.boneInverses=[];for(var e=0,t=this.bones.length;e<t;e++){var r=new ee;this.bones[e]&&r.getInverse(this.bones[e].matrixWorld),this.boneInverses.push(r)}},pose:function(){var e,t,r;for(t=0,r=this.bones.length;t<r;t++)e=this.bones[t],e&&e.matrixWorld.getInverse(this.boneInverses[t]);for(t=0,r=this.bones.length;t<r;t++)e=this.bones[t],e&&(e.parent&&e.parent.isBone?(e.matrix.getInverse(e.parent.matrixWorld),e.matrix.multiply(e.matrixWorld)):e.matrix.copy(e.matrixWorld),e.matrix.decompose(e.position,e.quaternion,e.scale))},update:function(){var e=new ee,t=new ee;return function(){for(var i=this.bones,n=this.boneInverses,o=this.boneMatrices,a=this.boneTexture,s=0,f=i.length;s<f;s++){var u=i[s]?i[s].matrixWorld:t;e.multiplyMatrices(u,n[s]),e.toArray(o,s*16)}a!==void 0&&(a.needsUpdate=!0)}}(),clone:function(){return new Ln(this.bones,this.boneInverses)},getBoneByName:function(e){for(var t=0,r=this.bones.length;t<r;t++){var i=this.bones[t];if(i.name===e)return i}}});function Va(){k.call(this),this.type="Bone"}Va.prototype=Object.assign(Object.create(k.prototype),{constructor:Va,isBone:!0});function xe(e){he.call(this),this.type="LineBasicMaterial",this.color=new J(16777215),this.linewidth=1,this.linecap="round",this.linejoin="round",this.lights=!1,this.setValues(e)}xe.prototype=Object.create(he.prototype);xe.prototype.constructor=xe;xe.prototype.isLineBasicMaterial=!0;xe.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.color.copy(e.color),this.linewidth=e.linewidth,this.linecap=e.linecap,this.linejoin=e.linejoin,this};function Ke(e,t,r){r===1&&console.error("THREE.Line: parameter THREE.LinePieces no longer supported. Use THREE.LineSegments instead."),k.call(this),this.type="Line",this.geometry=e!==void 0?e:new z,this.material=t!==void 0?t:new xe({color:Math.random()*16777215})}Ke.prototype=Object.assign(Object.create(k.prototype),{constructor:Ke,isLine:!0,computeLineDistances:function(){var e=new x,t=new x;return function(){var i=this.geometry;if(i.isBufferGeometry)if(i.index===null){for(var n=i.attributes.position,o=[0],a=1,s=n.count;a<s;a++)e.fromBufferAttribute(n,a-1),t.fromBufferAttribute(n,a),o[a]=o[a-1],o[a]+=e.distanceTo(t);i.addAttribute("lineDistance",new G(o,1))}else console.warn("THREE.Line.computeLineDistances(): Computation only possible with non-indexed BufferGeometry.");else if(i.isGeometry){var f=i.vertices,o=i.lineDistances;o[0]=0;for(var a=1,s=f.length;a<s;a++)o[a]=o[a-1],o[a]+=f[a-1].distanceTo(f[a])}return this}}(),raycast:function(){var e=new ee,t=new kt,r=new it;return function(n,o){var a=n.linePrecision,s=this.geometry,f=this.matrixWorld;if(s.boundingSphere===null&&s.computeBoundingSphere(),r.copy(s.boundingSphere),r.applyMatrix4(f),r.radius+=a,n.ray.intersectsSphere(r)!==!1){e.getInverse(f),t.copy(n.ray).applyMatrix4(e);var u=a/((this.scale.x+this.scale.y+this.scale.z)/3),c=u*u,h=new x,l=new x,p=new x,d=new x,m=this&&this.isLineSegments?2:1;if(s.isBufferGeometry){var v=s.index,g=s.attributes,b=g.position.array;if(v!==null)for(var w=v.array,y=0,S=w.length-1;y<S;y+=m){var R=w[y],B=w[y+1];h.fromArray(b,R*3),l.fromArray(b,B*3);var P=t.distanceSqToSegment(h,l,d,p);if(!(P>c)){d.applyMatrix4(this.matrixWorld);var A=n.ray.origin.distanceTo(d);A<n.near||A>n.far||o.push({distance:A,point:p.clone().applyMatrix4(this.matrixWorld),index:y,face:null,faceIndex:null,object:this})}}else for(var y=0,S=b.length/3-1;y<S;y+=m){h.fromArray(b,3*y),l.fromArray(b,3*y+3);var P=t.distanceSqToSegment(h,l,d,p);if(!(P>c)){d.applyMatrix4(this.matrixWorld);var A=n.ray.origin.distanceTo(d);A<n.near||A>n.far||o.push({distance:A,point:p.clone().applyMatrix4(this.matrixWorld),index:y,face:null,faceIndex:null,object:this})}}}else if(s.isGeometry)for(var D=s.vertices,I=D.length,y=0;y<I-1;y+=m){var P=t.distanceSqToSegment(D[y],D[y+1],d,p);if(!(P>c)){d.applyMatrix4(this.matrixWorld);var A=n.ray.origin.distanceTo(d);A<n.near||A>n.far||o.push({distance:A,point:p.clone().applyMatrix4(this.matrixWorld),index:y,face:null,faceIndex:null,object:this})}}}}}(),copy:function(e){return k.prototype.copy.call(this,e),this.geometry.copy(e.geometry),this.material.copy(e.material),this},clone:function(){return new this.constructor().copy(this)}});function Ae(e,t){Ke.call(this,e,t),this.type="LineSegments"}Ae.prototype=Object.assign(Object.create(Ke.prototype),{constructor:Ae,isLineSegments:!0,computeLineDistances:function(){var e=new x,t=new x;return function(){var i=this.geometry;if(i.isBufferGeometry)if(i.index===null){for(var n=i.attributes.position,o=[],a=0,s=n.count;a<s;a+=2)e.fromBufferAttribute(n,a),t.fromBufferAttribute(n,a+1),o[a]=a===0?0:o[a-1],o[a+1]=o[a]+e.distanceTo(t);i.addAttribute("lineDistance",new G(o,1))}else console.warn("THREE.LineSegments.computeLineDistances(): Computation only possible with non-indexed BufferGeometry.");else if(i.isGeometry)for(var f=i.vertices,o=i.lineDistances,a=0,s=f.length;a<s;a+=2)e.copy(f[a]),t.copy(f[a+1]),o[a]=a===0?0:o[a-1],o[a+1]=o[a]+e.distanceTo(t);return this}}()});function Rn(e,t){Ke.call(this,e,t),this.type="LineLoop"}Rn.prototype=Object.assign(Object.create(Ke.prototype),{constructor:Rn,isLineLoop:!0});function ur(e){he.call(this),this.type="PointsMaterial",this.color=new J(16777215),this.map=null,this.size=1,this.sizeAttenuation=!0,this.morphTargets=!1,this.lights=!1,this.setValues(e)}ur.prototype=Object.create(he.prototype);ur.prototype.constructor=ur;ur.prototype.isPointsMaterial=!0;ur.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.color.copy(e.color),this.map=e.map,this.size=e.size,this.sizeAttenuation=e.sizeAttenuation,this.morphTargets=e.morphTargets,this};function Xi(e,t){k.call(this),this.type="Points",this.geometry=e!==void 0?e:new z,this.material=t!==void 0?t:new ur({color:Math.random()*16777215})}Xi.prototype=Object.assign(Object.create(k.prototype),{constructor:Xi,isPoints:!0,raycast:function(){var e=new ee,t=new kt,r=new it;return function(n,o){var a=this,s=this.geometry,f=this.matrixWorld,u=n.params.Points.threshold;if(s.boundingSphere===null&&s.computeBoundingSphere(),r.copy(s.boundingSphere),r.applyMatrix4(f),r.radius+=u,n.ray.intersectsSphere(r)===!1)return;e.getInverse(f),t.copy(n.ray).applyMatrix4(e);var c=u/((this.scale.x+this.scale.y+this.scale.z)/3),h=c*c,l=new x,p=new x;function d(P,A){var D=t.distanceSqToPoint(P);if(D<h){t.closestPointToPoint(P,p),p.applyMatrix4(f);var I=n.ray.origin.distanceTo(p);if(I<n.near||I>n.far)return;o.push({distance:I,distanceToRay:Math.sqrt(D),point:p.clone(),index:A,face:null,object:a})}}if(s.isBufferGeometry){var m=s.index,v=s.attributes,g=v.position.array;if(m!==null)for(var b=m.array,w=0,y=b.length;w<y;w++){var S=b[w];l.fromArray(g,S*3),d(l,S)}else for(var w=0,R=g.length/3;w<R;w++)l.fromArray(g,w*3),d(l,w)}else for(var B=s.vertices,w=0,R=B.length;w<R;w++)d(B[w],w)}}(),clone:function(){return new this.constructor(this.geometry,this.material).copy(this)}});function ka(e,t,r,i,n,o,a,s,f){_e.call(this,e,t,r,i,n,o,a,s,f),this.format=a!==void 0?a:Ot,this.minFilter=o!==void 0?o:qe,this.magFilter=n!==void 0?n:qe,this.generateMipmaps=!1}ka.prototype=Object.assign(Object.create(_e.prototype),{constructor:ka,isVideoTexture:!0,update:function(){var e=this.image;e.readyState>=e.HAVE_CURRENT_DATA&&(this.needsUpdate=!0)}});function hi(e,t,r,i,n,o,a,s,f,u,c,h){_e.call(this,null,o,a,s,f,u,i,n,c,h),this.image={width:t,height:r},this.mipmaps=e,this.flipY=!1,this.generateMipmaps=!1}hi.prototype=Object.create(_e.prototype);hi.prototype.constructor=hi;hi.prototype.isCompressedTexture=!0;function Cn(e,t,r,i,n,o,a,s,f){_e.call(this,e,t,r,i,n,o,a,s,f),this.needsUpdate=!0}Cn.prototype=Object.create(_e.prototype);Cn.prototype.constructor=Cn;Cn.prototype.isCanvasTexture=!0;function Pn(e,t,r,i,n,o,a,s,f,u){if(u=u!==void 0?u:_r,u!==_r&&u!==Dr)throw new Error("DepthTexture format must be either THREE.DepthFormat or THREE.DepthStencilFormat");r===void 0&&u===_r&&(r=ei),r===void 0&&u===Dr&&(r=ti),_e.call(this,null,i,n,o,a,s,u,r,f),this.image={width:e,height:t},this.magFilter=a!==void 0?a:ke,this.minFilter=s!==void 0?s:ke,this.flipY=!1,this.generateMipmaps=!1}Pn.prototype=Object.create(_e.prototype);Pn.prototype.constructor=Pn;Pn.prototype.isDepthTexture=!0;function Xr(){var e=new Uint8Array(3),t=1,r=1,i=Ot;_e.call(this,null,void 0,void 0,void 0,void 0,void 0,i,void 0,void 0,void 0),this.image={data:e,width:t,height:r},this.magFilter=ke,this.minFilter=ke,this.generateMipmaps=!1,this.flipY=!1,this.unpackAlignment=1}Xr.prototype=Object.create(_e.prototype);Xr.prototype.constructor=Xr;Xr.prototype.isDataTexture=!0;Xr.prototype.isCfxTexture=!0;var Et={};Ta(Et,{BoxBufferGeometry:()=>kr,BoxGeometry:()=>Gi,CircleBufferGeometry:()=>on,CircleGeometry:()=>Qn,ConeBufferGeometry:()=>Jn,ConeGeometry:()=>Zn,CylinderBufferGeometry:()=>Kt,CylinderGeometry:()=>Jr,DodecahedronBufferGeometry:()=>Ji,DodecahedronGeometry:()=>Un,EdgesGeometry:()=>nn,ExtrudeBufferGeometry:()=>jt,ExtrudeGeometry:()=>qr,IcosahedronBufferGeometry:()=>Zi,IcosahedronGeometry:()=>On,LatheBufferGeometry:()=>rn,LatheGeometry:()=>Yn,OctahedronBufferGeometry:()=>jr,OctahedronGeometry:()=>In,ParametricBufferGeometry:()=>qi,ParametricGeometry:()=>Bn,PlaneBufferGeometry:()=>Qt,PlaneGeometry:()=>Sn,PolyhedronBufferGeometry:()=>ht,PolyhedronGeometry:()=>Fn,RingBufferGeometry:()=>tn,RingGeometry:()=>qn,ShapeBufferGeometry:()=>pi,ShapeGeometry:()=>Zr,SphereBufferGeometry:()=>Yr,SphereGeometry:()=>jn,TetrahedronBufferGeometry:()=>Yi,TetrahedronGeometry:()=>Dn,TextBufferGeometry:()=>en,TextGeometry:()=>Xn,TorusBufferGeometry:()=>$i,TorusGeometry:()=>zn,TorusKnotBufferGeometry:()=>Ki,TorusKnotGeometry:()=>Gn,TubeBufferGeometry:()=>Qi,TubeGeometry:()=>Nn,WireframeGeometry:()=>ji});function ji(e){z.call(this),this.type="WireframeGeometry";var t=[],r,i,n,o,a,s=[0,0],f={},u,c,h,l,p=["a","b","c"],d;if(e&&e.isGeometry){var m=e.faces;for(r=0,n=m.length;r<n;r++){var v=m[r];for(i=0;i<3;i++)c=v[p[i]],h=v[p[(i+1)%3]],s[0]=Math.min(c,h),s[1]=Math.max(c,h),l=s[0]+","+s[1],f[l]===void 0&&(f[l]={index1:s[0],index2:s[1]})}for(l in f)u=f[l],d=e.vertices[u.index1],t.push(d.x,d.y,d.z),d=e.vertices[u.index2],t.push(d.x,d.y,d.z)}else if(e&&e.isBufferGeometry){var g,b,w,y,S,R,B,P;if(d=new x,e.index!==null){for(g=e.attributes.position,b=e.index,w=e.groups,w.length===0&&(w=[{start:0,count:b.count,materialIndex:0}]),o=0,a=w.length;o<a;++o)for(y=w[o],S=y.start,R=y.count,r=S,n=S+R;r<n;r+=3)for(i=0;i<3;i++)c=b.getX(r+i),h=b.getX(r+(i+1)%3),s[0]=Math.min(c,h),s[1]=Math.max(c,h),l=s[0]+","+s[1],f[l]===void 0&&(f[l]={index1:s[0],index2:s[1]});for(l in f)u=f[l],d.fromBufferAttribute(g,u.index1),t.push(d.x,d.y,d.z),d.fromBufferAttribute(g,u.index2),t.push(d.x,d.y,d.z)}else for(g=e.attributes.position,r=0,n=g.count/3;r<n;r++)for(i=0;i<3;i++)B=3*r+i,d.fromBufferAttribute(g,B),t.push(d.x,d.y,d.z),P=3*r+(i+1)%3,d.fromBufferAttribute(g,P),t.push(d.x,d.y,d.z)}this.addAttribute("position",new G(t,3))}ji.prototype=Object.create(z.prototype);ji.prototype.constructor=ji;function Bn(e,t,r){re.call(this),this.type="ParametricGeometry",this.parameters={func:e,slices:t,stacks:r},this.fromBufferGeometry(new qi(e,t,r)),this.mergeVertices()}Bn.prototype=Object.create(re.prototype);Bn.prototype.constructor=Bn;function qi(e,t,r){z.call(this),this.type="ParametricBufferGeometry",this.parameters={func:e,slices:t,stacks:r};var i=[],n=[],o=[],a=[],s=1e-5,f=new x,u=new x,c=new x,h=new x,l=new x,p,d;e.length<3&&console.error("THREE.ParametricGeometry: Function must now modify a Vector3 as third parameter.");var m=t+1;for(p=0;p<=r;p++){var v=p/r;for(d=0;d<=t;d++){var g=d/t;e(g,v,u),n.push(u.x,u.y,u.z),g-s>=0?(e(g-s,v,c),h.subVectors(u,c)):(e(g+s,v,c),h.subVectors(c,u)),v-s>=0?(e(g,v-s,c),l.subVectors(u,c)):(e(g,v+s,c),l.subVectors(c,u)),f.crossVectors(h,l).normalize(),o.push(f.x,f.y,f.z),a.push(g,v)}}for(p=0;p<r;p++)for(d=0;d<t;d++){var b=p*m+d,w=p*m+d+1,y=(p+1)*m+d+1,S=(p+1)*m+d;i.push(b,w,S),i.push(w,y,S)}this.setIndex(i),this.addAttribute("position",new G(n,3)),this.addAttribute("normal",new G(o,3)),this.addAttribute("uv",new G(a,2))}qi.prototype=Object.create(z.prototype);qi.prototype.constructor=qi;function Fn(e,t,r,i){re.call(this),this.type="PolyhedronGeometry",this.parameters={vertices:e,indices:t,radius:r,detail:i},this.fromBufferGeometry(new ht(e,t,r,i)),this.mergeVertices()}Fn.prototype=Object.create(re.prototype);Fn.prototype.constructor=Fn;function ht(e,t,r,i){z.call(this),this.type="PolyhedronBufferGeometry",this.parameters={vertices:e,indices:t,radius:r,detail:i},r=r||1,i=i||0;var n=[],o=[];a(i),f(r),u(),this.addAttribute("position",new G(n,3)),this.addAttribute("normal",new G(n.slice(),3)),this.addAttribute("uv",new G(o,2)),i===0?this.computeVertexNormals():this.normalizeNormals();function a(g){for(var b=new x,w=new x,y=new x,S=0;S<t.length;S+=3)l(t[S+0],b),l(t[S+1],w),l(t[S+2],y),s(b,w,y,g)}function s(g,b,w,y){var S=Math.pow(2,y),R=[],B,P;for(B=0;B<=S;B++){R[B]=[];var A=g.clone().lerp(w,B/S),D=b.clone().lerp(w,B/S),I=S-B;for(P=0;P<=I;P++)P===0&&B===S?R[B][P]=A:R[B][P]=A.clone().lerp(D,P/I)}for(B=0;B<S;B++)for(P=0;P<2*(S-B)-1;P++){var H=Math.floor(P/2);P%2===0?(h(R[B][H+1]),h(R[B+1][H]),h(R[B][H])):(h(R[B][H+1]),h(R[B+1][H+1]),h(R[B+1][H]))}}function f(g){for(var b=new x,w=0;w<n.length;w+=3)b.x=n[w+0],b.y=n[w+1],b.z=n[w+2],b.normalize().multiplyScalar(g),n[w+0]=b.x,n[w+1]=b.y,n[w+2]=b.z}function u(){for(var g=new x,b=0;b<n.length;b+=3){g.x=n[b+0],g.y=n[b+1],g.z=n[b+2];var w=m(g)/2/Math.PI+.5,y=v(g)/Math.PI+.5;o.push(w,1-y)}p(),c()}function c(){for(var g=0;g<o.length;g+=6){var b=o[g+0],w=o[g+2],y=o[g+4],S=Math.max(b,w,y),R=Math.min(b,w,y);S>.9&&R<.1&&(b<.2&&(o[g+0]+=1),w<.2&&(o[g+2]+=1),y<.2&&(o[g+4]+=1))}}function h(g){n.push(g.x,g.y,g.z)}function l(g,b){var w=g*3;b.x=e[w+0],b.y=e[w+1],b.z=e[w+2]}function p(){for(var g=new x,b=new x,w=new x,y=new x,S=new O,R=new O,B=new O,P=0,A=0;P<n.length;P+=9,A+=6){g.set(n[P+0],n[P+1],n[P+2]),b.set(n[P+3],n[P+4],n[P+5]),w.set(n[P+6],n[P+7],n[P+8]),S.set(o[A+0],o[A+1]),R.set(o[A+2],o[A+3]),B.set(o[A+4],o[A+5]),y.copy(g).add(b).add(w).divideScalar(3);var D=m(y);d(S,A+0,g,D),d(R,A+2,b,D),d(B,A+4,w,D)}}function d(g,b,w,y){y<0&&g.x===1&&(o[b]=g.x-1),w.x===0&&w.z===0&&(o[b]=y/2/Math.PI+.5)}function m(g){return Math.atan2(g.z,-g.x)}function v(g){return Math.atan2(-g.y,Math.sqrt(g.x*g.x+g.z*g.z))}}ht.prototype=Object.create(z.prototype);ht.prototype.constructor=ht;function Dn(e,t){re.call(this),this.type="TetrahedronGeometry",this.parameters={radius:e,detail:t},this.fromBufferGeometry(new Yi(e,t)),this.mergeVertices()}Dn.prototype=Object.create(re.prototype);Dn.prototype.constructor=Dn;function Yi(e,t){var r=[1,1,1,-1,-1,1,-1,1,-1,1,-1,-1],i=[2,1,0,0,3,2,1,3,0,2,3,1];ht.call(this,r,i,e,t),this.type="TetrahedronBufferGeometry",this.parameters={radius:e,detail:t}}Yi.prototype=Object.create(ht.prototype);Yi.prototype.constructor=Yi;function In(e,t){re.call(this),this.type="OctahedronGeometry",this.parameters={radius:e,detail:t},this.fromBufferGeometry(new jr(e,t)),this.mergeVertices()}In.prototype=Object.create(re.prototype);In.prototype.constructor=In;function jr(e,t){var r=[1,0,0,-1,0,0,0,1,0,0,-1,0,0,0,1,0,0,-1],i=[0,2,4,0,4,3,0,3,5,0,5,2,1,2,5,1,5,3,1,3,4,1,4,2];ht.call(this,r,i,e,t),this.type="OctahedronBufferGeometry",this.parameters={radius:e,detail:t}}jr.prototype=Object.create(ht.prototype);jr.prototype.constructor=jr;function On(e,t){re.call(this),this.type="IcosahedronGeometry",this.parameters={radius:e,detail:t},this.fromBufferGeometry(new Zi(e,t)),this.mergeVertices()}On.prototype=Object.create(re.prototype);On.prototype.constructor=On;function Zi(e,t){var r=(1+Math.sqrt(5))/2,i=[-1,r,0,1,r,0,-1,-r,0,1,-r,0,0,-1,r,0,1,r,0,-1,-r,0,1,-r,r,0,-1,r,0,1,-r,0,-1,-r,0,1],n=[0,11,5,0,5,1,0,1,7,0,7,10,0,10,11,1,5,9,5,11,4,11,10,2,10,7,6,7,1,8,3,9,4,3,4,2,3,2,6,3,6,8,3,8,9,4,9,5,2,4,11,6,2,10,8,6,7,9,8,1];ht.call(this,i,n,e,t),this.type="IcosahedronBufferGeometry",this.parameters={radius:e,detail:t}}Zi.prototype=Object.create(ht.prototype);Zi.prototype.constructor=Zi;function Un(e,t){re.call(this),this.type="DodecahedronGeometry",this.parameters={radius:e,detail:t},this.fromBufferGeometry(new Ji(e,t)),this.mergeVertices()}Un.prototype=Object.create(re.prototype);Un.prototype.constructor=Un;function Ji(e,t){var r=(1+Math.sqrt(5))/2,i=1/r,n=[-1,-1,-1,-1,-1,1,-1,1,-1,-1,1,1,1,-1,-1,1,-1,1,1,1,-1,1,1,1,0,-i,-r,0,-i,r,0,i,-r,0,i,r,-i,-r,0,-i,r,0,i,-r,0,i,r,0,-r,0,-i,r,0,-i,-r,0,i,r,0,i],o=[3,11,7,3,7,15,3,15,13,7,19,17,7,17,6,7,6,15,17,4,8,17,8,10,17,10,6,8,0,16,8,16,2,8,2,10,0,12,1,0,1,18,0,18,16,6,10,2,6,2,13,6,13,15,2,16,18,2,18,3,2,3,13,18,1,9,18,9,11,18,11,3,4,14,12,4,12,0,4,0,8,11,9,5,11,5,19,11,19,7,19,5,14,19,14,4,19,4,17,1,12,14,1,14,5,1,5,9];ht.call(this,n,o,e,t),this.type="DodecahedronBufferGeometry",this.parameters={radius:e,detail:t}}Ji.prototype=Object.create(ht.prototype);Ji.prototype.constructor=Ji;function Nn(e,t,r,i,n,o){re.call(this),this.type="TubeGeometry",this.parameters={path:e,tubularSegments:t,radius:r,radialSegments:i,closed:n},o!==void 0&&console.warn("THREE.TubeGeometry: taper has been removed.");var a=new Qi(e,t,r,i,n);this.tangents=a.tangents,this.normals=a.normals,this.binormals=a.binormals,this.fromBufferGeometry(a),this.mergeVertices()}Nn.prototype=Object.create(re.prototype);Nn.prototype.constructor=Nn;function Qi(e,t,r,i,n){z.call(this),this.type="TubeBufferGeometry",this.parameters={path:e,tubularSegments:t,radius:r,radialSegments:i,closed:n},t=t||64,r=r||1,i=i||8,n=n||!1;var o=e.computeFrenetFrames(t,n);this.tangents=o.tangents,this.normals=o.normals,this.binormals=o.binormals;var a=new x,s=new x,f=new O,u=new x,c,h,l=[],p=[],d=[],m=[];v(),this.setIndex(m),this.addAttribute("position",new G(l,3)),this.addAttribute("normal",new G(p,3)),this.addAttribute("uv",new G(d,2));function v(){for(c=0;c<t;c++)g(c);g(n===!1?t:0),w(),b()}function g(y){u=e.getPointAt(y/t,u);var S=o.normals[y],R=o.binormals[y];for(h=0;h<=i;h++){var B=h/i*Math.PI*2,P=Math.sin(B),A=-Math.cos(B);s.x=A*S.x+P*R.x,s.y=A*S.y+P*R.y,s.z=A*S.z+P*R.z,s.normalize(),p.push(s.x,s.y,s.z),a.x=u.x+r*s.x,a.y=u.y+r*s.y,a.z=u.z+r*s.z,l.push(a.x,a.y,a.z)}}function b(){for(h=1;h<=t;h++)for(c=1;c<=i;c++){var y=(i+1)*(h-1)+(c-1),S=(i+1)*h+(c-1),R=(i+1)*h+c,B=(i+1)*(h-1)+c;m.push(y,S,B),m.push(S,R,B)}}function w(){for(c=0;c<=t;c++)for(h=0;h<=i;h++)f.x=c/t,f.y=h/i,d.push(f.x,f.y)}}Qi.prototype=Object.create(z.prototype);Qi.prototype.constructor=Qi;function Gn(e,t,r,i,n,o,a){re.call(this),this.type="TorusKnotGeometry",this.parameters={radius:e,tube:t,tubularSegments:r,radialSegments:i,p:n,q:o},a!==void 0&&console.warn("THREE.TorusKnotGeometry: heightScale has been deprecated. Use .scale( x, y, z ) instead."),this.fromBufferGeometry(new Ki(e,t,r,i,n,o)),this.mergeVertices()}Gn.prototype=Object.create(re.prototype);Gn.prototype.constructor=Gn;function Ki(e,t,r,i,n,o){z.call(this),this.type="TorusKnotBufferGeometry",this.parameters={radius:e,tube:t,tubularSegments:r,radialSegments:i,p:n,q:o},e=e||1,t=t||.4,r=Math.floor(r)||64,i=Math.floor(i)||8,n=n||2,o=o||3;var a=[],s=[],f=[],u=[],c,h,l=new x,p=new x,d=new x,m=new x,v=new x,g=new x,b=new x;for(c=0;c<=r;++c){var w=c/r*n*Math.PI*2;for(I(w,n,o,e,d),I(w+.01,n,o,e,m),g.subVectors(m,d),b.addVectors(m,d),v.crossVectors(g,b),b.crossVectors(v,g),v.normalize(),b.normalize(),h=0;h<=i;++h){var y=h/i*Math.PI*2,S=-t*Math.cos(y),R=t*Math.sin(y);l.x=d.x+(S*b.x+R*v.x),l.y=d.y+(S*b.y+R*v.y),l.z=d.z+(S*b.z+R*v.z),s.push(l.x,l.y,l.z),p.subVectors(l,d).normalize(),f.push(p.x,p.y,p.z),u.push(c/r),u.push(h/i)}}for(h=1;h<=r;h++)for(c=1;c<=i;c++){var B=(i+1)*(h-1)+(c-1),P=(i+1)*h+(c-1),A=(i+1)*h+c,D=(i+1)*(h-1)+c;a.push(B,P,D),a.push(P,A,D)}this.setIndex(a),this.addAttribute("position",new G(s,3)),this.addAttribute("normal",new G(f,3)),this.addAttribute("uv",new G(u,2));function I(H,X,j,V,$){var K=Math.cos(H),Q=Math.sin(H),E=j/X*H,T=Math.cos(E);$.x=V*(2+T)*.5*K,$.y=V*(2+T)*Q*.5,$.z=V*Math.sin(E)*.5}}Ki.prototype=Object.create(z.prototype);Ki.prototype.constructor=Ki;function zn(e,t,r,i,n){re.call(this),this.type="TorusGeometry",this.parameters={radius:e,tube:t,radialSegments:r,tubularSegments:i,arc:n},this.fromBufferGeometry(new $i(e,t,r,i,n)),this.mergeVertices()}zn.prototype=Object.create(re.prototype);zn.prototype.constructor=zn;function $i(e,t,r,i,n){z.call(this),this.type="TorusBufferGeometry",this.parameters={radius:e,tube:t,radialSegments:r,tubularSegments:i,arc:n},e=e||1,t=t||.4,r=Math.floor(r)||8,i=Math.floor(i)||6,n=n||Math.PI*2;var o=[],a=[],s=[],f=[],u=new x,c=new x,h=new x,l,p;for(l=0;l<=r;l++)for(p=0;p<=i;p++){var d=p/i*n,m=l/r*Math.PI*2;c.x=(e+t*Math.cos(m))*Math.cos(d),c.y=(e+t*Math.cos(m))*Math.sin(d),c.z=t*Math.sin(m),a.push(c.x,c.y,c.z),u.x=e*Math.cos(d),u.y=e*Math.sin(d),h.subVectors(c,u).normalize(),s.push(h.x,h.y,h.z),f.push(p/i),f.push(l/r)}for(l=1;l<=r;l++)for(p=1;p<=i;p++){var v=(i+1)*l+p-1,g=(i+1)*(l-1)+p-1,b=(i+1)*(l-1)+p,w=(i+1)*l+p;o.push(v,g,w),o.push(g,b,w)}this.setIndex(o),this.addAttribute("position",new G(a,3)),this.addAttribute("normal",new G(s,3)),this.addAttribute("uv",new G(f,2))}$i.prototype=Object.create(z.prototype);$i.prototype.constructor=$i;var Sh={triangulate:function(e,t,r){r=r||2;var i=t&&t.length,n=i?t[0]*r:e.length,o=Ah(e,0,n,r,!0),a=[];if(!o)return a;var s,f,u,c,h,l,p;if(i&&(o=Kl(e,t,o,r)),e.length>80*r){s=u=e[0],f=c=e[1];for(var d=r;d<n;d+=r)h=e[d],l=e[d+1],h<s&&(s=h),l<f&&(f=l),h>u&&(u=h),l>c&&(c=l);p=Math.max(u-s,c-f),p=p!==0?1/p:0}return Vn(o,a,r,s,f,p),a}};function Ah(e,t,r,i,n){var o,a;if(n===fp(e,t,r,i)>0)for(o=t;o<r;o+=i)a=Th(o,e[o],e[o+1],a);else for(o=r-i;o>=t;o-=i)a=Th(o,e[o],e[o+1],a);return a&&li(a,a.next)&&(Wn(a),a=a.next),a}function Hn(e,t){if(!e)return e;t||(t=e);var r=e,i;do if(i=!1,!r.steiner&&(li(r,r.next)||St(r.prev,r,r.next)===0)){if(Wn(r),r=t=r.prev,r===r.next)break;i=!0}else r=r.next;while(i||r!==t);return t}function Vn(e,t,r,i,n,o,a){if(e){!a&&o&&rp(e,i,n,o);for(var s=e,f,u;e.prev!==e.next;){if(f=e.prev,u=e.next,o?Zl(e,i,n,o):Yl(e)){t.push(f.i/r),t.push(e.i/r),t.push(u.i/r),Wn(e),e=u.next,s=u.next;continue}if(e=u,e===s){a?a===1?(e=Jl(e,t,r),Vn(e,t,r,i,n,o,2)):a===2&&Ql(e,t,r,i,n,o):Vn(Hn(e),t,r,i,n,o,1);break}}}}function Yl(e){var t=e.prev,r=e,i=e.next;if(St(t,r,i)>=0)return!1;for(var n=e.next.next;n!==e.prev;){if(na(t.x,t.y,r.x,r.y,i.x,i.y,n.x,n.y)&&St(n.prev,n,n.next)>=0)return!1;n=n.next}return!0}function Zl(e,t,r,i){var n=e.prev,o=e,a=e.next;if(St(n,o,a)>=0)return!1;for(var s=n.x<o.x?n.x<a.x?n.x:a.x:o.x<a.x?o.x:a.x,f=n.y<o.y?n.y<a.y?n.y:a.y:o.y<a.y?o.y:a.y,u=n.x>o.x?n.x>a.x?n.x:a.x:o.x>a.x?o.x:a.x,c=n.y>o.y?n.y>a.y?n.y:a.y:o.y>a.y?o.y:a.y,h=Wa(s,f,t,r,i),l=Wa(u,c,t,r,i),p=e.nextZ;p&&p.z<=l;){if(p!==e.prev&&p!==e.next&&na(n.x,n.y,o.x,o.y,a.x,a.y,p.x,p.y)&&St(p.prev,p,p.next)>=0)return!1;p=p.nextZ}for(p=e.prevZ;p&&p.z>=h;){if(p!==e.prev&&p!==e.next&&na(n.x,n.y,o.x,o.y,a.x,a.y,p.x,p.y)&&St(p.prev,p,p.next)>=0)return!1;p=p.prevZ}return!0}function Jl(e,t,r){var i=e;do{var n=i.prev,o=i.next.next;!li(n,o)&&Lh(n,i,i.next,o)&&kn(n,o)&&kn(o,n)&&(t.push(n.i/r),t.push(i.i/r),t.push(o.i/r),Wn(i),Wn(i.next),i=e=o),i=i.next}while(i!==e);return i}function Ql(e,t,r,i,n,o){var a=e;do{for(var s=a.next.next;s!==a.prev;){if(a.i!==s.i&&op(a,s)){var f=Rh(a,s);a=Hn(a,a.next),f=Hn(f,f.next),Vn(a,t,r,i,n,o),Vn(f,t,r,i,n,o);return}s=s.next}a=a.next}while(a!==e)}function Kl(e,t,r,i){var n=[],o,a,s,f,u;for(o=0,a=t.length;o<a;o++)s=t[o]*i,f=o<a-1?t[o+1]*i:e.length,u=Ah(e,s,f,i,!1),u===u.next&&(u.steiner=!0),n.push(np(u));for(n.sort($l),o=0;o<n.length;o++)ep(n[o],r),r=Hn(r,r.next);return r}function $l(e,t){return e.x-t.x}function ep(e,t){if(t=tp(e,t),t){var r=Rh(t,e);Hn(r,r.next)}}function tp(e,t){var r=t,i=e.x,n=e.y,o=-1/0,a;do{if(n<=r.y&&n>=r.next.y&&r.next.y!==r.y){var s=r.x+(n-r.y)*(r.next.x-r.x)/(r.next.y-r.y);if(s<=i&&s>o){if(o=s,s===i){if(n===r.y)return r;if(n===r.next.y)return r.next}a=r.x<r.next.x?r:r.next}}r=r.next}while(r!==t);if(!a)return null;if(i===o)return a.prev;var f=a,u=a.x,c=a.y,h=1/0,l;for(r=a.next;r!==f;)i>=r.x&&r.x>=u&&i!==r.x&&na(n<c?i:o,n,u,c,n<c?o:i,n,r.x,r.y)&&(l=Math.abs(n-r.y)/(i-r.x),(l<h||l===h&&r.x>a.x)&&kn(r,e)&&(a=r,h=l)),r=r.next;return a}function rp(e,t,r,i){var n=e;do n.z===null&&(n.z=Wa(n.x,n.y,t,r,i)),n.prevZ=n.prev,n.nextZ=n.next,n=n.next;while(n!==e);n.prevZ.nextZ=null,n.prevZ=null,ip(n)}function ip(e){var t,r,i,n,o,a,s,f,u=1;do{for(r=e,e=null,o=null,a=0;r;){for(a++,i=r,s=0,t=0;t<u&&(s++,i=i.nextZ,!!i);t++);for(f=u;s>0||f>0&&i;)s!==0&&(f===0||!i||r.z<=i.z)?(n=r,r=r.nextZ,s--):(n=i,i=i.nextZ,f--),o?o.nextZ=n:e=n,n.prevZ=o,o=n;r=i}o.nextZ=null,u*=2}while(a>1);return e}function Wa(e,t,r,i,n){return e=32767*(e-r)*n,t=32767*(t-i)*n,e=(e|e<<8)&16711935,e=(e|e<<4)&252645135,e=(e|e<<2)&858993459,e=(e|e<<1)&1431655765,t=(t|t<<8)&16711935,t=(t|t<<4)&252645135,t=(t|t<<2)&858993459,t=(t|t<<1)&1431655765,e|t<<1}function np(e){var t=e,r=e;do t.x<r.x&&(r=t),t=t.next;while(t!==e);return r}function na(e,t,r,i,n,o,a,s){return(n-a)*(t-s)-(e-a)*(o-s)>=0&&(e-a)*(i-s)-(r-a)*(t-s)>=0&&(r-a)*(o-s)-(n-a)*(i-s)>=0}function op(e,t){return e.next.i!==t.i&&e.prev.i!==t.i&&!ap(e,t)&&kn(e,t)&&kn(t,e)&&sp(e,t)}function St(e,t,r){return(t.y-e.y)*(r.x-t.x)-(t.x-e.x)*(r.y-t.y)}function li(e,t){return e.x===t.x&&e.y===t.y}function Lh(e,t,r,i){return li(e,t)&&li(r,i)||li(e,i)&&li(r,t)?!0:St(e,t,r)>0!=St(e,t,i)>0&&St(r,i,e)>0!=St(r,i,t)>0}function ap(e,t){var r=e;do{if(r.i!==e.i&&r.next.i!==e.i&&r.i!==t.i&&r.next.i!==t.i&&Lh(r,r.next,e,t))return!0;r=r.next}while(r!==e);return!1}function kn(e,t){return St(e.prev,e,e.next)<0?St(e,t,e.next)>=0&&St(e,e.prev,t)>=0:St(e,t,e.prev)<0||St(e,e.next,t)<0}function sp(e,t){var r=e,i=!1,n=(e.x+t.x)/2,o=(e.y+t.y)/2;do r.y>o!=r.next.y>o&&r.next.y!==r.y&&n<(r.next.x-r.x)*(o-r.y)/(r.next.y-r.y)+r.x&&(i=!i),r=r.next;while(r!==e);return i}function Rh(e,t){var r=new Xa(e.i,e.x,e.y),i=new Xa(t.i,t.x,t.y),n=e.next,o=t.prev;return e.next=t,t.prev=e,r.next=n,n.prev=r,i.next=r,r.prev=i,o.next=i,i.prev=o,i}function Th(e,t,r,i){var n=new Xa(e,t,r);return i?(n.next=i.next,n.prev=i,i.next.prev=n,i.next=n):(n.prev=n,n.next=n),n}function Wn(e){e.next.prev=e.prev,e.prev.next=e.next,e.prevZ&&(e.prevZ.nextZ=e.nextZ),e.nextZ&&(e.nextZ.prevZ=e.prevZ)}function Xa(e,t,r){this.i=e,this.x=t,this.y=r,this.prev=null,this.next=null,this.z=null,this.prevZ=null,this.nextZ=null,this.steiner=!1}function fp(e,t,r,i){for(var n=0,o=t,a=r-i;o<r;o+=i)n+=(e[a]-e[o])*(e[o+1]+e[a+1]),a=o;return n}var Xt={area:function(e){for(var t=e.length,r=0,i=t-1,n=0;n<t;i=n++)r+=e[i].x*e[n].y-e[n].x*e[i].y;return r*.5},isClockWise:function(e){return Xt.area(e)<0},triangulateShape:function(e,t){var r=[],i=[],n=[];Ch(e),Ph(r,e);var o=e.length;t.forEach(Ch);for(var a=0;a<t.length;a++)i.push(o),o+=t[a].length,Ph(r,t[a]);for(var s=Sh.triangulate(r,i),a=0;a<s.length;a+=3)n.push(s.slice(a,a+3));return n}};function Ch(e){var t=e.length;t>2&&e[t-1].equals(e[0])&&e.pop()}function Ph(e,t){for(var r=0;r<t.length;r++)e.push(t[r].x),e.push(t[r].y)}function qr(e,t){re.call(this),this.type="ExtrudeGeometry",this.parameters={shapes:e,options:t},this.fromBufferGeometry(new jt(e,t)),this.mergeVertices()}qr.prototype=Object.create(re.prototype);qr.prototype.constructor=qr;qr.prototype.toJSON=function(){var e=re.prototype.toJSON.call(this),t=this.parameters.shapes,r=this.parameters.options;return Bh(t,r,e)};function jt(e,t){z.call(this),this.type="ExtrudeBufferGeometry",this.parameters={shapes:e,options:t},e=Array.isArray(e)?e:[e];for(var r=this,i=[],n=[],o=0,a=e.length;o<a;o++){var s=e[o];f(s)}this.addAttribute("position",new G(i,3)),this.addAttribute("uv",new G(n,2)),this.computeVertexNormals();function f(u){var c=[],h=t.curveSegments!==void 0?t.curveSegments:12,l=t.steps!==void 0?t.steps:1,p=t.depth!==void 0?t.depth:100,d=t.bevelEnabled!==void 0?t.bevelEnabled:!0,m=t.bevelThickness!==void 0?t.bevelThickness:6,v=t.bevelSize!==void 0?t.bevelSize:m-2,g=t.bevelSegments!==void 0?t.bevelSegments:3,b=t.extrudePath,w=t.UVGenerator!==void 0?t.UVGenerator:up;t.amount!==void 0&&(console.warn("THREE.ExtrudeBufferGeometry: amount has been renamed to depth."),p=t.amount);var y,S=!1,R,B,P,A;b&&(y=b.getSpacedPoints(l),S=!0,d=!1,R=b.computeFrenetFrames(l,!1),B=new x,P=new x,A=new x),d||(g=0,m=0,v=0);var D,I,H,X=u.extractPoints(h),j=X.shape,V=X.holes,$=!Xt.isClockWise(j);if($)for(j=j.reverse(),I=0,H=V.length;I<H;I++)D=V[I],Xt.isClockWise(D)&&(V[I]=D.reverse());var K=Xt.triangulateShape(j,V),Q=j;for(I=0,H=V.length;I<H;I++)D=V[I],j=j.concat(D);function E(Le,Pe,F){return Pe||console.error("THREE.ExtrudeGeometry: vec does not exist"),Pe.clone().multiplyScalar(F).add(Le)}var T,U,L,te,N,q=j.length,Z,ve=K.length;function ge(Le,Pe,F){var se,ce,Te,le=Le.x-Pe.x,Re=Le.y-Pe.y,ze=F.x-Le.x,Ne=F.y-Le.y,Ct=le*le+Re*Re,He=le*Ne-Re*ze;if(Math.abs(He)>Number.EPSILON){var It=Math.sqrt(Ct),rt=Math.sqrt(ze*ze+Ne*Ne),Eo=Pe.x-Re/It,To=Pe.y+le/It,ba=F.x-Ne/rt,wa=F.y+ze/rt,So=((ba-Eo)*Ne-(wa-To)*ze)/(le*Ne-Re*ze);se=Eo+le*So-Le.x,ce=To+Re*So-Le.y;var Ao=se*se+ce*ce;if(Ao<=2)return new O(se,ce);Te=Math.sqrt(Ao/2)}else{var $r=!1;le>Number.EPSILON?ze>Number.EPSILON&&($r=!0):le<-Number.EPSILON?ze<-Number.EPSILON&&($r=!0):Math.sign(Re)===Math.sign(Ne)&&($r=!0),$r?(se=-Re,ce=le,Te=Math.sqrt(Ct)):(se=le,ce=Re,Te=Math.sqrt(Ct/2))}return new O(se/Te,ce/Te)}for(var me=[],W=0,pe=Q.length,Fe=pe-1,Ee=W+1;W<pe;W++,Fe++,Ee++)Fe===pe&&(Fe=0),Ee===pe&&(Ee=0),me[W]=ge(Q[W],Q[Fe],Q[Ee]);var _t=[],Je,st=me.concat();for(I=0,H=V.length;I<H;I++){for(D=V[I],Je=[],W=0,pe=D.length,Fe=pe-1,Ee=W+1;W<pe;W++,Fe++,Ee++)Fe===pe&&(Fe=0),Ee===pe&&(Ee=0),Je[W]=ge(D[W],D[Fe],D[Ee]);_t.push(Je),st=st.concat(Je)}for(T=0;T<g;T++){for(L=T/g,te=m*Math.cos(L*Math.PI/2),U=v*Math.sin(L*Math.PI/2),W=0,pe=Q.length;W<pe;W++)N=E(Q[W],me[W],U),ft(N.x,N.y,-te);for(I=0,H=V.length;I<H;I++)for(D=V[I],Je=_t[I],W=0,pe=D.length;W<pe;W++)N=E(D[W],Je[W],U),ft(N.x,N.y,-te)}for(U=v,W=0;W<q;W++)N=d?E(j[W],st[W],U):j[W],S?(P.copy(R.normals[0]).multiplyScalar(N.x),B.copy(R.binormals[0]).multiplyScalar(N.y),A.copy(y[0]).add(P).add(B),ft(A.x,A.y,A.z)):ft(N.x,N.y,0);var dt;for(dt=1;dt<=l;dt++)for(W=0;W<q;W++)N=d?E(j[W],st[W],U):j[W],S?(P.copy(R.normals[dt]).multiplyScalar(N.x),B.copy(R.binormals[dt]).multiplyScalar(N.y),A.copy(y[dt]).add(P).add(B),ft(A.x,A.y,A.z)):ft(N.x,N.y,p/l*dt);for(T=g-1;T>=0;T--){for(L=T/g,te=m*Math.cos(L*Math.PI/2),U=v*Math.sin(L*Math.PI/2),W=0,pe=Q.length;W<pe;W++)N=E(Q[W],me[W],U),ft(N.x,N.y,p+te);for(I=0,H=V.length;I<H;I++)for(D=V[I],Je=_t[I],W=0,pe=D.length;W<pe;W++)N=E(D[W],Je[W],U),S?ft(N.x,N.y+y[l-1].y,y[l-1].x+te):ft(N.x,N.y,p+te)}mr(),Jt();function mr(){var Le=i.length/3;if(d){var Pe=0,F=q*Pe;for(W=0;W<ve;W++)Z=K[W],mt(Z[2]+F,Z[1]+F,Z[0]+F);for(Pe=l+g*2,F=q*Pe,W=0;W<ve;W++)Z=K[W],mt(Z[0]+F,Z[1]+F,Z[2]+F)}else{for(W=0;W<ve;W++)Z=K[W],mt(Z[2],Z[1],Z[0]);for(W=0;W<ve;W++)Z=K[W],mt(Z[0]+q*l,Z[1]+q*l,Z[2]+q*l)}r.addGroup(Le,i.length/3-Le,0)}function Jt(){var Le=i.length/3,Pe=0;for(et(Q,Pe),Pe+=Q.length,I=0,H=V.length;I<H;I++)D=V[I],et(D,Pe),Pe+=D.length;r.addGroup(Le,i.length/3-Le,1)}function et(Le,Pe){var F,se;for(W=Le.length;--W>=0;){F=W,se=W-1,se<0&&(se=Le.length-1);var ce=0,Te=l+g*2;for(ce=0;ce<Te;ce++){var le=q*ce,Re=q*(ce+1),ze=Pe+F+le,Ne=Pe+se+le,Ct=Pe+se+Re,He=Pe+F+Re;Ai(ze,Ne,Ct,He)}}}function ft(Le,Pe,F){c.push(Le),c.push(Pe),c.push(F)}function mt(Le,Pe,F){Lt(Le),Lt(Pe),Lt(F);var se=i.length/3,ce=w.generateTopUV(r,i,se-3,se-2,se-1);Rt(ce[0]),Rt(ce[1]),Rt(ce[2])}function Ai(Le,Pe,F,se){Lt(Le),Lt(Pe),Lt(se),Lt(Pe),Lt(F),Lt(se);var ce=i.length/3,Te=w.generateSideWallUV(r,i,ce-6,ce-3,ce-2,ce-1);Rt(Te[0]),Rt(Te[1]),Rt(Te[3]),Rt(Te[1]),Rt(Te[2]),Rt(Te[3])}function Lt(Le){i.push(c[Le*3+0]),i.push(c[Le*3+1]),i.push(c[Le*3+2])}function Rt(Le){n.push(Le.x),n.push(Le.y)}}}jt.prototype=Object.create(z.prototype);jt.prototype.constructor=jt;jt.prototype.toJSON=function(){var e=z.prototype.toJSON.call(this),t=this.parameters.shapes,r=this.parameters.options;return Bh(t,r,e)};var up={generateTopUV:function(e,t,r,i,n){var o=t[r*3],a=t[r*3+1],s=t[i*3],f=t[i*3+1],u=t[n*3],c=t[n*3+1];return[new O(o,a),new O(s,f),new O(u,c)]},generateSideWallUV:function(e,t,r,i,n,o){var a=t[r*3],s=t[r*3+1],f=t[r*3+2],u=t[i*3],c=t[i*3+1],h=t[i*3+2],l=t[n*3],p=t[n*3+1],d=t[n*3+2],m=t[o*3],v=t[o*3+1],g=t[o*3+2];return Math.abs(s-c)<.01?[new O(a,1-f),new O(u,1-h),new O(l,1-d),new O(m,1-g)]:[new O(s,1-f),new O(c,1-h),new O(p,1-d),new O(v,1-g)]}};function Bh(e,t,r){if(r.shapes=[],Array.isArray(e))for(var i=0,n=e.length;i<n;i++){var o=e[i];r.shapes.push(o.uuid)}else r.shapes.push(e.uuid);return t.extrudePath!==void 0&&(r.options.extrudePath=t.extrudePath.toJSON()),r}function Xn(e,t){re.call(this),this.type="TextGeometry",this.parameters={text:e,parameters:t},this.fromBufferGeometry(new en(e,t)),this.mergeVertices()}Xn.prototype=Object.create(re.prototype);Xn.prototype.constructor=Xn;function en(e,t){t=t||{};var r=t.font;if(!(r&&r.isFont))return console.error("THREE.TextGeometry: font parameter is not an instance of THREE.Font."),new re;var i=r.generateShapes(e,t.size);t.depth=t.height!==void 0?t.height:50,t.bevelThickness===void 0&&(t.bevelThickness=10),t.bevelSize===void 0&&(t.bevelSize=8),t.bevelEnabled===void 0&&(t.bevelEnabled=!1),jt.call(this,i,t),this.type="TextBufferGeometry"}en.prototype=Object.create(jt.prototype);en.prototype.constructor=en;function jn(e,t,r,i,n,o,a){re.call(this),this.type="SphereGeometry",this.parameters={radius:e,widthSegments:t,heightSegments:r,phiStart:i,phiLength:n,thetaStart:o,thetaLength:a},this.fromBufferGeometry(new Yr(e,t,r,i,n,o,a)),this.mergeVertices()}jn.prototype=Object.create(re.prototype);jn.prototype.constructor=jn;function Yr(e,t,r,i,n,o,a){z.call(this),this.type="SphereBufferGeometry",this.parameters={radius:e,widthSegments:t,heightSegments:r,phiStart:i,phiLength:n,thetaStart:o,thetaLength:a},e=e||1,t=Math.max(3,Math.floor(t)||8),r=Math.max(2,Math.floor(r)||6),i=i!==void 0?i:0,n=n!==void 0?n:Math.PI*2,o=o!==void 0?o:0,a=a!==void 0?a:Math.PI;var s=o+a,f,u,c=0,h=[],l=new x,p=new x,d=[],m=[],v=[],g=[];for(u=0;u<=r;u++){var b=[],w=u/r;for(f=0;f<=t;f++){var y=f/t;l.x=-e*Math.cos(i+y*n)*Math.sin(o+w*a),l.y=e*Math.cos(o+w*a),l.z=e*Math.sin(i+y*n)*Math.sin(o+w*a),m.push(l.x,l.y,l.z),p.set(l.x,l.y,l.z).normalize(),v.push(p.x,p.y,p.z),g.push(y,1-w),b.push(c++)}h.push(b)}for(u=0;u<r;u++)for(f=0;f<t;f++){var S=h[u][f+1],R=h[u][f],B=h[u+1][f],P=h[u+1][f+1];(u!==0||o>0)&&d.push(S,R,P),(u!==r-1||s<Math.PI)&&d.push(R,B,P)}this.setIndex(d),this.addAttribute("position",new G(m,3)),this.addAttribute("normal",new G(v,3)),this.addAttribute("uv",new G(g,2))}Yr.prototype=Object.create(z.prototype);Yr.prototype.constructor=Yr;function qn(e,t,r,i,n,o){re.call(this),this.type="RingGeometry",this.parameters={innerRadius:e,outerRadius:t,thetaSegments:r,phiSegments:i,thetaStart:n,thetaLength:o},this.fromBufferGeometry(new tn(e,t,r,i,n,o)),this.mergeVertices()}qn.prototype=Object.create(re.prototype);qn.prototype.constructor=qn;function tn(e,t,r,i,n,o){z.call(this),this.type="RingBufferGeometry",this.parameters={innerRadius:e,outerRadius:t,thetaSegments:r,phiSegments:i,thetaStart:n,thetaLength:o},e=e||.5,t=t||1,n=n!==void 0?n:0,o=o!==void 0?o:Math.PI*2,r=r!==void 0?Math.max(3,r):8,i=i!==void 0?Math.max(1,i):1;var a=[],s=[],f=[],u=[],c,h=e,l=(t-e)/i,p=new x,d=new O,m,v;for(m=0;m<=i;m++){for(v=0;v<=r;v++)c=n+v/r*o,p.x=h*Math.cos(c),p.y=h*Math.sin(c),s.push(p.x,p.y,p.z),f.push(0,0,1),d.x=(p.x/t+1)/2,d.y=(p.y/t+1)/2,u.push(d.x,d.y);h+=l}for(m=0;m<i;m++){var g=m*(r+1);for(v=0;v<r;v++){c=v+g;var b=c,w=c+r+1,y=c+r+2,S=c+1;a.push(b,w,S),a.push(w,y,S)}}this.setIndex(a),this.addAttribute("position",new G(s,3)),this.addAttribute("normal",new G(f,3)),this.addAttribute("uv",new G(u,2))}tn.prototype=Object.create(z.prototype);tn.prototype.constructor=tn;function Yn(e,t,r,i){re.call(this),this.type="LatheGeometry",this.parameters={points:e,segments:t,phiStart:r,phiLength:i},this.fromBufferGeometry(new rn(e,t,r,i)),this.mergeVertices()}Yn.prototype=Object.create(re.prototype);Yn.prototype.constructor=Yn;function rn(e,t,r,i){z.call(this),this.type="LatheBufferGeometry",this.parameters={points:e,segments:t,phiStart:r,phiLength:i},t=Math.floor(t)||12,r=r||0,i=i||Math.PI*2,i=ie.clamp(i,0,Math.PI*2);var n=[],o=[],a=[],s,f=1/t,u=new x,c=new O,h,l;for(h=0;h<=t;h++){var p=r+h*f*i,d=Math.sin(p),m=Math.cos(p);for(l=0;l<=e.length-1;l++)u.x=e[l].x*d,u.y=e[l].y,u.z=e[l].x*m,o.push(u.x,u.y,u.z),c.x=h/t,c.y=l/(e.length-1),a.push(c.x,c.y)}for(h=0;h<t;h++)for(l=0;l<e.length-1;l++){s=l+h*e.length;var v=s,g=s+e.length,b=s+e.length+1,w=s+1;n.push(v,g,w),n.push(g,b,w)}if(this.setIndex(n),this.addAttribute("position",new G(o,3)),this.addAttribute("uv",new G(a,2)),this.computeVertexNormals(),i===Math.PI*2){var y=this.attributes.normal.array,S=new x,R=new x,B=new x;for(s=t*e.length*3,h=0,l=0;h<e.length;h++,l+=3)S.x=y[l+0],S.y=y[l+1],S.z=y[l+2],R.x=y[s+l+0],R.y=y[s+l+1],R.z=y[s+l+2],B.addVectors(S,R).normalize(),y[l+0]=y[s+l+0]=B.x,y[l+1]=y[s+l+1]=B.y,y[l+2]=y[s+l+2]=B.z}}rn.prototype=Object.create(z.prototype);rn.prototype.constructor=rn;function Zr(e,t){re.call(this),this.type="ShapeGeometry",typeof t=="object"&&(console.warn("THREE.ShapeGeometry: Options parameter has been removed."),t=t.curveSegments),this.parameters={shapes:e,curveSegments:t},this.fromBufferGeometry(new pi(e,t)),this.mergeVertices()}Zr.prototype=Object.create(re.prototype);Zr.prototype.constructor=Zr;Zr.prototype.toJSON=function(){var e=re.prototype.toJSON.call(this),t=this.parameters.shapes;return Fh(t,e)};function pi(e,t){z.call(this),this.type="ShapeBufferGeometry",this.parameters={shapes:e,curveSegments:t},t=t||12;var r=[],i=[],n=[],o=[],a=0,s=0;if(Array.isArray(e)===!1)u(e);else for(var f=0;f<e.length;f++)u(e[f]),this.addGroup(a,s,f),a+=s,s=0;this.setIndex(r),this.addAttribute("position",new G(i,3)),this.addAttribute("normal",new G(n,3)),this.addAttribute("uv",new G(o,2));function u(c){var h,l,p,d=i.length/3,m=c.extractPoints(t),v=m.shape,g=m.holes;for(Xt.isClockWise(v)===!1&&(v=v.reverse()),h=0,l=g.length;h<l;h++)p=g[h],Xt.isClockWise(p)===!0&&(g[h]=p.reverse());var b=Xt.triangulateShape(v,g);for(h=0,l=g.length;h<l;h++)p=g[h],v=v.concat(p);for(h=0,l=v.length;h<l;h++){var w=v[h];i.push(w.x,w.y,0),n.push(0,0,1),o.push(w.x,w.y)}for(h=0,l=b.length;h<l;h++){var y=b[h],S=y[0]+d,R=y[1]+d,B=y[2]+d;r.push(S,R,B),s+=3}}}pi.prototype=Object.create(z.prototype);pi.prototype.constructor=pi;pi.prototype.toJSON=function(){var e=z.prototype.toJSON.call(this),t=this.parameters.shapes;return Fh(t,e)};function Fh(e,t){if(t.shapes=[],Array.isArray(e))for(var r=0,i=e.length;r<i;r++){var n=e[r];t.shapes.push(n.uuid)}else t.shapes.push(e.uuid);return t}function nn(e,t){z.call(this),this.type="EdgesGeometry",this.parameters={thresholdAngle:t},t=t!==void 0?t:1;var r=[],i=Math.cos(ie.DEG2RAD*t),n=[0,0],o={},a,s,f,u=["a","b","c"],c;e.isBufferGeometry?(c=new re,c.fromBufferGeometry(e)):c=e.clone(),c.mergeVertices(),c.computeFaceNormals();for(var h=c.vertices,l=c.faces,p=0,d=l.length;p<d;p++)for(var m=l[p],v=0;v<3;v++)a=m[u[v]],s=m[u[(v+1)%3]],n[0]=Math.min(a,s),n[1]=Math.max(a,s),f=n[0]+","+n[1],o[f]===void 0?o[f]={index1:n[0],index2:n[1],face1:p,face2:void 0}:o[f].face2=p;for(f in o){var g=o[f];if(g.face2===void 0||l[g.face1].normal.dot(l[g.face2].normal)<=i){var b=h[g.index1];r.push(b.x,b.y,b.z),b=h[g.index2],r.push(b.x,b.y,b.z)}}this.addAttribute("position",new G(r,3))}nn.prototype=Object.create(z.prototype);nn.prototype.constructor=nn;function Jr(e,t,r,i,n,o,a,s){re.call(this),this.type="CylinderGeometry",this.parameters={radiusTop:e,radiusBottom:t,height:r,radialSegments:i,heightSegments:n,openEnded:o,thetaStart:a,thetaLength:s},this.fromBufferGeometry(new Kt(e,t,r,i,n,o,a,s)),this.mergeVertices()}Jr.prototype=Object.create(re.prototype);Jr.prototype.constructor=Jr;function Kt(e,t,r,i,n,o,a,s){z.call(this),this.type="CylinderBufferGeometry",this.parameters={radiusTop:e,radiusBottom:t,height:r,radialSegments:i,heightSegments:n,openEnded:o,thetaStart:a,thetaLength:s};var f=this;e=e!==void 0?e:1,t=t!==void 0?t:1,r=r||1,i=Math.floor(i)||8,n=Math.floor(n)||1,o=o!==void 0?o:!1,a=a!==void 0?a:0,s=s!==void 0?s:Math.PI*2;var u=[],c=[],h=[],l=[],p=0,d=[],m=r/2,v=0;g(),o===!1&&(e>0&&b(!0),t>0&&b(!1)),this.setIndex(u),this.addAttribute("position",new G(c,3)),this.addAttribute("normal",new G(h,3)),this.addAttribute("uv",new G(l,2));function g(){var w,y,S=new x,R=new x,B=0,P=(t-e)/r;for(y=0;y<=n;y++){var A=[],D=y/n,I=D*(t-e)+e;for(w=0;w<=i;w++){var H=w/i,X=H*s+a,j=Math.sin(X),V=Math.cos(X);R.x=I*j,R.y=-D*r+m,R.z=I*V,c.push(R.x,R.y,R.z),S.set(j,P,V).normalize(),h.push(S.x,S.y,S.z),l.push(H,1-D),A.push(p++)}d.push(A)}for(w=0;w<i;w++)for(y=0;y<n;y++){var $=d[y][w],K=d[y+1][w],Q=d[y+1][w+1],E=d[y][w+1];u.push($,K,E),u.push(K,Q,E),B+=6}f.addGroup(v,B,0),v+=B}function b(w){var y,S,R,B=new O,P=new x,A=0,D=w===!0?e:t,I=w===!0?1:-1;for(S=p,y=1;y<=i;y++)c.push(0,m*I,0),h.push(0,I,0),l.push(.5,.5),p++;for(R=p,y=0;y<=i;y++){var H=y/i,X=H*s+a,j=Math.cos(X),V=Math.sin(X);P.x=D*V,P.y=m*I,P.z=D*j,c.push(P.x,P.y,P.z),h.push(0,I,0),B.x=j*.5+.5,B.y=V*.5*I+.5,l.push(B.x,B.y),p++}for(y=0;y<i;y++){var $=S+y,K=R+y;w===!0?u.push(K,K+1,$):u.push(K+1,K,$),A+=3}f.addGroup(v,A,w===!0?1:2),v+=A}}Kt.prototype=Object.create(z.prototype);Kt.prototype.constructor=Kt;function Zn(e,t,r,i,n,o,a){Jr.call(this,0,e,t,r,i,n,o,a),this.type="ConeGeometry",this.parameters={radius:e,height:t,radialSegments:r,heightSegments:i,openEnded:n,thetaStart:o,thetaLength:a}}Zn.prototype=Object.create(Jr.prototype);Zn.prototype.constructor=Zn;function Jn(e,t,r,i,n,o,a){Kt.call(this,0,e,t,r,i,n,o,a),this.type="ConeBufferGeometry",this.parameters={radius:e,height:t,radialSegments:r,heightSegments:i,openEnded:n,thetaStart:o,thetaLength:a}}Jn.prototype=Object.create(Kt.prototype);Jn.prototype.constructor=Jn;function Qn(e,t,r,i){re.call(this),this.type="CircleGeometry",this.parameters={radius:e,segments:t,thetaStart:r,thetaLength:i},this.fromBufferGeometry(new on(e,t,r,i)),this.mergeVertices()}Qn.prototype=Object.create(re.prototype);Qn.prototype.constructor=Qn;function on(e,t,r,i){z.call(this),this.type="CircleBufferGeometry",this.parameters={radius:e,segments:t,thetaStart:r,thetaLength:i},e=e||1,t=t!==void 0?Math.max(3,t):8,r=r!==void 0?r:0,i=i!==void 0?i:Math.PI*2;var n=[],o=[],a=[],s=[],f,u,c=new x,h=new O;for(o.push(0,0,0),a.push(0,0,1),s.push(.5,.5),u=0,f=3;u<=t;u++,f+=3){var l=r+u/t*i;c.x=e*Math.cos(l),c.y=e*Math.sin(l),o.push(c.x,c.y,c.z),a.push(0,0,1),h.x=(o[f]/e+1)/2,h.y=(o[f+1]/e+1)/2,s.push(h.x,h.y)}for(f=1;f<=t;f++)n.push(f,f+1,0);this.setIndex(n),this.addAttribute("position",new G(o,3)),this.addAttribute("normal",new G(a,3)),this.addAttribute("uv",new G(s,2))}on.prototype=Object.create(z.prototype);on.prototype.constructor=on;var ja={};Ta(ja,{LineBasicMaterial:()=>xe,LineDashedMaterial:()=>_i,Material:()=>he,MeshBasicMaterial:()=>ot,MeshDepthMaterial:()=>wr,MeshDistanceMaterial:()=>Mr,MeshLambertMaterial:()=>yi,MeshMatcapMaterial:()=>xi,MeshNormalMaterial:()=>gi,MeshPhongMaterial:()=>Gt,MeshPhysicalMaterial:()=>mi,MeshStandardMaterial:()=>$t,MeshToonMaterial:()=>vi,PointsMaterial:()=>ur,RawShaderMaterial:()=>an,ShaderMaterial:()=>ct,ShadowMaterial:()=>di,SpriteMaterial:()=>Sr});function di(e){he.call(this),this.type="ShadowMaterial",this.color=new J(0),this.transparent=!0,this.setValues(e)}di.prototype=Object.create(he.prototype);di.prototype.constructor=di;di.prototype.isShadowMaterial=!0;di.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.color.copy(e.color),this};function an(e){ct.call(this,e),this.type="RawShaderMaterial"}an.prototype=Object.create(ct.prototype);an.prototype.constructor=an;an.prototype.isRawShaderMaterial=!0;function $t(e){he.call(this),this.defines={STANDARD:""},this.type="MeshStandardMaterial",this.color=new J(16777215),this.roughness=.5,this.metalness=.5,this.map=null,this.lightMap=null,this.lightMapIntensity=1,this.aoMap=null,this.aoMapIntensity=1,this.emissive=new J(0),this.emissiveIntensity=1,this.emissiveMap=null,this.bumpMap=null,this.bumpScale=1,this.normalMap=null,this.normalMapType=Ur,this.normalScale=new O(1,1),this.displacementMap=null,this.displacementScale=1,this.displacementBias=0,this.roughnessMap=null,this.metalnessMap=null,this.alphaMap=null,this.envMap=null,this.envMapIntensity=1,this.refractionRatio=.98,this.wireframe=!1,this.wireframeLinewidth=1,this.wireframeLinecap="round",this.wireframeLinejoin="round",this.skinning=!1,this.morphTargets=!1,this.morphNormals=!1,this.setValues(e)}$t.prototype=Object.create(he.prototype);$t.prototype.constructor=$t;$t.prototype.isMeshStandardMaterial=!0;$t.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.defines={STANDARD:""},this.color.copy(e.color),this.roughness=e.roughness,this.metalness=e.metalness,this.map=e.map,this.lightMap=e.lightMap,this.lightMapIntensity=e.lightMapIntensity,this.aoMap=e.aoMap,this.aoMapIntensity=e.aoMapIntensity,this.emissive.copy(e.emissive),this.emissiveMap=e.emissiveMap,this.emissiveIntensity=e.emissiveIntensity,this.bumpMap=e.bumpMap,this.bumpScale=e.bumpScale,this.normalMap=e.normalMap,this.normalMapType=e.normalMapType,this.normalScale.copy(e.normalScale),this.displacementMap=e.displacementMap,this.displacementScale=e.displacementScale,this.displacementBias=e.displacementBias,this.roughnessMap=e.roughnessMap,this.metalnessMap=e.metalnessMap,this.alphaMap=e.alphaMap,this.envMap=e.envMap,this.envMapIntensity=e.envMapIntensity,this.refractionRatio=e.refractionRatio,this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this.wireframeLinecap=e.wireframeLinecap,this.wireframeLinejoin=e.wireframeLinejoin,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this.morphNormals=e.morphNormals,this};function mi(e){$t.call(this),this.defines={PHYSICAL:""},this.type="MeshPhysicalMaterial",this.reflectivity=.5,this.clearCoat=0,this.clearCoatRoughness=0,this.setValues(e)}mi.prototype=Object.create($t.prototype);mi.prototype.constructor=mi;mi.prototype.isMeshPhysicalMaterial=!0;mi.prototype.copy=function(e){return $t.prototype.copy.call(this,e),this.defines={PHYSICAL:""},this.reflectivity=e.reflectivity,this.clearCoat=e.clearCoat,this.clearCoatRoughness=e.clearCoatRoughness,this};function Gt(e){he.call(this),this.type="MeshPhongMaterial",this.color=new J(16777215),this.specular=new J(1118481),this.shininess=30,this.map=null,this.lightMap=null,this.lightMapIntensity=1,this.aoMap=null,this.aoMapIntensity=1,this.emissive=new J(0),this.emissiveIntensity=1,this.emissiveMap=null,this.bumpMap=null,this.bumpScale=1,this.normalMap=null,this.normalMapType=Ur,this.normalScale=new O(1,1),this.displacementMap=null,this.displacementScale=1,this.displacementBias=0,this.specularMap=null,this.alphaMap=null,this.envMap=null,this.combine=Cr,this.reflectivity=1,this.refractionRatio=.98,this.wireframe=!1,this.wireframeLinewidth=1,this.wireframeLinecap="round",this.wireframeLinejoin="round",this.skinning=!1,this.morphTargets=!1,this.morphNormals=!1,this.setValues(e)}Gt.prototype=Object.create(he.prototype);Gt.prototype.constructor=Gt;Gt.prototype.isMeshPhongMaterial=!0;Gt.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.color.copy(e.color),this.specular.copy(e.specular),this.shininess=e.shininess,this.map=e.map,this.lightMap=e.lightMap,this.lightMapIntensity=e.lightMapIntensity,this.aoMap=e.aoMap,this.aoMapIntensity=e.aoMapIntensity,this.emissive.copy(e.emissive),this.emissiveMap=e.emissiveMap,this.emissiveIntensity=e.emissiveIntensity,this.bumpMap=e.bumpMap,this.bumpScale=e.bumpScale,this.normalMap=e.normalMap,this.normalMapType=e.normalMapType,this.normalScale.copy(e.normalScale),this.displacementMap=e.displacementMap,this.displacementScale=e.displacementScale,this.displacementBias=e.displacementBias,this.specularMap=e.specularMap,this.alphaMap=e.alphaMap,this.envMap=e.envMap,this.combine=e.combine,this.reflectivity=e.reflectivity,this.refractionRatio=e.refractionRatio,this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this.wireframeLinecap=e.wireframeLinecap,this.wireframeLinejoin=e.wireframeLinejoin,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this.morphNormals=e.morphNormals,this};function vi(e){Gt.call(this),this.defines={TOON:""},this.type="MeshToonMaterial",this.gradientMap=null,this.setValues(e)}vi.prototype=Object.create(Gt.prototype);vi.prototype.constructor=vi;vi.prototype.isMeshToonMaterial=!0;vi.prototype.copy=function(e){return Gt.prototype.copy.call(this,e),this.gradientMap=e.gradientMap,this};function gi(e){he.call(this),this.type="MeshNormalMaterial",this.bumpMap=null,this.bumpScale=1,this.normalMap=null,this.normalMapType=Ur,this.normalScale=new O(1,1),this.displacementMap=null,this.displacementScale=1,this.displacementBias=0,this.wireframe=!1,this.wireframeLinewidth=1,this.fog=!1,this.lights=!1,this.skinning=!1,this.morphTargets=!1,this.morphNormals=!1,this.setValues(e)}gi.prototype=Object.create(he.prototype);gi.prototype.constructor=gi;gi.prototype.isMeshNormalMaterial=!0;gi.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.bumpMap=e.bumpMap,this.bumpScale=e.bumpScale,this.normalMap=e.normalMap,this.normalMapType=e.normalMapType,this.normalScale.copy(e.normalScale),this.displacementMap=e.displacementMap,this.displacementScale=e.displacementScale,this.displacementBias=e.displacementBias,this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this.morphNormals=e.morphNormals,this};function yi(e){he.call(this),this.type="MeshLambertMaterial",this.color=new J(16777215),this.map=null,this.lightMap=null,this.lightMapIntensity=1,this.aoMap=null,this.aoMapIntensity=1,this.emissive=new J(0),this.emissiveIntensity=1,this.emissiveMap=null,this.specularMap=null,this.alphaMap=null,this.envMap=null,this.combine=Cr,this.reflectivity=1,this.refractionRatio=.98,this.wireframe=!1,this.wireframeLinewidth=1,this.wireframeLinecap="round",this.wireframeLinejoin="round",this.skinning=!1,this.morphTargets=!1,this.morphNormals=!1,this.setValues(e)}yi.prototype=Object.create(he.prototype);yi.prototype.constructor=yi;yi.prototype.isMeshLambertMaterial=!0;yi.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.color.copy(e.color),this.map=e.map,this.lightMap=e.lightMap,this.lightMapIntensity=e.lightMapIntensity,this.aoMap=e.aoMap,this.aoMapIntensity=e.aoMapIntensity,this.emissive.copy(e.emissive),this.emissiveMap=e.emissiveMap,this.emissiveIntensity=e.emissiveIntensity,this.specularMap=e.specularMap,this.alphaMap=e.alphaMap,this.envMap=e.envMap,this.combine=e.combine,this.reflectivity=e.reflectivity,this.refractionRatio=e.refractionRatio,this.wireframe=e.wireframe,this.wireframeLinewidth=e.wireframeLinewidth,this.wireframeLinecap=e.wireframeLinecap,this.wireframeLinejoin=e.wireframeLinejoin,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this.morphNormals=e.morphNormals,this};function xi(e){he.call(this),this.defines={MATCAP:""},this.type="MeshMatcapMaterial",this.color=new J(16777215),this.matcap=null,this.map=null,this.bumpMap=null,this.bumpScale=1,this.normalMap=null,this.normalMapType=Ur,this.normalScale=new O(1,1),this.displacementMap=null,this.displacementScale=1,this.displacementBias=0,this.alphaMap=null,this.skinning=!1,this.morphTargets=!1,this.morphNormals=!1,this.lights=!1,this.setValues(e)}xi.prototype=Object.create(he.prototype);xi.prototype.constructor=xi;xi.prototype.isMeshMatcapMaterial=!0;xi.prototype.copy=function(e){return he.prototype.copy.call(this,e),this.defines={MATCAP:""},this.color.copy(e.color),this.matcap=e.matcap,this.map=e.map,this.bumpMap=e.bumpMap,this.bumpScale=e.bumpScale,this.normalMap=e.normalMap,this.normalMapType=e.normalMapType,this.normalScale.copy(e.normalScale),this.displacementMap=e.displacementMap,this.displacementScale=e.displacementScale,this.displacementBias=e.displacementBias,this.alphaMap=e.alphaMap,this.skinning=e.skinning,this.morphTargets=e.morphTargets,this.morphNormals=e.morphNormals,this};function _i(e){xe.call(this),this.type="LineDashedMaterial",this.scale=1,this.dashSize=3,this.gapSize=1,this.setValues(e)}_i.prototype=Object.create(xe.prototype);_i.prototype.constructor=_i;_i.prototype.isLineDashedMaterial=!0;_i.prototype.copy=function(e){return xe.prototype.copy.call(this,e),this.scale=e.scale,this.dashSize=e.dashSize,this.gapSize=e.gapSize,this};var lt={arraySlice:function(e,t,r){return lt.isTypedArray(e)?new e.constructor(e.subarray(t,r!==void 0?r:e.length)):e.slice(t,r)},convertArray:function(e,t,r){return!e||!r&&e.constructor===t?e:typeof t.BYTES_PER_ELEMENT=="number"?new t(e):Array.prototype.slice.call(e)},isTypedArray:function(e){return ArrayBuffer.isView(e)&&!(e instanceof DataView)},getKeyframeOrder:function(e){function t(o,a){return e[o]-e[a]}for(var r=e.length,i=new Array(r),n=0;n!==r;++n)i[n]=n;return i.sort(t),i},sortedArray:function(e,t,r){for(var i=e.length,n=new e.constructor(i),o=0,a=0;a!==i;++o)for(var s=r[o]*t,f=0;f!==t;++f)n[a++]=e[s+f];return n},flattenJSON:function(e,t,r,i){for(var n=1,o=e[0];o!==void 0&&o[i]===void 0;)o=e[n++];if(o!==void 0){var a=o[i];if(a!==void 0)if(Array.isArray(a))do a=o[i],a!==void 0&&(t.push(o.time),r.push.apply(r,a)),o=e[n++];while(o!==void 0);else if(a.toArray!==void 0)do a=o[i],a!==void 0&&(t.push(o.time),a.toArray(r,r.length)),o=e[n++];while(o!==void 0);else do a=o[i],a!==void 0&&(t.push(o.time),r.push(a)),o=e[n++];while(o!==void 0)}}};function yt(e,t,r,i){this.parameterPositions=e,this._cachedIndex=0,this.resultBuffer=i!==void 0?i:new t.constructor(r),this.sampleValues=t,this.valueSize=r}Object.assign(yt.prototype,{evaluate:function(e){var t=this.parameterPositions,r=this._cachedIndex,i=t[r],n=t[r-1];e:{t:{var o;r:{i:if(!(e<i)){for(var a=r+2;;){if(i===void 0){if(e<n)break i;return r=t.length,this._cachedIndex=r,this.afterEnd_(r-1,e,n)}if(r===a)break;if(n=i,i=t[++r],e<i)break t}o=t.length;break r}if(!(e>=n)){var s=t[1];e<s&&(r=2,n=s);for(var a=r-2;;){if(n===void 0)return this._cachedIndex=0,this.beforeStart_(0,e,i);if(r===a)break;if(i=n,n=t[--r-1],e>=n)break t}o=r,r=0;break r}break e}for(;r<o;){var f=r+o>>>1;e<t[f]?o=f:r=f+1}if(i=t[r],n=t[r-1],n===void 0)return this._cachedIndex=0,this.beforeStart_(0,e,i);if(i===void 0)return r=t.length,this._cachedIndex=r,this.afterEnd_(r-1,n,e)}this._cachedIndex=r,this.intervalChanged_(r,n,i)}return this.interpolate_(r,n,e,i)},settings:null,DefaultSettings_:{},getSettings_:function(){return this.settings||this.DefaultSettings_},copySampleValue_:function(e){for(var t=this.resultBuffer,r=this.sampleValues,i=this.valueSize,n=e*i,o=0;o!==i;++o)t[o]=r[n+o];return t},interpolate_:function(){throw new Error("call to abstract method")},intervalChanged_:function(){}});Object.assign(yt.prototype,{beforeStart_:yt.prototype.copySampleValue_,afterEnd_:yt.prototype.copySampleValue_});function Kn(e,t,r,i){yt.call(this,e,t,r,i),this._weightPrev=-0,this._offsetPrev=-0,this._weightNext=-0,this._offsetNext=-0}Kn.prototype=Object.assign(Object.create(yt.prototype),{constructor:Kn,DefaultSettings_:{endingStart:Ir,endingEnd:Ir},intervalChanged_:function(e,t,r){var i=this.parameterPositions,n=e-2,o=e+1,a=i[n],s=i[o];if(a===void 0)switch(this.getSettings_().endingStart){case Or:n=e,a=2*t-r;break;case Ii:n=i.length-2,a=t+i[n]-i[n+1];break;default:n=e,a=r}if(s===void 0)switch(this.getSettings_().endingEnd){case Or:o=e,s=2*r-t;break;case Ii:o=1,s=r+i[1]-i[0];break;default:o=e-1,s=t}var f=(r-t)*.5,u=this.valueSize;this._weightPrev=f/(t-a),this._weightNext=f/(s-r),this._offsetPrev=n*u,this._offsetNext=o*u},interpolate_:function(e,t,r,i){for(var n=this.resultBuffer,o=this.sampleValues,a=this.valueSize,s=e*a,f=s-a,u=this._offsetPrev,c=this._offsetNext,h=this._weightPrev,l=this._weightNext,p=(r-t)/(i-t),d=p*p,m=d*p,v=-h*m+2*h*d-h*p,g=(1+h)*m+(-1.5-2*h)*d+(-.5+h)*p+1,b=(-1-l)*m+(1.5+l)*d+.5*p,w=l*m-l*d,y=0;y!==a;++y)n[y]=v*o[u+y]+g*o[f+y]+b*o[s+y]+w*o[c+y];return n}});function bi(e,t,r,i){yt.call(this,e,t,r,i)}bi.prototype=Object.assign(Object.create(yt.prototype),{constructor:bi,interpolate_:function(e,t,r,i){for(var n=this.resultBuffer,o=this.sampleValues,a=this.valueSize,s=e*a,f=s-a,u=(r-t)/(i-t),c=1-u,h=0;h!==a;++h)n[h]=o[f+h]*c+o[s+h]*u;return n}});function $n(e,t,r,i){yt.call(this,e,t,r,i)}$n.prototype=Object.assign(Object.create(yt.prototype),{constructor:$n,interpolate_:function(e){return this.copySampleValue_(e-1)}});function Ye(e,t,r,i){if(e===void 0)throw new Error("THREE.KeyframeTrack: track name is undefined");if(t===void 0||t.length===0)throw new Error("THREE.KeyframeTrack: no keyframes in track named "+e);this.name=e,this.times=lt.convertArray(t,this.TimeBufferType),this.values=lt.convertArray(r,this.ValueBufferType),this.setInterpolation(i||this.DefaultInterpolation)}Object.assign(Ye,{toJSON:function(e){var t=e.constructor,r;if(t.toJSON!==void 0)r=t.toJSON(e);else{r={name:e.name,times:lt.convertArray(e.times,Array),values:lt.convertArray(e.values,Array)};var i=e.getInterpolation();i!==e.DefaultInterpolation&&(r.interpolation=i)}return r.type=e.ValueTypeName,r}});Object.assign(Ye.prototype,{constructor:Ye,TimeBufferType:Float32Array,ValueBufferType:Float32Array,DefaultInterpolation:Di,InterpolantFactoryMethodDiscrete:function(e){return new $n(this.times,this.values,this.getValueSize(),e)},InterpolantFactoryMethodLinear:function(e){return new bi(this.times,this.values,this.getValueSize(),e)},InterpolantFactoryMethodSmooth:function(e){return new Kn(this.times,this.values,this.getValueSize(),e)},setInterpolation:function(e){var t;switch(e){case ri:t=this.InterpolantFactoryMethodDiscrete;break;case Di:t=this.InterpolantFactoryMethodLinear;break;case ko:t=this.InterpolantFactoryMethodSmooth;break}if(t===void 0){var r="unsupported interpolation for "+this.ValueTypeName+" keyframe track named "+this.name;if(this.createInterpolant===void 0)if(e!==this.DefaultInterpolation)this.setInterpolation(this.DefaultInterpolation);else throw new Error(r);return console.warn("THREE.KeyframeTrack:",r),this}return this.createInterpolant=t,this},getInterpolation:function(){switch(this.createInterpolant){case this.InterpolantFactoryMethodDiscrete:return ri;case this.InterpolantFactoryMethodLinear:return Di;case this.InterpolantFactoryMethodSmooth:return ko}},getValueSize:function(){return this.values.length/this.times.length},shift:function(e){if(e!==0)for(var t=this.times,r=0,i=t.length;r!==i;++r)t[r]+=e;return this},scale:function(e){if(e!==1)for(var t=this.times,r=0,i=t.length;r!==i;++r)t[r]*=e;return this},trim:function(e,t){for(var r=this.times,i=r.length,n=0,o=i-1;n!==i&&r[n]<e;)++n;for(;o!==-1&&r[o]>t;)--o;if(++o,n!==0||o!==i){n>=o&&(o=Math.max(o,1),n=o-1);var a=this.getValueSize();this.times=lt.arraySlice(r,n,o),this.values=lt.arraySlice(this.values,n*a,o*a)}return this},validate:function(){var e=!0,t=this.getValueSize();t-Math.floor(t)!==0&&(console.error("THREE.KeyframeTrack: Invalid value size in track.",this),e=!1);var r=this.times,i=this.values,n=r.length;n===0&&(console.error("THREE.KeyframeTrack: Track is empty.",this),e=!1);for(var o=null,a=0;a!==n;a++){var s=r[a];if(typeof s=="number"&&isNaN(s)){console.error("THREE.KeyframeTrack: Time is not a valid number.",this,a,s),e=!1;break}if(o!==null&&o>s){console.error("THREE.KeyframeTrack: Out of order keys.",this,a,s,o),e=!1;break}o=s}if(i!==void 0&&lt.isTypedArray(i))for(var a=0,f=i.length;a!==f;++a){var u=i[a];if(isNaN(u)){console.error("THREE.KeyframeTrack: Value is not a valid number.",this,a,u),e=!1;break}}return e},optimize:function(){for(var e=this.times,t=this.values,r=this.getValueSize(),i=this.getInterpolation()===ko,n=1,o=e.length-1,a=1;a<o;++a){var s=!1,f=e[a],u=e[a+1];if(f!==u&&(a!==1||f!==f[0]))if(i)s=!0;else for(var c=a*r,h=c-r,l=c+r,p=0;p!==r;++p){var d=t[c+p];if(d!==t[h+p]||d!==t[l+p]){s=!0;break}}if(s){if(a!==n){e[n]=e[a];for(var m=a*r,v=n*r,p=0;p!==r;++p)t[v+p]=t[m+p]}++n}}if(o>0){e[n]=e[o];for(var m=o*r,v=n*r,p=0;p!==r;++p)t[v+p]=t[m+p];++n}return n!==e.length&&(this.times=lt.arraySlice(e,0,n),this.values=lt.arraySlice(t,0,n*r)),this}});function eo(e,t,r){Ye.call(this,e,t,r)}eo.prototype=Object.assign(Object.create(Ye.prototype),{constructor:eo,ValueTypeName:"bool",ValueBufferType:Array,DefaultInterpolation:ri,InterpolantFactoryMethodLinear:void 0,InterpolantFactoryMethodSmooth:void 0});function to(e,t,r,i){Ye.call(this,e,t,r,i)}to.prototype=Object.assign(Object.create(Ye.prototype),{constructor:to,ValueTypeName:"color"});function wi(e,t,r,i){Ye.call(this,e,t,r,i)}wi.prototype=Object.assign(Object.create(Ye.prototype),{constructor:wi,ValueTypeName:"number"});function ro(e,t,r,i){yt.call(this,e,t,r,i)}ro.prototype=Object.assign(Object.create(yt.prototype),{constructor:ro,interpolate_:function(e,t,r,i){for(var n=this.resultBuffer,o=this.sampleValues,a=this.valueSize,s=e*a,f=(r-t)/(i-t),u=s+a;s!==u;s+=4)Ge.slerpFlat(n,0,o,s-a,o,s,f);return n}});function sn(e,t,r,i){Ye.call(this,e,t,r,i)}sn.prototype=Object.assign(Object.create(Ye.prototype),{constructor:sn,ValueTypeName:"quaternion",DefaultInterpolation:Di,InterpolantFactoryMethodLinear:function(e){return new ro(this.times,this.values,this.getValueSize(),e)},InterpolantFactoryMethodSmooth:void 0});function io(e,t,r,i){Ye.call(this,e,t,r,i)}io.prototype=Object.assign(Object.create(Ye.prototype),{constructor:io,ValueTypeName:"string",ValueBufferType:Array,DefaultInterpolation:ri,InterpolantFactoryMethodLinear:void 0,InterpolantFactoryMethodSmooth:void 0});function Mi(e,t,r,i){Ye.call(this,e,t,r,i)}Mi.prototype=Object.assign(Object.create(Ye.prototype),{constructor:Mi,ValueTypeName:"vector"});function Ft(e,t,r){this.name=e,this.tracks=r,this.duration=t!==void 0?t:-1,this.uuid=ie.generateUUID(),this.duration<0&&this.resetDuration()}function cp(e){switch(e.toLowerCase()){case"scalar":case"double":case"float":case"number":case"integer":return wi;case"vector":case"vector2":case"vector3":case"vector4":return Mi;case"color":return to;case"quaternion":return sn;case"bool":case"boolean":return eo;case"string":return io}throw new Error("THREE.KeyframeTrack: Unsupported typeName: "+e)}function hp(e){if(e.type===void 0)throw new Error("THREE.KeyframeTrack: track type undefined, can not parse");var t=cp(e.type);if(e.times===void 0){var r=[],i=[];lt.flattenJSON(e.keys,r,i,"value"),e.times=r,e.values=i}return t.parse!==void 0?t.parse(e):new t(e.name,e.times,e.values,e.interpolation)}Object.assign(Ft,{parse:function(e){for(var t=[],r=e.tracks,i=1/(e.fps||1),n=0,o=r.length;n!==o;++n)t.push(hp(r[n]).scale(i));return new Ft(e.name,e.duration,t)},toJSON:function(e){for(var t=[],r=e.tracks,i={name:e.name,duration:e.duration,tracks:t,uuid:e.uuid},n=0,o=r.length;n!==o;++n)t.push(Ye.toJSON(r[n]));return i},CreateFromMorphTargetSequence:function(e,t,r,i){for(var n=t.length,o=[],a=0;a<n;a++){var s=[],f=[];s.push((a+n-1)%n,a,(a+1)%n),f.push(0,1,0);var u=lt.getKeyframeOrder(s);s=lt.sortedArray(s,1,u),f=lt.sortedArray(f,1,u),!i&&s[0]===0&&(s.push(n),f.push(f[0])),o.push(new wi(".morphTargetInfluences["+t[a].name+"]",s,f).scale(1/r))}return new Ft(e,-1,o)},findByName:function(e,t){var r=e;if(!Array.isArray(e)){var i=e;r=i.geometry&&i.geometry.animations||i.animations}for(var n=0;n<r.length;n++)if(r[n].name===t)return r[n];return null},CreateClipsFromMorphTargetSequences:function(e,t,r){for(var i={},n=/^([\w-]*?)([\d]+)$/,o=0,a=e.length;o<a;o++){var s=e[o],f=s.name.match(n);if(f&&f.length>1){var u=f[1],c=i[u];c||(i[u]=c=[]),c.push(s)}}var h=[];for(var u in i)h.push(Ft.CreateFromMorphTargetSequence(u,i[u],t,r));return h},parseAnimation:function(e,t){if(!e)return console.error("THREE.AnimationClip: No animation in JSONLoader data."),null;for(var r=function(w,y,S,R,B){if(S.length!==0){var P=[],A=[];lt.flattenJSON(S,P,A,R),P.length!==0&&B.push(new w(y,P,A))}},i=[],n=e.name||"default",o=e.length||-1,a=e.fps||30,s=e.hierarchy||[],f=0;f<s.length;f++){var u=s[f].keys;if(!(!u||u.length===0))if(u[0].morphTargets){for(var c={},h=0;h<u.length;h++)if(u[h].morphTargets)for(var l=0;l<u[h].morphTargets.length;l++)c[u[h].morphTargets[l]]=-1;for(var p in c){for(var d=[],m=[],l=0;l!==u[h].morphTargets.length;++l){var v=u[h];d.push(v.time),m.push(v.morphTarget===p?1:0)}i.push(new wi(".morphTargetInfluence["+p+"]",d,m))}o=c.length*(a||1)}else{var g=".bones["+t[f].name+"]";r(Mi,g+".position",u,"pos",i),r(sn,g+".quaternion",u,"rot",i),r(Mi,g+".scale",u,"scl",i)}}if(i.length===0)return null;var b=new Ft(n,o,i);return b}});Object.assign(Ft.prototype,{resetDuration:function(){for(var e=this.tracks,t=0,r=0,i=e.length;r!==i;++r){var n=this.tracks[r];t=Math.max(t,n.times[n.times.length-1])}return this.duration=t,this},trim:function(){for(var e=0;e<this.tracks.length;e++)this.tracks[e].trim(0,this.duration);return this},validate:function(){for(var e=!0,t=0;t<this.tracks.length;t++)e=e&&this.tracks[t].validate();return e},optimize:function(){for(var e=0;e<this.tracks.length;e++)this.tracks[e].optimize();return this}});var cr={enabled:!1,files:{},add:function(e,t){this.enabled!==!1&&(this.files[e]=t)},get:function(e){if(this.enabled!==!1)return this.files[e]},remove:function(e){delete this.files[e]},clear:function(){this.files={}}};function oa(e,t,r){var i=this,n=!1,o=0,a=0,s=void 0;this.onStart=void 0,this.onLoad=e,this.onProgress=t,this.onError=r,this.itemStart=function(f){a++,n===!1&&i.onStart!==void 0&&i.onStart(f,o,a),n=!0},this.itemEnd=function(f){o++,i.onProgress!==void 0&&i.onProgress(f,o,a),o===a&&(n=!1,i.onLoad!==void 0&&i.onLoad())},this.itemError=function(f){i.onError!==void 0&&i.onError(f)},this.resolveURL=function(f){return s?s(f):f},this.setURLModifier=function(f){return s=f,this}}var We=new oa;var er={};function at(e){this.manager=e!==void 0?e:We}Object.assign(at.prototype,{load:function(e,t,r,i){e===void 0&&(e=""),this.path!==void 0&&(e=this.path+e),e=this.manager.resolveURL(e);var n=this,o=cr.get(e);if(o!==void 0)return n.manager.itemStart(e),setTimeout(function(){t&&t(o),n.manager.itemEnd(e)},0),o;if(er[e]!==void 0){er[e].push({onLoad:t,onProgress:r,onError:i});return}var a=/^data:(.*?)(;base64)?,(.*)$/,s=e.match(a);if(s){var f=s[1],u=!!s[2],c=s[3];c=decodeURIComponent(c),u&&(c=atob(c));try{var h,l=(this.responseType||"").toLowerCase();switch(l){case"arraybuffer":case"blob":for(var p=new Uint8Array(c.length),d=0;d<c.length;d++)p[d]=c.charCodeAt(d);l==="blob"?h=new Blob([p.buffer],{type:f}):h=p.buffer;break;case"document":var m=new DOMParser;h=m.parseFromString(c,f);break;case"json":h=JSON.parse(c);break;default:h=c;break}setTimeout(function(){t&&t(h),n.manager.itemEnd(e)},0)}catch(b){setTimeout(function(){i&&i(b),n.manager.itemError(e),n.manager.itemEnd(e)},0)}}else{er[e]=[],er[e].push({onLoad:t,onProgress:r,onError:i});var v=new XMLHttpRequest;v.open("GET",e,!0),v.addEventListener("load",function(b){var w=this.response;cr.add(e,w);var y=er[e];if(delete er[e],this.status===200||this.status===0){this.status===0&&console.warn("THREE.FileLoader: HTTP Status 0 received.");for(var S=0,R=y.length;S<R;S++){var B=y[S];B.onLoad&&B.onLoad(w)}n.manager.itemEnd(e)}else{for(var S=0,R=y.length;S<R;S++){var B=y[S];B.onError&&B.onError(b)}n.manager.itemError(e),n.manager.itemEnd(e)}},!1),v.addEventListener("progress",function(b){for(var w=er[e],y=0,S=w.length;y<S;y++){var R=w[y];R.onProgress&&R.onProgress(b)}},!1),v.addEventListener("error",function(b){var w=er[e];delete er[e];for(var y=0,S=w.length;y<S;y++){var R=w[y];R.onError&&R.onError(b)}n.manager.itemError(e),n.manager.itemEnd(e)},!1),v.addEventListener("abort",function(b){var w=er[e];delete er[e];for(var y=0,S=w.length;y<S;y++){var R=w[y];R.onError&&R.onError(b)}n.manager.itemError(e),n.manager.itemEnd(e)},!1),this.responseType!==void 0&&(v.responseType=this.responseType),this.withCredentials!==void 0&&(v.withCredentials=this.withCredentials),v.overrideMimeType&&v.overrideMimeType(this.mimeType!==void 0?this.mimeType:"text/plain");for(var g in this.requestHeader)v.setRequestHeader(g,this.requestHeader[g]);v.send(null)}return n.manager.itemStart(e),v},setPath:function(e){return this.path=e,this},setResponseType:function(e){return this.responseType=e,this},setWithCredentials:function(e){return this.withCredentials=e,this},setMimeType:function(e){return this.mimeType=e,this},setRequestHeader:function(e){return this.requestHeader=e,this}});function Dh(e){this.manager=e!==void 0?e:We}Object.assign(Dh.prototype,{load:function(e,t,r,i){var n=this,o=new at(n.manager);o.setPath(n.path),o.load(e,function(a){t(n.parse(JSON.parse(a)))},r,i)},parse:function(e,t){for(var r=[],i=0;i<e.length;i++){var n=Ft.parse(e[i]);r.push(n)}t(r)},setPath:function(e){return this.path=e,this}});function Ih(e){this.manager=e!==void 0?e:We,this._parser=null}Object.assign(Ih.prototype,{load:function(e,t,r,i){var n=this,o=[],a=new hi;a.image=o;var s=new at(this.manager);s.setPath(this.path),s.setResponseType("arraybuffer");function f(l){s.load(e[l],function(p){var d=n._parser(p,!0);o[l]={width:d.width,height:d.height,format:d.format,mipmaps:d.mipmaps},u+=1,u===6&&(d.mipmapCount===1&&(a.minFilter=qe),a.format=d.format,a.needsUpdate=!0,t&&t(a))},r,i)}if(Array.isArray(e))for(var u=0,c=0,h=e.length;c<h;++c)f(c);else s.load(e,function(l){var p=n._parser(l,!0);if(p.isCubemap)for(var d=p.mipmaps.length/p.mipmapCount,m=0;m<d;m++){o[m]={mipmaps:[]};for(var v=0;v<p.mipmapCount;v++)o[m].mipmaps.push(p.mipmaps[m*p.mipmapCount+v]),o[m].format=p.format,o[m].width=p.width,o[m].height=p.height}else a.image.width=p.width,a.image.height=p.height,a.mipmaps=p.mipmaps;p.mipmapCount===1&&(a.minFilter=qe),a.format=p.format,a.needsUpdate=!0,t&&t(a)},r,i);return a},setPath:function(e){return this.path=e,this}});function qa(e){this.manager=e!==void 0?e:We,this._parser=null}Object.assign(qa.prototype,{load:function(e,t,r,i){var n=this,o=new br,a=new at(this.manager);return a.setResponseType("arraybuffer"),a.setPath(this.path),a.load(e,function(s){var f=n._parser(s);f&&(f.image!==void 0?o.image=f.image:f.data!==void 0&&(o.image.width=f.width,o.image.height=f.height,o.image.data=f.data),o.wrapS=f.wrapS!==void 0?f.wrapS:vt,o.wrapT=f.wrapT!==void 0?f.wrapT:vt,o.magFilter=f.magFilter!==void 0?f.magFilter:qe,o.minFilter=f.minFilter!==void 0?f.minFilter:Pr,o.anisotropy=f.anisotropy!==void 0?f.anisotropy:1,f.format!==void 0&&(o.format=f.format),f.type!==void 0&&(o.type=f.type),f.mipmaps!==void 0&&(o.mipmaps=f.mipmaps),f.mipmapCount===1&&(o.minFilter=qe),o.needsUpdate=!0,t&&t(o,f))},r,i),o},setPath:function(e){return this.path=e,this}});function Qr(e){this.manager=e!==void 0?e:We}Object.assign(Qr.prototype,{crossOrigin:"anonymous",load:function(e,t,r,i){e===void 0&&(e=""),this.path!==void 0&&(e=this.path+e),e=this.manager.resolveURL(e);var n=this,o=cr.get(e);if(o!==void 0)return n.manager.itemStart(e),setTimeout(function(){t&&t(o),n.manager.itemEnd(e)},0),o;var a=document.createElementNS("http://www.w3.org/1999/xhtml","img");function s(){a.removeEventListener("load",s,!1),a.removeEventListener("error",f,!1),cr.add(e,this),t&&t(this),n.manager.itemEnd(e)}function f(u){a.removeEventListener("load",s,!1),a.removeEventListener("error",f,!1),i&&i(u),n.manager.itemError(e),n.manager.itemEnd(e)}return a.addEventListener("load",s,!1),a.addEventListener("error",f,!1),e.substr(0,5)!=="data:"&&this.crossOrigin!==void 0&&(a.crossOrigin=this.crossOrigin),n.manager.itemStart(e),a.src=e,a},setCrossOrigin:function(e){return this.crossOrigin=e,this},setPath:function(e){return this.path=e,this}});function aa(e){this.manager=e!==void 0?e:We}Object.assign(aa.prototype,{crossOrigin:"anonymous",load:function(e,t,r,i){var n=new Wt,o=new Qr(this.manager);o.setCrossOrigin(this.crossOrigin),o.setPath(this.path);var a=0;function s(u){o.load(e[u],function(c){n.images[u]=c,a++,a===6&&(n.needsUpdate=!0,t&&t(n))},void 0,i)}for(var f=0;f<e.length;++f)s(f);return n},setCrossOrigin:function(e){return this.crossOrigin=e,this},setPath:function(e){return this.path=e,this}});function fn(e){this.manager=e!==void 0?e:We}Object.assign(fn.prototype,{crossOrigin:"anonymous",load:function(e,t,r,i){var n=new _e,o=new Qr(this.manager);return o.setCrossOrigin(this.crossOrigin),o.setPath(this.path),o.load(e,function(a){n.image=a;var s=e.search(/\.jpe?g($|\?)/i)>0||e.search(/^data\:image\/jpeg/)===0;n.format=s?Ot:wt,n.needsUpdate=!0,t!==void 0&&t(n)},r,i),n},setCrossOrigin:function(e){return this.crossOrigin=e,this},setPath:function(e){return this.path=e,this}});function ne(){this.type="Curve",this.arcLengthDivisions=200}Object.assign(ne.prototype,{getPoint:function(){return console.warn("THREE.Curve: .getPoint() not implemented."),null},getPointAt:function(e,t){var r=this.getUtoTmapping(e);return this.getPoint(r,t)},getPoints:function(e){e===void 0&&(e=5);for(var t=[],r=0;r<=e;r++)t.push(this.getPoint(r/e));return t},getSpacedPoints:function(e){e===void 0&&(e=5);for(var t=[],r=0;r<=e;r++)t.push(this.getPointAt(r/e));return t},getLength:function(){var e=this.getLengths();return e[e.length-1]},getLengths:function(e){if(e===void 0&&(e=this.arcLengthDivisions),this.cacheArcLengths&&this.cacheArcLengths.length===e+1&&!this.needsUpdate)return this.cacheArcLengths;this.needsUpdate=!1;var t=[],r,i=this.getPoint(0),n,o=0;for(t.push(0),n=1;n<=e;n++)r=this.getPoint(n/e),o+=r.distanceTo(i),t.push(o),i=r;return this.cacheArcLengths=t,t},updateArcLengths:function(){this.needsUpdate=!0,this.getLengths()},getUtoTmapping:function(e,t){var r=this.getLengths(),i=0,n=r.length,o;t?o=t:o=e*r[n-1];for(var a=0,s=n-1,f;a<=s;)if(i=Math.floor(a+(s-a)/2),f=r[i]-o,f<0)a=i+1;else if(f>0)s=i-1;else{s=i;break}if(i=s,r[i]===o)return i/(n-1);var u=r[i],c=r[i+1],h=c-u,l=(o-u)/h,p=(i+l)/(n-1);return p},getTangent:function(e){var t=1e-4,r=e-t,i=e+t;r<0&&(r=0),i>1&&(i=1);var n=this.getPoint(r),o=this.getPoint(i),a=o.clone().sub(n);return a.normalize()},getTangentAt:function(e){var t=this.getUtoTmapping(e);return this.getTangent(t)},computeFrenetFrames:function(e,t){var r=new x,i=[],n=[],o=[],a=new x,s=new ee,f,u,c;for(f=0;f<=e;f++)u=f/e,i[f]=this.getTangentAt(u),i[f].normalize();n[0]=new x,o[0]=new x;var h=Number.MAX_VALUE,l=Math.abs(i[0].x),p=Math.abs(i[0].y),d=Math.abs(i[0].z);for(l<=h&&(h=l,r.set(1,0,0)),p<=h&&(h=p,r.set(0,1,0)),d<=h&&r.set(0,0,1),a.crossVectors(i[0],r).normalize(),n[0].crossVectors(i[0],a),o[0].crossVectors(i[0],n[0]),f=1;f<=e;f++)n[f]=n[f-1].clone(),o[f]=o[f-1].clone(),a.crossVectors(i[f-1],i[f]),a.length()>Number.EPSILON&&(a.normalize(),c=Math.acos(ie.clamp(i[f-1].dot(i[f]),-1,1)),n[f].applyMatrix4(s.makeRotationAxis(a,c))),o[f].crossVectors(i[f],n[f]);if(t===!0)for(c=Math.acos(ie.clamp(n[0].dot(n[e]),-1,1)),c/=e,i[0].dot(a.crossVectors(n[0],n[e]))>0&&(c=-c),f=1;f<=e;f++)n[f].applyMatrix4(s.makeRotationAxis(i[f],c*f)),o[f].crossVectors(i[f],n[f]);return{tangents:i,normals:n,binormals:o}},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.arcLengthDivisions=e.arcLengthDivisions,this},toJSON:function(){var e={metadata:{version:4.5,type:"Curve",generator:"Curve.toJSON"}};return e.arcLengthDivisions=this.arcLengthDivisions,e.type=this.type,e},fromJSON:function(e){return this.arcLengthDivisions=e.arcLengthDivisions,this}});var no={};Ta(no,{ArcCurve:()=>un,CatmullRomCurve3:()=>xt,CubicBezierCurve:()=>qt,CubicBezierCurve3:()=>hr,EllipseCurve:()=>At,LineCurve:()=>Tt,LineCurve3:()=>tr,QuadraticBezierCurve:()=>Yt,QuadraticBezierCurve3:()=>lr,SplineCurve:()=>Zt});function At(e,t,r,i,n,o,a,s){ne.call(this),this.type="EllipseCurve",this.aX=e||0,this.aY=t||0,this.xRadius=r||1,this.yRadius=i||1,this.aStartAngle=n||0,this.aEndAngle=o||2*Math.PI,this.aClockwise=a||!1,this.aRotation=s||0}At.prototype=Object.create(ne.prototype);At.prototype.constructor=At;At.prototype.isEllipseCurve=!0;At.prototype.getPoint=function(e,t){for(var r=t||new O,i=Math.PI*2,n=this.aEndAngle-this.aStartAngle,o=Math.abs(n)<Number.EPSILON;n<0;)n+=i;for(;n>i;)n-=i;n<Number.EPSILON&&(o?n=0:n=i),this.aClockwise===!0&&!o&&(n===i?n=-i:n=n-i);var a=this.aStartAngle+e*n,s=this.aX+this.xRadius*Math.cos(a),f=this.aY+this.yRadius*Math.sin(a);if(this.aRotation!==0){var u=Math.cos(this.aRotation),c=Math.sin(this.aRotation),h=s-this.aX,l=f-this.aY;s=h*u-l*c+this.aX,f=h*c+l*u+this.aY}return r.set(s,f)};At.prototype.copy=function(e){return ne.prototype.copy.call(this,e),this.aX=e.aX,this.aY=e.aY,this.xRadius=e.xRadius,this.yRadius=e.yRadius,this.aStartAngle=e.aStartAngle,this.aEndAngle=e.aEndAngle,this.aClockwise=e.aClockwise,this.aRotation=e.aRotation,this};At.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);return e.aX=this.aX,e.aY=this.aY,e.xRadius=this.xRadius,e.yRadius=this.yRadius,e.aStartAngle=this.aStartAngle,e.aEndAngle=this.aEndAngle,e.aClockwise=this.aClockwise,e.aRotation=this.aRotation,e};At.prototype.fromJSON=function(e){return ne.prototype.fromJSON.call(this,e),this.aX=e.aX,this.aY=e.aY,this.xRadius=e.xRadius,this.yRadius=e.yRadius,this.aStartAngle=e.aStartAngle,this.aEndAngle=e.aEndAngle,this.aClockwise=e.aClockwise,this.aRotation=e.aRotation,this};function un(e,t,r,i,n,o){At.call(this,e,t,r,r,i,n,o),this.type="ArcCurve"}un.prototype=Object.create(At.prototype);un.prototype.constructor=un;un.prototype.isArcCurve=!0;function Qa(){var e=0,t=0,r=0,i=0;function n(o,a,s,f){e=o,t=s,r=-3*o+3*a-2*s-f,i=2*o-2*a+s+f}return{initCatmullRom:function(o,a,s,f,u){n(a,s,u*(s-o),u*(f-a))},initNonuniformCatmullRom:function(o,a,s,f,u,c,h){var l=(a-o)/u-(s-o)/(u+c)+(s-a)/c,p=(s-a)/c-(f-a)/(c+h)+(f-s)/h;l*=c,p*=c,n(a,s,l,p)},calc:function(o){var a=o*o,s=a*o;return e+t*o+r*a+i*s}}}var sa=new x,Ya=new Qa,Za=new Qa,Ja=new Qa;function xt(e,t,r,i){ne.call(this),this.type="CatmullRomCurve3",this.points=e||[],this.closed=t||!1,this.curveType=r||"centripetal",this.tension=i||.5}xt.prototype=Object.create(ne.prototype);xt.prototype.constructor=xt;xt.prototype.isCatmullRomCurve3=!0;xt.prototype.getPoint=function(e,t){var r=t||new x,i=this.points,n=i.length,o=(n-(this.closed?0:1))*e,a=Math.floor(o),s=o-a;this.closed?a+=a>0?0:(Math.floor(Math.abs(a)/n)+1)*n:s===0&&a===n-1&&(a=n-2,s=1);var f,u,c,h;if(this.closed||a>0?f=i[(a-1)%n]:(sa.subVectors(i[0],i[1]).add(i[0]),f=sa),u=i[a%n],c=i[(a+1)%n],this.closed||a+2<n?h=i[(a+2)%n]:(sa.subVectors(i[n-1],i[n-2]).add(i[n-1]),h=sa),this.curveType==="centripetal"||this.curveType==="chordal"){var l=this.curveType==="chordal"?.5:.25,p=Math.pow(f.distanceToSquared(u),l),d=Math.pow(u.distanceToSquared(c),l),m=Math.pow(c.distanceToSquared(h),l);d<1e-4&&(d=1),p<1e-4&&(p=d),m<1e-4&&(m=d),Ya.initNonuniformCatmullRom(f.x,u.x,c.x,h.x,p,d,m),Za.initNonuniformCatmullRom(f.y,u.y,c.y,h.y,p,d,m),Ja.initNonuniformCatmullRom(f.z,u.z,c.z,h.z,p,d,m)}else this.curveType==="catmullrom"&&(Ya.initCatmullRom(f.x,u.x,c.x,h.x,this.tension),Za.initCatmullRom(f.y,u.y,c.y,h.y,this.tension),Ja.initCatmullRom(f.z,u.z,c.z,h.z,this.tension));return r.set(Ya.calc(s),Za.calc(s),Ja.calc(s)),r};xt.prototype.copy=function(e){ne.prototype.copy.call(this,e),this.points=[];for(var t=0,r=e.points.length;t<r;t++){var i=e.points[t];this.points.push(i.clone())}return this.closed=e.closed,this.curveType=e.curveType,this.tension=e.tension,this};xt.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);e.points=[];for(var t=0,r=this.points.length;t<r;t++){var i=this.points[t];e.points.push(i.toArray())}return e.closed=this.closed,e.curveType=this.curveType,e.tension=this.tension,e};xt.prototype.fromJSON=function(e){ne.prototype.fromJSON.call(this,e),this.points=[];for(var t=0,r=e.points.length;t<r;t++){var i=e.points[t];this.points.push(new x().fromArray(i))}return this.closed=e.closed,this.curveType=e.curveType,this.tension=e.tension,this};function Ka(e,t,r,i,n){var o=(i-t)*.5,a=(n-r)*.5,s=e*e,f=e*s;return(2*r-2*i+o+a)*f+(-3*r+3*i-2*o-a)*s+o*e+r}function lp(e,t){var r=1-e;return r*r*t}function pp(e,t){return 2*(1-e)*e*t}function dp(e,t){return e*e*t}function Ei(e,t,r,i){return lp(e,t)+pp(e,r)+dp(e,i)}function mp(e,t){var r=1-e;return r*r*r*t}function vp(e,t){var r=1-e;return 3*r*r*e*t}function gp(e,t){return 3*(1-e)*e*e*t}function yp(e,t){return e*e*e*t}function Ti(e,t,r,i,n){return mp(e,t)+vp(e,r)+gp(e,i)+yp(e,n)}function qt(e,t,r,i){ne.call(this),this.type="CubicBezierCurve",this.v0=e||new O,this.v1=t||new O,this.v2=r||new O,this.v3=i||new O}qt.prototype=Object.create(ne.prototype);qt.prototype.constructor=qt;qt.prototype.isCubicBezierCurve=!0;qt.prototype.getPoint=function(e,t){var r=t||new O,i=this.v0,n=this.v1,o=this.v2,a=this.v3;return r.set(Ti(e,i.x,n.x,o.x,a.x),Ti(e,i.y,n.y,o.y,a.y)),r};qt.prototype.copy=function(e){return ne.prototype.copy.call(this,e),this.v0.copy(e.v0),this.v1.copy(e.v1),this.v2.copy(e.v2),this.v3.copy(e.v3),this};qt.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);return e.v0=this.v0.toArray(),e.v1=this.v1.toArray(),e.v2=this.v2.toArray(),e.v3=this.v3.toArray(),e};qt.prototype.fromJSON=function(e){return ne.prototype.fromJSON.call(this,e),this.v0.fromArray(e.v0),this.v1.fromArray(e.v1),this.v2.fromArray(e.v2),this.v3.fromArray(e.v3),this};function hr(e,t,r,i){ne.call(this),this.type="CubicBezierCurve3",this.v0=e||new x,this.v1=t||new x,this.v2=r||new x,this.v3=i||new x}hr.prototype=Object.create(ne.prototype);hr.prototype.constructor=hr;hr.prototype.isCubicBezierCurve3=!0;hr.prototype.getPoint=function(e,t){var r=t||new x,i=this.v0,n=this.v1,o=this.v2,a=this.v3;return r.set(Ti(e,i.x,n.x,o.x,a.x),Ti(e,i.y,n.y,o.y,a.y),Ti(e,i.z,n.z,o.z,a.z)),r};hr.prototype.copy=function(e){return ne.prototype.copy.call(this,e),this.v0.copy(e.v0),this.v1.copy(e.v1),this.v2.copy(e.v2),this.v3.copy(e.v3),this};hr.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);return e.v0=this.v0.toArray(),e.v1=this.v1.toArray(),e.v2=this.v2.toArray(),e.v3=this.v3.toArray(),e};hr.prototype.fromJSON=function(e){return ne.prototype.fromJSON.call(this,e),this.v0.fromArray(e.v0),this.v1.fromArray(e.v1),this.v2.fromArray(e.v2),this.v3.fromArray(e.v3),this};function Tt(e,t){ne.call(this),this.type="LineCurve",this.v1=e||new O,this.v2=t||new O}Tt.prototype=Object.create(ne.prototype);Tt.prototype.constructor=Tt;Tt.prototype.isLineCurve=!0;Tt.prototype.getPoint=function(e,t){var r=t||new O;return e===1?r.copy(this.v2):(r.copy(this.v2).sub(this.v1),r.multiplyScalar(e).add(this.v1)),r};Tt.prototype.getPointAt=function(e,t){return this.getPoint(e,t)};Tt.prototype.getTangent=function(){var e=this.v2.clone().sub(this.v1);return e.normalize()};Tt.prototype.copy=function(e){return ne.prototype.copy.call(this,e),this.v1.copy(e.v1),this.v2.copy(e.v2),this};Tt.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);return e.v1=this.v1.toArray(),e.v2=this.v2.toArray(),e};Tt.prototype.fromJSON=function(e){return ne.prototype.fromJSON.call(this,e),this.v1.fromArray(e.v1),this.v2.fromArray(e.v2),this};function tr(e,t){ne.call(this),this.type="LineCurve3",this.v1=e||new x,this.v2=t||new x}tr.prototype=Object.create(ne.prototype);tr.prototype.constructor=tr;tr.prototype.isLineCurve3=!0;tr.prototype.getPoint=function(e,t){var r=t||new x;return e===1?r.copy(this.v2):(r.copy(this.v2).sub(this.v1),r.multiplyScalar(e).add(this.v1)),r};tr.prototype.getPointAt=function(e,t){return this.getPoint(e,t)};tr.prototype.copy=function(e){return ne.prototype.copy.call(this,e),this.v1.copy(e.v1),this.v2.copy(e.v2),this};tr.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);return e.v1=this.v1.toArray(),e.v2=this.v2.toArray(),e};tr.prototype.fromJSON=function(e){return ne.prototype.fromJSON.call(this,e),this.v1.fromArray(e.v1),this.v2.fromArray(e.v2),this};function Yt(e,t,r){ne.call(this),this.type="QuadraticBezierCurve",this.v0=e||new O,this.v1=t||new O,this.v2=r||new O}Yt.prototype=Object.create(ne.prototype);Yt.prototype.constructor=Yt;Yt.prototype.isQuadraticBezierCurve=!0;Yt.prototype.getPoint=function(e,t){var r=t||new O,i=this.v0,n=this.v1,o=this.v2;return r.set(Ei(e,i.x,n.x,o.x),Ei(e,i.y,n.y,o.y)),r};Yt.prototype.copy=function(e){return ne.prototype.copy.call(this,e),this.v0.copy(e.v0),this.v1.copy(e.v1),this.v2.copy(e.v2),this};Yt.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);return e.v0=this.v0.toArray(),e.v1=this.v1.toArray(),e.v2=this.v2.toArray(),e};Yt.prototype.fromJSON=function(e){return ne.prototype.fromJSON.call(this,e),this.v0.fromArray(e.v0),this.v1.fromArray(e.v1),this.v2.fromArray(e.v2),this};function lr(e,t,r){ne.call(this),this.type="QuadraticBezierCurve3",this.v0=e||new x,this.v1=t||new x,this.v2=r||new x}lr.prototype=Object.create(ne.prototype);lr.prototype.constructor=lr;lr.prototype.isQuadraticBezierCurve3=!0;lr.prototype.getPoint=function(e,t){var r=t||new x,i=this.v0,n=this.v1,o=this.v2;return r.set(Ei(e,i.x,n.x,o.x),Ei(e,i.y,n.y,o.y),Ei(e,i.z,n.z,o.z)),r};lr.prototype.copy=function(e){return ne.prototype.copy.call(this,e),this.v0.copy(e.v0),this.v1.copy(e.v1),this.v2.copy(e.v2),this};lr.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);return e.v0=this.v0.toArray(),e.v1=this.v1.toArray(),e.v2=this.v2.toArray(),e};lr.prototype.fromJSON=function(e){return ne.prototype.fromJSON.call(this,e),this.v0.fromArray(e.v0),this.v1.fromArray(e.v1),this.v2.fromArray(e.v2),this};function Zt(e){ne.call(this),this.type="SplineCurve",this.points=e||[]}Zt.prototype=Object.create(ne.prototype);Zt.prototype.constructor=Zt;Zt.prototype.isSplineCurve=!0;Zt.prototype.getPoint=function(e,t){var r=t||new O,i=this.points,n=(i.length-1)*e,o=Math.floor(n),a=n-o,s=i[o===0?o:o-1],f=i[o],u=i[o>i.length-2?i.length-1:o+1],c=i[o>i.length-3?i.length-1:o+2];return r.set(Ka(a,s.x,f.x,u.x,c.x),Ka(a,s.y,f.y,u.y,c.y)),r};Zt.prototype.copy=function(e){ne.prototype.copy.call(this,e),this.points=[];for(var t=0,r=e.points.length;t<r;t++){var i=e.points[t];this.points.push(i.clone())}return this};Zt.prototype.toJSON=function(){var e=ne.prototype.toJSON.call(this);e.points=[];for(var t=0,r=this.points.length;t<r;t++){var i=this.points[t];e.points.push(i.toArray())}return e};Zt.prototype.fromJSON=function(e){ne.prototype.fromJSON.call(this,e),this.points=[];for(var t=0,r=e.points.length;t<r;t++){var i=e.points[t];this.points.push(new O().fromArray(i))}return this};function rr(){ne.call(this),this.type="CurvePath",this.curves=[],this.autoClose=!1}rr.prototype=Object.assign(Object.create(ne.prototype),{constructor:rr,add:function(e){this.curves.push(e)},closePath:function(){var e=this.curves[0].getPoint(0),t=this.curves[this.curves.length-1].getPoint(1);e.equals(t)||this.curves.push(new Tt(t,e))},getPoint:function(e){for(var t=e*this.getLength(),r=this.getCurveLengths(),i=0;i<r.length;){if(r[i]>=t){var n=r[i]-t,o=this.curves[i],a=o.getLength(),s=a===0?0:1-n/a;return o.getPointAt(s)}i++}return null},getLength:function(){var e=this.getCurveLengths();return e[e.length-1]},updateArcLengths:function(){this.needsUpdate=!0,this.cacheLengths=null,this.getCurveLengths()},getCurveLengths:function(){if(this.cacheLengths&&this.cacheLengths.length===this.curves.length)return this.cacheLengths;for(var e=[],t=0,r=0,i=this.curves.length;r<i;r++)t+=this.curves[r].getLength(),e.push(t);return this.cacheLengths=e,e},getSpacedPoints:function(e){e===void 0&&(e=40);for(var t=[],r=0;r<=e;r++)t.push(this.getPoint(r/e));return this.autoClose&&t.push(t[0]),t},getPoints:function(e){e=e||12;for(var t=[],r,i=0,n=this.curves;i<n.length;i++)for(var o=n[i],a=o&&o.isEllipseCurve?e*2:o&&(o.isLineCurve||o.isLineCurve3)?1:o&&o.isSplineCurve?e*o.points.length:e,s=o.getPoints(a),f=0;f<s.length;f++){var u=s[f];r&&r.equals(u)||(t.push(u),r=u)}return this.autoClose&&t.length>1&&!t[t.length-1].equals(t[0])&&t.push(t[0]),t},copy:function(e){ne.prototype.copy.call(this,e),this.curves=[];for(var t=0,r=e.curves.length;t<r;t++){var i=e.curves[t];this.curves.push(i.clone())}return this.autoClose=e.autoClose,this},toJSON:function(){var e=ne.prototype.toJSON.call(this);e.autoClose=this.autoClose,e.curves=[];for(var t=0,r=this.curves.length;t<r;t++){var i=this.curves[t];e.curves.push(i.toJSON())}return e},fromJSON:function(e){ne.prototype.fromJSON.call(this,e),this.autoClose=e.autoClose,this.curves=[];for(var t=0,r=e.curves.length;t<r;t++){var i=e.curves[t];this.curves.push(new no[i.type]().fromJSON(i))}return this}});function Dt(e){rr.call(this),this.type="Path",this.currentPoint=new O,e&&this.setFromPoints(e)}Dt.prototype=Object.assign(Object.create(rr.prototype),{constructor:Dt,setFromPoints:function(e){this.moveTo(e[0].x,e[0].y);for(var t=1,r=e.length;t<r;t++)this.lineTo(e[t].x,e[t].y)},moveTo:function(e,t){this.currentPoint.set(e,t)},lineTo:function(e,t){var r=new Tt(this.currentPoint.clone(),new O(e,t));this.curves.push(r),this.currentPoint.set(e,t)},quadraticCurveTo:function(e,t,r,i){var n=new Yt(this.currentPoint.clone(),new O(e,t),new O(r,i));this.curves.push(n),this.currentPoint.set(r,i)},bezierCurveTo:function(e,t,r,i,n,o){var a=new qt(this.currentPoint.clone(),new O(e,t),new O(r,i),new O(n,o));this.curves.push(a),this.currentPoint.set(n,o)},splineThru:function(e){var t=[this.currentPoint.clone()].concat(e),r=new Zt(t);this.curves.push(r),this.currentPoint.copy(e[e.length-1])},arc:function(e,t,r,i,n,o){var a=this.currentPoint.x,s=this.currentPoint.y;this.absarc(e+a,t+s,r,i,n,o)},absarc:function(e,t,r,i,n,o){this.absellipse(e,t,r,r,i,n,o)},ellipse:function(e,t,r,i,n,o,a,s){var f=this.currentPoint.x,u=this.currentPoint.y;this.absellipse(e+f,t+u,r,i,n,o,a,s)},absellipse:function(e,t,r,i,n,o,a,s){var f=new At(e,t,r,i,n,o,a,s);if(this.curves.length>0){var u=f.getPoint(0);u.equals(this.currentPoint)||this.lineTo(u.x,u.y)}this.curves.push(f);var c=f.getPoint(1);this.currentPoint.copy(c)},copy:function(e){return rr.prototype.copy.call(this,e),this.currentPoint.copy(e.currentPoint),this},toJSON:function(){var e=rr.prototype.toJSON.call(this);return e.currentPoint=this.currentPoint.toArray(),e},fromJSON:function(e){return rr.prototype.fromJSON.call(this,e),this.currentPoint.fromArray(e.currentPoint),this}});function ir(e){Dt.call(this,e),this.uuid=ie.generateUUID(),this.type="Shape",this.holes=[]}ir.prototype=Object.assign(Object.create(Dt.prototype),{constructor:ir,getPointsHoles:function(e){for(var t=[],r=0,i=this.holes.length;r<i;r++)t[r]=this.holes[r].getPoints(e);return t},extractPoints:function(e){return{shape:this.getPoints(e),holes:this.getPointsHoles(e)}},copy:function(e){Dt.prototype.copy.call(this,e),this.holes=[];for(var t=0,r=e.holes.length;t<r;t++){var i=e.holes[t];this.holes.push(i.clone())}return this},toJSON:function(){var e=Dt.prototype.toJSON.call(this);e.uuid=this.uuid,e.holes=[];for(var t=0,r=this.holes.length;t<r;t++){var i=this.holes[t];e.holes.push(i.toJSON())}return e},fromJSON:function(e){Dt.prototype.fromJSON.call(this,e),this.uuid=e.uuid,this.holes=[];for(var t=0,r=e.holes.length;t<r;t++){var i=e.holes[t];this.holes.push(new Dt().fromJSON(i))}return this}});function Ue(e,t){k.call(this),this.type="Light",this.color=new J(e),this.intensity=t!==void 0?t:1,this.receiveShadow=void 0}Ue.prototype=Object.assign(Object.create(k.prototype),{constructor:Ue,isLight:!0,copy:function(e){return k.prototype.copy.call(this,e),this.color.copy(e.color),this.intensity=e.intensity,this},toJSON:function(e){var t=k.prototype.toJSON.call(this,e);return t.object.color=this.color.getHex(),t.object.intensity=this.intensity,this.groundColor!==void 0&&(t.object.groundColor=this.groundColor.getHex()),this.distance!==void 0&&(t.object.distance=this.distance),this.angle!==void 0&&(t.object.angle=this.angle),this.decay!==void 0&&(t.object.decay=this.decay),this.penumbra!==void 0&&(t.object.penumbra=this.penumbra),this.shadow!==void 0&&(t.object.shadow=this.shadow.toJSON()),t}});function oo(e,t,r){Ue.call(this,e,r),this.type="HemisphereLight",this.castShadow=void 0,this.position.copy(k.DefaultUp),this.updateMatrix(),this.groundColor=new J(t)}oo.prototype=Object.assign(Object.create(Ue.prototype),{constructor:oo,isHemisphereLight:!0,copy:function(e){return Ue.prototype.copy.call(this,e),this.groundColor.copy(e.groundColor),this}});function pr(e){this.camera=e,this.bias=0,this.radius=1,this.mapSize=new O(512,512),this.map=null,this.matrix=new ee}Object.assign(pr.prototype,{copy:function(e){return this.camera=e.camera.clone(),this.bias=e.bias,this.radius=e.radius,this.mapSize.copy(e.mapSize),this},clone:function(){return new this.constructor().copy(this)},toJSON:function(){var e={};return this.bias!==0&&(e.bias=this.bias),this.radius!==1&&(e.radius=this.radius),(this.mapSize.x!==512||this.mapSize.y!==512)&&(e.mapSize=this.mapSize.toArray()),e.camera=this.camera.toJSON(!1).object,delete e.camera.matrix,e}});function ao(){pr.call(this,new De(50,1,.5,500))}ao.prototype=Object.assign(Object.create(pr.prototype),{constructor:ao,isSpotLightShadow:!0,update:function(e){var t=this.camera,r=ie.RAD2DEG*2*e.angle,i=this.mapSize.width/this.mapSize.height,n=e.distance||t.far;(r!==t.fov||i!==t.aspect||n!==t.far)&&(t.fov=r,t.aspect=i,t.far=n,t.updateProjectionMatrix())}});function so(e,t,r,i,n,o){Ue.call(this,e,t),this.type="SpotLight",this.position.copy(k.DefaultUp),this.updateMatrix(),this.target=new k,Object.defineProperty(this,"power",{get:function(){return this.intensity*Math.PI},set:function(a){this.intensity=a/Math.PI}}),this.distance=r!==void 0?r:0,this.angle=i!==void 0?i:Math.PI/3,this.penumbra=n!==void 0?n:0,this.decay=o!==void 0?o:1,this.shadow=new ao}so.prototype=Object.assign(Object.create(Ue.prototype),{constructor:so,isSpotLight:!0,copy:function(e){return Ue.prototype.copy.call(this,e),this.distance=e.distance,this.angle=e.angle,this.penumbra=e.penumbra,this.decay=e.decay,this.target=e.target.clone(),this.shadow=e.shadow.clone(),this}});function fo(e,t,r,i){Ue.call(this,e,t),this.type="PointLight",Object.defineProperty(this,"power",{get:function(){return this.intensity*4*Math.PI},set:function(n){this.intensity=n/(4*Math.PI)}}),this.distance=r!==void 0?r:0,this.decay=i!==void 0?i:1,this.shadow=new pr(new De(90,1,.5,500))}fo.prototype=Object.assign(Object.create(Ue.prototype),{constructor:fo,isPointLight:!0,copy:function(e){return Ue.prototype.copy.call(this,e),this.distance=e.distance,this.decay=e.decay,this.shadow=e.shadow.clone(),this}});function dr(e,t,r,i,n,o){Nt.call(this),this.type="OrthographicCamera",this.zoom=1,this.view=null,this.left=e!==void 0?e:-1,this.right=t!==void 0?t:1,this.top=r!==void 0?r:1,this.bottom=i!==void 0?i:-1,this.near=n!==void 0?n:.1,this.far=o!==void 0?o:2e3,this.updateProjectionMatrix()}dr.prototype=Object.assign(Object.create(Nt.prototype),{constructor:dr,isOrthographicCamera:!0,copy:function(e,t){return Nt.prototype.copy.call(this,e,t),this.left=e.left,this.right=e.right,this.top=e.top,this.bottom=e.bottom,this.near=e.near,this.far=e.far,this.zoom=e.zoom,this.view=e.view===null?null:Object.assign({},e.view),this},setViewOffset:function(e,t,r,i,n,o){this.view===null&&(this.view={enabled:!0,fullWidth:1,fullHeight:1,offsetX:0,offsetY:0,width:1,height:1}),this.view.enabled=!0,this.view.fullWidth=e,this.view.fullHeight=t,this.view.offsetX=r,this.view.offsetY=i,this.view.width=n,this.view.height=o,this.updateProjectionMatrix()},clearViewOffset:function(){this.view!==null&&(this.view.enabled=!1),this.updateProjectionMatrix()},updateProjectionMatrix:function(){var e=(this.right-this.left)/(2*this.zoom),t=(this.top-this.bottom)/(2*this.zoom),r=(this.right+this.left)/2,i=(this.top+this.bottom)/2,n=r-e,o=r+e,a=i+t,s=i-t;if(this.view!==null&&this.view.enabled){var f=this.zoom/(this.view.width/this.view.fullWidth),u=this.zoom/(this.view.height/this.view.fullHeight),c=(this.right-this.left)/this.view.width,h=(this.top-this.bottom)/this.view.height;n+=c*(this.view.offsetX/f),o=n+c*(this.view.width/f),a-=h*(this.view.offsetY/u),s=a-h*(this.view.height/u)}this.projectionMatrix.makeOrthographic(n,o,a,s,this.near,this.far),this.projectionMatrixInverse.getInverse(this.projectionMatrix)},toJSON:function(e){var t=k.prototype.toJSON.call(this,e);return t.object.zoom=this.zoom,t.object.left=this.left,t.object.right=this.right,t.object.top=this.top,t.object.bottom=this.bottom,t.object.near=this.near,t.object.far=this.far,this.view!==null&&(t.object.view=Object.assign({},this.view)),t}});function uo(){pr.call(this,new dr(-5,5,5,-5,.5,500))}uo.prototype=Object.assign(Object.create(pr.prototype),{constructor:uo});function co(e,t){Ue.call(this,e,t),this.type="DirectionalLight",this.position.copy(k.DefaultUp),this.updateMatrix(),this.target=new k,this.shadow=new uo}co.prototype=Object.assign(Object.create(Ue.prototype),{constructor:co,isDirectionalLight:!0,copy:function(e){return Ue.prototype.copy.call(this,e),this.target=e.target.clone(),this.shadow=e.shadow.clone(),this}});function ho(e,t){Ue.call(this,e,t),this.type="AmbientLight",this.castShadow=void 0}ho.prototype=Object.assign(Object.create(Ue.prototype),{constructor:ho,isAmbientLight:!0});function lo(e,t,r,i){Ue.call(this,e,t),this.type="RectAreaLight",this.width=r!==void 0?r:10,this.height=i!==void 0?i:10}lo.prototype=Object.assign(Object.create(Ue.prototype),{constructor:lo,isRectAreaLight:!0,copy:function(e){return Ue.prototype.copy.call(this,e),this.width=e.width,this.height=e.height,this},toJSON:function(e){var t=Ue.prototype.toJSON.call(this,e);return t.object.width=this.width,t.object.height=this.height,t}});function cn(e){this.manager=e!==void 0?e:We,this.textures={}}Object.assign(cn.prototype,{load:function(e,t,r,i){var n=this,o=new at(n.manager);o.setPath(n.path),o.load(e,function(a){t(n.parse(JSON.parse(a)))},r,i)},parse:function(e){var t=this.textures;function r(f){return t[f]===void 0&&console.warn("THREE.MaterialLoader: Undefined texture",f),t[f]}var i=new ja[e.type];if(e.uuid!==void 0&&(i.uuid=e.uuid),e.name!==void 0&&(i.name=e.name),e.color!==void 0&&i.color.setHex(e.color),e.roughness!==void 0&&(i.roughness=e.roughness),e.metalness!==void 0&&(i.metalness=e.metalness),e.emissive!==void 0&&i.emissive.setHex(e.emissive),e.specular!==void 0&&i.specular.setHex(e.specular),e.shininess!==void 0&&(i.shininess=e.shininess),e.clearCoat!==void 0&&(i.clearCoat=e.clearCoat),e.clearCoatRoughness!==void 0&&(i.clearCoatRoughness=e.clearCoatRoughness),e.vertexColors!==void 0&&(i.vertexColors=e.vertexColors),e.fog!==void 0&&(i.fog=e.fog),e.flatShading!==void 0&&(i.flatShading=e.flatShading),e.blending!==void 0&&(i.blending=e.blending),e.combine!==void 0&&(i.combine=e.combine),e.side!==void 0&&(i.side=e.side),e.opacity!==void 0&&(i.opacity=e.opacity),e.transparent!==void 0&&(i.transparent=e.transparent),e.alphaTest!==void 0&&(i.alphaTest=e.alphaTest),e.depthTest!==void 0&&(i.depthTest=e.depthTest),e.depthWrite!==void 0&&(i.depthWrite=e.depthWrite),e.colorWrite!==void 0&&(i.colorWrite=e.colorWrite),e.wireframe!==void 0&&(i.wireframe=e.wireframe),e.wireframeLinewidth!==void 0&&(i.wireframeLinewidth=e.wireframeLinewidth),e.wireframeLinecap!==void 0&&(i.wireframeLinecap=e.wireframeLinecap),e.wireframeLinejoin!==void 0&&(i.wireframeLinejoin=e.wireframeLinejoin),e.rotation!==void 0&&(i.rotation=e.rotation),e.linewidth!==1&&(i.linewidth=e.linewidth),e.dashSize!==void 0&&(i.dashSize=e.dashSize),e.gapSize!==void 0&&(i.gapSize=e.gapSize),e.scale!==void 0&&(i.scale=e.scale),e.polygonOffset!==void 0&&(i.polygonOffset=e.polygonOffset),e.polygonOffsetFactor!==void 0&&(i.polygonOffsetFactor=e.polygonOffsetFactor),e.polygonOffsetUnits!==void 0&&(i.polygonOffsetUnits=e.polygonOffsetUnits),e.skinning!==void 0&&(i.skinning=e.skinning),e.morphTargets!==void 0&&(i.morphTargets=e.morphTargets),e.dithering!==void 0&&(i.dithering=e.dithering),e.visible!==void 0&&(i.visible=e.visible),e.userData!==void 0&&(i.userData=e.userData),e.uniforms!==void 0)for(var n in e.uniforms){var o=e.uniforms[n];switch(i.uniforms[n]={},o.type){case"t":i.uniforms[n].value=r(o.value);break;case"c":i.uniforms[n].value=new J().setHex(o.value);break;case"v2":i.uniforms[n].value=new O().fromArray(o.value);break;case"v3":i.uniforms[n].value=new x().fromArray(o.value);break;case"v4":i.uniforms[n].value=new we().fromArray(o.value);break;case"m3":i.uniforms[n].value=new Oe().fromArray(o.value);case"m4":i.uniforms[n].value=new ee().fromArray(o.value);break;default:i.uniforms[n].value=o.value}}if(e.defines!==void 0&&(i.defines=e.defines),e.vertexShader!==void 0&&(i.vertexShader=e.vertexShader),e.fragmentShader!==void 0&&(i.fragmentShader=e.fragmentShader),e.extensions!==void 0)for(var a in e.extensions)i.extensions[a]=e.extensions[a];if(e.shading!==void 0&&(i.flatShading=e.shading===1),e.size!==void 0&&(i.size=e.size),e.sizeAttenuation!==void 0&&(i.sizeAttenuation=e.sizeAttenuation),e.map!==void 0&&(i.map=r(e.map)),e.alphaMap!==void 0&&(i.alphaMap=r(e.alphaMap),i.transparent=!0),e.bumpMap!==void 0&&(i.bumpMap=r(e.bumpMap)),e.bumpScale!==void 0&&(i.bumpScale=e.bumpScale),e.normalMap!==void 0&&(i.normalMap=r(e.normalMap)),e.normalMapType!==void 0&&(i.normalMapType=e.normalMapType),e.normalScale!==void 0){var s=e.normalScale;Array.isArray(s)===!1&&(s=[s,s]),i.normalScale=new O().fromArray(s)}return e.displacementMap!==void 0&&(i.displacementMap=r(e.displacementMap)),e.displacementScale!==void 0&&(i.displacementScale=e.displacementScale),e.displacementBias!==void 0&&(i.displacementBias=e.displacementBias),e.roughnessMap!==void 0&&(i.roughnessMap=r(e.roughnessMap)),e.metalnessMap!==void 0&&(i.metalnessMap=r(e.metalnessMap)),e.emissiveMap!==void 0&&(i.emissiveMap=r(e.emissiveMap)),e.emissiveIntensity!==void 0&&(i.emissiveIntensity=e.emissiveIntensity),e.specularMap!==void 0&&(i.specularMap=r(e.specularMap)),e.envMap!==void 0&&(i.envMap=r(e.envMap)),e.envMapIntensity!==void 0&&(i.envMapIntensity=e.envMapIntensity),e.reflectivity!==void 0&&(i.reflectivity=e.reflectivity),e.lightMap!==void 0&&(i.lightMap=r(e.lightMap)),e.lightMapIntensity!==void 0&&(i.lightMapIntensity=e.lightMapIntensity),e.aoMap!==void 0&&(i.aoMap=r(e.aoMap)),e.aoMapIntensity!==void 0&&(i.aoMapIntensity=e.aoMapIntensity),e.gradientMap!==void 0&&(i.gradientMap=r(e.gradientMap)),i},setPath:function(e){return this.path=e,this},setTextures:function(e){return this.textures=e,this}});var po={decodeText:function(e){if(typeof TextDecoder<"u")return new TextDecoder().decode(e);for(var t="",r=0,i=e.length;r<i;r++)t+=String.fromCharCode(e[r]);return decodeURIComponent(escape(t))},extractUrlBase:function(e){var t=e.lastIndexOf("/");return t===-1?"./":e.substr(0,t+1)}};function fa(e){this.manager=e!==void 0?e:We}Object.assign(fa.prototype,{load:function(e,t,r,i){var n=this,o=new at(n.manager);o.setPath(n.path),o.load(e,function(a){t(n.parse(JSON.parse(a)))},r,i)},parse:function(e){var t=new z,r=e.data.index;if(r!==void 0){var i=new Oh[r.type](r.array);t.setIndex(new ye(i,1))}var n=e.data.attributes;for(var o in n){var a=n[o],i=new Oh[a.type](a.array);t.addAttribute(o,new ye(i,a.itemSize,a.normalized))}var s=e.data.groups||e.data.drawcalls||e.data.offsets;if(s!==void 0)for(var f=0,u=s.length;f!==u;++f){var c=s[f];t.addGroup(c.start,c.count,c.materialIndex)}var h=e.data.boundingSphere;if(h!==void 0){var l=new x;h.center!==void 0&&l.fromArray(h.center),t.boundingSphere=new it(l,h.radius)}return e.name&&(t.name=e.name),e.userData&&(t.userData=e.userData),t},setPath:function(e){return this.path=e,this}});var Oh={Int8Array,Uint8Array,Uint8ClampedArray:typeof Uint8ClampedArray<"u"?Uint8ClampedArray:Uint8Array,Int16Array,Uint16Array,Int32Array,Uint32Array,Float32Array,Float64Array};function ua(e){this.manager=e!==void 0?e:We,this.resourcePath=""}Object.assign(ua.prototype,{crossOrigin:"anonymous",load:function(e,t,r,i){var n=this,o=this.path===void 0?po.extractUrlBase(e):this.path;this.resourcePath=this.resourcePath||o;var a=new at(n.manager);a.setPath(this.path),a.load(e,function(s){var f=null;try{f=JSON.parse(s)}catch(c){i!==void 0&&i(c),console.error("THREE:ObjectLoader: Can't parse "+e+".",c.message);return}var u=f.metadata;if(u===void 0||u.type===void 0||u.type.toLowerCase()==="geometry"){console.error("THREE.ObjectLoader: Can't load "+e);return}n.parse(f,t)},r,i)},setPath:function(e){return this.path=e,this},setResourcePath:function(e){return this.resourcePath=e,this},setCrossOrigin:function(e){return this.crossOrigin=e,this},parse:function(e,t){var r=this.parseShape(e.shapes),i=this.parseGeometries(e.geometries,r),n=this.parseImages(e.images,function(){t!==void 0&&t(s)}),o=this.parseTextures(e.textures,n),a=this.parseMaterials(e.materials,o),s=this.parseObject(e.object,i,a);return e.animations&&(s.animations=this.parseAnimations(e.animations)),(e.images===void 0||e.images.length===0)&&t!==void 0&&t(s),s},parseShape:function(e){var t={};if(e!==void 0)for(var r=0,i=e.length;r<i;r++){var n=new ir().fromJSON(e[r]);t[n.uuid]=n}return t},parseGeometries:function(e,t){var r={};if(e!==void 0)for(var i=new fa,n=0,o=e.length;n<o;n++){var a,s=e[n];switch(s.type){case"PlaneGeometry":case"PlaneBufferGeometry":a=new Et[s.type](s.width,s.height,s.widthSegments,s.heightSegments);break;case"BoxGeometry":case"BoxBufferGeometry":case"CubeGeometry":a=new Et[s.type](s.width,s.height,s.depth,s.widthSegments,s.heightSegments,s.depthSegments);break;case"CircleGeometry":case"CircleBufferGeometry":a=new Et[s.type](s.radius,s.segments,s.thetaStart,s.thetaLength);break;case"CylinderGeometry":case"CylinderBufferGeometry":a=new Et[s.type](s.radiusTop,s.radiusBottom,s.height,s.radialSegments,s.heightSegments,s.openEnded,s.thetaStart,s.thetaLength);break;case"ConeGeometry":case"ConeBufferGeometry":a=new Et[s.type](s.radius,s.height,s.radialSegments,s.heightSegments,s.openEnded,s.thetaStart,s.thetaLength);break;case"SphereGeometry":case"SphereBufferGeometry":a=new Et[s.type](s.radius,s.widthSegments,s.heightSegments,s.phiStart,s.phiLength,s.thetaStart,s.thetaLength);break;case"DodecahedronGeometry":case"DodecahedronBufferGeometry":case"IcosahedronGeometry":case"IcosahedronBufferGeometry":case"OctahedronGeometry":case"OctahedronBufferGeometry":case"TetrahedronGeometry":case"TetrahedronBufferGeometry":a=new Et[s.type](s.radius,s.detail);break;case"RingGeometry":case"RingBufferGeometry":a=new Et[s.type](s.innerRadius,s.outerRadius,s.thetaSegments,s.phiSegments,s.thetaStart,s.thetaLength);break;case"TorusGeometry":case"TorusBufferGeometry":a=new Et[s.type](s.radius,s.tube,s.radialSegments,s.tubularSegments,s.arc);break;case"TorusKnotGeometry":case"TorusKnotBufferGeometry":a=new Et[s.type](s.radius,s.tube,s.tubularSegments,s.radialSegments,s.p,s.q);break;case"LatheGeometry":case"LatheBufferGeometry":a=new Et[s.type](s.points,s.segments,s.phiStart,s.phiLength);break;case"PolyhedronGeometry":case"PolyhedronBufferGeometry":a=new Et[s.type](s.vertices,s.indices,s.radius,s.details);break;case"ShapeGeometry":case"ShapeBufferGeometry":for(var h=[],f=0,u=s.shapes.length;f<u;f++){var c=t[s.shapes[f]];h.push(c)}a=new Et[s.type](h,s.curveSegments);break;case"ExtrudeGeometry":case"ExtrudeBufferGeometry":for(var h=[],f=0,u=s.shapes.length;f<u;f++){var c=t[s.shapes[f]];h.push(c)}var l=s.options.extrudePath;l!==void 0&&(s.options.extrudePath=new no[l.type]().fromJSON(l)),a=new Et[s.type](h,s.options);break;case"BufferGeometry":a=i.parse(s);break;case"Geometry":if("THREE"in window&&"LegacyJSONLoader"in THREE){var p=new THREE.LegacyJSONLoader;a=p.parse(s,this.resourcePath).geometry}else console.error('THREE.ObjectLoader: You have to import LegacyJSONLoader in order load geometry data of type "Geometry".');break;default:console.warn('THREE.ObjectLoader: Unsupported geometry type "'+s.type+'"');continue}a.uuid=s.uuid,s.name!==void 0&&(a.name=s.name),a.isBufferGeometry===!0&&s.userData!==void 0&&(a.userData=s.userData),r[s.uuid]=a}return r},parseMaterials:function(e,t){var r={},i={};if(e!==void 0){var n=new cn;n.setTextures(t);for(var o=0,a=e.length;o<a;o++){var s=e[o];if(s.type==="MultiMaterial"){for(var f=[],u=0;u<s.materials.length;u++){var c=s.materials[u];r[c.uuid]===void 0&&(r[c.uuid]=n.parse(c)),f.push(r[c.uuid])}i[s.uuid]=f}else i[s.uuid]=n.parse(s),r[s.uuid]=i[s.uuid]}}return i},parseAnimations:function(e){for(var t=[],r=0;r<e.length;r++){var i=e[r],n=Ft.parse(i);i.uuid!==void 0&&(n.uuid=i.uuid),t.push(n)}return t},parseImages:function(e,t){var r=this,i={};function n(m){return r.manager.itemStart(m),a.load(m,function(){r.manager.itemEnd(m)},void 0,function(){r.manager.itemError(m),r.manager.itemEnd(m)})}if(e!==void 0&&e.length>0){var o=new oa(t),a=new Qr(o);a.setCrossOrigin(this.crossOrigin);for(var s=0,f=e.length;s<f;s++){var u=e[s],c=u.url;if(Array.isArray(c)){i[u.uuid]=[];for(var h=0,l=c.length;h<l;h++){var p=c[h],d=/^(\/\/)|([a-z]+:(\/\/)?)/i.test(p)?p:r.resourcePath+p;i[u.uuid].push(n(d))}}else{var d=/^(\/\/)|([a-z]+:(\/\/)?)/i.test(u.url)?u.url:r.resourcePath+u.url;i[u.uuid]=n(d)}}}return i},parseTextures:function(e,t){function r(f,u){return typeof f=="number"?f:(console.warn("THREE.ObjectLoader.parseTexture: Constant should be in numeric form.",f),u[f])}var i={};if(e!==void 0)for(var n=0,o=e.length;n<o;n++){var a=e[n];a.image===void 0&&console.warn('THREE.ObjectLoader: No "image" specified for',a.uuid),t[a.image]===void 0&&console.warn("THREE.ObjectLoader: Undefined image",a.image);var s;Array.isArray(t[a.image])?s=new Wt(t[a.image]):s=new _e(t[a.image]),s.needsUpdate=!0,s.uuid=a.uuid,a.name!==void 0&&(s.name=a.name),a.mapping!==void 0&&(s.mapping=r(a.mapping,xp)),a.offset!==void 0&&s.offset.fromArray(a.offset),a.repeat!==void 0&&s.repeat.fromArray(a.repeat),a.center!==void 0&&s.center.fromArray(a.center),a.rotation!==void 0&&(s.rotation=a.rotation),a.wrap!==void 0&&(s.wrapS=r(a.wrap[0],Uh),s.wrapT=r(a.wrap[1],Uh)),a.format!==void 0&&(s.format=a.format),a.type!==void 0&&(s.type=a.type),a.encoding!==void 0&&(s.encoding=a.encoding),a.minFilter!==void 0&&(s.minFilter=r(a.minFilter,Nh)),a.magFilter!==void 0&&(s.magFilter=r(a.magFilter,Nh)),a.anisotropy!==void 0&&(s.anisotropy=a.anisotropy),a.flipY!==void 0&&(s.flipY=a.flipY),a.premultiplyAlpha!==void 0&&(s.premultiplyAlpha=a.premultiplyAlpha),a.unpackAlignment!==void 0&&(s.unpackAlignment=a.unpackAlignment),i[a.uuid]=s}return i},parseObject:function(e,t,r){var i;function n(d){return t[d]===void 0&&console.warn("THREE.ObjectLoader: Undefined geometry",d),t[d]}function o(d){if(d!==void 0){if(Array.isArray(d)){for(var m=[],v=0,g=d.length;v<g;v++){var b=d[v];r[b]===void 0&&console.warn("THREE.ObjectLoader: Undefined material",b),m.push(r[b])}return m}return r[d]===void 0&&console.warn("THREE.ObjectLoader: Undefined material",d),r[d]}}switch(e.type){case"Scene":i=new Wr,e.background!==void 0&&Number.isInteger(e.background)&&(i.background=new J(e.background)),e.fog!==void 0&&(e.fog.type==="Fog"?i.fog=new fi(e.fog.color,e.fog.near,e.fog.far):e.fog.type==="FogExp2"&&(i.fog=new si(e.fog.color,e.fog.density)));break;case"PerspectiveCamera":i=new De(e.fov,e.aspect,e.near,e.far),e.focus!==void 0&&(i.focus=e.focus),e.zoom!==void 0&&(i.zoom=e.zoom),e.filmGauge!==void 0&&(i.filmGauge=e.filmGauge),e.filmOffset!==void 0&&(i.filmOffset=e.filmOffset),e.view!==void 0&&(i.view=Object.assign({},e.view));break;case"OrthographicCamera":i=new dr(e.left,e.right,e.top,e.bottom,e.near,e.far),e.zoom!==void 0&&(i.zoom=e.zoom),e.view!==void 0&&(i.view=Object.assign({},e.view));break;case"AmbientLight":i=new ho(e.color,e.intensity);break;case"DirectionalLight":i=new co(e.color,e.intensity);break;case"PointLight":i=new fo(e.color,e.intensity,e.distance,e.decay);break;case"RectAreaLight":i=new lo(e.color,e.intensity,e.width,e.height);break;case"SpotLight":i=new so(e.color,e.intensity,e.distance,e.angle,e.penumbra,e.decay);break;case"HemisphereLight":i=new oo(e.color,e.groundColor,e.intensity);break;case"SkinnedMesh":console.warn("THREE.ObjectLoader.parseObject() does not support SkinnedMesh yet.");case"Mesh":var a=n(e.geometry),s=o(e.material);a.bones&&a.bones.length>0?i=new ci(a,s):i=new Xe(a,s);break;case"LOD":i=new ui;break;case"Line":i=new Ke(n(e.geometry),o(e.material),e.mode);break;case"LineLoop":i=new Rn(n(e.geometry),o(e.material));break;case"LineSegments":i=new Ae(n(e.geometry),o(e.material));break;case"PointCloud":case"Points":i=new Xi(n(e.geometry),o(e.material));break;case"Sprite":i=new Wi(o(e.material));break;case"Group":i=new Er;break;default:i=new k}if(i.uuid=e.uuid,e.name!==void 0&&(i.name=e.name),e.matrix!==void 0?(i.matrix.fromArray(e.matrix),e.matrixAutoUpdate!==void 0&&(i.matrixAutoUpdate=e.matrixAutoUpdate),i.matrixAutoUpdate&&i.matrix.decompose(i.position,i.quaternion,i.scale)):(e.position!==void 0&&i.position.fromArray(e.position),e.rotation!==void 0&&i.rotation.fromArray(e.rotation),e.quaternion!==void 0&&i.quaternion.fromArray(e.quaternion),e.scale!==void 0&&i.scale.fromArray(e.scale)),e.castShadow!==void 0&&(i.castShadow=e.castShadow),e.receiveShadow!==void 0&&(i.receiveShadow=e.receiveShadow),e.shadow&&(e.shadow.bias!==void 0&&(i.shadow.bias=e.shadow.bias),e.shadow.radius!==void 0&&(i.shadow.radius=e.shadow.radius),e.shadow.mapSize!==void 0&&i.shadow.mapSize.fromArray(e.shadow.mapSize),e.shadow.camera!==void 0&&(i.shadow.camera=this.parseObject(e.shadow.camera))),e.visible!==void 0&&(i.visible=e.visible),e.frustumCulled!==void 0&&(i.frustumCulled=e.frustumCulled),e.renderOrder!==void 0&&(i.renderOrder=e.renderOrder),e.userData!==void 0&&(i.userData=e.userData),e.layers!==void 0&&(i.layers.mask=e.layers),e.children!==void 0)for(var f=e.children,u=0;u<f.length;u++)i.add(this.parseObject(f[u],t,r));if(e.type==="LOD")for(var c=e.levels,h=0;h<c.length;h++){var l=c[h],p=i.getObjectByProperty("uuid",l.object);p!==void 0&&i.addLevel(p,l.distance)}return i}});var xp={UVMapping:Mn,CubeReflectionMapping:Li,CubeRefractionMapping:En,EquirectangularReflectionMapping:Go,EquirectangularRefractionMapping:Tn,SphericalReflectionMapping:zo,CubeUVReflectionMapping:Ri,CubeUVRefractionMapping:Ci},Uh={RepeatWrapping:Ht,ClampToEdgeWrapping:vt,MirroredRepeatWrapping:ar},Nh={NearestFilter:ke,NearestMipMapNearestFilter:Pi,NearestMipMapLinearFilter:Bi,LinearFilter:qe,LinearMipMapNearestFilter:Ho,LinearMipMapLinearFilter:Pr};function $a(e){typeof createImageBitmap>"u"&&console.warn("THREE.ImageBitmapLoader: createImageBitmap() not supported."),typeof fetch>"u"&&console.warn("THREE.ImageBitmapLoader: fetch() not supported."),this.manager=e!==void 0?e:We,this.options=void 0}$a.prototype={constructor:$a,setOptions:function(t){return this.options=t,this},load:function(e,t,r,i){e===void 0&&(e=""),this.path!==void 0&&(e=this.path+e),e=this.manager.resolveURL(e);var n=this,o=cr.get(e);if(o!==void 0)return n.manager.itemStart(e),setTimeout(function(){t&&t(o),n.manager.itemEnd(e)},0),o;fetch(e).then(function(a){return a.blob()}).then(function(a){return createImageBitmap(a,n.options)}).then(function(a){cr.add(e,a),t&&t(a),n.manager.itemEnd(e)}).catch(function(a){i&&i(a),n.manager.itemError(e),n.manager.itemEnd(e)})},setCrossOrigin:function(){return this},setPath:function(e){return this.path=e,this}};function ca(){this.type="ShapePath",this.color=new J,this.subPaths=[],this.currentPath=null}Object.assign(ca.prototype,{moveTo:function(e,t){this.currentPath=new Dt,this.subPaths.push(this.currentPath),this.currentPath.moveTo(e,t)},lineTo:function(e,t){this.currentPath.lineTo(e,t)},quadraticCurveTo:function(e,t,r,i){this.currentPath.quadraticCurveTo(e,t,r,i)},bezierCurveTo:function(e,t,r,i,n,o){this.currentPath.bezierCurveTo(e,t,r,i,n,o)},splineThru:function(e){this.currentPath.splineThru(e)},toShapes:function(e,t){function r(V){for(var $=[],K=0,Q=V.length;K<Q;K++){var E=V[K],T=new ir;T.curves=E.curves,$.push(T)}return $}function i(V,$){for(var K=$.length,Q=!1,E=K-1,T=0;T<K;E=T++){var U=$[E],L=$[T],te=L.x-U.x,N=L.y-U.y;if(Math.abs(N)>Number.EPSILON){if(N<0&&(U=$[T],te=-te,L=$[E],N=-N),V.y<U.y||V.y>L.y)continue;if(V.y===U.y){if(V.x===U.x)return!0}else{var q=N*(V.x-U.x)-te*(V.y-U.y);if(q===0)return!0;if(q<0)continue;Q=!Q}}else{if(V.y!==U.y)continue;if(L.x<=V.x&&V.x<=U.x||U.x<=V.x&&V.x<=L.x)return!0}}return Q}var n=Xt.isClockWise,o=this.subPaths;if(o.length===0)return[];if(t===!0)return r(o);var a,s,f,u=[];if(o.length===1)return s=o[0],f=new ir,f.curves=s.curves,u.push(f),u;var c=!n(o[0].getPoints());c=e?!c:c;var h=[],l=[],p=[],d=0,m;l[d]=void 0,p[d]=[];for(var v=0,g=o.length;v<g;v++)s=o[v],m=s.getPoints(),a=n(m),a=e?!a:a,a?(!c&&l[d]&&d++,l[d]={s:new ir,p:m},l[d].s.curves=s.curves,c&&d++,p[d]=[]):p[d].push({h:s,p:m[0]});if(!l[0])return r(o);if(l.length>1){for(var b=!1,w=[],y=0,S=l.length;y<S;y++)h[y]=[];for(var y=0,S=l.length;y<S;y++)for(var R=p[y],B=0;B<R.length;B++){for(var P=R[B],A=!0,D=0;D<l.length;D++)i(P.p,l[D].p)&&(y!==D&&w.push({froms:y,tos:D,hole:B}),A?(A=!1,h[D].push(P)):b=!0);A&&h[y].push(P)}w.length>0&&(b||(p=h))}for(var I,v=0,H=l.length;v<H;v++){f=l[v].s,u.push(f),I=p[v];for(var X=0,j=I.length;X<j;X++)f.holes.push(I[X].h)}return u}});function ha(e){this.type="Font",this.data=e}Object.assign(ha.prototype,{isFont:!0,generateShapes:function(e,t){t===void 0&&(t=100);for(var r=[],i=_p(e,t,this.data),n=0,o=i.length;n<o;n++)Array.prototype.push.apply(r,i[n].toShapes());return r}});function _p(e,t,r){for(var i=Array.from?Array.from(e):String(e).split(""),n=t/r.resolution,o=(r.boundingBox.yMax-r.boundingBox.yMin+r.underlineThickness)*n,a=[],s=0,f=0,u=0;u<i.length;u++){var c=i[u];if(c===`
`)s=0,f-=o;else{var h=bp(c,n,s,f,r);s+=h.offsetX,a.push(h.path)}}return a}function bp(e,t,r,i,n){var o=n.glyphs[e]||n.glyphs["?"];if(o){var a=new ca,s,f,u,c,h,l,p,d;if(o.o)for(var m=o._cachedOutline||(o._cachedOutline=o.o.split(" ")),v=0,g=m.length;v<g;){var b=m[v++];switch(b){case"m":s=m[v++]*t+r,f=m[v++]*t+i,a.moveTo(s,f);break;case"l":s=m[v++]*t+r,f=m[v++]*t+i,a.lineTo(s,f);break;case"q":u=m[v++]*t+r,c=m[v++]*t+i,h=m[v++]*t+r,l=m[v++]*t+i,a.quadraticCurveTo(h,l,u,c);break;case"b":u=m[v++]*t+r,c=m[v++]*t+i,h=m[v++]*t+r,l=m[v++]*t+i,p=m[v++]*t+r,d=m[v++]*t+i,a.bezierCurveTo(h,l,p,d,u,c);break}}return{offsetX:o.ha*t,path:a}}}function Gh(e){this.manager=e!==void 0?e:We}Object.assign(Gh.prototype,{load:function(e,t,r,i){var n=this,o=new at(this.manager);o.setPath(this.path),o.load(e,function(a){var s;try{s=JSON.parse(a)}catch{console.warn("THREE.FontLoader: typeface.js support is being deprecated. Use typeface.json instead."),s=JSON.parse(a.substring(65,a.length-2))}var f=n.parse(s);t&&t(f)},r,i)},parse:function(e){return new ha(e)},setPath:function(e){return this.path=e,this}});function hn(){}hn.Handlers={handlers:[],add:function(e,t){this.handlers.push(e,t)},get:function(e){for(var t=this.handlers,r=0,i=t.length;r<i;r+=2){var n=t[r],o=t[r+1];if(n.test(e))return o}return null}};Object.assign(hn.prototype,{crossOrigin:"anonymous",onLoadStart:function(){},onLoadProgress:function(){},onLoadComplete:function(){},initMaterials:function(e,t,r){for(var i=[],n=0;n<e.length;++n)i[n]=this.createMaterial(e[n],t,r);return i},createMaterial:function(){var e={NoBlending:Rr,NormalBlending:yr,AdditiveBlending:xn,SubtractiveBlending:_n,MultiplyBlending:bn,CustomBlending:Bo},t=new J,r=new fn,i=new cn;return function(o,a,s){var f={};function u(p,d,m,v,g){var b=a+p,w=hn.Handlers.get(b),y;w!==null?y=w.load(b):(r.setCrossOrigin(s),y=r.load(b)),d!==void 0&&(y.repeat.fromArray(d),d[0]!==1&&(y.wrapS=Ht),d[1]!==1&&(y.wrapT=Ht)),m!==void 0&&y.offset.fromArray(m),v!==void 0&&(v[0]==="repeat"&&(y.wrapS=Ht),v[0]==="mirror"&&(y.wrapS=ar),v[1]==="repeat"&&(y.wrapT=Ht),v[1]==="mirror"&&(y.wrapT=ar)),g!==void 0&&(y.anisotropy=g);var S=ie.generateUUID();return f[S]=y,S}var c={uuid:ie.generateUUID(),type:"MeshLambertMaterial"};for(var h in o){var l=o[h];switch(h){case"DbgColor":case"DbgIndex":case"opticalDensity":case"illumination":break;case"DbgName":c.name=l;break;case"blending":c.blending=e[l];break;case"colorAmbient":case"mapAmbient":console.warn("THREE.Loader.createMaterial:",h,"is no longer supported.");break;case"colorDiffuse":c.color=t.fromArray(l).getHex();break;case"colorSpecular":c.specular=t.fromArray(l).getHex();break;case"colorEmissive":c.emissive=t.fromArray(l).getHex();break;case"specularCoef":c.shininess=l;break;case"shading":l.toLowerCase()==="basic"&&(c.type="MeshBasicMaterial"),l.toLowerCase()==="phong"&&(c.type="MeshPhongMaterial"),l.toLowerCase()==="standard"&&(c.type="MeshStandardMaterial");break;case"mapDiffuse":c.map=u(l,o.mapDiffuseRepeat,o.mapDiffuseOffset,o.mapDiffuseWrap,o.mapDiffuseAnisotropy);break;case"mapDiffuseRepeat":case"mapDiffuseOffset":case"mapDiffuseWrap":case"mapDiffuseAnisotropy":break;case"mapEmissive":c.emissiveMap=u(l,o.mapEmissiveRepeat,o.mapEmissiveOffset,o.mapEmissiveWrap,o.mapEmissiveAnisotropy);break;case"mapEmissiveRepeat":case"mapEmissiveOffset":case"mapEmissiveWrap":case"mapEmissiveAnisotropy":break;case"mapLight":c.lightMap=u(l,o.mapLightRepeat,o.mapLightOffset,o.mapLightWrap,o.mapLightAnisotropy);break;case"mapLightRepeat":case"mapLightOffset":case"mapLightWrap":case"mapLightAnisotropy":break;case"mapAO":c.aoMap=u(l,o.mapAORepeat,o.mapAOOffset,o.mapAOWrap,o.mapAOAnisotropy);break;case"mapAORepeat":case"mapAOOffset":case"mapAOWrap":case"mapAOAnisotropy":break;case"mapBump":c.bumpMap=u(l,o.mapBumpRepeat,o.mapBumpOffset,o.mapBumpWrap,o.mapBumpAnisotropy);break;case"mapBumpScale":c.bumpScale=l;break;case"mapBumpRepeat":case"mapBumpOffset":case"mapBumpWrap":case"mapBumpAnisotropy":break;case"mapNormal":c.normalMap=u(l,o.mapNormalRepeat,o.mapNormalOffset,o.mapNormalWrap,o.mapNormalAnisotropy);break;case"mapNormalFactor":c.normalScale=l;break;case"mapNormalRepeat":case"mapNormalOffset":case"mapNormalWrap":case"mapNormalAnisotropy":break;case"mapSpecular":c.specularMap=u(l,o.mapSpecularRepeat,o.mapSpecularOffset,o.mapSpecularWrap,o.mapSpecularAnisotropy);break;case"mapSpecularRepeat":case"mapSpecularOffset":case"mapSpecularWrap":case"mapSpecularAnisotropy":break;case"mapMetalness":c.metalnessMap=u(l,o.mapMetalnessRepeat,o.mapMetalnessOffset,o.mapMetalnessWrap,o.mapMetalnessAnisotropy);break;case"mapMetalnessRepeat":case"mapMetalnessOffset":case"mapMetalnessWrap":case"mapMetalnessAnisotropy":break;case"mapRoughness":c.roughnessMap=u(l,o.mapRoughnessRepeat,o.mapRoughnessOffset,o.mapRoughnessWrap,o.mapRoughnessAnisotropy);break;case"mapRoughnessRepeat":case"mapRoughnessOffset":case"mapRoughnessWrap":case"mapRoughnessAnisotropy":break;case"mapAlpha":c.alphaMap=u(l,o.mapAlphaRepeat,o.mapAlphaOffset,o.mapAlphaWrap,o.mapAlphaAnisotropy);break;case"mapAlphaRepeat":case"mapAlphaOffset":case"mapAlphaWrap":case"mapAlphaAnisotropy":break;case"flipSided":c.side=Ze;break;case"doubleSided":c.side=or;break;case"transparency":console.warn("THREE.Loader.createMaterial: transparency has been renamed to opacity"),c.opacity=l;break;case"depthTest":case"depthWrite":case"colorWrite":case"opacity":case"reflectivity":case"transparent":case"visible":case"wireframe":c[h]=l;break;case"vertexColors":l===!0&&(c.vertexColors=zt),l==="face"&&(c.vertexColors=Po);break;default:console.error("THREE.Loader.createMaterial: Unsupported",h,l);break}}return c.type==="MeshBasicMaterial"&&delete c.emissive,c.type!=="MeshPhongMaterial"&&delete c.specular,c.opacity<1&&(c.transparent=!0),i.setTextures(f),i.parse(c)}}()});var la,mo={getContext:function(){return la===void 0&&(la=new(window.AudioContext||window.webkitAudioContext)),la},setContext:function(e){la=e}};function pa(e){this.manager=e!==void 0?e:We}Object.assign(pa.prototype,{load:function(e,t,r,i){var n=new at(this.manager);n.setResponseType("arraybuffer"),n.setPath(this.path),n.load(e,function(o){var a=o.slice(0),s=mo.getContext();s.decodeAudioData(a,function(f){t(f)})},r,i)},setPath:function(e){return this.path=e,this}});function zh(){this.type="StereoCamera",this.aspect=1,this.eyeSep=.064,this.cameraL=new De,this.cameraL.layers.enable(1),this.cameraL.matrixAutoUpdate=!1,this.cameraR=new De,this.cameraR.layers.enable(2),this.cameraR.matrixAutoUpdate=!1}Object.assign(zh.prototype,{update:function(){var e,t,r,i,n,o,a,s,f=new ee,u=new ee;return function(h){var l=e!==this||t!==h.focus||r!==h.fov||i!==h.aspect*this.aspect||n!==h.near||o!==h.far||a!==h.zoom||s!==this.eyeSep;if(l){e=this,t=h.focus,r=h.fov,i=h.aspect*this.aspect,n=h.near,o=h.far,a=h.zoom;var p=h.projectionMatrix.clone();s=this.eyeSep/2;var d=s*n/t,m=n*Math.tan(ie.DEG2RAD*r*.5)/a,v,g;u.elements[12]=-s,f.elements[12]=s,v=-m*i+d,g=m*i+d,p.elements[0]=2*n/(g-v),p.elements[8]=(g+v)/(g-v),this.cameraL.projectionMatrix.copy(p),v=-m*i-d,g=m*i-d,p.elements[0]=2*n/(g-v),p.elements[8]=(g+v)/(g-v),this.cameraR.projectionMatrix.copy(p)}this.cameraL.matrixWorld.copy(h.matrixWorld).multiply(u),this.cameraR.matrixWorld.copy(h.matrixWorld).multiply(f)}}()});function ln(e,t,r,i){k.call(this),this.type="CubeCamera";var n=90,o=1,a=new De(n,o,e,t);a.up.set(0,-1,0),a.lookAt(new x(1,0,0)),this.add(a);var s=new De(n,o,e,t);s.up.set(0,-1,0),s.lookAt(new x(-1,0,0)),this.add(s);var f=new De(n,o,e,t);f.up.set(0,0,1),f.lookAt(new x(0,1,0)),this.add(f);var u=new De(n,o,e,t);u.up.set(0,0,-1),u.lookAt(new x(0,-1,0)),this.add(u);var c=new De(n,o,e,t);c.up.set(0,-1,0),c.lookAt(new x(0,0,1)),this.add(c);var h=new De(n,o,e,t);h.up.set(0,-1,0),h.lookAt(new x(0,0,-1)),this.add(h),i=i||{format:Ot,magFilter:qe,minFilter:qe},this.renderTarget=new ni(r,r,i),this.renderTarget.texture.name="CubeCamera",this.update=function(l,p){this.parent===null&&this.updateMatrixWorld();var d=l.getRenderTarget(),m=this.renderTarget,v=m.texture.generateMipmaps;m.texture.generateMipmaps=!1,m.activeCubeFace=0,l.render(p,a,m),m.activeCubeFace=1,l.render(p,s,m),m.activeCubeFace=2,l.render(p,f,m),m.activeCubeFace=3,l.render(p,u,m),m.activeCubeFace=4,l.render(p,c,m),m.texture.generateMipmaps=v,m.activeCubeFace=5,l.render(p,h,m),l.setRenderTarget(d)},this.clear=function(l,p,d,m){for(var v=l.getRenderTarget(),g=this.renderTarget,b=0;b<6;b++)g.activeCubeFace=b,l.setRenderTarget(g),l.clear(p,d,m);l.setRenderTarget(v)}}ln.prototype=Object.create(k.prototype);ln.prototype.constructor=ln;function da(e){this.autoStart=e!==void 0?e:!0,this.startTime=0,this.oldTime=0,this.elapsedTime=0,this.running=!1}Object.assign(da.prototype,{start:function(){this.startTime=(typeof performance>"u"?Date:performance).now(),this.oldTime=this.startTime,this.elapsedTime=0,this.running=!0},stop:function(){this.getElapsedTime(),this.running=!1,this.autoStart=!1},getElapsedTime:function(){return this.getDelta(),this.elapsedTime},getDelta:function(){var e=0;if(this.autoStart&&!this.running)return this.start(),0;if(this.running){var t=(typeof performance>"u"?Date:performance).now();e=(t-this.oldTime)/1e3,this.oldTime=t,this.elapsedTime+=e}return e}});function es(){k.call(this),this.type="AudioListener",this.context=mo.getContext(),this.gain=this.context.createGain(),this.gain.connect(this.context.destination),this.filter=null,this.timeDelta=0}es.prototype=Object.assign(Object.create(k.prototype),{constructor:es,getInput:function(){return this.gain},removeFilter:function(){return this.filter!==null&&(this.gain.disconnect(this.filter),this.filter.disconnect(this.context.destination),this.gain.connect(this.context.destination),this.filter=null),this},getFilter:function(){return this.filter},setFilter:function(e){return this.filter!==null?(this.gain.disconnect(this.filter),this.filter.disconnect(this.context.destination)):this.gain.disconnect(this.context.destination),this.filter=e,this.gain.connect(this.filter),this.filter.connect(this.context.destination),this},getMasterVolume:function(){return this.gain.gain.value},setMasterVolume:function(e){return this.gain.gain.setTargetAtTime(e,this.context.currentTime,.01),this},updateMatrixWorld:function(){var e=new x,t=new Ge,r=new x,i=new x,n=new da;return function(a){k.prototype.updateMatrixWorld.call(this,a);var s=this.context.listener,f=this.up;if(this.timeDelta=n.getDelta(),this.matrixWorld.decompose(e,t,r),i.set(0,0,-1).applyQuaternion(t),s.positionX){var u=this.context.currentTime+this.timeDelta;s.positionX.linearRampToValueAtTime(e.x,u),s.positionY.linearRampToValueAtTime(e.y,u),s.positionZ.linearRampToValueAtTime(e.z,u),s.forwardX.linearRampToValueAtTime(i.x,u),s.forwardY.linearRampToValueAtTime(i.y,u),s.forwardZ.linearRampToValueAtTime(i.z,u),s.upX.linearRampToValueAtTime(f.x,u),s.upY.linearRampToValueAtTime(f.y,u),s.upZ.linearRampToValueAtTime(f.z,u)}else s.setPosition(e.x,e.y,e.z),s.setOrientation(i.x,i.y,i.z,f.x,f.y,f.z)}}()});function Kr(e){k.call(this),this.type="Audio",this.listener=e,this.context=e.context,this.gain=this.context.createGain(),this.gain.connect(e.getInput()),this.autoplay=!1,this.buffer=null,this.detune=0,this.loop=!1,this.startTime=0,this.offset=0,this.playbackRate=1,this.isPlaying=!1,this.hasPlaybackControl=!0,this.sourceType="empty",this.filters=[]}Kr.prototype=Object.assign(Object.create(k.prototype),{constructor:Kr,getOutput:function(){return this.gain},setNodeSource:function(e){return this.hasPlaybackControl=!1,this.sourceType="audioNode",this.source=e,this.connect(),this},setMediaElementSource:function(e){return this.hasPlaybackControl=!1,this.sourceType="mediaNode",this.source=this.context.createMediaElementSource(e),this.connect(),this},setBuffer:function(e){return this.buffer=e,this.sourceType="buffer",this.autoplay&&this.play(),this},play:function(){if(this.isPlaying===!0){console.warn("THREE.Audio: Audio is already playing.");return}if(this.hasPlaybackControl===!1){console.warn("THREE.Audio: this Audio has no playback control.");return}var e=this.context.createBufferSource();return e.buffer=this.buffer,e.detune.value=this.detune,e.loop=this.loop,e.onended=this.onEnded.bind(this),e.playbackRate.setValueAtTime(this.playbackRate,this.startTime),this.startTime=this.context.currentTime,e.start(this.startTime,this.offset),this.isPlaying=!0,this.source=e,this.connect()},pause:function(){if(this.hasPlaybackControl===!1){console.warn("THREE.Audio: this Audio has no playback control.");return}return this.isPlaying===!0&&(this.source.stop(),this.source.onended=null,this.offset+=(this.context.currentTime-this.startTime)*this.playbackRate,this.isPlaying=!1),this},stop:function(){if(this.hasPlaybackControl===!1){console.warn("THREE.Audio: this Audio has no playback control.");return}return this.source.stop(),this.source.onended=null,this.offset=0,this.isPlaying=!1,this},connect:function(){if(this.filters.length>0){this.source.connect(this.filters[0]);for(var e=1,t=this.filters.length;e<t;e++)this.filters[e-1].connect(this.filters[e]);this.filters[this.filters.length-1].connect(this.getOutput())}else this.source.connect(this.getOutput());return this},disconnect:function(){if(this.filters.length>0){this.source.disconnect(this.filters[0]);for(var e=1,t=this.filters.length;e<t;e++)this.filters[e-1].disconnect(this.filters[e]);this.filters[this.filters.length-1].disconnect(this.getOutput())}else this.source.disconnect(this.getOutput());return this},getFilters:function(){return this.filters},setFilters:function(e){return e||(e=[]),this.isPlaying===!0?(this.disconnect(),this.filters=e,this.connect()):this.filters=e,this},setDetune:function(e){return this.detune=e,this.isPlaying===!0&&this.source.detune.setTargetAtTime(this.detune,this.context.currentTime,.01),this},getDetune:function(){return this.detune},getFilter:function(){return this.getFilters()[0]},setFilter:function(e){return this.setFilters(e?[e]:[])},setPlaybackRate:function(e){if(this.hasPlaybackControl===!1){console.warn("THREE.Audio: this Audio has no playback control.");return}return this.playbackRate=e,this.isPlaying===!0&&this.source.playbackRate.setTargetAtTime(this.playbackRate,this.context.currentTime,.01),this},getPlaybackRate:function(){return this.playbackRate},onEnded:function(){this.isPlaying=!1},getLoop:function(){return this.hasPlaybackControl===!1?(console.warn("THREE.Audio: this Audio has no playback control."),!1):this.loop},setLoop:function(e){if(this.hasPlaybackControl===!1){console.warn("THREE.Audio: this Audio has no playback control.");return}return this.loop=e,this.isPlaying===!0&&(this.source.loop=this.loop),this},getVolume:function(){return this.gain.gain.value},setVolume:function(e){return this.gain.gain.setTargetAtTime(e,this.context.currentTime,.01),this}});function ts(e){Kr.call(this,e),this.panner=this.context.createPanner(),this.panner.connect(this.gain)}ts.prototype=Object.assign(Object.create(Kr.prototype),{constructor:ts,getOutput:function(){return this.panner},getRefDistance:function(){return this.panner.refDistance},setRefDistance:function(e){return this.panner.refDistance=e,this},getRolloffFactor:function(){return this.panner.rolloffFactor},setRolloffFactor:function(e){return this.panner.rolloffFactor=e,this},getDistanceModel:function(){return this.panner.distanceModel},setDistanceModel:function(e){return this.panner.distanceModel=e,this},getMaxDistance:function(){return this.panner.maxDistance},setMaxDistance:function(e){return this.panner.maxDistance=e,this},setDirectionalCone:function(e,t,r){return this.panner.coneInnerAngle=e,this.panner.coneOuterAngle=t,this.panner.coneOuterGain=r,this},updateMatrixWorld:function(){var e=new x,t=new Ge,r=new x,i=new x;return function(o){if(k.prototype.updateMatrixWorld.call(this,o),this.isPlaying!==!1){this.matrixWorld.decompose(e,t,r),i.set(0,0,1).applyQuaternion(t);var a=this.panner;if(a.positionX){var s=this.context.currentTime+this.listener.timeDelta;a.positionX.linearRampToValueAtTime(e.x,s),a.positionY.linearRampToValueAtTime(e.y,s),a.positionZ.linearRampToValueAtTime(e.z,s),a.orientationX.linearRampToValueAtTime(i.x,s),a.orientationY.linearRampToValueAtTime(i.y,s),a.orientationZ.linearRampToValueAtTime(i.z,s)}else a.setPosition(e.x,e.y,e.z),a.setOrientation(i.x,i.y,i.z)}}}()});function ma(e,t){this.analyser=e.context.createAnalyser(),this.analyser.fftSize=t!==void 0?t:2048,this.data=new Uint8Array(this.analyser.frequencyBinCount),e.getOutput().connect(this.analyser)}Object.assign(ma.prototype,{getFrequencyData:function(){return this.analyser.getByteFrequencyData(this.data),this.data},getAverageFrequency:function(){for(var e=0,t=this.getFrequencyData(),r=0;r<t.length;r++)e+=t[r];return e/t.length}});function va(e,t,r){this.binding=e,this.valueSize=r;var i=Float64Array,n;switch(t){case"quaternion":n=this._slerp;break;case"string":case"bool":i=Array,n=this._select;break;default:n=this._lerp}this.buffer=new i(r*4),this._mixBufferRegion=n,this.cumulativeWeight=0,this.useCount=0,this.referenceCount=0}Object.assign(va.prototype,{accumulate:function(e,t){var r=this.buffer,i=this.valueSize,n=e*i+i,o=this.cumulativeWeight;if(o===0){for(var a=0;a!==i;++a)r[n+a]=r[a];o=t}else{o+=t;var s=t/o;this._mixBufferRegion(r,n,0,s,i)}this.cumulativeWeight=o},apply:function(e){var t=this.valueSize,r=this.buffer,i=e*t+t,n=this.cumulativeWeight,o=this.binding;if(this.cumulativeWeight=0,n<1){var a=t*3;this._mixBufferRegion(r,i,a,1-n,t)}for(var s=t,f=t+t;s!==f;++s)if(r[s]!==r[s+t]){o.setValue(r,i);break}},saveOriginalState:function(){var e=this.binding,t=this.buffer,r=this.valueSize,i=r*3;e.getValue(t,i);for(var n=r,o=i;n!==o;++n)t[n]=t[i+n%r];this.cumulativeWeight=0},restoreOriginalState:function(){var e=this.valueSize*3;this.binding.setValue(this.buffer,e)},_select:function(e,t,r,i,n){if(i>=.5)for(var o=0;o!==n;++o)e[t+o]=e[r+o]},_slerp:function(e,t,r,i){Ge.slerpFlat(e,t,e,t,e,r,i)},_lerp:function(e,t,r,i,n){for(var o=1-i,a=0;a!==n;++a){var s=t+a;e[s]=e[s]*o+e[r+a]*i}}});var rs="\\[\\]\\.:\\/";function Hh(e,t,r){var i=r||pt.parseTrackName(t);this._targetGroup=e,this._bindings=e.subscribe_(t,i)}Object.assign(Hh.prototype,{getValue:function(e,t){this.bind();var r=this._targetGroup.nCachedObjects_,i=this._bindings[r];i!==void 0&&i.getValue(e,t)},setValue:function(e,t){for(var r=this._bindings,i=this._targetGroup.nCachedObjects_,n=r.length;i!==n;++i)r[i].setValue(e,t)},bind:function(){for(var e=this._bindings,t=this._targetGroup.nCachedObjects_,r=e.length;t!==r;++t)e[t].bind()},unbind:function(){for(var e=this._bindings,t=this._targetGroup.nCachedObjects_,r=e.length;t!==r;++t)e[t].unbind()}});function pt(e,t,r){this.path=t,this.parsedPath=r||pt.parseTrackName(t),this.node=pt.findNode(e,this.parsedPath.nodeName)||e,this.rootNode=e}Object.assign(pt,{Composite:Hh,create:function(e,t,r){return e&&e.isAnimationObjectGroup?new pt.Composite(e,t,r):new pt(e,t,r)},sanitizeNodeName:function(){var e=new RegExp("["+rs+"]","g");return function(r){return r.replace(/\s/g,"_").replace(e,"")}}(),parseTrackName:function(){var e="[^"+rs+"]",t="[^"+rs.replace("\\.","")+"]",r=/((?:WC+[\/:])*)/.source.replace("WC",e),i=/(WCOD+)?/.source.replace("WCOD",t),n=/(?:\.(WC+)(?:\[(.+)\])?)?/.source.replace("WC",e),o=/\.(WC+)(?:\[(.+)\])?/.source.replace("WC",e),a=new RegExp("^"+r+i+n+o+"$"),s=["material","materials","bones"];return function(u){var c=a.exec(u);if(!c)throw new Error("PropertyBinding: Cannot parse trackName: "+u);var h={nodeName:c[2],objectName:c[3],objectIndex:c[4],propertyName:c[5],propertyIndex:c[6]},l=h.nodeName&&h.nodeName.lastIndexOf(".");if(l!==void 0&&l!==-1){var p=h.nodeName.substring(l+1);s.indexOf(p)!==-1&&(h.nodeName=h.nodeName.substring(0,l),h.objectName=p)}if(h.propertyName===null||h.propertyName.length===0)throw new Error("PropertyBinding: can not parse propertyName from trackName: "+u);return h}}(),findNode:function(e,t){if(!t||t===""||t==="root"||t==="."||t===-1||t===e.name||t===e.uuid)return e;if(e.skeleton){var r=e.skeleton.getBoneByName(t);if(r!==void 0)return r}if(e.children){var i=function(o){for(var a=0;a<o.length;a++){var s=o[a];if(s.name===t||s.uuid===t)return s;var f=i(s.children);if(f)return f}return null},n=i(e.children);if(n)return n}return null}});Object.assign(pt.prototype,{_getValue_unavailable:function(){},_setValue_unavailable:function(){},BindingType:{Direct:0,EntireArray:1,ArrayElement:2,HasFromToArray:3},Versioning:{None:0,NeedsUpdate:1,MatrixWorldNeedsUpdate:2},GetterByBindingType:[function(t,r){t[r]=this.node[this.propertyName]},function(t,r){for(var i=this.resolvedProperty,n=0,o=i.length;n!==o;++n)t[r++]=i[n]},function(t,r){t[r]=this.resolvedProperty[this.propertyIndex]},function(t,r){this.resolvedProperty.toArray(t,r)}],SetterByBindingTypeAndVersioning:[[function(t,r){this.targetObject[this.propertyName]=t[r]},function(t,r){this.targetObject[this.propertyName]=t[r],this.targetObject.needsUpdate=!0},function(t,r){this.targetObject[this.propertyName]=t[r],this.targetObject.matrixWorldNeedsUpdate=!0}],[function(t,r){for(var i=this.resolvedProperty,n=0,o=i.length;n!==o;++n)i[n]=t[r++]},function(t,r){for(var i=this.resolvedProperty,n=0,o=i.length;n!==o;++n)i[n]=t[r++];this.targetObject.needsUpdate=!0},function(t,r){for(var i=this.resolvedProperty,n=0,o=i.length;n!==o;++n)i[n]=t[r++];this.targetObject.matrixWorldNeedsUpdate=!0}],[function(t,r){this.resolvedProperty[this.propertyIndex]=t[r]},function(t,r){this.resolvedProperty[this.propertyIndex]=t[r],this.targetObject.needsUpdate=!0},function(t,r){this.resolvedProperty[this.propertyIndex]=t[r],this.targetObject.matrixWorldNeedsUpdate=!0}],[function(t,r){this.resolvedProperty.fromArray(t,r)},function(t,r){this.resolvedProperty.fromArray(t,r),this.targetObject.needsUpdate=!0},function(t,r){this.resolvedProperty.fromArray(t,r),this.targetObject.matrixWorldNeedsUpdate=!0}]],getValue:function(t,r){this.bind(),this.getValue(t,r)},setValue:function(t,r){this.bind(),this.setValue(t,r)},bind:function(){var e=this.node,t=this.parsedPath,r=t.objectName,i=t.propertyName,n=t.propertyIndex;if(e||(e=pt.findNode(this.rootNode,t.nodeName)||this.rootNode,this.node=e),this.getValue=this._getValue_unavailable,this.setValue=this._setValue_unavailable,!e){console.error("THREE.PropertyBinding: Trying to update node for track: "+this.path+" but it wasn't found.");return}if(r){var o=t.objectIndex;switch(r){case"materials":if(!e.material){console.error("THREE.PropertyBinding: Can not bind to material as node does not have a material.",this);return}if(!e.material.materials){console.error("THREE.PropertyBinding: Can not bind to material.materials as node.material does not have a materials array.",this);return}e=e.material.materials;break;case"bones":if(!e.skeleton){console.error("THREE.PropertyBinding: Can not bind to bones as node does not have a skeleton.",this);return}e=e.skeleton.bones;for(var a=0;a<e.length;a++)if(e[a].name===o){o=a;break}break;default:if(e[r]===void 0){console.error("THREE.PropertyBinding: Can not bind to objectName of node undefined.",this);return}e=e[r]}if(o!==void 0){if(e[o]===void 0){console.error("THREE.PropertyBinding: Trying to bind to objectIndex of objectName, but is undefined.",this,e);return}e=e[o]}}var s=e[i];if(s===void 0){var f=t.nodeName;console.error("THREE.PropertyBinding: Trying to update property for track: "+f+"."+i+" but it wasn't found.",e);return}var u=this.Versioning.None;this.targetObject=e,e.needsUpdate!==void 0?u=this.Versioning.NeedsUpdate:e.matrixWorldNeedsUpdate!==void 0&&(u=this.Versioning.MatrixWorldNeedsUpdate);var c=this.BindingType.Direct;if(n!==void 0){if(i==="morphTargetInfluences"){if(!e.geometry){console.error("THREE.PropertyBinding: Can not bind to morphTargetInfluences because node does not have a geometry.",this);return}if(e.geometry.isBufferGeometry){if(!e.geometry.morphAttributes){console.error("THREE.PropertyBinding: Can not bind to morphTargetInfluences because node does not have a geometry.morphAttributes.",this);return}for(var a=0;a<this.node.geometry.morphAttributes.position.length;a++)if(e.geometry.morphAttributes.position[a].name===n){n=a;break}}else{if(!e.geometry.morphTargets){console.error("THREE.PropertyBinding: Can not bind to morphTargetInfluences because node does not have a geometry.morphTargets.",this);return}for(var a=0;a<this.node.geometry.morphTargets.length;a++)if(e.geometry.morphTargets[a].name===n){n=a;break}}}c=this.BindingType.ArrayElement,this.resolvedProperty=s,this.propertyIndex=n}else s.fromArray!==void 0&&s.toArray!==void 0?(c=this.BindingType.HasFromToArray,this.resolvedProperty=s):Array.isArray(s)?(c=this.BindingType.EntireArray,this.resolvedProperty=s):this.propertyName=i;this.getValue=this.GetterByBindingType[c],this.setValue=this.SetterByBindingTypeAndVersioning[c][u]},unbind:function(){this.node=null,this.getValue=this._getValue_unbound,this.setValue=this._setValue_unbound}});Object.assign(pt.prototype,{_getValue_unbound:pt.prototype.getValue,_setValue_unbound:pt.prototype.setValue});function Vh(){this.uuid=ie.generateUUID(),this._objects=Array.prototype.slice.call(arguments),this.nCachedObjects_=0;var e={};this._indicesByUUID=e;for(var t=0,r=arguments.length;t!==r;++t)e[arguments[t].uuid]=t;this._paths=[],this._parsedPaths=[],this._bindings=[],this._bindingsIndicesByPath={};var i=this;this.stats={objects:{get total(){return i._objects.length},get inUse(){return this.total-i.nCachedObjects_}},get bindingsPerObject(){return i._bindings.length}}}Object.assign(Vh.prototype,{isAnimationObjectGroup:!0,add:function(){for(var e=this._objects,t=e.length,r=this.nCachedObjects_,i=this._indicesByUUID,n=this._paths,o=this._parsedPaths,a=this._bindings,s=a.length,f=void 0,u=0,c=arguments.length;u!==c;++u){var h=arguments[u],l=h.uuid,p=i[l];if(p===void 0){p=t++,i[l]=p,e.push(h);for(var d=0,m=s;d!==m;++d)a[d].push(new pt(h,n[d],o[d]))}else if(p<r){f=e[p];var v=--r,g=e[v];i[g.uuid]=p,e[p]=g,i[l]=v,e[v]=h;for(var d=0,m=s;d!==m;++d){var b=a[d],w=b[v],y=b[p];b[p]=w,y===void 0&&(y=new pt(h,n[d],o[d])),b[v]=y}}else e[p]!==f&&console.error("THREE.AnimationObjectGroup: Different objects with the same UUID detected. Clean the caches or recreate your infrastructure when reloading scenes.")}this.nCachedObjects_=r},remove:function(){for(var e=this._objects,t=this.nCachedObjects_,r=this._indicesByUUID,i=this._bindings,n=i.length,o=0,a=arguments.length;o!==a;++o){var s=arguments[o],f=s.uuid,u=r[f];if(u!==void 0&&u>=t){var c=t++,h=e[c];r[h.uuid]=u,e[u]=h,r[f]=c,e[c]=s;for(var l=0,p=n;l!==p;++l){var d=i[l],m=d[c],v=d[u];d[u]=m,d[c]=v}}}this.nCachedObjects_=t},uncache:function(){for(var e=this._objects,t=e.length,r=this.nCachedObjects_,i=this._indicesByUUID,n=this._bindings,o=n.length,a=0,s=arguments.length;a!==s;++a){var f=arguments[a],u=f.uuid,c=i[u];if(c!==void 0)if(delete i[u],c<r){var h=--r,l=e[h],p=--t,d=e[p];i[l.uuid]=c,e[c]=l,i[d.uuid]=h,e[h]=d,e.pop();for(var m=0,v=o;m!==v;++m){var g=n[m],b=g[h],w=g[p];g[c]=b,g[h]=w,g.pop()}}else{var p=--t,d=e[p];i[d.uuid]=c,e[c]=d,e.pop();for(var m=0,v=o;m!==v;++m){var g=n[m];g[c]=g[p],g.pop()}}}this.nCachedObjects_=r},subscribe_:function(e,t){var r=this._bindingsIndicesByPath,i=r[e],n=this._bindings;if(i!==void 0)return n[i];var o=this._paths,a=this._parsedPaths,s=this._objects,f=s.length,u=this.nCachedObjects_,c=new Array(f);i=n.length,r[e]=i,o.push(e),a.push(t),n.push(c);for(var h=u,l=s.length;h!==l;++h){var p=s[h];c[h]=new pt(p,e,t)}return c},unsubscribe_:function(e){var t=this._bindingsIndicesByPath,r=t[e];if(r!==void 0){var i=this._paths,n=this._parsedPaths,o=this._bindings,a=o.length-1,s=o[a],f=e[a];t[f]=r,o[r]=s,o.pop(),n[r]=n[a],n.pop(),i[r]=i[a],i.pop()}}});function is(e,t,r){this._mixer=e,this._clip=t,this._localRoot=r||null;for(var i=t.tracks,n=i.length,o=new Array(n),a={endingStart:Ir,endingEnd:Ir},s=0;s!==n;++s){var f=i[s].createInterpolant(null);o[s]=f,f.settings=a}this._interpolantSettings=a,this._interpolants=o,this._propertyBindings=new Array(n),this._cacheIndex=null,this._byClipCacheIndex=null,this._timeScaleInterpolant=null,this._weightInterpolant=null,this.loop=pf,this._loopCount=-1,this._startTime=null,this.time=0,this.timeScale=1,this._effectiveTimeScale=1,this.weight=1,this._effectiveWeight=1,this.repetitions=1/0,this.paused=!1,this.enabled=!0,this.clampWhenFinished=!1,this.zeroSlopeAtStart=!0,this.zeroSlopeAtEnd=!0}Object.assign(is.prototype,{play:function(){return this._mixer._activateAction(this),this},stop:function(){return this._mixer._deactivateAction(this),this.reset()},reset:function(){return this.paused=!1,this.enabled=!0,this.time=0,this._loopCount=-1,this._startTime=null,this.stopFading().stopWarping()},isRunning:function(){return this.enabled&&!this.paused&&this.timeScale!==0&&this._startTime===null&&this._mixer._isActiveAction(this)},isScheduled:function(){return this._mixer._isActiveAction(this)},startAt:function(e){return this._startTime=e,this},setLoop:function(e,t){return this.loop=e,this.repetitions=t,this},setEffectiveWeight:function(e){return this.weight=e,this._effectiveWeight=this.enabled?e:0,this.stopFading()},getEffectiveWeight:function(){return this._effectiveWeight},fadeIn:function(e){return this._scheduleFading(e,0,1)},fadeOut:function(e){return this._scheduleFading(e,1,0)},crossFadeFrom:function(e,t,r){if(e.fadeOut(t),this.fadeIn(t),r){var i=this._clip.duration,n=e._clip.duration,o=n/i,a=i/n;e.warp(1,o,t),this.warp(a,1,t)}return this},crossFadeTo:function(e,t,r){return e.crossFadeFrom(this,t,r)},stopFading:function(){var e=this._weightInterpolant;return e!==null&&(this._weightInterpolant=null,this._mixer._takeBackControlInterpolant(e)),this},setEffectiveTimeScale:function(e){return this.timeScale=e,this._effectiveTimeScale=this.paused?0:e,this.stopWarping()},getEffectiveTimeScale:function(){return this._effectiveTimeScale},setDuration:function(e){return this.timeScale=this._clip.duration/e,this.stopWarping()},syncWith:function(e){return this.time=e.time,this.timeScale=e.timeScale,this.stopWarping()},halt:function(e){return this.warp(this._effectiveTimeScale,0,e)},warp:function(e,t,r){var i=this._mixer,n=i.time,o=this._timeScaleInterpolant,a=this.timeScale;o===null&&(o=i._lendControlInterpolant(),this._timeScaleInterpolant=o);var s=o.parameterPositions,f=o.sampleValues;return s[0]=n,s[1]=n+r,f[0]=e/a,f[1]=t/a,this},stopWarping:function(){var e=this._timeScaleInterpolant;return e!==null&&(this._timeScaleInterpolant=null,this._mixer._takeBackControlInterpolant(e)),this},getMixer:function(){return this._mixer},getClip:function(){return this._clip},getRoot:function(){return this._localRoot||this._mixer._root},_update:function(e,t,r,i){if(!this.enabled){this._updateWeight(e);return}var n=this._startTime;if(n!==null){var o=(e-n)*r;if(o<0||r===0)return;this._startTime=null,t=r*o}t*=this._updateTimeScale(e);var a=this._updateTime(t),s=this._updateWeight(e);if(s>0)for(var f=this._interpolants,u=this._propertyBindings,c=0,h=f.length;c!==h;++c)f[c].evaluate(a),u[c].accumulate(i,s)},_updateWeight:function(e){var t=0;if(this.enabled){t=this.weight;var r=this._weightInterpolant;if(r!==null){var i=r.evaluate(e)[0];t*=i,e>r.parameterPositions[1]&&(this.stopFading(),i===0&&(this.enabled=!1))}}return this._effectiveWeight=t,t},_updateTimeScale:function(e){var t=0;if(!this.paused){t=this.timeScale;var r=this._timeScaleInterpolant;if(r!==null){var i=r.evaluate(e)[0];t*=i,e>r.parameterPositions[1]&&(this.stopWarping(),t===0?this.paused=!0:this.timeScale=t)}}return this._effectiveTimeScale=t,t},_updateTime:function(e){var t=this.time+e,r=this._clip.duration,i=this.loop,n=this._loopCount,o=i===df;if(e===0)return n===-1?t:o&&(n&1)===1?r-t:t;if(i===lf){n===-1&&(this._loopCount=0,this._setEndings(!0,!0,!1));e:{if(t>=r)t=r;else if(t<0)t=0;else break e;this.clampWhenFinished?this.paused=!0:this.enabled=!1,this._mixer.dispatchEvent({type:"finished",action:this,direction:e<0?-1:1})}}else{if(n===-1&&(e>=0?(n=0,this._setEndings(!0,this.repetitions===0,o)):this._setEndings(this.repetitions===0,!0,o)),t>=r||t<0){var a=Math.floor(t/r);t-=r*a,n+=Math.abs(a);var s=this.repetitions-n;if(s<=0)this.clampWhenFinished?this.paused=!0:this.enabled=!1,t=e>0?r:0,this._mixer.dispatchEvent({type:"finished",action:this,direction:e>0?1:-1});else{if(s===1){var f=e<0;this._setEndings(f,!f,o)}else this._setEndings(!1,!1,o);this._loopCount=n,this._mixer.dispatchEvent({type:"loop",action:this,loopDelta:a})}}if(o&&(n&1)===1)return this.time=t,r-t}return this.time=t,t},_setEndings:function(e,t,r){var i=this._interpolantSettings;r?(i.endingStart=Or,i.endingEnd=Or):(e?i.endingStart=this.zeroSlopeAtStart?Or:Ir:i.endingStart=Ii,t?i.endingEnd=this.zeroSlopeAtEnd?Or:Ir:i.endingEnd=Ii)},_scheduleFading:function(e,t,r){var i=this._mixer,n=i.time,o=this._weightInterpolant;o===null&&(o=i._lendControlInterpolant(),this._weightInterpolant=o);var a=o.parameterPositions,s=o.sampleValues;return a[0]=n,s[0]=t,a[1]=n+e,s[1]=r,this}});function ns(e){this._root=e,this._initMemoryManager(),this._accuIndex=0,this.time=0,this.timeScale=1}ns.prototype=Object.assign(Object.create(bt.prototype),{constructor:ns,_bindAction:function(e,t){var r=e._localRoot||this._root,i=e._clip.tracks,n=i.length,o=e._propertyBindings,a=e._interpolants,s=r.uuid,f=this._bindingsByRootAndName,u=f[s];u===void 0&&(u={},f[s]=u);for(var c=0;c!==n;++c){var h=i[c],l=h.name,p=u[l];if(p!==void 0)o[c]=p;else{if(p=o[c],p!==void 0){p._cacheIndex===null&&(++p.referenceCount,this._addInactiveBinding(p,s,l));continue}var d=t&&t._propertyBindings[c].binding.parsedPath;p=new va(pt.create(r,l,d),h.ValueTypeName,h.getValueSize()),++p.referenceCount,this._addInactiveBinding(p,s,l),o[c]=p}a[c].resultBuffer=p.buffer}},_activateAction:function(e){if(!this._isActiveAction(e)){if(e._cacheIndex===null){var t=(e._localRoot||this._root).uuid,r=e._clip.uuid,i=this._actionsByClip[r];this._bindAction(e,i&&i.knownActions[0]),this._addInactiveAction(e,r,t)}for(var n=e._propertyBindings,o=0,a=n.length;o!==a;++o){var s=n[o];s.useCount++===0&&(this._lendBinding(s),s.saveOriginalState())}this._lendAction(e)}},_deactivateAction:function(e){if(this._isActiveAction(e)){for(var t=e._propertyBindings,r=0,i=t.length;r!==i;++r){var n=t[r];--n.useCount===0&&(n.restoreOriginalState(),this._takeBackBinding(n))}this._takeBackAction(e)}},_initMemoryManager:function(){this._actions=[],this._nActiveActions=0,this._actionsByClip={},this._bindings=[],this._nActiveBindings=0,this._bindingsByRootAndName={},this._controlInterpolants=[],this._nActiveControlInterpolants=0;var e=this;this.stats={actions:{get total(){return e._actions.length},get inUse(){return e._nActiveActions}},bindings:{get total(){return e._bindings.length},get inUse(){return e._nActiveBindings}},controlInterpolants:{get total(){return e._controlInterpolants.length},get inUse(){return e._nActiveControlInterpolants}}}},_isActiveAction:function(e){var t=e._cacheIndex;return t!==null&&t<this._nActiveActions},_addInactiveAction:function(e,t,r){var i=this._actions,n=this._actionsByClip,o=n[t];if(o===void 0)o={knownActions:[e],actionByRoot:{}},e._byClipCacheIndex=0,n[t]=o;else{var a=o.knownActions;e._byClipCacheIndex=a.length,a.push(e)}e._cacheIndex=i.length,i.push(e),o.actionByRoot[r]=e},_removeInactiveAction:function(e){var t=this._actions,r=t[t.length-1],i=e._cacheIndex;r._cacheIndex=i,t[i]=r,t.pop(),e._cacheIndex=null;var n=e._clip.uuid,o=this._actionsByClip,a=o[n],s=a.knownActions,f=s[s.length-1],u=e._byClipCacheIndex;f._byClipCacheIndex=u,s[u]=f,s.pop(),e._byClipCacheIndex=null;var c=a.actionByRoot,h=(e._localRoot||this._root).uuid;delete c[h],s.length===0&&delete o[n],this._removeInactiveBindingsForAction(e)},_removeInactiveBindingsForAction:function(e){for(var t=e._propertyBindings,r=0,i=t.length;r!==i;++r){var n=t[r];--n.referenceCount===0&&this._removeInactiveBinding(n)}},_lendAction:function(e){var t=this._actions,r=e._cacheIndex,i=this._nActiveActions++,n=t[i];e._cacheIndex=i,t[i]=e,n._cacheIndex=r,t[r]=n},_takeBackAction:function(e){var t=this._actions,r=e._cacheIndex,i=--this._nActiveActions,n=t[i];e._cacheIndex=i,t[i]=e,n._cacheIndex=r,t[r]=n},_addInactiveBinding:function(e,t,r){var i=this._bindingsByRootAndName,n=i[t],o=this._bindings;n===void 0&&(n={},i[t]=n),n[r]=e,e._cacheIndex=o.length,o.push(e)},_removeInactiveBinding:function(e){var t=this._bindings,r=e.binding,i=r.rootNode.uuid,n=r.path,o=this._bindingsByRootAndName,a=o[i],s=t[t.length-1],f=e._cacheIndex;s._cacheIndex=f,t[f]=s,t.pop(),delete a[n];e:{for(var u in a)break e;delete o[i]}},_lendBinding:function(e){var t=this._bindings,r=e._cacheIndex,i=this._nActiveBindings++,n=t[i];e._cacheIndex=i,t[i]=e,n._cacheIndex=r,t[r]=n},_takeBackBinding:function(e){var t=this._bindings,r=e._cacheIndex,i=--this._nActiveBindings,n=t[i];e._cacheIndex=i,t[i]=e,n._cacheIndex=r,t[r]=n},_lendControlInterpolant:function(){var e=this._controlInterpolants,t=this._nActiveControlInterpolants++,r=e[t];return r===void 0&&(r=new bi(new Float32Array(2),new Float32Array(2),1,this._controlInterpolantsResultBuffer),r.__cacheIndex=t,e[t]=r),r},_takeBackControlInterpolant:function(e){var t=this._controlInterpolants,r=e.__cacheIndex,i=--this._nActiveControlInterpolants,n=t[i];e.__cacheIndex=i,t[i]=e,n.__cacheIndex=r,t[r]=n},_controlInterpolantsResultBuffer:new Float32Array(1),clipAction:function(e,t){var r=t||this._root,i=r.uuid,n=typeof e=="string"?Ft.findByName(r,e):e,o=n!==null?n.uuid:e,a=this._actionsByClip[o],s=null;if(a!==void 0){var f=a.actionByRoot[i];if(f!==void 0)return f;s=a.knownActions[0],n===null&&(n=s._clip)}if(n===null)return null;var u=new is(this,n,t);return this._bindAction(u,s),this._addInactiveAction(u,o,i),u},existingAction:function(e,t){var r=t||this._root,i=r.uuid,n=typeof e=="string"?Ft.findByName(r,e):e,o=n?n.uuid:e,a=this._actionsByClip[o];return a!==void 0&&a.actionByRoot[i]||null},stopAllAction:function(){var e=this._actions,t=this._nActiveActions,r=this._bindings,i=this._nActiveBindings;this._nActiveActions=0,this._nActiveBindings=0;for(var n=0;n!==t;++n)e[n].reset();for(var n=0;n!==i;++n)r[n].useCount=0;return this},update:function(e){e*=this.timeScale;for(var t=this._actions,r=this._nActiveActions,i=this.time+=e,n=Math.sign(e),o=this._accuIndex^=1,a=0;a!==r;++a){var s=t[a];s._update(i,e,n,o)}for(var f=this._bindings,u=this._nActiveBindings,a=0;a!==u;++a)f[a].apply(o);return this},getRoot:function(){return this._root},uncacheClip:function(e){var t=this._actions,r=e.uuid,i=this._actionsByClip,n=i[r];if(n!==void 0){for(var o=n.knownActions,a=0,s=o.length;a!==s;++a){var f=o[a];this._deactivateAction(f);var u=f._cacheIndex,c=t[t.length-1];f._cacheIndex=null,f._byClipCacheIndex=null,c._cacheIndex=u,t[u]=c,t.pop(),this._removeInactiveBindingsForAction(f)}delete i[r]}},uncacheRoot:function(e){var t=e.uuid,r=this._actionsByClip;for(var i in r){var n=r[i].actionByRoot,o=n[t];o!==void 0&&(this._deactivateAction(o),this._removeInactiveAction(o))}var a=this._bindingsByRootAndName,s=a[t];if(s!==void 0)for(var f in s){var u=s[f];u.restoreOriginalState(),this._removeInactiveBinding(u)}},uncacheAction:function(e,t){var r=this.existingAction(e,t);r!==null&&(this._deactivateAction(r),this._removeInactiveAction(r))}});function vo(e){typeof e=="string"&&(console.warn("THREE.Uniform: Type parameter is no longer needed."),e=arguments[1]),this.value=e}vo.prototype.clone=function(){return new vo(this.value.clone===void 0?this.value:this.value.clone())};function os(){z.call(this),this.type="InstancedBufferGeometry",this.maxInstancedCount=void 0}os.prototype=Object.assign(Object.create(z.prototype),{constructor:os,isInstancedBufferGeometry:!0,copy:function(e){return z.prototype.copy.call(this,e),this.maxInstancedCount=e.maxInstancedCount,this},clone:function(){return new this.constructor().copy(this)}});function as(e,t,r){Tr.call(this,e,t),this.meshPerAttribute=r||1}as.prototype=Object.assign(Object.create(Tr.prototype),{constructor:as,isInstancedInterleavedBuffer:!0,copy:function(e){return Tr.prototype.copy.call(this,e),this.meshPerAttribute=e.meshPerAttribute,this}});function ss(e,t,r,i){typeof r=="number"&&(i=r,r=!1,console.error("THREE.InstancedBufferAttribute: The constructor now expects normalized as the third argument.")),ye.call(this,e,t,r),this.meshPerAttribute=i||1}ss.prototype=Object.assign(Object.create(ye.prototype),{constructor:ss,isInstancedBufferAttribute:!0,copy:function(e){return ye.prototype.copy.call(this,e),this.meshPerAttribute=e.meshPerAttribute,this}});function Wh(e,t,r,i){this.ray=new kt(e,t),this.near=r||0,this.far=i||1/0,this.params={Mesh:{},Line:{},LOD:{},Points:{threshold:1},Sprite:{}},Object.defineProperties(this.params,{PointCloud:{get:function(){return console.warn("THREE.Raycaster: params.PointCloud has been renamed to params.Points."),this.Points}}})}function kh(e,t){return e.distance-t.distance}function fs(e,t,r,i){if(e.visible!==!1&&(e.raycast(t,r),i===!0))for(var n=e.children,o=0,a=n.length;o<a;o++)fs(n[o],t,r,!0)}Object.assign(Wh.prototype,{linePrecision:1,set:function(e,t){this.ray.set(e,t)},setFromCamera:function(e,t){t&&t.isPerspectiveCamera?(this.ray.origin.setFromMatrixPosition(t.matrixWorld),this.ray.direction.set(e.x,e.y,.5).unproject(t).sub(this.ray.origin).normalize()):t&&t.isOrthographicCamera?(this.ray.origin.set(e.x,e.y,(t.near+t.far)/(t.near-t.far)).unproject(t),this.ray.direction.set(0,0,-1).transformDirection(t.matrixWorld)):console.error("THREE.Raycaster: Unsupported camera type.")},intersectObject:function(e,t,r){var i=r||[];return fs(e,this,i,t),i.sort(kh),i},intersectObjects:function(e,t,r){var i=r||[];if(Array.isArray(e)===!1)return console.warn("THREE.Raycaster.intersectObjects: objects is not an Array."),i;for(var n=0,o=e.length;n<o;n++)fs(e[n],this,i,t);return i.sort(kh),i}});function Xh(e,t,r){return this.radius=e!==void 0?e:1,this.phi=t!==void 0?t:0,this.theta=r!==void 0?r:0,this}Object.assign(Xh.prototype,{set:function(e,t,r){return this.radius=e,this.phi=t,this.theta=r,this},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.radius=e.radius,this.phi=e.phi,this.theta=e.theta,this},makeSafe:function(){var e=1e-6;return this.phi=Math.max(e,Math.min(Math.PI-e,this.phi)),this},setFromVector3:function(e){return this.setFromCartesianCoords(e.x,e.y,e.z)},setFromCartesianCoords:function(e,t,r){return this.radius=Math.sqrt(e*e+t*t+r*r),this.radius===0?(this.theta=0,this.phi=0):(this.theta=Math.atan2(e,r),this.phi=Math.acos(ie.clamp(t/this.radius,-1,1))),this}});function jh(e,t,r){return this.radius=e!==void 0?e:1,this.theta=t!==void 0?t:0,this.y=r!==void 0?r:0,this}Object.assign(jh.prototype,{set:function(e,t,r){return this.radius=e,this.theta=t,this.y=r,this},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.radius=e.radius,this.theta=e.theta,this.y=e.y,this},setFromVector3:function(e){return this.setFromCartesianCoords(e.x,e.y,e.z)},setFromCartesianCoords:function(e,t,r){return this.radius=Math.sqrt(e*e+r*r),this.theta=Math.atan2(e,r),this.y=t,this}});function ga(e,t){this.min=e!==void 0?e:new O(1/0,1/0),this.max=t!==void 0?t:new O(-1/0,-1/0)}Object.assign(ga.prototype,{set:function(e,t){return this.min.copy(e),this.max.copy(t),this},setFromPoints:function(e){this.makeEmpty();for(var t=0,r=e.length;t<r;t++)this.expandByPoint(e[t]);return this},setFromCenterAndSize:function(){var e=new O;return function(r,i){var n=e.copy(i).multiplyScalar(.5);return this.min.copy(r).sub(n),this.max.copy(r).add(n),this}}(),clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.min.copy(e.min),this.max.copy(e.max),this},makeEmpty:function(){return this.min.x=this.min.y=1/0,this.max.x=this.max.y=-1/0,this},isEmpty:function(){return this.max.x<this.min.x||this.max.y<this.min.y},getCenter:function(e){return e===void 0&&(console.warn("THREE.Box2: .getCenter() target is now required"),e=new O),this.isEmpty()?e.set(0,0):e.addVectors(this.min,this.max).multiplyScalar(.5)},getSize:function(e){return e===void 0&&(console.warn("THREE.Box2: .getSize() target is now required"),e=new O),this.isEmpty()?e.set(0,0):e.subVectors(this.max,this.min)},expandByPoint:function(e){return this.min.min(e),this.max.max(e),this},expandByVector:function(e){return this.min.sub(e),this.max.add(e),this},expandByScalar:function(e){return this.min.addScalar(-e),this.max.addScalar(e),this},containsPoint:function(e){return!(e.x<this.min.x||e.x>this.max.x||e.y<this.min.y||e.y>this.max.y)},containsBox:function(e){return this.min.x<=e.min.x&&e.max.x<=this.max.x&&this.min.y<=e.min.y&&e.max.y<=this.max.y},getParameter:function(e,t){return t===void 0&&(console.warn("THREE.Box2: .getParameter() target is now required"),t=new O),t.set((e.x-this.min.x)/(this.max.x-this.min.x),(e.y-this.min.y)/(this.max.y-this.min.y))},intersectsBox:function(e){return!(e.max.x<this.min.x||e.min.x>this.max.x||e.max.y<this.min.y||e.min.y>this.max.y)},clampPoint:function(e,t){return t===void 0&&(console.warn("THREE.Box2: .clampPoint() target is now required"),t=new O),t.copy(e).clamp(this.min,this.max)},distanceToPoint:function(){var e=new O;return function(r){var i=e.copy(r).clamp(this.min,this.max);return i.sub(r).length()}}(),intersect:function(e){return this.min.max(e.min),this.max.min(e.max),this},union:function(e){return this.min.min(e.min),this.max.max(e.max),this},translate:function(e){return this.min.add(e),this.max.add(e),this},equals:function(e){return e.min.equals(this.min)&&e.max.equals(this.max)}});function ya(e,t){this.start=e!==void 0?e:new x,this.end=t!==void 0?t:new x}Object.assign(ya.prototype,{set:function(e,t){return this.start.copy(e),this.end.copy(t),this},clone:function(){return new this.constructor().copy(this)},copy:function(e){return this.start.copy(e.start),this.end.copy(e.end),this},getCenter:function(e){return e===void 0&&(console.warn("THREE.Line3: .getCenter() target is now required"),e=new x),e.addVectors(this.start,this.end).multiplyScalar(.5)},delta:function(e){return e===void 0&&(console.warn("THREE.Line3: .delta() target is now required"),e=new x),e.subVectors(this.end,this.start)},distanceSq:function(){return this.start.distanceToSquared(this.end)},distance:function(){return this.start.distanceTo(this.end)},at:function(e,t){return t===void 0&&(console.warn("THREE.Line3: .at() target is now required"),t=new x),this.delta(t).multiplyScalar(e).add(this.start)},closestPointToPointParameter:function(){var e=new x,t=new x;return function(i,n){e.subVectors(i,this.start),t.subVectors(this.end,this.start);var o=t.dot(t),a=t.dot(e),s=a/o;return n&&(s=ie.clamp(s,0,1)),s}}(),closestPointToPoint:function(e,t,r){var i=this.closestPointToPointParameter(e,t);return r===void 0&&(console.warn("THREE.Line3: .closestPointToPoint() target is now required"),r=new x),this.delta(r).multiplyScalar(i).add(this.start)},applyMatrix4:function(e){return this.start.applyMatrix4(e),this.end.applyMatrix4(e),this},equals:function(e){return e.start.equals(this.start)&&e.end.equals(this.end)}});function go(e){k.call(this),this.material=e,this.render=function(){}}go.prototype=Object.create(k.prototype);go.prototype.constructor=go;go.prototype.isImmediateRenderObject=!0;function yo(e,t,r,i){this.object=e,this.size=t!==void 0?t:1;var n=r!==void 0?r:16711680,o=i!==void 0?i:1,a=0,s=this.object.geometry;s&&s.isGeometry?a=s.faces.length*3:s&&s.isBufferGeometry&&(a=s.attributes.normal.count);var f=new z,u=new G(a*2*3,3);f.addAttribute("position",u),Ae.call(this,f,new xe({color:n,linewidth:o})),this.matrixAutoUpdate=!1,this.update()}yo.prototype=Object.create(Ae.prototype);yo.prototype.constructor=yo;yo.prototype.update=function(){var e=new x,t=new x,r=new Oe;return function(){var n=["a","b","c"];this.object.updateMatrixWorld(!0),r.getNormalMatrix(this.object.matrixWorld);var o=this.object.matrixWorld,a=this.geometry.attributes.position,s=this.object.geometry;if(s&&s.isGeometry)for(var f=s.vertices,u=s.faces,c=0,h=0,l=u.length;h<l;h++)for(var p=u[h],d=0,m=p.vertexNormals.length;d<m;d++){var v=f[p[n[d]]],g=p.vertexNormals[d];e.copy(v).applyMatrix4(o),t.copy(g).applyMatrix3(r).normalize().multiplyScalar(this.size).add(e),a.setXYZ(c,e.x,e.y,e.z),c=c+1,a.setXYZ(c,t.x,t.y,t.z),c=c+1}else if(s&&s.isBufferGeometry)for(var b=s.attributes.position,w=s.attributes.normal,c=0,d=0,m=b.count;d<m;d++)e.set(b.getX(d),b.getY(d),b.getZ(d)).applyMatrix4(o),t.set(w.getX(d),w.getY(d),w.getZ(d)),t.applyMatrix3(r).normalize().multiplyScalar(this.size).add(e),a.setXYZ(c,e.x,e.y,e.z),c=c+1,a.setXYZ(c,t.x,t.y,t.z),c=c+1;a.needsUpdate=!0}}();function pn(e,t){k.call(this),this.light=e,this.light.updateMatrixWorld(),this.matrix=e.matrixWorld,this.matrixAutoUpdate=!1,this.color=t;for(var r=new z,i=[0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,-1,0,1,0,0,0,0,1,1,0,0,0,0,-1,1],n=0,o=1,a=32;n<a;n++,o++){var s=n/a*Math.PI*2,f=o/a*Math.PI*2;i.push(Math.cos(s),Math.sin(s),1,Math.cos(f),Math.sin(f),1)}r.addAttribute("position",new G(i,3));var u=new xe({fog:!1});this.cone=new Ae(r,u),this.add(this.cone),this.update()}pn.prototype=Object.create(k.prototype);pn.prototype.constructor=pn;pn.prototype.dispose=function(){this.cone.geometry.dispose(),this.cone.material.dispose()};pn.prototype.update=function(){var e=new x;return function(){this.light.updateMatrixWorld();var r=this.light.distance?this.light.distance:1e3,i=r*Math.tan(this.light.angle);this.cone.scale.set(i,i,r),e.setFromMatrixPosition(this.light.target.matrixWorld),this.cone.lookAt(e),this.color!==void 0?this.cone.material.color.set(this.color):this.cone.material.color.copy(this.light.color)}}();function qh(e){var t=[];e&&e.isBone&&t.push(e);for(var r=0;r<e.children.length;r++)t.push.apply(t,qh(e.children[r]));return t}function Si(e){for(var t=qh(e),r=new z,i=[],n=[],o=new J(0,0,1),a=new J(0,1,0),s=0;s<t.length;s++){var f=t[s];f.parent&&f.parent.isBone&&(i.push(0,0,0),i.push(0,0,0),n.push(o.r,o.g,o.b),n.push(a.r,a.g,a.b))}r.addAttribute("position",new G(i,3)),r.addAttribute("color",new G(n,3));var u=new xe({vertexColors:zt,depthTest:!1,depthWrite:!1,transparent:!0});Ae.call(this,r,u),this.root=e,this.bones=t,this.matrix=e.matrixWorld,this.matrixAutoUpdate=!1}Si.prototype=Object.create(Ae.prototype);Si.prototype.constructor=Si;Si.prototype.updateMatrixWorld=function(){var e=new x,t=new ee,r=new ee;return function(n){var o=this.bones,a=this.geometry,s=a.getAttribute("position");r.getInverse(this.root.matrixWorld);for(var f=0,u=0;f<o.length;f++){var c=o[f];c.parent&&c.parent.isBone&&(t.multiplyMatrices(r,c.matrixWorld),e.setFromMatrixPosition(t),s.setXYZ(u,e.x,e.y,e.z),t.multiplyMatrices(r,c.parent.matrixWorld),e.setFromMatrixPosition(t),s.setXYZ(u+1,e.x,e.y,e.z),u+=2)}a.getAttribute("position").needsUpdate=!0,k.prototype.updateMatrixWorld.call(this,n)}}();function dn(e,t,r){this.light=e,this.light.updateMatrixWorld(),this.color=r;var i=new Yr(t,4,2),n=new ot({wireframe:!0,fog:!1});Xe.call(this,i,n),this.matrix=this.light.matrixWorld,this.matrixAutoUpdate=!1,this.update()}dn.prototype=Object.create(Xe.prototype);dn.prototype.constructor=dn;dn.prototype.dispose=function(){this.geometry.dispose(),this.material.dispose()};dn.prototype.update=function(){this.color!==void 0?this.material.color.set(this.color):this.material.color.copy(this.light.color)};function mn(e,t){this.type="RectAreaLightHelper",this.light=e,this.color=t;var r=[1,1,0,-1,1,0,-1,-1,0,1,-1,0,1,1,0],i=new z;i.addAttribute("position",new G(r,3)),i.computeBoundingSphere();var n=new xe({fog:!1});Ke.call(this,i,n);var o=[1,1,0,-1,1,0,-1,-1,0,1,1,0,-1,-1,0,1,-1,0],a=new z;a.addAttribute("position",new G(o,3)),a.computeBoundingSphere(),this.add(new Xe(a,new ot({side:THREE.BackSide,fog:!1}))),this.update()}mn.prototype=Object.create(Ke.prototype);mn.prototype.constructor=mn;mn.prototype.update=function(){if(this.scale.set(.5*this.light.width,.5*this.light.height,1),this.color!==void 0)this.material.color.set(this.color),this.children[0].material.color.set(this.color);else{this.material.color.copy(this.light.color).multiplyScalar(this.light.intensity);var e=this.material.color,t=Math.max(e.r,e.g,e.b);t>1&&e.multiplyScalar(1/t),this.children[0].material.color.copy(this.material.color)}};mn.prototype.dispose=function(){this.geometry.dispose(),this.material.dispose(),this.children[0].geometry.dispose(),this.children[0].material.dispose()};function vn(e,t,r){k.call(this),this.light=e,this.light.updateMatrixWorld(),this.matrix=e.matrixWorld,this.matrixAutoUpdate=!1,this.color=r;var i=new jr(t);i.rotateY(Math.PI*.5),this.material=new ot({wireframe:!0,fog:!1}),this.color===void 0&&(this.material.vertexColors=zt);var n=i.getAttribute("position"),o=new Float32Array(n.count*3);i.addAttribute("color",new ye(o,3)),this.add(new Xe(i,this.material)),this.update()}vn.prototype=Object.create(k.prototype);vn.prototype.constructor=vn;vn.prototype.dispose=function(){this.children[0].geometry.dispose(),this.children[0].material.dispose()};vn.prototype.update=function(){var e=new x,t=new J,r=new J;return function(){var n=this.children[0];if(this.color!==void 0)this.material.color.set(this.color);else{var o=n.geometry.getAttribute("color");t.copy(this.light.color),r.copy(this.light.groundColor);for(var a=0,s=o.count;a<s;a++){var f=a<s/2?t:r;o.setXYZ(a,f.r,f.g,f.b)}o.needsUpdate=!0}n.lookAt(e.setFromMatrixPosition(this.light.matrixWorld).negate())}}();function gn(e,t,r,i){e=e||10,t=t||10,r=new J(r!==void 0?r:4473924),i=new J(i!==void 0?i:8947848);for(var n=t/2,o=e/t,a=e/2,s=[],f=[],u=0,c=0,h=-a;u<=t;u++,h+=o){s.push(-a,0,h,a,0,h),s.push(h,0,-a,h,0,a);var l=u===n?r:i;l.toArray(f,c),c+=3,l.toArray(f,c),c+=3,l.toArray(f,c),c+=3,l.toArray(f,c),c+=3}var p=new z;p.addAttribute("position",new G(s,3)),p.addAttribute("color",new G(f,3));var d=new xe({vertexColors:zt});Ae.call(this,p,d)}gn.prototype=Object.create(Ae.prototype);gn.prototype.constructor=gn;function xa(e,t,r,i,n,o){e=e||10,t=t||16,r=r||8,i=i||64,n=new J(n!==void 0?n:4473924),o=new J(o!==void 0?o:8947848);var a=[],s=[],f,u,c,h,l,p,d;for(h=0;h<=t;h++)c=h/t*(Math.PI*2),f=Math.sin(c)*e,u=Math.cos(c)*e,a.push(0,0,0),a.push(f,0,u),d=h&1?n:o,s.push(d.r,d.g,d.b),s.push(d.r,d.g,d.b);for(h=0;h<=r;h++)for(d=h&1?n:o,p=e-e/r*h,l=0;l<i;l++)c=l/i*(Math.PI*2),f=Math.sin(c)*p,u=Math.cos(c)*p,a.push(f,0,u),s.push(d.r,d.g,d.b),c=(l+1)/i*(Math.PI*2),f=Math.sin(c)*p,u=Math.cos(c)*p,a.push(f,0,u),s.push(d.r,d.g,d.b);var m=new z;m.addAttribute("position",new G(a,3)),m.addAttribute("color",new G(s,3));var v=new xe({vertexColors:zt});Ae.call(this,m,v)}xa.prototype=Object.create(Ae.prototype);xa.prototype.constructor=xa;function xo(e,t,r,i){this.object=e,this.size=t!==void 0?t:1;var n=r!==void 0?r:16776960,o=i!==void 0?i:1,a=0,s=this.object.geometry;s&&s.isGeometry?a=s.faces.length:console.warn("THREE.FaceNormalsHelper: only THREE.Geometry is supported. Use THREE.VertexNormalsHelper, instead.");var f=new z,u=new G(a*2*3,3);f.addAttribute("position",u),Ae.call(this,f,new xe({color:n,linewidth:o})),this.matrixAutoUpdate=!1,this.update()}xo.prototype=Object.create(Ae.prototype);xo.prototype.constructor=xo;xo.prototype.update=function(){var e=new x,t=new x,r=new Oe;return function(){this.object.updateMatrixWorld(!0),r.getNormalMatrix(this.object.matrixWorld);for(var n=this.object.matrixWorld,o=this.geometry.attributes.position,a=this.object.geometry,s=a.vertices,f=a.faces,u=0,c=0,h=f.length;c<h;c++){var l=f[c],p=l.normal;e.copy(s[l.a]).add(s[l.b]).add(s[l.c]).divideScalar(3).applyMatrix4(n),t.copy(p).applyMatrix3(r).normalize().multiplyScalar(this.size).add(e),o.setXYZ(u,e.x,e.y,e.z),u=u+1,o.setXYZ(u,t.x,t.y,t.z),u=u+1}o.needsUpdate=!0}}();function yn(e,t,r){k.call(this),this.light=e,this.light.updateMatrixWorld(),this.matrix=e.matrixWorld,this.matrixAutoUpdate=!1,this.color=r,t===void 0&&(t=1);var i=new z;i.addAttribute("position",new G([-t,t,0,t,t,0,t,-t,0,-t,-t,0,-t,t,0],3));var n=new xe({fog:!1});this.lightPlane=new Ke(i,n),this.add(this.lightPlane),i=new z,i.addAttribute("position",new G([0,0,0,0,0,1],3)),this.targetLine=new Ke(i,n),this.add(this.targetLine),this.update()}yn.prototype=Object.create(k.prototype);yn.prototype.constructor=yn;yn.prototype.dispose=function(){this.lightPlane.geometry.dispose(),this.lightPlane.material.dispose(),this.targetLine.geometry.dispose(),this.targetLine.material.dispose()};yn.prototype.update=function(){var e=new x,t=new x,r=new x;return function(){e.setFromMatrixPosition(this.light.matrixWorld),t.setFromMatrixPosition(this.light.target.matrixWorld),r.subVectors(t,e),this.lightPlane.lookAt(t),this.color!==void 0?(this.lightPlane.material.color.set(this.color),this.targetLine.material.color.set(this.color)):(this.lightPlane.material.color.copy(this.light.color),this.targetLine.material.color.copy(this.light.color)),this.targetLine.lookAt(t),this.targetLine.scale.z=r.length()}}();function _o(e){var t=new z,r=new xe({color:16777215,vertexColors:Po}),i=[],n=[],o={},a=new J(16755200),s=new J(16711680),f=new J(43775),u=new J(16777215),c=new J(3355443);h("n1","n2",a),h("n2","n4",a),h("n4","n3",a),h("n3","n1",a),h("f1","f2",a),h("f2","f4",a),h("f4","f3",a),h("f3","f1",a),h("n1","f1",a),h("n2","f2",a),h("n3","f3",a),h("n4","f4",a),h("p","n1",s),h("p","n2",s),h("p","n3",s),h("p","n4",s),h("u1","u2",f),h("u2","u3",f),h("u3","u1",f),h("c","t",u),h("p","c",c),h("cn1","cn2",c),h("cn3","cn4",c),h("cf1","cf2",c),h("cf3","cf4",c);function h(p,d,m){l(p,m),l(d,m)}function l(p,d){i.push(0,0,0),n.push(d.r,d.g,d.b),o[p]===void 0&&(o[p]=[]),o[p].push(i.length/3-1)}t.addAttribute("position",new G(i,3)),t.addAttribute("color",new G(n,3)),Ae.call(this,t,r),this.camera=e,this.camera.updateProjectionMatrix&&this.camera.updateProjectionMatrix(),this.matrix=e.matrixWorld,this.matrixAutoUpdate=!1,this.pointMap=o,this.update()}_o.prototype=Object.create(Ae.prototype);_o.prototype.constructor=_o;_o.prototype.update=function(){var e,t,r=new x,i=new Nt;function n(o,a,s,f){r.set(a,s,f).unproject(i);var u=t[o];if(u!==void 0)for(var c=e.getAttribute("position"),h=0,l=u.length;h<l;h++)c.setXYZ(u[h],r.x,r.y,r.z)}return function(){e=this.geometry,t=this.pointMap;var a=1,s=1;i.projectionMatrix.copy(this.camera.projectionMatrix),n("c",0,0,-1),n("t",0,0,1),n("n1",-a,-s,-1),n("n2",a,-s,-1),n("n3",-a,s,-1),n("n4",a,s,-1),n("f1",-a,-s,1),n("f2",a,-s,1),n("f3",-a,s,1),n("f4",a,s,1),n("u1",a*.7,s*1.1,-1),n("u2",-a*.7,s*1.1,-1),n("u3",0,s*2,-1),n("cf1",-a,0,1),n("cf2",a,0,1),n("cf3",0,-s,1),n("cf4",0,s,1),n("cn1",-a,0,-1),n("cn2",a,0,-1),n("cn3",0,-s,-1),n("cn4",0,s,-1),e.getAttribute("position").needsUpdate=!0}}();function Ar(e,t){this.object=e,t===void 0&&(t=16776960);var r=new Uint16Array([0,1,1,2,2,3,3,0,4,5,5,6,6,7,7,4,0,4,1,5,2,6,3,7]),i=new Float32Array(8*3),n=new z;n.setIndex(new ye(r,1)),n.addAttribute("position",new ye(i,3)),Ae.call(this,n,new xe({color:t})),this.matrixAutoUpdate=!1,this.update()}Ar.prototype=Object.create(Ae.prototype);Ar.prototype.constructor=Ar;Ar.prototype.update=function(){var e=new Pt;return function(r){if(r!==void 0&&console.warn("THREE.BoxHelper: .update() has no longer arguments."),this.object!==void 0&&e.setFromObject(this.object),!e.isEmpty()){var i=e.min,n=e.max,o=this.geometry.attributes.position,a=o.array;a[0]=n.x,a[1]=n.y,a[2]=n.z,a[3]=i.x,a[4]=n.y,a[5]=n.z,a[6]=i.x,a[7]=i.y,a[8]=n.z,a[9]=n.x,a[10]=i.y,a[11]=n.z,a[12]=n.x,a[13]=n.y,a[14]=i.z,a[15]=i.x,a[16]=n.y,a[17]=i.z,a[18]=i.x,a[19]=i.y,a[20]=i.z,a[21]=n.x,a[22]=i.y,a[23]=i.z,o.needsUpdate=!0,this.geometry.computeBoundingSphere()}}}();Ar.prototype.setFromObject=function(e){return this.object=e,this.update(),this};Ar.prototype.copy=function(e){return Ae.prototype.copy.call(this,e),this.object=e.object,this};Ar.prototype.clone=function(){return new this.constructor().copy(this)};function bo(e,t){this.type="Box3Helper",this.box=e;var r=t!==void 0?t:16776960,i=new Uint16Array([0,1,1,2,2,3,3,0,4,5,5,6,6,7,7,4,0,4,1,5,2,6,3,7]),n=[1,1,1,-1,1,1,-1,-1,1,1,-1,1,1,1,-1,-1,1,-1,-1,-1,-1,1,-1,-1],o=new z;o.setIndex(new ye(i,1)),o.addAttribute("position",new G(n,3)),Ae.call(this,o,new xe({color:r})),this.geometry.computeBoundingSphere()}bo.prototype=Object.create(Ae.prototype);bo.prototype.constructor=bo;bo.prototype.updateMatrixWorld=function(e){var t=this.box;t.isEmpty()||(t.getCenter(this.position),t.getSize(this.scale),this.scale.multiplyScalar(.5),k.prototype.updateMatrixWorld.call(this,e))};function wo(e,t,r){this.type="PlaneHelper",this.plane=e,this.size=t===void 0?1:t;var i=r!==void 0?r:16776960,n=[1,-1,1,-1,1,1,-1,-1,1,1,1,1,-1,1,1,-1,-1,1,1,-1,1,1,1,1,0,0,1,0,0,0],o=new z;o.addAttribute("position",new G(n,3)),o.computeBoundingSphere(),Ke.call(this,o,new xe({color:i}));var a=[1,1,1,-1,1,1,-1,-1,1,1,1,1,-1,-1,1,1,-1,1],s=new z;s.addAttribute("position",new G(a,3)),s.computeBoundingSphere(),this.add(new Xe(s,new ot({color:i,opacity:.2,transparent:!0,depthWrite:!1})))}wo.prototype=Object.create(Ke.prototype);wo.prototype.constructor=wo;wo.prototype.updateMatrixWorld=function(e){var t=-this.plane.constant;Math.abs(t)<1e-8&&(t=1e-8),this.scale.set(.5*this.size,.5*this.size,t),this.children[0].material.side=t<0?Ze:gr,this.lookAt(this.plane.normal),k.prototype.updateMatrixWorld.call(this,e)};var _a,us;function Lr(e,t,r,i,n,o){k.call(this),e===void 0&&(e=new THREE.Vector3(0,0,1)),t===void 0&&(t=new THREE.Vector3(0,0,0)),r===void 0&&(r=1),i===void 0&&(i=16776960),n===void 0&&(n=.2*r),o===void 0&&(o=.2*n),_a===void 0&&(_a=new z,_a.addAttribute("position",new G([0,0,0,0,1,0],3)),us=new Kt(0,.5,1,5,1),us.translate(0,-.5,0)),this.position.copy(t),this.line=new Ke(_a,new xe({color:i})),this.line.matrixAutoUpdate=!1,this.add(this.line),this.cone=new Xe(us,new ot({color:i})),this.cone.matrixAutoUpdate=!1,this.add(this.cone),this.setDirection(e),this.setLength(r,n,o)}Lr.prototype=Object.create(k.prototype);Lr.prototype.constructor=Lr;Lr.prototype.setDirection=function(){var e=new x,t;return function(i){i.y>.99999?this.quaternion.set(0,0,0,1):i.y<-.99999?this.quaternion.set(1,0,0,0):(e.set(i.z,0,-i.x).normalize(),t=Math.acos(i.y),this.quaternion.setFromAxisAngle(e,t))}}();Lr.prototype.setLength=function(e,t,r){t===void 0&&(t=.2*e),r===void 0&&(r=.2*t),this.line.scale.set(1,Math.max(0,e-t),1),this.line.updateMatrix(),this.cone.scale.set(r,t,r),this.cone.position.y=e,this.cone.updateMatrix()};Lr.prototype.setColor=function(e){this.line.material.color.copy(e),this.cone.material.color.copy(e)};Lr.prototype.copy=function(e){return k.prototype.copy.call(this,e,!1),this.line.copy(e.line),this.cone.copy(e.cone),this};Lr.prototype.clone=function(){return new this.constructor().copy(this)};function Mo(e){e=e||1;var t=[0,0,0,e,0,0,0,0,0,0,e,0,0,0,0,0,0,e],r=[1,0,0,1,.6,0,0,1,0,.6,1,0,0,0,1,0,.6,1],i=new z;i.addAttribute("position",new G(t,3)),i.addAttribute("color",new G(r,3));var n=new xe({vertexColors:zt});Ae.call(this,i,n)}Mo.prototype=Object.create(Ae.prototype);Mo.prototype.constructor=Mo;ne.create=function(e,t){return console.log("THREE.Curve.create() has been deprecated"),e.prototype=Object.create(ne.prototype),e.prototype.constructor=e,e.prototype.getPoint=t,e};Object.assign(rr.prototype,{createPointsGeometry:function(e){console.warn("THREE.CurvePath: .createPointsGeometry() has been removed. Use new THREE.Geometry().setFromPoints( points ) instead.");var t=this.getPoints(e);return this.createGeometry(t)},createSpacedPointsGeometry:function(e){console.warn("THREE.CurvePath: .createSpacedPointsGeometry() has been removed. Use new THREE.Geometry().setFromPoints( points ) instead.");var t=this.getSpacedPoints(e);return this.createGeometry(t)},createGeometry:function(e){console.warn("THREE.CurvePath: .createGeometry() has been removed. Use new THREE.Geometry().setFromPoints( points ) instead.");for(var t=new re,r=0,i=e.length;r<i;r++){var n=e[r];t.vertices.push(new x(n.x,n.y,n.z||0))}return t}});Object.assign(Dt.prototype,{fromPoints:function(e){console.warn("THREE.Path: .fromPoints() has been renamed to .setFromPoints()."),this.setFromPoints(e)}});function wp(e){console.warn("THREE.ClosedSplineCurve3 has been deprecated. Use THREE.CatmullRomCurve3 instead."),xt.call(this,e),this.type="catmullrom",this.closed=!0}wp.prototype=Object.create(xt.prototype);function Mp(e){console.warn("THREE.SplineCurve3 has been deprecated. Use THREE.CatmullRomCurve3 instead."),xt.call(this,e),this.type="catmullrom"}Mp.prototype=Object.create(xt.prototype);function Yh(e){console.warn("THREE.Spline has been removed. Use THREE.CatmullRomCurve3 instead."),xt.call(this,e),this.type="catmullrom"}Yh.prototype=Object.create(xt.prototype);Object.assign(Yh.prototype,{initFromArray:function(){console.error("THREE.Spline: .initFromArray() has been removed.")},getControlPointsArray:function(){console.error("THREE.Spline: .getControlPointsArray() has been removed.")},reparametrizeByArcLength:function(){console.error("THREE.Spline: .reparametrizeByArcLength() has been removed.")}});gn.prototype.setColors=function(){console.error("THREE.GridHelper: setColors() has been deprecated, pass them in the constructor instead.")};Si.prototype.update=function(){console.error("THREE.SkeletonHelper: update() no longer needs to be called.")};Object.assign(hn.prototype,{extractUrlBase:function(e){return console.warn("THREE.Loader: .extractUrlBase() has been deprecated. Use THREE.LoaderUtils.extractUrlBase() instead."),po.extractUrlBase(e)}});Object.assign(ua.prototype,{setTexturePath:function(e){return console.warn("THREE.ObjectLoader: .setTexturePath() has been renamed to .setResourcePath()."),this.setResourcePath(e)}});Object.assign(ga.prototype,{center:function(e){return console.warn("THREE.Box2: .center() has been renamed to .getCenter()."),this.getCenter(e)},empty:function(){return console.warn("THREE.Box2: .empty() has been renamed to .isEmpty()."),this.isEmpty()},isIntersectionBox:function(e){return console.warn("THREE.Box2: .isIntersectionBox() has been renamed to .intersectsBox()."),this.intersectsBox(e)},size:function(e){return console.warn("THREE.Box2: .size() has been renamed to .getSize()."),this.getSize(e)}});Object.assign(Pt.prototype,{center:function(e){return console.warn("THREE.Box3: .center() has been renamed to .getCenter()."),this.getCenter(e)},empty:function(){return console.warn("THREE.Box3: .empty() has been renamed to .isEmpty()."),this.isEmpty()},isIntersectionBox:function(e){return console.warn("THREE.Box3: .isIntersectionBox() has been renamed to .intersectsBox()."),this.intersectsBox(e)},isIntersectionSphere:function(e){return console.warn("THREE.Box3: .isIntersectionSphere() has been renamed to .intersectsSphere()."),this.intersectsSphere(e)},size:function(e){return console.warn("THREE.Box3: .size() has been renamed to .getSize()."),this.getSize(e)}});ya.prototype.center=function(e){return console.warn("THREE.Line3: .center() has been renamed to .getCenter()."),this.getCenter(e)};Object.assign(ie,{random16:function(){return console.warn("THREE.Math: .random16() has been deprecated. Use Math.random() instead."),Math.random()},nearestPowerOfTwo:function(e){return console.warn("THREE.Math: .nearestPowerOfTwo() has been renamed to .floorPowerOfTwo()."),ie.floorPowerOfTwo(e)},nextPowerOfTwo:function(e){return console.warn("THREE.Math: .nextPowerOfTwo() has been renamed to .ceilPowerOfTwo()."),ie.ceilPowerOfTwo(e)}});Object.assign(Oe.prototype,{flattenToArrayOffset:function(e,t){return console.warn("THREE.Matrix3: .flattenToArrayOffset() has been deprecated. Use .toArray() instead."),this.toArray(e,t)},multiplyVector3:function(e){return console.warn("THREE.Matrix3: .multiplyVector3() has been removed. Use vector.applyMatrix3( matrix ) instead."),e.applyMatrix3(this)},multiplyVector3Array:function(){console.error("THREE.Matrix3: .multiplyVector3Array() has been removed.")},applyToBuffer:function(e){return console.warn("THREE.Matrix3: .applyToBuffer() has been removed. Use matrix.applyToBufferAttribute( attribute ) instead."),this.applyToBufferAttribute(e)},applyToVector3Array:function(){console.error("THREE.Matrix3: .applyToVector3Array() has been removed.")}});Object.assign(ee.prototype,{extractPosition:function(e){return console.warn("THREE.Matrix4: .extractPosition() has been renamed to .copyPosition()."),this.copyPosition(e)},flattenToArrayOffset:function(e,t){return console.warn("THREE.Matrix4: .flattenToArrayOffset() has been deprecated. Use .toArray() instead."),this.toArray(e,t)},getPosition:function(){var e;return function(){return e===void 0&&(e=new x),console.warn("THREE.Matrix4: .getPosition() has been removed. Use Vector3.setFromMatrixPosition( matrix ) instead."),e.setFromMatrixColumn(this,3)}}(),setRotationFromQuaternion:function(e){return console.warn("THREE.Matrix4: .setRotationFromQuaternion() has been renamed to .makeRotationFromQuaternion()."),this.makeRotationFromQuaternion(e)},multiplyToArray:function(){console.warn("THREE.Matrix4: .multiplyToArray() has been removed.")},multiplyVector3:function(e){return console.warn("THREE.Matrix4: .multiplyVector3() has been removed. Use vector.applyMatrix4( matrix ) instead."),e.applyMatrix4(this)},multiplyVector4:function(e){return console.warn("THREE.Matrix4: .multiplyVector4() has been removed. Use vector.applyMatrix4( matrix ) instead."),e.applyMatrix4(this)},multiplyVector3Array:function(){console.error("THREE.Matrix4: .multiplyVector3Array() has been removed.")},rotateAxis:function(e){console.warn("THREE.Matrix4: .rotateAxis() has been removed. Use Vector3.transformDirection( matrix ) instead."),e.transformDirection(this)},crossVector:function(e){return console.warn("THREE.Matrix4: .crossVector() has been removed. Use vector.applyMatrix4( matrix ) instead."),e.applyMatrix4(this)},translate:function(){console.error("THREE.Matrix4: .translate() has been removed.")},rotateX:function(){console.error("THREE.Matrix4: .rotateX() has been removed.")},rotateY:function(){console.error("THREE.Matrix4: .rotateY() has been removed.")},rotateZ:function(){console.error("THREE.Matrix4: .rotateZ() has been removed.")},rotateByAxis:function(){console.error("THREE.Matrix4: .rotateByAxis() has been removed.")},applyToBuffer:function(e){return console.warn("THREE.Matrix4: .applyToBuffer() has been removed. Use matrix.applyToBufferAttribute( attribute ) instead."),this.applyToBufferAttribute(e)},applyToVector3Array:function(){console.error("THREE.Matrix4: .applyToVector3Array() has been removed.")},makeFrustum:function(e,t,r,i,n,o){return console.warn("THREE.Matrix4: .makeFrustum() has been removed. Use .makePerspective( left, right, top, bottom, near, far ) instead."),this.makePerspective(e,t,i,r,n,o)}});Ut.prototype.isIntersectionLine=function(e){return console.warn("THREE.Plane: .isIntersectionLine() has been renamed to .intersectsLine()."),this.intersectsLine(e)};Ge.prototype.multiplyVector3=function(e){return console.warn("THREE.Quaternion: .multiplyVector3() has been removed. Use is now vector.applyQuaternion( quaternion ) instead."),e.applyQuaternion(this)};Object.assign(kt.prototype,{isIntersectionBox:function(e){return console.warn("THREE.Ray: .isIntersectionBox() has been renamed to .intersectsBox()."),this.intersectsBox(e)},isIntersectionPlane:function(e){return console.warn("THREE.Ray: .isIntersectionPlane() has been renamed to .intersectsPlane()."),this.intersectsPlane(e)},isIntersectionSphere:function(e){return console.warn("THREE.Ray: .isIntersectionSphere() has been renamed to .intersectsSphere()."),this.intersectsSphere(e)}});Object.assign(nt.prototype,{area:function(){return console.warn("THREE.Triangle: .area() has been renamed to .getArea()."),this.getArea()},barycoordFromPoint:function(e,t){return console.warn("THREE.Triangle: .barycoordFromPoint() has been renamed to .getBarycoord()."),this.getBarycoord(e,t)},midpoint:function(e){return console.warn("THREE.Triangle: .midpoint() has been renamed to .getMidpoint()."),this.getMidpoint(e)},normal:function(e){return console.warn("THREE.Triangle: .normal() has been renamed to .getNormal()."),this.getNormal(e)},plane:function(e){return console.warn("THREE.Triangle: .plane() has been renamed to .getPlane()."),this.getPlane(e)}});Object.assign(nt,{barycoordFromPoint:function(e,t,r,i,n){return console.warn("THREE.Triangle: .barycoordFromPoint() has been renamed to .getBarycoord()."),nt.getBarycoord(e,t,r,i,n)},normal:function(e,t,r,i){return console.warn("THREE.Triangle: .normal() has been renamed to .getNormal()."),nt.getNormal(e,t,r,i)}});Object.assign(ir.prototype,{extractAllPoints:function(e){return console.warn("THREE.Shape: .extractAllPoints() has been removed. Use .extractPoints() instead."),this.extractPoints(e)},extrude:function(e){return console.warn("THREE.Shape: .extrude() has been removed. Use ExtrudeGeometry() instead."),new qr(this,e)},makeGeometry:function(e){return console.warn("THREE.Shape: .makeGeometry() has been removed. Use ShapeGeometry() instead."),new Zr(this,e)}});Object.assign(O.prototype,{fromAttribute:function(e,t,r){return console.warn("THREE.Vector2: .fromAttribute() has been renamed to .fromBufferAttribute()."),this.fromBufferAttribute(e,t,r)},distanceToManhattan:function(e){return console.warn("THREE.Vector2: .distanceToManhattan() has been renamed to .manhattanDistanceTo()."),this.manhattanDistanceTo(e)},lengthManhattan:function(){return console.warn("THREE.Vector2: .lengthManhattan() has been renamed to .manhattanLength()."),this.manhattanLength()}});Object.assign(x.prototype,{setEulerFromRotationMatrix:function(){console.error("THREE.Vector3: .setEulerFromRotationMatrix() has been removed. Use Euler.setFromRotationMatrix() instead.")},setEulerFromQuaternion:function(){console.error("THREE.Vector3: .setEulerFromQuaternion() has been removed. Use Euler.setFromQuaternion() instead.")},getPositionFromMatrix:function(e){return console.warn("THREE.Vector3: .getPositionFromMatrix() has been renamed to .setFromMatrixPosition()."),this.setFromMatrixPosition(e)},getScaleFromMatrix:function(e){return console.warn("THREE.Vector3: .getScaleFromMatrix() has been renamed to .setFromMatrixScale()."),this.setFromMatrixScale(e)},getColumnFromMatrix:function(e,t){return console.warn("THREE.Vector3: .getColumnFromMatrix() has been renamed to .setFromMatrixColumn()."),this.setFromMatrixColumn(t,e)},applyProjection:function(e){return console.warn("THREE.Vector3: .applyProjection() has been removed. Use .applyMatrix4( m ) instead."),this.applyMatrix4(e)},fromAttribute:function(e,t,r){return console.warn("THREE.Vector3: .fromAttribute() has been renamed to .fromBufferAttribute()."),this.fromBufferAttribute(e,t,r)},distanceToManhattan:function(e){return console.warn("THREE.Vector3: .distanceToManhattan() has been renamed to .manhattanDistanceTo()."),this.manhattanDistanceTo(e)},lengthManhattan:function(){return console.warn("THREE.Vector3: .lengthManhattan() has been renamed to .manhattanLength()."),this.manhattanLength()}});Object.assign(we.prototype,{fromAttribute:function(e,t,r){return console.warn("THREE.Vector4: .fromAttribute() has been renamed to .fromBufferAttribute()."),this.fromBufferAttribute(e,t,r)},lengthManhattan:function(){return console.warn("THREE.Vector4: .lengthManhattan() has been renamed to .manhattanLength()."),this.manhattanLength()}});Object.assign(re.prototype,{computeTangents:function(){console.error("THREE.Geometry: .computeTangents() has been removed.")},computeLineDistances:function(){console.error("THREE.Geometry: .computeLineDistances() has been removed. Use THREE.Line.computeLineDistances() instead.")}});Object.assign(k.prototype,{getChildByName:function(e){return console.warn("THREE.Object3D: .getChildByName() has been renamed to .getObjectByName()."),this.getObjectByName(e)},renderDepth:function(){console.warn("THREE.Object3D: .renderDepth has been removed. Use .renderOrder, instead.")},translate:function(e,t){return console.warn("THREE.Object3D: .translate() has been removed. Use .translateOnAxis( axis, distance ) instead."),this.translateOnAxis(t,e)},getWorldRotation:function(){console.error("THREE.Object3D: .getWorldRotation() has been removed. Use THREE.Object3D.getWorldQuaternion( target ) instead.")}});Object.defineProperties(k.prototype,{eulerOrder:{get:function(){return console.warn("THREE.Object3D: .eulerOrder is now .rotation.order."),this.rotation.order},set:function(e){console.warn("THREE.Object3D: .eulerOrder is now .rotation.order."),this.rotation.order=e}},useQuaternion:{get:function(){console.warn("THREE.Object3D: .useQuaternion has been removed. The library now uses quaternions by default.")},set:function(){console.warn("THREE.Object3D: .useQuaternion has been removed. The library now uses quaternions by default.")}}});Object.defineProperties(ui.prototype,{objects:{get:function(){return console.warn("THREE.LOD: .objects has been renamed to .levels."),this.levels}}});Object.defineProperty(Ln.prototype,"useVertexTexture",{get:function(){console.warn("THREE.Skeleton: useVertexTexture has been removed.")},set:function(){console.warn("THREE.Skeleton: useVertexTexture has been removed.")}});ci.prototype.initBones=function(){console.error("THREE.SkinnedMesh: initBones() has been removed.")};Object.defineProperty(ne.prototype,"__arcLengthDivisions",{get:function(){return console.warn("THREE.Curve: .__arcLengthDivisions is now .arcLengthDivisions."),this.arcLengthDivisions},set:function(e){console.warn("THREE.Curve: .__arcLengthDivisions is now .arcLengthDivisions."),this.arcLengthDivisions=e}});De.prototype.setLens=function(e,t){console.warn("THREE.PerspectiveCamera.setLens is deprecated. Use .setFocalLength and .filmGauge for a photographic setup."),t!==void 0&&(this.filmGauge=t),this.setFocalLength(e)};Object.defineProperties(Ue.prototype,{onlyShadow:{set:function(){console.warn("THREE.Light: .onlyShadow has been removed.")}},shadowCameraFov:{set:function(e){console.warn("THREE.Light: .shadowCameraFov is now .shadow.camera.fov."),this.shadow.camera.fov=e}},shadowCameraLeft:{set:function(e){console.warn("THREE.Light: .shadowCameraLeft is now .shadow.camera.left."),this.shadow.camera.left=e}},shadowCameraRight:{set:function(e){console.warn("THREE.Light: .shadowCameraRight is now .shadow.camera.right."),this.shadow.camera.right=e}},shadowCameraTop:{set:function(e){console.warn("THREE.Light: .shadowCameraTop is now .shadow.camera.top."),this.shadow.camera.top=e}},shadowCameraBottom:{set:function(e){console.warn("THREE.Light: .shadowCameraBottom is now .shadow.camera.bottom."),this.shadow.camera.bottom=e}},shadowCameraNear:{set:function(e){console.warn("THREE.Light: .shadowCameraNear is now .shadow.camera.near."),this.shadow.camera.near=e}},shadowCameraFar:{set:function(e){console.warn("THREE.Light: .shadowCameraFar is now .shadow.camera.far."),this.shadow.camera.far=e}},shadowCameraVisible:{set:function(){console.warn("THREE.Light: .shadowCameraVisible has been removed. Use new THREE.CameraHelper( light.shadow.camera ) instead.")}},shadowBias:{set:function(e){console.warn("THREE.Light: .shadowBias is now .shadow.bias."),this.shadow.bias=e}},shadowDarkness:{set:function(){console.warn("THREE.Light: .shadowDarkness has been removed.")}},shadowMapWidth:{set:function(e){console.warn("THREE.Light: .shadowMapWidth is now .shadow.mapSize.width."),this.shadow.mapSize.width=e}},shadowMapHeight:{set:function(e){console.warn("THREE.Light: .shadowMapHeight is now .shadow.mapSize.height."),this.shadow.mapSize.height=e}}});Object.defineProperties(ye.prototype,{length:{get:function(){return console.warn("THREE.BufferAttribute: .length has been deprecated. Use .count instead."),this.array.length}},copyIndicesArray:function(){console.error("THREE.BufferAttribute: .copyIndicesArray() has been removed.")}});Object.assign(z.prototype,{addIndex:function(e){console.warn("THREE.BufferGeometry: .addIndex() has been renamed to .setIndex()."),this.setIndex(e)},addDrawCall:function(e,t,r){r!==void 0&&console.warn("THREE.BufferGeometry: .addDrawCall() no longer supports indexOffset."),console.warn("THREE.BufferGeometry: .addDrawCall() is now .addGroup()."),this.addGroup(e,t)},clearDrawCalls:function(){console.warn("THREE.BufferGeometry: .clearDrawCalls() is now .clearGroups()."),this.clearGroups()},computeTangents:function(){console.warn("THREE.BufferGeometry: .computeTangents() has been removed.")},computeOffsets:function(){console.warn("THREE.BufferGeometry: .computeOffsets() has been removed.")}});Object.defineProperties(z.prototype,{drawcalls:{get:function(){return console.error("THREE.BufferGeometry: .drawcalls has been renamed to .groups."),this.groups}},offsets:{get:function(){return console.warn("THREE.BufferGeometry: .offsets has been renamed to .groups."),this.groups}}});Object.assign(jt.prototype,{getArrays:function(){console.error("THREE.ExtrudeBufferGeometry: .getArrays() has been removed.")},addShapeList:function(){console.error("THREE.ExtrudeBufferGeometry: .addShapeList() has been removed.")},addShape:function(){console.error("THREE.ExtrudeBufferGeometry: .addShape() has been removed.")}});Object.defineProperties(vo.prototype,{dynamic:{set:function(){console.warn("THREE.Uniform: .dynamic has been removed. Use object.onBeforeRender() instead.")}},onUpdate:{value:function(){return console.warn("THREE.Uniform: .onUpdate() has been removed. Use object.onBeforeRender() instead."),this}}});Object.defineProperties(he.prototype,{wrapAround:{get:function(){console.warn("THREE.Material: .wrapAround has been removed.")},set:function(){console.warn("THREE.Material: .wrapAround has been removed.")}},overdraw:{get:function(){console.warn("THREE.Material: .overdraw has been removed.")},set:function(){console.warn("THREE.Material: .overdraw has been removed.")}},wrapRGB:{get:function(){return console.warn("THREE.Material: .wrapRGB has been removed."),new J}},shading:{get:function(){console.error("THREE."+this.type+": .shading has been removed. Use the boolean .flatShading instead.")},set:function(e){console.warn("THREE."+this.type+": .shading has been removed. Use the boolean .flatShading instead."),this.flatShading=e===Co}}});Object.defineProperties(Gt.prototype,{metal:{get:function(){return console.warn("THREE.MeshPhongMaterial: .metal has been removed. Use THREE.MeshStandardMaterial instead."),!1},set:function(){console.warn("THREE.MeshPhongMaterial: .metal has been removed. Use THREE.MeshStandardMaterial instead")}}});Object.defineProperties(ct.prototype,{derivatives:{get:function(){return console.warn("THREE.ShaderMaterial: .derivatives has been moved to .extensions.derivatives."),this.extensions.derivatives},set:function(e){console.warn("THREE. ShaderMaterial: .derivatives has been moved to .extensions.derivatives."),this.extensions.derivatives=e}}});Object.assign(Hi.prototype,{clearTarget:function(e,t,r,i){console.warn("THREE.WebGLRenderer: .clearTarget() has been deprecated. Use .setRenderTarget() and .clear() instead."),this.setRenderTarget(e),this.clear(t,r,i)},animate:function(e){console.warn("THREE.WebGLRenderer: .animate() is now .setAnimationLoop()."),this.setAnimationLoop(e)},getCurrentRenderTarget:function(){return console.warn("THREE.WebGLRenderer: .getCurrentRenderTarget() is now .getRenderTarget()."),this.getRenderTarget()},getMaxAnisotropy:function(){return console.warn("THREE.WebGLRenderer: .getMaxAnisotropy() is now .capabilities.getMaxAnisotropy()."),this.capabilities.getMaxAnisotropy()},getPrecision:function(){return console.warn("THREE.WebGLRenderer: .getPrecision() is now .capabilities.precision."),this.capabilities.precision},resetGLState:function(){return console.warn("THREE.WebGLRenderer: .resetGLState() is now .state.reset()."),this.state.reset()},supportsFloatTextures:function(){return console.warn("THREE.WebGLRenderer: .supportsFloatTextures() is now .extensions.get( 'OES_texture_float' )."),this.extensions.get("OES_texture_float")},supportsHalfFloatTextures:function(){return console.warn("THREE.WebGLRenderer: .supportsHalfFloatTextures() is now .extensions.get( 'OES_texture_half_float' )."),this.extensions.get("OES_texture_half_float")},supportsStandardDerivatives:function(){return console.warn("THREE.WebGLRenderer: .supportsStandardDerivatives() is now .extensions.get( 'OES_standard_derivatives' )."),this.extensions.get("OES_standard_derivatives")},supportsCompressedTextureS3TC:function(){return console.warn("THREE.WebGLRenderer: .supportsCompressedTextureS3TC() is now .extensions.get( 'WEBGL_compressed_texture_s3tc' )."),this.extensions.get("WEBGL_compressed_texture_s3tc")},supportsCompressedTexturePVRTC:function(){return console.warn("THREE.WebGLRenderer: .supportsCompressedTexturePVRTC() is now .extensions.get( 'WEBGL_compressed_texture_pvrtc' )."),this.extensions.get("WEBGL_compressed_texture_pvrtc")},supportsBlendMinMax:function(){return console.warn("THREE.WebGLRenderer: .supportsBlendMinMax() is now .extensions.get( 'EXT_blend_minmax' )."),this.extensions.get("EXT_blend_minmax")},supportsVertexTextures:function(){return console.warn("THREE.WebGLRenderer: .supportsVertexTextures() is now .capabilities.vertexTextures."),this.capabilities.vertexTextures},supportsInstancedArrays:function(){return console.warn("THREE.WebGLRenderer: .supportsInstancedArrays() is now .extensions.get( 'ANGLE_instanced_arrays' )."),this.extensions.get("ANGLE_instanced_arrays")},enableScissorTest:function(e){console.warn("THREE.WebGLRenderer: .enableScissorTest() is now .setScissorTest()."),this.setScissorTest(e)},initMaterial:function(){console.warn("THREE.WebGLRenderer: .initMaterial() has been removed.")},addPrePlugin:function(){console.warn("THREE.WebGLRenderer: .addPrePlugin() has been removed.")},addPostPlugin:function(){console.warn("THREE.WebGLRenderer: .addPostPlugin() has been removed.")},updateShadowMap:function(){console.warn("THREE.WebGLRenderer: .updateShadowMap() has been removed.")},setFaceCulling:function(){console.warn("THREE.WebGLRenderer: .setFaceCulling() has been removed.")}});Object.defineProperties(Hi.prototype,{shadowMapEnabled:{get:function(){return this.shadowMap.enabled},set:function(e){console.warn("THREE.WebGLRenderer: .shadowMapEnabled is now .shadowMap.enabled."),this.shadowMap.enabled=e}},shadowMapType:{get:function(){return this.shadowMap.type},set:function(e){console.warn("THREE.WebGLRenderer: .shadowMapType is now .shadowMap.type."),this.shadowMap.type=e}},shadowMapCullFace:{get:function(){console.warn("THREE.WebGLRenderer: .shadowMapCullFace has been removed. Set Material.shadowSide instead.")},set:function(){console.warn("THREE.WebGLRenderer: .shadowMapCullFace has been removed. Set Material.shadowSide instead.")}}});Object.defineProperties(ta.prototype,{cullFace:{get:function(){console.warn("THREE.WebGLRenderer: .shadowMap.cullFace has been removed. Set Material.shadowSide instead.")},set:function(){console.warn("THREE.WebGLRenderer: .shadowMap.cullFace has been removed. Set Material.shadowSide instead.")}},renderReverseSided:{get:function(){console.warn("THREE.WebGLRenderer: .shadowMap.renderReverseSided has been removed. Set Material.shadowSide instead.")},set:function(){console.warn("THREE.WebGLRenderer: .shadowMap.renderReverseSided has been removed. Set Material.shadowSide instead.")}},renderSingleSided:{get:function(){console.warn("THREE.WebGLRenderer: .shadowMap.renderSingleSided has been removed. Set Material.shadowSide instead.")},set:function(){console.warn("THREE.WebGLRenderer: .shadowMap.renderSingleSided has been removed. Set Material.shadowSide instead.")}}});Object.defineProperties(Mt.prototype,{wrapS:{get:function(){return console.warn("THREE.WebGLRenderTarget: .wrapS is now .texture.wrapS."),this.texture.wrapS},set:function(e){console.warn("THREE.WebGLRenderTarget: .wrapS is now .texture.wrapS."),this.texture.wrapS=e}},wrapT:{get:function(){return console.warn("THREE.WebGLRenderTarget: .wrapT is now .texture.wrapT."),this.texture.wrapT},set:function(e){console.warn("THREE.WebGLRenderTarget: .wrapT is now .texture.wrapT."),this.texture.wrapT=e}},magFilter:{get:function(){return console.warn("THREE.WebGLRenderTarget: .magFilter is now .texture.magFilter."),this.texture.magFilter},set:function(e){console.warn("THREE.WebGLRenderTarget: .magFilter is now .texture.magFilter."),this.texture.magFilter=e}},minFilter:{get:function(){return console.warn("THREE.WebGLRenderTarget: .minFilter is now .texture.minFilter."),this.texture.minFilter},set:function(e){console.warn("THREE.WebGLRenderTarget: .minFilter is now .texture.minFilter."),this.texture.minFilter=e}},anisotropy:{get:function(){return console.warn("THREE.WebGLRenderTarget: .anisotropy is now .texture.anisotropy."),this.texture.anisotropy},set:function(e){console.warn("THREE.WebGLRenderTarget: .anisotropy is now .texture.anisotropy."),this.texture.anisotropy=e}},offset:{get:function(){return console.warn("THREE.WebGLRenderTarget: .offset is now .texture.offset."),this.texture.offset},set:function(e){console.warn("THREE.WebGLRenderTarget: .offset is now .texture.offset."),this.texture.offset=e}},repeat:{get:function(){return console.warn("THREE.WebGLRenderTarget: .repeat is now .texture.repeat."),this.texture.repeat},set:function(e){console.warn("THREE.WebGLRenderTarget: .repeat is now .texture.repeat."),this.texture.repeat=e}},format:{get:function(){return console.warn("THREE.WebGLRenderTarget: .format is now .texture.format."),this.texture.format},set:function(e){console.warn("THREE.WebGLRenderTarget: .format is now .texture.format."),this.texture.format=e}},type:{get:function(){return console.warn("THREE.WebGLRenderTarget: .type is now .texture.type."),this.texture.type},set:function(e){console.warn("THREE.WebGLRenderTarget: .type is now .texture.type."),this.texture.type=e}},generateMipmaps:{get:function(){return console.warn("THREE.WebGLRenderTarget: .generateMipmaps is now .texture.generateMipmaps."),this.texture.generateMipmaps},set:function(e){console.warn("THREE.WebGLRenderTarget: .generateMipmaps is now .texture.generateMipmaps."),this.texture.generateMipmaps=e}}});Object.defineProperties(ia.prototype,{standing:{set:function(){console.warn("THREE.WebVRManager: .standing has been removed.")}},userHeight:{set:function(){console.warn("THREE.WebVRManager: .userHeight has been removed.")}}});Kr.prototype.load=function(e){console.warn("THREE.Audio: .load has been deprecated. Use THREE.AudioLoader instead.");var t=this,r=new pa;return r.load(e,function(i){t.setBuffer(i)}),this};ma.prototype.getData=function(){return console.warn("THREE.AudioAnalyser: .getData() is now .getFrequencyData()."),this.getFrequencyData()};ln.prototype.updateCubeMap=function(e,t){return console.warn("THREE.CubeCamera: .updateCubeMap() is now .update()."),this.update(e,t)};sr.crossOrigin=void 0;sr.loadTexture=function(e,t,r,i){console.warn("THREE.ImageUtils.loadTexture has been deprecated. Use THREE.TextureLoader() instead.");var n=new fn;n.setCrossOrigin(this.crossOrigin);var o=n.load(e,r,void 0,i);return t&&(o.mapping=t),o};sr.loadTextureCube=function(e,t,r,i){console.warn("THREE.ImageUtils.loadTextureCube has been deprecated. Use THREE.CubeTextureLoader() instead.");var n=new aa;n.setCrossOrigin(this.crossOrigin);var o=n.load(e,r,void 0,i);return t&&(o.mapping=t),o};sr.loadCompressedTexture=function(){console.error("THREE.ImageUtils.loadCompressedTexture has been removed. Use THREE.DDSLoader instead.")};sr.loadCompressedTextureCube=function(){console.error("THREE.ImageUtils.loadCompressedTextureCube has been removed. Use THREE.DDSLoader instead.")};function Ep(e){let t=atob(e.split(",")[1]),r=e.split(",")[0].split(":")[1].split(";")[0],i=new ArrayBuffer(t.length),n=new Uint8Array(i);for(let a=0;a<t.length;a++)n[a]=t.charCodeAt(a);return new Blob([i],{type:r})}var cs=class{constructor(){this.animating=!1}initialize(){window.addEventListener("resize",u=>{this.resize()}),this.canvas=document.createElement("canvas"),this.canvas.style.display="none",this.canvas.width=window.innerWidth,this.canvas.height=window.innerHeight,this.screenshotCanvas=document.createElement("canvas"),this.screenshotCanvas.style.display="none",this.screenshotCanvas.width=window.innerWidth,this.screenshotCanvas.height=window.innerHeight,this.buffer=new Uint8Array(window.innerWidth*window.innerHeight*4);let t=new dr(window.innerWidth/-2,window.innerWidth/2,window.innerHeight/2,window.innerHeight/-2,0,1e4);t.position.z=100;let r=new Wr,i=new Mt(window.innerWidth,window.innerHeight,{minFilter:ke,magFilter:ke,format:wt,type:Br}),n=new Xr;n.needsUpdate=!0;let o=new ct({uniforms:{tDiffuse:{value:n}},vertexShader:`
			varying vec2 vUv;

			void main() {
				vUv = vec2(uv.x, 1.0-uv.y);
				gl_Position = projectionMatrix * modelViewMatrix * vec4( position, 1.0 );
			}
`,fragmentShader:`
			varying vec2 vUv;
			uniform sampler2D tDiffuse;

			void main() {
				gl_FragColor = texture2D( tDiffuse, vUv );
			}
`});this.material=o;let a=new Qt(window.innerWidth,window.innerHeight),s=new Xe(a,o);s.position.z=-100,r.add(s);let f=new Hi;f.setPixelRatio(window.devicePixelRatio),f.setSize(window.innerWidth,window.innerHeight),f.autoClear=!1,document.body.appendChild(f.domElement),f.domElement.style.display="none",this.renderer=f,this.rtTexture=i,this.sceneRTT=r,this.cameraRTT=t,this.animate=this.animate.bind(this),this.ctx=this.canvas.getContext("2d"),this.screenshotCtx=this.screenshotCanvas.getContext("2d")}resize(){this.canvas.width=window.innerWidth,this.canvas.height=window.innerHeight,this.screenshotCanvas.width=window.innerWidth,this.screenshotCanvas.height=window.innerHeight,this.buffer=new Uint8Array(window.innerWidth*window.innerHeight*4);let t=new dr(window.innerWidth/-2,window.innerWidth/2,window.innerHeight/2,window.innerHeight/-2,0,1e4);t.position.z=100,this.cameraRTT=t;let r=new Wr,i=new Qt(window.innerWidth,window.innerHeight),n=new Xe(i,this.material);n.position.z=-100,r.add(n),this.sceneRTT=r,this.rtTexture.setSize(window.innerWidth,window.innerHeight),this.renderer.setSize(window.innerWidth,window.innerHeight)}requestScreenshot(t){return new Promise(r=>{requestAnimationFrame(()=>{let i=this.handleRequest(t);r(i)})})}start(t){return this.animating=!0,requestAnimationFrame(this.animate),this.canvas.captureStream(t)}stop(){this.animating=!1}animate(){this.animating&&requestAnimationFrame(this.animate),this.renderer.render(this.sceneRTT,this.cameraRTT,this.rtTexture,!0),this.renderer.readRenderTargetPixels(this.rtTexture,0,0,window.innerWidth,window.innerHeight,this.buffer);let t=new Uint8ClampedArray(this.buffer.buffer);this.ctx.putImageData(new ImageData(t,window.innerWidth,window.innerHeight),0,0)}handleRequest(t){t||(t={}),this.renderer.render(this.sceneRTT,this.cameraRTT,this.rtTexture,!0),this.renderer.readRenderTargetPixels(this.rtTexture,0,0,window.innerWidth,window.innerHeight,this.buffer);let r=new Uint8ClampedArray(this.buffer.buffer);if(t.outline){let s=this.screenshotCanvas.width-2,f=this.screenshotCanvas.height-2;for(let u=0;u<this.screenshotCanvas.width;u++)for(let c=0;c<this.screenshotCanvas.height;c++){let h=(c*this.screenshotCanvas.width+u)*4;(u<2||c<2||u>=s||c>=f)&&(r[h]=255,r[h+1]=255,r[h+2]=255)}}if(this.screenshotCtx.putImageData(new ImageData(r,window.innerWidth,window.innerHeight),0,0),t.canvas)return this.screenshotCanvas;t.encoding||(t.encoding="jpg"),t.quality||(t.quality=.92);let i="image/png";switch(t.encoding){case"jpg":i="image/jpeg";break;case"png":i="image/png";break;case"webp":i="image/webp";break}let n=this.screenshotCanvas.toDataURL(i,t.quality),o=()=>{let a=new FormData;return a.append(t.targetField,Ep(n),`screenshot.${t.encoding}`),a};return t.targetURL&&fetch(t.targetURL,{method:"POST",mode:"cors",headers:t.headers,body:t.targetField?o():JSON.stringify({data:n,id:t.id,dimensions:{width:window.innerWidth,height:window.innerHeight}})}).then(a=>a.json()).then(a=>{triggerNuiCallback("screenshotCreated",{data:a,id:t.id})}),{data:n,id:t.id,dimensions:{width:window.innerWidth,height:window.innerHeight}}}};window.gameRenderer=new cs;window.gameRenderer.initialize();window.addEventListener("message",async e=>{e.data.screenshotRequest&&await gameRenderer.requestScreenshot(e.data.screenshotRequest)});})();
//!\ DECLARE ALIAS AFTER assign prototype !
