import request from '@/utils/request'

export function addAdmin(data) {
  return request({
    url: '/rest/admins',
    method: 'post',
    data
  })
}
export function getAdminList(params) {
  return request({
    url: '/rest/admins',
    method: 'get',
    params
  })
}
export function getOneAdmin(id) {
  return request({
    url: `/rest/admins/${id}`,
    method: 'get',
  })
}
export function editOneAdmin(id, data) {
  return request({
    url: `/rest/admins/${id}`,
    method: 'put',
    data
  })
}
export function deleteOneAdmin(id) {
  return request({
    url: `/rest/admins/${id}`,
    method: 'delete',
  })
}
