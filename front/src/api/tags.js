import { request } from '../utils/request'
export function queryAllTags() {
  return request({
    url: '/bp/api/tags/queryAll',
    method: 'get'
  })
}
