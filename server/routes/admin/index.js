module.exports = app => {
	var express = require('express');
	var assert = require('http-assert')
	var inflection = require('inflection')
	var router = express.Router({
		mergeParams: true
	});
	//增加
	router.post('/', function (req, res, next) {
		req.Model.add(req, res)
	});
	//删除
	router.delete('/:id', function (req, res, next) {
		req.Model.delete(req, res)
	});
	//修改
	router.put('/:id', function (req, res, next) {
		req.Model.edit(req, res)
	});
	//查询详细信息
	router.get('/:id', function (req, res, next) {
		req.Model.queryOne(req, res)
	});
	//查询所有列表
	router.get('/', function (req, res, next) {
		req.Model.queryByType(req, res)
	});

	app.use('/admin/:resource', function (req, res, next) {
		//将路由名规范化为模块名称
		const modelName = inflection.classify(req.params.resource);
		console.log(modelName);
		//引入对应模块
		const model = require(`../../dao/${modelName}`);
		//将模块挂在到req中
		req.Model = model;
		next();
	}, router)
}