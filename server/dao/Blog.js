const Jwt = require('../utils/jwtUtils');
const Utils = require('../utils');
const Tips = require('../utils/tip');
const { number } = require('is');

module.exports = class Blog_dao extends require('../model/common/curd') {
	//新增博客
	static async add(req, res) {
		const data = Utils.filter(req.body, ['title', 'content', 'note_id', 'brief', 'publish']);
		const {
			uid
		} = await Jwt.verifysync(req.headers.authorization, global.globalkey);
		if (!uid) {
			return res.send({
				...Tips[1005]
			})
		}
		let {
			name
		} = data;
		//字段校验
		const result = Utils.formatData(data, [{
				key: 'note_id',
				type: 'number'
			},
			{
				key: 'title',
				type: 'string'
			},
			{
				key: 'brief',
				type: 'string'
			},
			{
				key: 'content',
				type: 'string'
			},
			{
				key: 'publish',
				type: 'number'
			}
		]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		let {
			title = '无标题', content = '', note_id = '', brief = '', publish = 0, create_time = ''
		} = data;
		create_time = Utils.getDate19();
		try {
			await this.addField("t_blog", ['title', 'content',
				'note_id', 'brief', 'publish', 'uid', 'create_time'
			], title, content, note_id, brief, publish, uid, create_time)
			res.send(Tips[0])
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//删除博客
	static async delete(req, res) {
		const data = Utils.filter(req.params, ['id']);
		const {
			uid
		} = await Jwt.verifysync(req.headers.authorization, global.globalkey);
		if (!uid) {
			return res.send({
				...Tips[1005]
			})
		}
		let result = Utils.formatData(data, [{
			key: 'id',
			type: 'number'
		}]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		const {
			id
		} = data
		try {
			await this.deleteField("t_blog", ["id", "uid"], id, uid)
			res.send(Tips[0])
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//修改
	static async edit(req, res) {
		const data = Utils.filter(req.body, ['title','content', 'note_id', 'id', 'brief', 'publish']);
		const {
			uid
		} = await Jwt.verifysync(req.headers.authorization, global.globalkey);
		console.log(data);
		const result = Utils.formatData(data, [{
				key: 'note_id',
				type: 'number'
			},
			{
				key: 'id',
				type: 'number'
			},
			{
				key: 'title',
				type: 'string'
			},
			{
				key: 'brief',
				type: 'string'
			},
			{
				key: 'content',
				type: 'string'
			},
			{
				key: 'publish',
				type: 'number'
			}
		]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		let {
			title,
			content,
			note_id,
			id,
			brief,
			publish = 0,
			update_time = ''
		} = data;
		id = Number(id)
		update_time = Utils.getDate19();
		try {
			await this.editField("t_blog ", ['title', 'content', 'note_id','brief', 'publish', 'update_time'], ["id", "uid"], title, content, note_id, brief, publish, update_time, id, uid)
			res.send(Tips[0])
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//发布博客
	static async changeBlogStatus(req, res) {
		const data = Utils.filter(req.body, ['id', 'publish']);
		const {
			uid
		} = await Jwt.verifysync(req.headers.authorization, global.globalkey);
		const result = Utils.formatData(data, [{
				key: 'id',
				type: 'number'
			},
			{
				key: 'publish',
				type: 'number'
			}
		]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		const {
			id,
			publish
		} = data;
		const update_time = Utils.getDate19();
		try {
			await this.editField("t_blog", ['publish'], ["uid", "id"], publish, id, uid)
			res.send(Tips[0])
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//查询博客详情
	static async queryOne(req, res) {
		const data = Utils.filter(req.query, ['id']);
		const {
			uid
		} = await Jwt.verifysync(req.headers.authorization, global.globalkey);
		const result = Utils.formatData(data, [{
			key: 'id',
			type: 'number'
		}]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		let {
			id
		} = data;
		id = parseInt(id);
		try {
			const queryRes = await this.queryOneOfField("t_blog", ['title', 'content', 'note_id', 'id', 'brief', 'publish', 'create_time', 'update_time'], ["id", "is_delete"], id, 0)
			res.send({
				...Tips[0],
				queryRes: queryRes[0]
			})
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//查询所有博客(type：0所有 type：1根据笔记本查询)
	static async queryByType(req, res) {
		const data = Utils.filter(req.query, ['pageSize', 'pageNum', 'note_id', 'type'])
		const {
			uid
		} = await Jwt.verifysync(req.headers.authorization, global.globalkey);
		const result = Utils.formatData(data, [{
			key: 'type',
			type: 'number'
		}]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		let {
			pageSize = 10, pageNum = 1, type = 0, note_id
		} = data
		pageSize = Number(pageSize);
		pageNum = Number(pageNum);
		const offset = (pageNum - 1) * pageSize;
		const {
			id
		} = data;
		try {

			if (type == 1) {
				const count = await this.querySumOfField("t_blog", ["uid", "is_delete"], uid, 0)
				const list = await this.QueryFieldByPage("t_blog", ['title', 'content', 'note_id', 'id', 'brief', 'publish', 'create_time', 'update_time'], "create_time", ["uid", "note_id", "is_delete"], offset, pageSize, uid, note_id, 0)
				res.send({
					...Tips[0],
					total: count[0]["count(1)"],
					data: list,
					pageNum,
					pageSize
				})
			} else {
				const count = await this.querySumOfField("t_blog", ["uid", "is_delete"], uid, 0)
				const list = await this.QueryFieldByPage("t_blog", ['title', 'content', 'note_id', 'id', 'brief', 'publish', 'create_time', 'update_time'], "create_time", ["uid", "is_delete"], offset, pageSize, uid, 0)
				res.send({
					...Tips[0],
					total: count[0]["count(1)"],
					data: list,
					pageNum,
					pageSize
				})
			}

		} catch (err) {
			console.log(err);
			res.send(Tips[1008])
		}
	}
}