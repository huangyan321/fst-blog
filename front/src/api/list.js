import { request } from '../utils/request'
export function queryBlogsBySelectTags(params) {
  return request({
    url: '/admin/api/blogs/queryAll',
    method: 'get',
    params
  })
}
