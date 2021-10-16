/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : db_myblog

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 17/10/2021 02:24:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `blog_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `uid` int(0) NULL DEFAULT 1 COMMENT 'uid',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `create_time` datetime(0) NOT NULL COMMENT '注册时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `publish` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否发布',
  `brief` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `ext_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`blog_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES (3, 'vue中使用watch监听数据时出现的一些问题', 1, '## vue中watch监听数据的执行顺序问题\n### 监听子组件中获取的数据\n在data中初始化一个变量，并在watch中监听，在methods中发起网络请求并将数据赋值给这个变量时，watch中出发的回调函数和methods中还未执行的代码谁先执行？  \n继续执行还未执行的代码，然后执行监听器中的回调函数。\n### 父组件获取数据，传递给子组件\n父组件中的data初始化一个变量，通过网络请求获取数据赋给该变量并传递给子组件，子组件中使用watch进行监听，代码谁先执行？  \n继续执行父组件还未执行的代码，执行完后按顺序被子组件中的watch监听到并执行回调函数。\n## watch如何监听到数据的变化?\n**只要是对象和数组，无论是否是空值**，第一次都可以监听到数据变化，这个数据是按代码最后赋的值来决定传入watch的newValue,**(除了null,undefine,和空字符串在变量本身就为这些值时无法监听到)**,个人认为，watch监听的是变量内存地址的变化来决定是否执行回调。`null不是有效的对象实例，因此没有为它分配内存。它只是一个值，指示对象引用当前不引用对象。`，估计undefine,和空字符串也是如此。\n## 父组件给子组件传递数据，子组件使用watch监听props数据，在watch的回调函数中将自身变量赋值为传递过来的数组，会导致无限循环？\n```javascript\nwatch: {\n      provinceList: {\n        deep: true,\n        handler(val) {\n          this.dataList = val //浅复制了数组\n          this.init()\n          this.option && this.chart.setOption(this.option);\n        }\n      }\n    },\n```\n因为子组件的监听回调函数中直接使用了普通的`=`号，因为数组跟对象一样也是引用类型，所以此时的操作只是将指向数组的地址赋值给了`dataList`，所以后续对dataList的数组操作仍然会被监听到，导致无限循环。\n    ', '2021-10-09 15:24:39', '2021-10-17 02:19:13', '1', '在data中初始化一个变量，并在watch中监听，在methods中发起网络请求并将数据赋值给这个变量时，watch中出发的回调函数和methods中还未执行的代码谁先执行？   继续执行还未执行的代码，然后执行监听器中的回调函数。', 0, '这是额外的信息');
INSERT INTO `t_blog` VALUES (14, 'node.js简单实现爬取王者所有英雄皮肤', 1, '直接上代码\n`wCrawl.js`\n```javascript\nconst cheerio = require(\"cheerio\")\nconst fs = require(\"fs\")\n//获取html文档内容  \nconst iconv = require(\"iconv-lite\")\nconst axios = require(\"axios\")\nconst {\n  rmAndMkdir\n} = require(\"./rwFs\")\nlet httpUrl = \"https://pvp.qq.com/web201605/herolist.shtml\"\n/**创建输出目录\n * 输出路径\n * @param {String} path \n */\nfunction crawlPictures(path) {\n  axios.get(httpUrl, {\n    responseType: \'arraybuffer\'\n  }).then(res => {\n    const str = transCoding(res.data, \'gbk\')\n    let $ = cheerio.load(str, {\n      decodeEntities: false\n    })\n    rmAndMkdir(\"./img\")\n    console.log(\"开始爬取网页内容...\");\n    $(\".herolist li a\").each(async (index, element) => {\n      let heroDetailUrl = \"https://pvp.qq.com/web201605/\" +\n        $(element).attr(\"href\")\n      let $_ = cheerio.load(element, {\n        decodeEntities: false\n      })\n      let heroName = $_(\"img\").attr(\'alt\')\n      await sleep();\n      parseImg({\n        heroDetailUrl,\n        heroName\n      })\n    })\n  })\n}\nasync function parseImg({\n  heroDetailUrl,\n  heroName\n}) {\n  let {\n    data\n  } = await axios.get(heroDetailUrl, {\n    responseType: \'arraybuffer\'\n  });\n  let $ = cheerio.load(transCoding(data, \'gbk\'), {\n    decodeEntities: false\n  })\n  let downloadUrl = $(\".wrapper .zk-con1\").attr(\"style\")\n\n  let res = /background\\:url\\(\'(.*?)\'\\) center 0/igs.exec(downloadUrl)[1]\n  fs.mkdir(`./img/${heroName}`, function (err) {\n    if (!err) {\n      $(\".pic-pf ul\").each((index, element) => {\n        let imgName = $(element).attr(\"data-imgname\")\n        let arr = imgName.split(\"&\")\n        arr.pop();\n        let lastArr = arr.map(item => {\n          let index = item.indexOf(\"|\")\n          if (index !== -1) {\n            return item.slice(index + 1)\n          }\n          return item\n        })\n        for (let i = 0; i < lastArr.length; i++) {\n          imgDownload({\n            imgUrl: doHandleUrl(\"https:\" + res, i + 1),\n            skinName: lastArr[i],\n            heroName\n          })\n        }\n\n        function doHandleUrl(url, number) {\n          let lastIndex = url.lastIndexOf(\'.\')\n          if (lastIndex !== -1) {\n            return url.substr(0, lastIndex - 1) + number + url.substr(lastIndex)\n          }\n        }\n      })\n    }\n  })\n}\n\nasync function imgDownload({\n  imgUrl,\n  skinName,\n  heroName\n}) {\n  console.log(skinName);\n  let {\n    data: imgRes\n  } = await axios.get(imgUrl, {\n    responseType: \'stream\'\n  })\n  let ws = fs.createWriteStream(`./img/${heroName}/${skinName}.jpg`, {\n    flags: \"w\",\n\n  })\n  imgRes.pipe(ws)\n}\n\nfunction transCoding(content, format) {\n  return iconv.decode(Buffer.from(content), format)\n}\n\nfunction sleep() {\n  return new Promise((resolve, reject) => {\n    setTimeout(resolve, 2000);\n  })\n}\nmodule.exports = crawlPictures\n```\n封装的一些promise  \n`rwFs.js`\n```javascript\nconst fs = require(\"fs\")\n/**\n * 写入文件\n * @param {String} path \n * @param {*}} content \n * @returns \n */\nfunction fsWrite(path, content) {\n  return new Promise((resolve, reject) => {\n    fs.writeFile(path, content, {\n      flag: \"a\",\n      encoding: \"utf-8\"\n    }, function (err) {\n      if (!err) {\n        console.log(\"写入成功\");\n        resolve()\n      } else {\n        console.log(err);\n        reject()\n      }\n    })\n  })\n}\n/**\n * 读取文件内容\n * @param {Sting} url \n * @returns \n */\nfunction fsRead(url) {\n  return new Promise((resolve, reject) => {\n    fs.readFile(url, {\n      flag: \'r\',\n      encoding: \"utf-8\"\n    }, function (err, data) {\n      if (err) {\n        reject(err)\n      } else {\n        resolve(data)\n      }\n    });\n  })\n}\n/**\n * 判断文件是否存在\n * @param {String} path \n * @returns\n */\nfunction isFileExisted(path) {\n  return new Promise((resolve, reject) => {\n    fs.access(path, (err) => {\n      if (err) {\n        console.log(\"文件不存在\");\n        resolve(false)\n      } else {\n        resolve(true)\n      }\n    })\n  })\n}\n/**\n * 删除指定路径下的目录文件夹\n * @param {String} path \n * @returns \n */\nfunction rmDir(path) {\n  return new Promise((resolve, reject) => {\n    fs.rmdir(path, {\n      recursive: true\n    }, (err) => {\n      if (err) {\n        reject(err)\n      } else {\n        console.log(\"正在删除\");\n        resolve()\n      }\n    })\n  })\n}\n/**\n * 在指定路径下创建目录\n * @param {String} path \n * @returns \n */\nfunction mkDir(path) {\n  return new Promise((resolve, reject) => {\n    fs.mkdir(path, (err) => {\n      if (err) {\n        reject(err)\n      } else {\n        console.log(\"正在创建目录\");\n        resolve()\n      }\n    })\n  })\n}\n/**\n * 重新创建对应路径下文件夹\n * @param {String} path \n */\nasync function rmAndMkdir(path) {\n  try {\n    var isExist = await isFileExisted(path)\n    if (isExist) {\n      await rmDir(path);\n      await mkDir(path);\n    } else {\n      await mkDir(path);\n    }\n  } catch (err) {\n    console.log(err);\n  }\n}\n\nmodule.exports = {\n  fsWrite,\n  fsRead,\n  isFileExisted,\n  rmDir,\n  mkDir,\n  rmAndMkdir\n}\n```\nindex.js\n```javascript\nconst crawlPictures = require(\"./crawlPictures\")\ncrawlPictures(\"./img\")\n```\n`node ./index.js`  执行  \n还不错的小demo\n\n![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8286a6e2a91246dea629242d2ee612dc~tplv-k3u1fbpfcp-watermark.image)\n爬取完成', '2021-10-17 00:50:42', '2021-10-17 02:20:00', '1', 'node.js简单实现爬取王者所有英雄皮肤', 0, NULL);
INSERT INTO `t_blog` VALUES (15, '使用router.addroutes动态添加路由时踩的一些坑', 1, '## 前言\n### 在开发后台管理系统不可避免地会涉及到根据用户权限来动态渲染侧边栏的问题，在vue2.2.0之后可以使用router.addroutes()来方便动态添加路由了。\n\n## `router.addroutes()`使用\n```javascript\n  addRoutes (routes: RouteConfig[]): void;\n  //动态添加更多的路由规则。参数必须是一个符合 routes 选项要求的数组。\n```\n简易实现侧边栏动态渲染：  \n\n在`router.js`中配置静态路由表:  \n```javascript\nexport const constantRouterMap = [{\n    path: \'/login\',\n    component: () => import(\'@/views/login/index\'),\n    hidden: true\n  },]\n```\n配置需要动态渲染的路由表:  \n```javascript\nexport const asyncRouterMap = [{\n    path: \'/admin\',\n    component: () => import(\'@/views/admin/index\'),\n    hidden: true,\n    meta: {\n          title: \'xxx\',\n          icon: \'xxx\',\n          //角色权限字段\n          role: [\'admin\']\n        }\n    },\n    {\n        ...\n        \n    }]\n``` \n在用户登录跳转时，在导航守卫`router.beforeEach()`内执行操作获取用户信息，根据用户信息拿到对应role字段，与`asyncRouterMap[i].meta.role`进行比对，过滤出角色所属的路由表。\n```javascript\n//permission.js\nrouter.beforeEach(async (to, from, next) => {\n  // 验证用户是否已经登陆过\n  const hasToken = getToken()\n  if (hasToken) {\n    if (to.path === \'/login\') {\n    //是否跳转登录页\n      next({\n        path: \'/\'\n      })\n    } else {\n      //这一步为了路由数据持久化，防止刷新后vuex数据丢失造成的侧边栏显示异常\n      const hasGetRouters = store.getters.routers\n      //是否已经获取用户信息\n      const hasGetUserInfo = store.getters.name\n      if (hasGetUserInfo && hasGetRouters.length) {\n        next()\n      } else {\n        try {\n        //获取角色信息\n          const {\n            role\n          } = await store.dispatch(\'user/getInfo\')\n          //传入角色信息，执行过滤方法\n          await store.dispatch(\'permission/getRoutes\', {\n            role\n          })\n          //动态添加路由\n          router.addRoutes(store.getters.addRouters);\n          next({\n            ...to,\n            replace: true\n          })\n        } catch (error) {\n        }\n      }\n    }\n  }\n})\n```\n\n## 遇到的一些问题\n### 明明已经成功拿到动态路由表了，使用`router.addRoutes()`后并未在`this.$router.options`中更新？ \n其实这是vue-router设计如此，在issue中作者有提到`That is normal, options is the object passed to the vuerouter constructor. It\'s not modified afterwards`。其实相应的路由已经添加了，只是将参数传给了vuerouter构造函数，所以没法在vueRouter实例中看到。  \n### 侧边栏如果通过`v-for=\"route in $router.options\"`渲染，怎么才能实现有效更新？\n因为之前提到过，如果使用`router.addRoutes`来进行添加路由无法更新`this.$router.options`，所以主要的实现方法是通过store来存储路由表。  \n\n```javascript\n//store\nconst state = {\n  routers: [],\n  addRouters: []\n}\n\nconst mutations = {\n  SET_ROUTERS: (state, routers) => {\n    state.addRouters = routers;\n    //与静态路由表拼接\n    state.routers = constantRouterMap.concat(routers);\n  }\n}\nconst actions = {\n  getRoutes({\n    commit\n  }, data) {\n    return new Promise(resolve => {\n      const {\n        role\n      } = data;\n      \n          ...\n          //过滤出role对应路由表accessedRouters\n      commit(\'SET_ROUTERS\', accessedRouters);\n      resolve();\n    })\n  }\n}\n```\n使用：\n```javascript\n//sideBar.vue\n\n    ...mapState(\"permission\", {\n      routers: \"routers\",\n    }),\n```\n### 刷新之后侧边栏显示空白？\n因为vuex无法持久化保存数据，在页面刷新之后数据被清空，所以需要在`router.beforeEach()`内再做一层判断页面是否刷新。', '2021-10-17 00:57:42', '2021-10-17 02:21:11', '1', '在开发后台管理系统不可避免地会涉及到根据用户权限来动态渲染侧边栏的问题，在vue2.2.0之后可以使用router.addroutes()来方便动态添加路由了。', 0, NULL);
INSERT INTO `t_blog` VALUES (16, '玩转mustache模板引擎', 1, '\n## 什么是模板引擎？\n>模板引擎的基本机理就是替换（转换），将指定的标签转换为需要的业务数据；将指定的伪语句按照某种流程来变换输出\n\n\n\n### Mustache模板引擎\n> 一个胡子模板是一个包含任意数量的小胡子标签的字符串。标签由围绕它们的双髭指示。\n \n\n* ### `{{data}}`\n\n双花括号就是mustache语法的标识符，花括号中的data表示键名，作用是直接输出与键名匹配的键值。\n```javascript\nvar template = `\n<div>{{data}}</div>\n`\nvar data = \"hello world\"\nvar html = mustache.render(template,data)\n//输出\n`\n<div>hello world</div>\n`\n```\n\n* ### `{{.}}`\n\n表示枚举，可循环输出整个数组,需搭配{{#data}}和{{/data}}使用。\n\n\n* ### `{{#data}}和{{/data}}`\n\n该语法以#开始，并以/结束表示区块，用于对当前上下文的数据进行一次或多次的渲染，类似vue中的`v-for`指令。\n```javascript \n// li标签根据data属性hobbies对应的键值持续迭代\nvar template = `\n  <div>\n  {{#hobbies}}\n    <li>{{.}}</li>\n  {{/hobbies}}\n  </div>`;\nvar hobbies = [\"唱\",\"跳\",\"rap\"]\nvar html = mustache.render(template)\n//输出\n `\n  <div>\n    <li>唱</li>\n    <li>跳</li>\n    <li>rap</li>\n  </div>`\n```\n实现一下mustache模板引擎实现原理，其中包括了以上几种语法的*简单*实现。\n\n## Render函数\n \n```javascript\nwindow.my_templateEngine = {\n  //渲染函数\n  render(templateStr, data) {\n    //将字符串模板转换成tokens数组\n    var tokens = parserTemplateToTokens(templateStr);\n    //结合数据渲染模板\n    var resTemplate = renderTemplate(data, tokens)\n    return resTemplate\n  }\n}\n```\n一个模板引擎最核心的便是其**渲染(render)函数**，渲染函数从主要负责将字符串模板与数据结合，动态渲染出HTML。\n### 嵌套数组(Tokens)\n> **Tokens**为Mustache的底层核心机理：js的嵌套数组，它是模板字符串的js表示形式，并且Tokens 是**抽象语法树（AST）**、**虚拟节点**等的思路来源。  \n \n\n数组形式：  \n ```\n\n0: (2) [\'text\', \'\\n    <ul>\\n      \']\n1: (3) [\'#\', \'students\', Array(5)]\n2: (2) [\'text\', \'\\n    </ul>\\n    \']\n```\n`\'text\'`代表普通字符串，直接拼接,第2项为字符串  \n`\'name\'`代表存储基本类型的键，第2项为键名  \n`\'#\'和\'/\'`表示区块，第2项为键名，第3项为数组  \n\n\n要将字符串模板转换成tokens数组，肯定要对传入的字符串模板进行处理，我们知道，Mustache语法是靠识别双花括号`{{}}`内的参数来进行数据替换的，那么我们必须使用某种识别方法来提取`{{}}`的内容。扫描器（Scanner）就是用来实现它的\n### 扫描器(Scanner)\n```javascript\nexport default class Scanner {\n  constructor(templateStr) {\n    //贮存传入的字符串模板\n    this.templateStr = templateStr\n    //贮存tag之前的字符串\n    this.tail = templateStr\n    //扫描指针\n    this.pos = 0\n  }\n  //扫描方法,传入需要识别的tag\n  scanUntil(stopTag) {\n    //记录一下pos\n    var pos_backup = this.pos\n    //当尾巴的开头不是stopTag的时候 就说明没有扫描到stopTag\n    while(this.tail.indexOf(stopTag) !== 0 && !this.isEnd()) {\n      this.pos ++;\n      this.tail = this.templateStr.substr(this.pos)\n    }\n    return this.templateStr.substring(pos_backup,this.pos)\n  }\n  //跳过传入的tag\n  scan(tag) {\n    while(this.tail.indexOf(tag) === 0) {\n    //过掉tag\n      this.pos += 2;\n      this.tail = this.templateStr.substr(this.pos)\n    }\n  }\n  //判断是否到末尾\n  isEnd() {\n    return this.pos > this.templateStr.length\n  }\n}\n```\n`scanUntil()`方法对传入的字符串进行检索，如果当前字符串中索引为0的字符不是\'{\',就将pos指针`加1`，直到遇到\'{\'，该方法会返回处于\'{\'之前的字符串。  \n`scan()`方法负责跳过tag，因为\"{{\"占用了两个字符的位置并且已经完成了它的使命，所以截去并将pos位置`加2`。下面是该方法示例\n```javascript\n//示例\nimport Scanner from \"./scanner\";\nvar scanner = new Scanner(`<div><ul><li>{{hey}}</li></ul></div>`)\nconsole.log(scanner.scanUntil(\"{{\")) //<div><ul><li>\nscanner.scan(\"{{\") //跳过\nconsole.log(scanner.scanUntil(\"}}\")) //hey\nscanner.scan(\"}}\") //跳过\nconsole.log(scanner.scanUntil(\"}}\")) //</li></ul></div>\n...\n```\n\n\n### 使用扫描器获取Tokens\n```javascript\nimport Scanner from \"./scanner\";\nimport nestTokens from \"./nestTokens\"\nexport default function parserTemplateToTokens(templateStr) {\n  var tokens = [];\n  var words = \"\";\n  var scanner = new Scanner(templateStr)\n  while (scanner.eos()) {\n    //收集mustache开始标记之前的值\n    words = scanner.scanUntil(\"{{\");\n    //过掉标记\n    scanner.scan(\"{{\")\n    if (words !== \'\') {\n      tokens.push([\"text\", words]);\n    }\n    //收集mustache结束标记之前的值\n    words = scanner.scanUntil(\"}}\");\n    //过掉标记\n    scanner.scan(\"}}\")\n    if (words !== \'\') {\n      if(words[0] === \"#\") {\n      tokens.push([\"#\", words.substring(1)]);\n    } else if(words[0] === \"/\"){\n      tokens.push([\"/\", words.substring(1)] );\n    } else {\n      tokens.push([\"name\", words]);\n    }\n    }\n  }\n  return tokens\n}\n```\n根据示例方法，可以实现将截取的字符串形成像下面的形式的数组：  \n```\n0: (2) [\'text\', \'\\n    <ul>\\n      \']\n1: (3) [\'#\', \'students\', Array(5)]\n2: (2) [\'text\', \'\\n        <li>\\n          学生\']\n3: (2) [\'name\', \'name\']\n4: (2) [\'text\', \'的爱好是\\n          <ol>\\n            \']\n5: (3) [\'#\', \'hobbies\', Array(3)]\n6: (2) [\'text\', \'\\n            <li>\']\n7: (2) [\'name\', \'.\']\n8: (2) [\'text\', \'</li>\\n              \']\n9: (2) [\'/\', \'hobbies\']\n10: (2) [\'text\', \'\\n              </ol>\\n        </li>\\n        \']\n11: (2) [\'/\', \'students\']\n12: (2) [\'text\', \'\\n    </ul>\\n    \']\n```\n可以看到 数组中存在有**hobbies**和**students**两个区块，我们所期望的是他们是`嵌套`的关系（像以下的嵌套形式），所以我们的实现方式仍然存在一些问题。\n```\n0: (2) [\'text\', \'\\n    <ul>\\n      \']\n1: Array(3)\n  0: \"#\"\n  1: \"students\"\n  2: Array(5)\n    0: (2) [\'text\', \'\\n        <li>\\n          学生\']\n    1: (2) [\'name\', \'name\']\n    2: (2) [\'text\', \'的爱好是\\n          <ol>\\n            \']\n    3: Array(3)\n      0: \"#\"\n      1: \"hobbies\"\n      2: Array(3)\n        0: (2) [\'text\', \'\\n            <li>\']\n        1: (2) [\'name\', \'.\']\n        2: (2) [\'text\', \'</li>\\n              \']\n4: (2) [\'text\', \'\\n              </ol>\\n        </li>\\n        \']\n2: (2) [\'text\', \'\\n    </ul>\\n    \']\n```\n\n### 数组折叠\n```javascript\nexport default function nestTokens(tokens) {\n  //遍历数组遇到 # \n  let nestTokens = [];\n  let tagStack = [];\n  for (let i = 0; i < tokens.length; i++) {\n    let token = tokens[i];\n    switch (token[0]) {\n      case \"#\":\n        //这个存的是层级(几个#)，待会好回去\n        tagStack.push(token);\n        break;\n      case \"/\":\n        let tagStackPop = tagStack.pop();\n        //碰到第一个/触发出栈操作时，可以判断当前栈是否还有值，如果有则将出栈值push到栈顶数组中\n        if(tagStack.length) {\n          tagStack[tagStack.length - 1][2].push(tagStackPop)\n        }else {\n          nestTokens.push(tagStackPop)\n        }\n        break;\n      default:\n        if (tagStack.length === 0) {\n          nestTokens.push(token)\n        } else {\n          tagStack[tagStack.length - 1][2].push(token)\n        }\n        break;\n    }\n  }\n  return nestTokens\n}\n```\n`nestTokens()`方法对传入的tokens数组进行遍历，普通项正常进入nestTokens数组，遍历过程中若是遇到嵌套开始标志`#`,就将其压入tagStack，并且后续对nestTokens的push操作都是在tagStack栈顶数组中，如果遇到嵌套结束标志`/`，可以判断当前tagStack是否还有值，如果有则将出栈值push到栈顶数组中,如果没有值了则将最后一个出栈的数组push到nestTokens中并将nestTokens返回。\n### 嵌套复杂类型的读取\n如果我们需要拿到对象类型的值，需要用上`.`点符号，但目前的渲染函数只能识别简单的数据类型，所以我们需要再封装一个方法，来对数据中的复杂类型进行获取。\n```javascript\n// 根据传入的带点字符串参数 查找对象的值\nexport default function lookup(dataObj, keyName) {\n  let str = \'\'\n  try {\n    let i = keyName.indexOf(\'.\')\n    if (i !== -1 && keyName !== \'.\') {\n      str = keyName.substring(0, i);\n      return lookup(dataObj[str], keyName.substr(i + 1))\n    } else {\n      return dataObj[keyName]\n    }\n  } catch(err) {\n    console.log(err);\n  }\n}\n```\n### 最后一步模板渲染\n最终的Tokens数组我们已经拿到了，接下来便是最后一步但是同样重要，`模板渲染`,将tokens与数据进行结合，并形成最终的domStr。\n```javascript\nimport lookup from \"./lookup\"\nimport parserArr from \"./parserArr\"\n// 实现功能 将数据与tokens数组合成html\nexport default function renderTemplate(data, tokens) {\n  let resStr = \'\';\n  for (let i = 0; i < tokens.length; i++) {\n    let token = tokens[i]\n    if (token[0] === \'text\') {\n      resStr += token[1]\n    } else if (token[0] === \'name\') {\n      resStr += lookup(data, token[1])\n    } else if (token[0] === \'#\') {\n      resStr += parserArr(token, data)\n    }\n  }\n  return resStr\n}\n\n```\n测试\n```javascript\n var template = `\n    <ul>\n      {{#students}}\n      <li>\n        学生{{name}}的爱好是\n        <ol>\n          {{#hobbies}}\n          <li>{{.}}</li>\n          {{/hobbies}}\n        </ol>\n      </li>\n      {{/students}}\n    </ul>\n    `\n    var data = {\n      students: [{\n          \'name\': \'小明\',\n          \'hobbies\': [\'游泳\', \'健身\']\n        },\n        {\n          \'name\': \'小红\',\n          \'hobbies\': [\'足球\', \'篮球\', \'羽毛球\']\n        },\n        {\n          \'name\': \'小坤\',\n          \'hobbies\': [\'唱\', \'跳\',\'rap\', \'篮球\']\n        },\n      ]\n    }\n    var domStr = window.my_templateEngine.render(template, data);\n    var container = document.getElementById(\"container\");\n    container.innerHTML = domStr\n```\n浏览器输出结果  \n![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cc4719225d7e4b4d866f16a81c041d3e~tplv-k3u1fbpfcp-watermark.image?)\n\n\n![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f190c95875fa4125a79a839230a1c04e~tplv-k3u1fbpfcp-watermark.image?)\n\n', '2021-10-17 00:58:59', '2021-10-17 02:19:34', '1', '模板引擎的基本机理就是替换（转换），将指定的标签转换为需要的业务数据；将指定的伪语句按照某种流程来变换输出', 0, NULL);

-- ----------------------------
-- Table structure for t_img
-- ----------------------------
DROP TABLE IF EXISTS `t_img`;
CREATE TABLE `t_img`  (
  `img_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(0) NOT NULL COMMENT 'uid',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片url',
  `create_time` datetime(0) NOT NULL COMMENT '注册时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`img_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_img
-- ----------------------------
INSERT INTO `t_img` VALUES (1, 1, 'swiper1.jpeg', 'http://127.0.0.1:3000/static/0d4c377fd0f7a06b77cab10624638da4', '2021-10-12 23:14:57', '2021-10-12 23:14:57', 0);

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `tag_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(0) NOT NULL COMMENT 'uid',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `blog_id` int(0) NOT NULL COMMENT '博客id',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_delete` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`tag_id`) USING BTREE,
  UNIQUE INDEX `blog_id`(`blog_id`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 203 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (253, 1, '2021-10-17 02:19:13', '2021-10-17 02:19:13', 3, 'vue', '0');
INSERT INTO `t_tag` VALUES (254, 1, '2021-10-17 02:19:13', '2021-10-17 02:19:13', 3, 'vue watch', '0');
INSERT INTO `t_tag` VALUES (255, 1, '2021-10-17 02:19:34', '2021-10-17 02:19:34', 16, 'mustache', '0');
INSERT INTO `t_tag` VALUES (256, 1, '2021-10-17 02:19:34', '2021-10-17 02:19:34', 16, 'vue', '0');
INSERT INTO `t_tag` VALUES (257, 1, '2021-10-17 02:19:34', '2021-10-17 02:19:34', 16, '模板引擎', '0');
INSERT INTO `t_tag` VALUES (258, 1, '2021-10-17 02:19:34', '2021-10-17 02:19:34', 16, '前端', '0');
INSERT INTO `t_tag` VALUES (259, 1, '2021-10-17 02:20:00', '2021-10-17 02:20:00', 14, 'nodejs', '0');
INSERT INTO `t_tag` VALUES (260, 1, '2021-10-17 02:20:00', '2021-10-17 02:20:00', 14, '后端', '0');
INSERT INTO `t_tag` VALUES (261, 1, '2021-10-17 02:20:00', '2021-10-17 02:20:00', 14, '爬虫', '0');
INSERT INTO `t_tag` VALUES (262, 1, '2021-10-17 02:20:00', '2021-10-17 02:20:00', 14, '王者荣耀', '0');
INSERT INTO `t_tag` VALUES (271, 1, '2021-10-17 02:21:11', '2021-10-17 02:21:11', 15, 'vue', '0');
INSERT INTO `t_tag` VALUES (272, 1, '2021-10-17 02:21:11', '2021-10-17 02:21:11', 15, 'vue-router', '0');
INSERT INTO `t_tag` VALUES (273, 1, '2021-10-17 02:21:11', '2021-10-17 02:21:11', 15, '后台管理系统', '0');
INSERT INTO `t_tag` VALUES (274, 1, '2021-10-17 02:21:11', '2021-10-17 02:21:11', 15, '前端', '0');
INSERT INTO `t_tag` VALUES (275, 1, '2021-10-17 02:21:11', '2021-10-17 02:21:11', 15, '权限管理', '0');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `uid` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `create_time` datetime(0) NOT NULL COMMENT '注册时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`uid`, `name`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '123456', '2021-10-08 17:35:30', '2021-10-17 01:54:01', 0);
INSERT INTO `t_user` VALUES (6, 'xietintin', '123456', '2021-10-17 02:06:24', '2021-10-17 02:06:34', 0);

SET FOREIGN_KEY_CHECKS = 1;
