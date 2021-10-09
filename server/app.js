var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
global.globalkey = "123456" //全局key
const Utils = require('./utils');
const Tips = require('./utils/tip');
const router = require('./routes');

var app = express();


app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({
	extended: false
}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
require('./routes/admin/index')(app)
router(app);
module.exports = app;