const IS = require('is');
module.exports = {
	/**
	 * 增加
	 * @param {String} table 表
	 * @param {Array} params 待添加的字段
	 * @returns 
	 */
	Add(table, params) {
		if (IS.array(params) && IS.string(table)) {
			return `INSERT IGNORE INTO ${table}(${params.join(',')}) VALUES(${params.map(()=>'?').join(',')});`
		} else {
			return false
		}
	},
	/**
	 * 
	 * @param {String} table 表
	 * @param {Array} where 表位置
	 * @returns 
	 */
	Delete(table, where) {
		if (IS.array(where) && IS.string(table)) {
			return `UPDATE ${table} set is_delete=1 WHERE ${where.map(i=>i).join(' = ? and ') + ' = ?'}`
		} else {
			return false
		}
	},
	/**
	 * 
	 * @param {String} table 表
	 * @param {Array} set 需要更新的参数
	 * @param {Array} where 表位置
	 * @returns 
	 */
	Edit(table, set, where) {
		if (IS.string(table) && IS.array(set) && IS.array(where)) {
			return `UPDATE ${table} set ${set.map(i=>i).join(' = ? , ') + ' = ?'} WHERE ${where.map(i=>i).join(' = ? and ') + ' = ?'}`
		} else {
			return false
		}
	},
	/**
	 * 
	 * @param {String} table 表
	 * @param {Array} params 查询参数
	 * @param {Array} where 表位置
	 * @returns 
	 */
	QueryOne(table, params, where) {
		if (IS.array(where) && IS.string(table) && IS.array(params)) {
			return `SELECT  ${params.map(i=>i).join(',')} FROM ${table} WHERE ${where.map(i=>i).join(' = ? and ') + ' = ?'};`
		} else {
			return false
		}
	},
	/**
	 * 
	 * @param {String} table 表
	 * @param {Array} where 表位置
	 * @returns 
	 */
	QuerySum(table, where) {
		if (IS.array(where) && IS.string(table)) {
			return `SELECT count(1) FROM  ${table} WHERE ${where.map(i=>i).join(' = ? and ') + ' = ?'};`
		} else {
			return false
		}
	},
	/**
	 * 
	 * @param {String} table 表
	 * @param {Array} params 需要查询的值
	 * @param {String} order 排序方式
	 * @param {Array} where 表位置
	 * @returns 
	 */
	QueryAll(table, params, order, where) {
		if (IS.string(order) && IS.string(table) && IS.array(params) && IS.array(where)) {
			return `SELECT ${params.map(i=>i).join(',')}  FROM  ${table} WHERE ${where.map(i=>i).join(' = ? and ') + ' = ?'} ORDER BY ${order} DESC;`
		} else {
			return false
		}
	},
	/**
	 * 
	 * @param {String} table 表
	 * @param {Array} params 需要查询的值
	 * @param {String} order 排序方式
	 * @param {Array} where 表位置
	 * @param {Number} offset 偏移量
	 * @param {Number} pageSize 查询页数
	 * @returns 
	 */
	QueryByPage(table, params, order, where, offset, pageSize) {
		if (IS.string(order) && IS.string(table) && IS.array(params) && IS.array(where) && IS.number(offset) && IS.number(pageSize)) {
			return `SELECT ${params.map(i=>i).join(',')}  FROM  ${table} WHERE ${where.map(i=>i).join(' = ? and ') + ' = ?'} ORDER BY ${order} DESC  limit ${offset},${pageSize};`
		} else {
			return false
		}
	},
}