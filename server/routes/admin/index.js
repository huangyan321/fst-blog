module.exports = app => {
	var express = require('express');
	var assert = require('http-assert')
	var inflection = require('inflection')
	var router = express.Router({
		mergeParams: true
	});

	
	app.use('/admin/:resource', function (req, res, next) {
		//将路由名规范化为模块名称
		const modelName = inflection.classify(req.params.resource);

	}, router)
}