/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80026
Source Host           : localhost:3306
Source Database       : db_myblog

Target Server Type    : MYSQL
Target Server Version : 80026
File Encoding         : 65001

Date: 2021-11-05 11:06:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog` (
  `blog_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `uid` int DEFAULT '1' COMMENT 'uid',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '内容',
  `create_time` datetime NOT NULL COMMENT '注册时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `publish` tinyint DEFAULT '0' COMMENT '是否发布',
  `brief` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `ext_info` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`blog_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES ('17', '玩转mustache模板引擎', '1', '\n## 什么是模板引擎？\n>模板引擎的基本机理就是替换（转换），将指定的标签转换为需要的业务数据；将指定的伪语句按照某种流程来变换输出\n\n\n\n### Mustache模板引擎\n> 一个胡子模板是一个包含任意数量的小胡子标签的字符串。标签由围绕它们的双髭指示。\n \n\n* ### `{{data}}`\n\n双花括号就是mustache语法的标识符，花括号中的data表示键名，作用是直接输出与键名匹配的键值。\n```javascript\nvar template = `\n<div>{{data}}</div>\n`\nvar data = \"hello world\"\nvar html = mustache.render(template,data)\n//输出\n`\n<div>hello world</div>\n`\n```\n\n* ### `{{.}}`\n\n表示枚举，可循环输出整个数组,需搭配{{#data}}和{{/data}}使用。\n\n\n* ### `{{#data}}和{{/data}}`\n\n该语法以#开始，并以/结束表示区块，用于对当前上下文的数据进行一次或多次的渲染，类似vue中的`v-for`指令。\n```javascript \n// li标签根据data属性hobbies对应的键值持续迭代\nvar template = `\n  <div>\n  {{#hobbies}}\n    <li>{{.}}</li>\n  {{/hobbies}}\n  </div>`;\nvar hobbies = [\"唱\",\"跳\",\"rap\"]\nvar html = mustache.render(template)\n//输出\n `\n  <div>\n    <li>唱</li>\n    <li>跳</li>\n    <li>rap</li>\n  </div>`\n```\n实现一下mustache模板引擎实现原理，其中包括了以上几种语法的*简单*实现。\n\n## Render函数\n \n```javascript\nwindow.my_templateEngine = {\n  //渲染函数\n  render(templateStr, data) {\n    //将字符串模板转换成tokens数组\n    var tokens = parserTemplateToTokens(templateStr);\n    //结合数据渲染模板\n    var resTemplate = renderTemplate(data, tokens)\n    return resTemplate\n  }\n}\n```\n一个模板引擎最核心的便是其**渲染(render)函数**，渲染函数从主要负责将字符串模板与数据结合，动态渲染出HTML。\n### 嵌套数组(Tokens)\n> **Tokens**为Mustache的底层核心机理：js的嵌套数组，它是模板字符串的js表示形式，并且Tokens 是**抽象语法树（AST）**、**虚拟节点**等的思路来源。  \n \n\n数组形式：  \n ```\n\n0: (2) [\'text\', \'\\n    <ul>\\n      \']\n1: (3) [\'#\', \'students\', Array(5)]\n2: (2) [\'text\', \'\\n    </ul>\\n    \']\n```\n`\'text\'`代表普通字符串，直接拼接,第2项为字符串  \n`\'name\'`代表存储基本类型的键，第2项为键名  \n`\'#\'和\'/\'`表示区块，第2项为键名，第3项为数组  \n\n\n要将字符串模板转换成tokens数组，肯定要对传入的字符串模板进行处理，我们知道，Mustache语法是靠识别双花括号`{{}}`内的参数来进行数据替换的，那么我们必须使用某种识别方法来提取`{{}}`的内容。扫描器（Scanner）就是用来实现它的\n### 扫描器(Scanner)\n```javascript\nexport default class Scanner {\n  constructor(templateStr) {\n    //贮存传入的字符串模板\n    this.templateStr = templateStr\n    //贮存tag之前的字符串\n    this.tail = templateStr\n    //扫描指针\n    this.pos = 0\n  }\n  //扫描方法,传入需要识别的tag\n  scanUntil(stopTag) {\n    //记录一下pos\n    var pos_backup = this.pos\n    //当尾巴的开头不是stopTag的时候 就说明没有扫描到stopTag\n    while(this.tail.indexOf(stopTag) !== 0 && !this.isEnd()) {\n      this.pos ++;\n      this.tail = this.templateStr.substr(this.pos)\n    }\n    return this.templateStr.substring(pos_backup,this.pos)\n  }\n  //跳过传入的tag\n  scan(tag) {\n    while(this.tail.indexOf(tag) === 0) {\n    //过掉tag\n      this.pos += 2;\n      this.tail = this.templateStr.substr(this.pos)\n    }\n  }\n  //判断是否到末尾\n  isEnd() {\n    return this.pos > this.templateStr.length\n  }\n}\n```\n`scanUntil()`方法对传入的字符串进行检索，如果当前字符串中索引为0的字符不是\'{\',就将pos指针`加1`，直到遇到\'{\'，该方法会返回处于\'{\'之前的字符串。  \n`scan()`方法负责跳过tag，因为\"{{\"占用了两个字符的位置并且已经完成了它的使命，所以截去并将pos位置`加2`。下面是该方法示例\n```javascript\n//示例\nimport Scanner from \"./scanner\";\nvar scanner = new Scanner(`<div><ul><li>{{hey}}</li></ul></div>`)\nconsole.log(scanner.scanUntil(\"{{\")) //<div><ul><li>\nscanner.scan(\"{{\") //跳过\nconsole.log(scanner.scanUntil(\"}}\")) //hey\nscanner.scan(\"}}\") //跳过\nconsole.log(scanner.scanUntil(\"}}\")) //</li></ul></div>\n...\n```\n\n\n### 使用扫描器获取Tokens\n```javascript\nimport Scanner from \"./scanner\";\nimport nestTokens from \"./nestTokens\"\nexport default function parserTemplateToTokens(templateStr) {\n  var tokens = [];\n  var words = \"\";\n  var scanner = new Scanner(templateStr)\n  while (scanner.eos()) {\n    //收集mustache开始标记之前的值\n    words = scanner.scanUntil(\"{{\");\n    //过掉标记\n    scanner.scan(\"{{\")\n    if (words !== \'\') {\n      tokens.push([\"text\", words]);\n    }\n    //收集mustache结束标记之前的值\n    words = scanner.scanUntil(\"}}\");\n    //过掉标记\n    scanner.scan(\"}}\")\n    if (words !== \'\') {\n      if(words[0] === \"#\") {\n      tokens.push([\"#\", words.substring(1)]);\n    } else if(words[0] === \"/\"){\n      tokens.push([\"/\", words.substring(1)] );\n    } else {\n      tokens.push([\"name\", words]);\n    }\n    }\n  }\n  return tokens\n}\n```\n根据示例方法，可以实现将截取的字符串形成像下面的形式的数组：  \n```\n0: (2) [\'text\', \'\\n    <ul>\\n      \']\n1: (3) [\'#\', \'students\', Array(5)]\n2: (2) [\'text\', \'\\n        <li>\\n          学生\']\n3: (2) [\'name\', \'name\']\n4: (2) [\'text\', \'的爱好是\\n          <ol>\\n            \']\n5: (3) [\'#\', \'hobbies\', Array(3)]\n6: (2) [\'text\', \'\\n            <li>\']\n7: (2) [\'name\', \'.\']\n8: (2) [\'text\', \'</li>\\n              \']\n9: (2) [\'/\', \'hobbies\']\n10: (2) [\'text\', \'\\n              </ol>\\n        </li>\\n        \']\n11: (2) [\'/\', \'students\']\n12: (2) [\'text\', \'\\n    </ul>\\n    \']\n```\n可以看到 数组中存在有**hobbies**和**students**两个区块，我们所期望的是他们是`嵌套`的关系（像以下的嵌套形式），所以我们的实现方式仍然存在一些问题。\n```\n0: (2) [\'text\', \'\\n    <ul>\\n      \']\n1: Array(3)\n  0: \"#\"\n  1: \"students\"\n  2: Array(5)\n    0: (2) [\'text\', \'\\n        <li>\\n          学生\']\n    1: (2) [\'name\', \'name\']\n    2: (2) [\'text\', \'的爱好是\\n          <ol>\\n            \']\n    3: Array(3)\n      0: \"#\"\n      1: \"hobbies\"\n      2: Array(3)\n        0: (2) [\'text\', \'\\n            <li>\']\n        1: (2) [\'name\', \'.\']\n        2: (2) [\'text\', \'</li>\\n              \']\n4: (2) [\'text\', \'\\n              </ol>\\n        </li>\\n        \']\n2: (2) [\'text\', \'\\n    </ul>\\n    \']\n```\n\n### 数组折叠\n```javascript\nexport default function nestTokens(tokens) {\n  //遍历数组遇到 # \n  let nestTokens = [];\n  let tagStack = [];\n  for (let i = 0; i < tokens.length; i++) {\n    let token = tokens[i];\n    switch (token[0]) {\n      case \"#\":\n        //这个存的是层级(几个#)，待会好回去\n        tagStack.push(token);\n        break;\n      case \"/\":\n        let tagStackPop = tagStack.pop();\n        //碰到第一个/触发出栈操作时，可以判断当前栈是否还有值，如果有则将出栈值push到栈顶数组中\n        if(tagStack.length) {\n          tagStack[tagStack.length - 1][2].push(tagStackPop)\n        }else {\n          nestTokens.push(tagStackPop)\n        }\n        break;\n      default:\n        if (tagStack.length === 0) {\n          nestTokens.push(token)\n        } else {\n          tagStack[tagStack.length - 1][2].push(token)\n        }\n        break;\n    }\n  }\n  return nestTokens\n}\n```\n`nestTokens()`方法对传入的tokens数组进行遍历，普通项正常进入nestTokens数组，遍历过程中若是遇到嵌套开始标志`#`,就将其压入tagStack，并且后续对nestTokens的push操作都是在tagStack栈顶数组中，如果遇到嵌套结束标志`/`，可以判断当前tagStack是否还有值，如果有则将出栈值push到栈顶数组中,如果没有值了则将最后一个出栈的数组push到nestTokens中并将nestTokens返回。\n### 嵌套复杂类型的读取\n如果我们需要拿到对象类型的值，需要用上`.`点符号，但目前的渲染函数只能识别简单的数据类型，所以我们需要再封装一个方法，来对数据中的复杂类型进行获取。\n```javascript\n// 根据传入的带点字符串参数 查找对象的值\nexport default function lookup(dataObj, keyName) {\n  let str = \'\'\n  try {\n    let i = keyName.indexOf(\'.\')\n    if (i !== -1 && keyName !== \'.\') {\n      str = keyName.substring(0, i);\n      return lookup(dataObj[str], keyName.substr(i + 1))\n    } else {\n      return dataObj[keyName]\n    }\n  } catch(err) {\n    console.log(err);\n  }\n}\n```\n### 最后一步模板渲染\n最终的Tokens数组我们已经拿到了，接下来便是最后一步但是同样重要，`模板渲染`,将tokens与数据进行结合，并形成最终的domStr。\n```javascript\nimport lookup from \"./lookup\"\nimport parserArr from \"./parserArr\"\n// 实现功能 将数据与tokens数组合成html\nexport default function renderTemplate(data, tokens) {\n  let resStr = \'\';\n  for (let i = 0; i < tokens.length; i++) {\n    let token = tokens[i]\n    if (token[0] === \'text\') {\n      resStr += token[1]\n    } else if (token[0] === \'name\') {\n      resStr += lookup(data, token[1])\n    } else if (token[0] === \'#\') {\n      resStr += parserArr(token, data)\n    }\n  }\n  return resStr\n}\n\n```\n测试\n```javascript\n var template = `\n    <ul>\n      {{#students}}\n      <li>\n        学生{{name}}的爱好是\n        <ol>\n          {{#hobbies}}\n          <li>{{.}}</li>\n          {{/hobbies}}\n        </ol>\n      </li>\n      {{/students}}\n    </ul>\n    `\n    var data = {\n      students: [{\n          \'name\': \'小明\',\n          \'hobbies\': [\'游泳\', \'健身\']\n        },\n        {\n          \'name\': \'小红\',\n          \'hobbies\': [\'足球\', \'篮球\', \'羽毛球\']\n        },\n        {\n          \'name\': \'小坤\',\n          \'hobbies\': [\'唱\', \'跳\',\'rap\', \'篮球\']\n        },\n      ]\n    }\n    var domStr = window.my_templateEngine.render(template, data);\n    var container = document.getElementById(\"container\");\n    container.innerHTML = domStr\n```\n浏览器输出结果  \n![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cc4719225d7e4b4d866f16a81c041d3e~tplv-k3u1fbpfcp-watermark.image?)\n\n\n![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f190c95875fa4125a79a839230a1c04e~tplv-k3u1fbpfcp-watermark.image?)\n\n', '2021-11-05 10:09:02', '2021-11-05 11:03:52', '1', '>模板引擎的基本机理就是替换（转换），将指定的标签转换为需要的业务数据；将指定的伪语句按照某种流程来变换输出', '0', null);

-- ----------------------------
-- Table structure for t_img
-- ----------------------------
DROP TABLE IF EXISTS `t_img`;
CREATE TABLE `t_img` (
  `img_id` int unsigned NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL COMMENT 'uid',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图片名称',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图片url',
  `create_time` datetime NOT NULL COMMENT '注册时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`img_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_img
-- ----------------------------
INSERT INTO `t_img` VALUES ('1', '1', 'swiper1.jpeg', 'http://127.0.0.1:3000/static/0d4c377fd0f7a06b77cab10624638da4', '2021-10-12 23:14:57', '2021-10-12 23:14:57', '0');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `tag_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标签名',
  `uid` int NOT NULL COMMENT 'uid',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) DEFAULT '0',
  `blog_id` int DEFAULT NULL COMMENT '博客id',
  `publish` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tag_id`) USING BTREE,
  UNIQUE KEY `name` (`name`,`blog_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES ('141', '模板引擎', '1', '2021-11-05 11:03:52', '2021-11-05 11:03:52', '0', '17', null);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `uid` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '姓名',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `create_time` datetime NOT NULL COMMENT '注册时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', '123456', '2021-10-08 17:35:30', '2021-10-13 22:43:32', '0');
