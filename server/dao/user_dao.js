const Jwt = require('../utils/jwtUtils');
const Utils = require('../utils');
const Tips = require('../utils/tip');
module.exports = class User_dao extends require('../model/user_mod') {
	static async login(req, res) {
		const data = Utils.filter(req.body, ['username', 'password']);
		//字段校验
		const result = Utils.formatData(data, [{
				key: "username",
				type: "string"
			},
			{
				key: "password",
				type: "string"
			}
		]);
		if (!result) {
			return res.send({
				...Tips[1007]
			})
		}
		let {
			username,
			password
		} = data;
		const queryRes = await this.loginMod(username, password)
		if (queryRes[0] && queryRes[0].uid) {
			const uid = queryRes[0].uid;
			const token = Jwt.sign({
				uid
			}, global.globalkey, '1day');
			res.send({
				...Tips[0],
				token
			})
		} else {
			res.send({
				...Tips[1006],
			})
		}

	}
}