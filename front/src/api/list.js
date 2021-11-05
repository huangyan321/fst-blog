import { request } from '../utils/request'
export function queryBlogsBySelectTags(params) {
  return request({
    url: 'blogs/queryAll',
    method: 'get',
    params
  })
}
