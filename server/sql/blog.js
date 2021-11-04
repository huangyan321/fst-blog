const IS = require('is')
module.exports = {
  queryTagNameByTagsId(table, params, order, tag_id, where) {
    if (
      IS.string(table) &&
      IS.array(params) &&
      IS.string(order) &&
      IS.array(tag_id) &&
      IS.array(where)
    ) {
      return `SELECT ${params
        .map((i) => i)
        .join(',')} FROM ${table} WHERE tag_id in (${tag_id.join(',')}) AND ${
        where.map((i) => i).join(' = ? AND ') + ' = ?'
        //TODO
      } ORDER BY ${order} DESC `
    } else {
      return false
    }
  },
  queryBlogsIdByTagsName(table, params, order, names, where) {
    if (
      IS.string(table) &&
      IS.array(params) &&
      IS.string(order) &&
      IS.array(names) &&
      IS.array(where)
    ) {
      return `SELECT ${params
        .map((i) => i)
        .join(',')} FROM ${table} WHERE name in (${names
        .map((i) => `'${i}'`)
        .join(',')}) AND ${
        where.map((i) => i).join(' = ? AND ') + ' = ?'
        //TODO
      } ORDER BY ${order} DESC`
    } else {
      return false
    }
  },
  queryBlogByBlogIds(table, params, order, blogIds, where, offset, pageSize) {
    if (
      IS.string(table) &&
      IS.array(params) &&
      IS.string(order) &&
      IS.array(blogIds) &&
      IS.array(where) &&
      IS.number(offset) &&
      IS.number(pageSize)
    ) {
      return `SELECT ${params
        .map((i) => i)
        .join(',')} FROM ${table} WHERE blog_id in (${blogIds.join(',')}) AND ${
        where.map((i) => i).join(' = ? AND ') + ' = ?'
        //TODO
      } ORDER BY ${order} DESC LIMIT ${offset},${pageSize};`
    } else {
      return false
    }
  },
}
