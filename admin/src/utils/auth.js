import Cookies from 'js-cookie'

const TokenKey = 'shop-admin-token'
const RoleKey = 'shop-admin-id'
export function getToken() {
  return Cookies.get(TokenKey)
}

export function setToken(token) {
  return Cookies.set(TokenKey, token,{ expires: 7 })
}

export function setRoleId(roleId) {
  return Cookies.set(RoleKey, roleId)
}
export function getRoleId(roleId) {
  return Cookies.get(RoleKey, roleId)
}

export function removeToken() {
  return Cookies.remove(TokenKey)
}
