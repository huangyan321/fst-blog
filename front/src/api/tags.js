import { request } from '../utils/request'
export function queryAllTags() {
  return request({
    url: '/admin/api/tags/queryAll',
    method: 'get',
  })
}
