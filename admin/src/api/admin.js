import request from "@/utils/request";

export function addAdmin(data) {
  return request({
    url: "/api/users",
    method: "post",
    data
  });
}
export function getAdminList(params) {
  return request({
    url: "/api/users/queryAll",
    method: "get",
    params
  });
}
export function getOneAdmin(params) {
  return request({
    url: `/api/users/query`,
    method: "get",
    params
  });
}
export function editOneAdmin(data) {
  return request({
    url: `/api/users`,
    method: "put",
    data
  });
}
export function deleteOneAdmin(id) {
  return request({
    url: `/api/users`,
    method: "delete",
    data: id
  });
}
