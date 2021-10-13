import request from '@/utils/request'

export function addArticle(data) {
  return request({
    url: '/blogs',
    method: 'post',
    data
  })
}
export function getArticleList(params) {
  return request({
    url: '/blogs/queryAll',
    method: 'get',
    params
  })
}
export function getOneArticle(id) {
  return request({
    url: `/rest/articles/${id}`,
    method: 'get',
  })
}
export function editOneArticle(id, data) {
  return request({
    url: `/rest/articles/${id}`,
    method: 'put',
    data
  })
}
export function deleteOneArticle(id) {
  return request({
    url: `/rest/articles`,
    method: 'delete',
    data: id
  })
}
