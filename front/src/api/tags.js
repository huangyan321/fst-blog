import { request } from '../utils/request'
export function queryQcsLogoInfoList(data) {
  return request({
    url: 'device/commonDevice/queryQcsLogoInfoList',
    method: 'post',
    data
  })
}
