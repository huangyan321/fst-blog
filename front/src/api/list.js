import { request } from '../utils/request'
export function queryBlogsBySelectTags(params) {
  return request({
    url: '/bp/api/blogs/queryAll',
    method: 'get',
    params
  })
}
