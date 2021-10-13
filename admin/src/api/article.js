import request from '@/utils/request'

export function addArticle(data) {
  return request({
    url: '/api/blogs',
    method: 'post',
    data
  })
}
export function getArticleList(params) {
  return request({
    url: '/api/blogs/queryAll',
    method: 'get',
    params
  })
}
export function getOneArticle(id) {
  return request({
    url: `/api/blogs/${id}`,
    method: 'get',
  })
}
export function editOneArticle(data) {
  return request({
    url: `/api/blogs`,
    method: 'put',
    data
  })
}
export function deleteOneArticle(id) {
  return request({
    url: `/api/blogs`,
    method: 'delete',
    data: id
  })
}
