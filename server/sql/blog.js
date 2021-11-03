const IS = require('is')
module.exports = {
  queryAllBlogByTags(table, params, order, tag_id, where, offset, pageSize) {
    if (
      IS.string(table) &&
      IS.array(params) &&
      IS.string(order) &&
      IS.array(tag_id) &&
      IS.array(where) &&
      IS.number(offset) &&
      IS.number(pageSize)
    ) {
      return `SELECT ${params
        .map((i) => i)
        .join(',')} FROM ${table} WHERE tag_id in (${tag_id.join(',')}) AND ${
        where.map((i) => i).join(' = ? AND ') + ' = ?'
        //TODO
      } ORDER BY ${order} DESC  limit ${offset},${pageSize}`
    } else {
      return false
    }
  },
}
