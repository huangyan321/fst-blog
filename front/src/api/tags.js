import { request } from '../utils/request'
export function queryAllTags() {
  return request({
    url: 'tags/queryAll',
    method: 'get'
  })
}
