const Jwt = require('../utils/jwtUtils');
const Utils = require('../utils');
const Tips = require('../utils/tip');

module.exports = class Note_dao extends require('../model/common/curd') {
	//新增笔记
	static async add(req, res) {
		const data = Utils.filter(req.body, ['name']);
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
			key: "name",
			type: "string"
		}, ]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		const create_time = Utils.getDate19();
		try {
			await this.addField("t_note", ['name', 'uid',
				'create_time'
			], name, uid, create_time)
			res.send(Tips[0])
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//删除笔记
	static async delete(req, res) {
		const data = Utils.filter(req.body, ['id']);
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
			await this.deleteField("t_note", ["id", "uid"], id, uid)
			await this.deleteField("t_blog", ["note_id", "uid"], id, uid)
			res.send(Tips[0])
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//修改
	static async edit(req, res) {
		const data = Utils.filter(req.body, ['name', 'id']);
		const {
			uid
		} = await Jwt.verifysync(req.headers.authorization, global.globalkey);
		const result = Utils.formatData(data, [{
				key: 'name',
				type: 'string'
			},
			{
				key: 'id',
				type: 'number'
			}
		]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		const {
			name,
			id
		} = data;
		try {
			await this.editField("t_note", ["name"], ["id", "uid"], name, id, uid)
			res.send(Tips[0])
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//查询笔记本详情
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
		const {
			id
		} = data;
		try {
			const queryRes = await this.queryOneOfField("t_note", ["name"], ["id"], id)
			res.send({
				...Tips[0],
				queryRes: queryRes[0]
			})
		} catch (err) {
			res.send(Tips[1008])
		}
	}
	//查询所有笔记本(type：0所有type：1分页)
	static async queryByType(req, res) {
		const data = Utils.filter(req.query, ['pageSize', 'pageNum', 'type'])
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
			pageSize = 10, pageNum = 1, type = 0
		} = data
		pageSize = Number(pageSize);
		pageNum = Number(pageNum);
		const offset = (pageNum - 1) * pageSize;
		const {
			id
		} = data;
		try {
			const count = await this.querySumOfField("t_note", ["uid", "is_delete"], uid, 0)
			if (type == 1) {
				const list = await this.QueryFieldByPage("t_note", ["name", "id", "create_time", "update_time"], "create_time", ["uid", "is_delete"], offset, pageSize, uid, 0)
				res.send({
					...Tips[0],
					total: count[0]["count(1)"],
					data: list,
					pageNum,
					pageSize
				})
			} else {
				const list = await this.queryAllOfField("t_note", ["name", "id", "create_time", "update_time"], "create_time", ["uid", "is_delete"], uid, 0)
				res.send({
					...Tips[0],
					total: count[0]["count(1)"],
					data: list
				})
			}

		} catch (err) {
			console.log(err);
			res.send(Tips[1008])
		}
	}
}