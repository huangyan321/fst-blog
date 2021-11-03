import { request } from '../utils/request'
export function queryAllBlogs(params) {
  return request({
    url: '/admin/api/blogs/queryAll',
    method: 'get',
    params
  })
}
