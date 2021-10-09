const Utils = require('../../utils');
const sqlSentence = require('../../sql')
module.exports = class Curd extends require('../index') {

	/**
	 * 
	 * @param {String} table 表名
	 * @param {Array} params 字符串数组，需要插入的字段名
	 * @param  {...any} values 字段名对应的数据
	 * @returns 
	 */
	static addField(table, params, ...values) {
		return new Promise((resolve, reject) => {
			const sql = sqlSentence.Add(table, params);
			if (sql) {
				this.query(sql, this.formatParams(...values)).then(res => {
					resolve(res)
				}).catch(err => {
					reject(err)
				})
			}
		})
	}
	/**
	 * 
	 * @param {String} table 表名
	 * @param {Array} where 在表的哪个位置
	 * @param  {...any} values 字段名对应的数据
	 * @returns 
	 */
	static deleteField(table, where, ...values) {
		return new Promise((resolve, reject) => {
			const sql = sqlSentence.Delete(table, where);
			console.log(sql);
			if (sql) {
				this.query(sql, this.formatParams(...values)).then(res => {
					resolve(res)
				}).catch(err => {
					reject(err)
				})
			}
		})
	}
	static editField(table, set, where, ...values) {
		return new Promise((resolve, reject) => {
			const sql = sqlSentence.Edit(table, set, where);
			console.log(sql);
			if (sql) {
				this.query(sql, this.formatParams(...values)).then(res => {
					resolve(res)
				}).catch(err => {
					reject(err)
				})
			}
		})
	}
	static queryOneOfField(table, params, where, ...values) {
		return new Promise((resolve, reject) => {
			const sql = sqlSentence.QueryOne(table, params, where);
			console.log(sql);
			if (sql) {
				this.query(sql, this.formatParams(...values)).then(res => {
					resolve(res)
				}).catch(err => {
					reject(err)
				})
			}
		})
	}
	static querySumOfField(table, where, ...values) {
		return new Promise((resolve, reject) => {
			const sql = sqlSentence.QuerySum(table, where);
			console.log(sql);
			if (sql) {
				this.query(sql, this.formatParams(...values)).then(res => {
					resolve(res)
				}).catch(err => {
					reject(err)
				})
			}
		})
	}
	static queryAllOfField(table, params, order, where, ...values) {
		return new Promise((resolve, reject) => {
			const sql = sqlSentence.QueryAll(table, params, order, where);
			console.log(sql);
			if (sql) {
				this.query(sql, this.formatParams(...values)).then(res => {
					resolve(res)
				}).catch(err => {
					reject(err)
				})
			}
		})
	}
	static QueryFieldByPage(table, params, order, where, offset, pageSize, ...values) {
		return new Promise((resolve, reject) => {
			const sql = sqlSentence.QueryByPage(table, params, order, where, offset, pageSize);
			console.log(sql);
			if (sql) {
				this.query(sql, this.formatParams(...values)).then(res => {
					resolve(res)
				}).catch(err => {
					reject(err)
				})
			}
		})
	}
}