"use strict";(self.webpackChunkvf_network=self.webpackChunkvf_network||[]).push([[5095],{3905:(e,t,r)=>{r.d(t,{Zo:()=>p,kt:()=>f});var n=r(7294);function a(e,t,r){return t in e?Object.defineProperty(e,t,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[t]=r,e}function o(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,n)}return r}function i(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?o(Object(r),!0).forEach((function(t){a(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):o(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}function s(e,t){if(null==e)return{};var r,n,a=function(e,t){if(null==e)return{};var r,n,a={},o=Object.keys(e);for(n=0;n<o.length;n++)r=o[n],t.indexOf(r)>=0||(a[r]=e[r]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(n=0;n<o.length;n++)r=o[n],t.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(e,r)&&(a[r]=e[r])}return a}var l=n.createContext({}),c=function(e){var t=n.useContext(l),r=t;return e&&(r="function"==typeof e?e(t):i(i({},t),e)),r},p=function(e){var t=c(e.components);return n.createElement(l.Provider,{value:t},e.children)},u="mdxType",d={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},m=n.forwardRef((function(e,t){var r=e.components,a=e.mdxType,o=e.originalType,l=e.parentName,p=s(e,["components","mdxType","originalType","parentName"]),u=c(r),m=a,f=u["".concat(l,".").concat(m)]||u[m]||d[m]||o;return r?n.createElement(f,i(i({ref:t},p),{},{components:r})):n.createElement(f,i({ref:t},p))}));function f(e,t){var r=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=r.length,i=new Array(o);i[0]=m;var s={};for(var l in t)hasOwnProperty.call(t,l)&&(s[l]=t[l]);s.originalType=e,s[u]="string"==typeof e?e:a,i[1]=s;for(var c=2;c<o;c++)i[c]=r[c];return n.createElement.apply(null,i)}return n.createElement.apply(null,r)}m.displayName="MDXCreateElement"},1281:(e,t,r)=>{r.r(t),r.d(t,{assets:()=>l,contentTitle:()=>i,default:()=>d,frontMatter:()=>o,metadata:()=>s,toc:()=>c});var n=r(7462),a=(r(7294),r(3905));const o={sidebar_position:1,title:"Example",description:"my hello page description",hide_table_of_contents:!1},i="Example",s={unversionedId:"getting-started/Example",id:"getting-started/Example",title:"Example",description:"my hello page description",source:"@site/docs/getting-started/Example.md",sourceDirName:"getting-started",slug:"/getting-started/Example",permalink:"/docs/getting-started/Example",draft:!1,editUrl:"https://github.com/vafreitas/VFNetwork/docs/getting-started/Example.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1,title:"Example",description:"my hello page description",hide_table_of_contents:!1},sidebar:"tutorialSidebar",previous:{title:"How to Use",permalink:"/docs/getting-started/How-to-use"},next:{title:"Get",permalink:"/docs/http-methods/get"}},l={},c=[{value:"APIBuilder",id:"apibuilder",level:2},{value:"Configuration Variables.",id:"configuration-variables",level:2},{value:"URLPath",id:"urlpath",level:3},{value:"HTTPMethods",id:"httpmethods",level:3},{value:"HTTPHeader",id:"httpheader",level:3},{value:"HTTPTask",id:"httptask",level:3}],p={toc:c},u="wrapper";function d(e){let{components:t,...r}=e;return(0,a.kt)(u,(0,n.Z)({},p,r,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"example"},"Example"),(0,a.kt)("h2",{id:"apibuilder"},"APIBuilder"),(0,a.kt)("p",null,"With APIBuilder you can configure your requests. For Example."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-swift"},'enum HomeAPI {\n    case home\n    case categories(ExampleStruct)\n}\n\nextension HomeAPI: APIBuilder {\n    \n    var path: URLPath {\n        switch self {\n        case .home:\n            return .plain("jokes/random")\n        case .categories:\n            return .plain("jokes/categories")\n        }\n    }\n    \n    var httpMethod: HTTPMethods {\n        switch self {\n        case .home:\n            return .get\n        case .categories:\n            return .post\n        }\n    }\n    \n    var headers: HTTPHeader {\n        .bearer("Bearer yourToken")\n    }\n    \n    var task: HTTPTask {\n        switch self {\n        case .home:\n            return .request\n        case let .categories(model):\n            return .requestEncoder(model)\n        }\n    }\n}\n')),(0,a.kt)("h2",{id:"configuration-variables"},"Configuration Variables."),(0,a.kt)("h3",{id:"urlpath"},"URLPath"),(0,a.kt)("p",null,"With URLPath you can configure two types of URLs."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-swift"},'.plain("jokes/random") // jokes/random\n.composed("joke", pathId: "ID") // /joke/10\n')),(0,a.kt)("h3",{id:"httpmethods"},"HTTPMethods"),(0,a.kt)("p",null,"With HTTPMethods you can choose five types of methods."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre"},".get\n.post\n.put\n.patch\n.delete\n")),(0,a.kt)("h3",{id:"httpheader"},"HTTPHeader"),(0,a.kt)("p",null,"With HTTPHeader you can choose five types of headers."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-swift"},'.custom([\n  .header("key", "value"),\n  .bearer("YourToken")\n]) // Array of HTTPHeader\n\n// Only one option\n.bearer("yourToken")\n.basic("yourBase64")\n.header("key", "value")\n')),(0,a.kt)("h3",{id:"httptask"},"HTTPTask"),(0,a.kt)("p",null,"With HTTPTask you can choose five types of tasks."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-swift"},'.request // Plain\n.requestBody([\n     "name": "Victor",\n     "lastname": "Freitas"\n]) // Body\n.requestEncoder(model) // Body\n.requestURLParameters(urlParameters: ["transactionId": "ID"]) // Query String\n.requestParameters(bodyParameters: ["name": "Victor"], urlParameters: ["transactionId": "ID"]) // Body with Query String.\n')),(0,a.kt)("h1",{id:"request-service"},"Request Service"),(0,a.kt)("p",null,"With RequestService you can execute your requests. For Example."),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-swift"},"import VFNetwork\n\nclass HomeService: RequestService<HomeAPI> {\n    func getJoke(completion: @escaping (Result<JokeModel, Error>) -> Void) {\n        execute(.joke, responseType: JokeModel.self, completion: completion)\n    }\n    \n    func getCategories(completion: @escaping (Result<CategoryModel, Error>) -> Void) {\n        execute(.categories, responseType: CategoryModel.self, completion: completion)\n    }\n}\n\n")))}d.isMDXComponent=!0}}]);