var express = require("express");
var path = require("path");
var history = require("connect-history-api-fallback");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
global.globalkey = "123456"; //全局key

var app = express();

//跨域配置
app.all("*", function (req, res, next) {
  //设置允许跨域的域名，*代表允许任意域名跨域

  res.header("Access-Control-Allow-Origin", "*");
  //允许的header类型
  res.header(
    "Access-Control-Allow-Headers",
    "Content-Type,Access-Token,Appid,Secret,Authorization"
  );
  //跨域允许的请求方式
  res.header("Access-Control-Allow-Methods", "DELETE,PUT,POST,GET,OPTIONS");
  if (req.method.toLowerCase() == "options") res.sendStatus(200);
  //让options尝试请求快速结束
  else next();
});

app.use(
  //使用history模式
  history({
    index: "/index.html",
  })
);
app.use(logger("dev"));
app.use(express.json());
app.use(
  express.urlencoded({
    extended: false,
  })
);
app.use(cookieParser());
// app.use(express.static(path.join(__dirname, 'public')))
// app.use('/admin', express.static(__dirname + '/../admin/dist'))
app.use(express.static(__dirname + "/../front/dist"));
require("./routes/admin/index")(app);
require("./routes/user/index")(app);
module.exports = app;
