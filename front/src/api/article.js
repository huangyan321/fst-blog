import { request } from '../utils/request'
export function queryAllBlogs(params) {
  return request({
    url: '/admin/api/blogs/queryAll',
    method: 'get',
    params
  })
}
export function queryOneBlog(blog_id) {
  return request({
    url: '/admin/api/blogs/query',
    method: 'get',
    params: { blog_id }
  })
}
