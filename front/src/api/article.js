import { request } from '../utils/request'
export function queryAllBlogs(params) {
  return request({
    url: 'blogs/queryAll',
    method: 'get',
    params
  })
}
export function queryOneBlog(blog_id) {
  return request({
    url: 'blogs/query',
    method: 'get',
    params: { blog_id }
  })
}
