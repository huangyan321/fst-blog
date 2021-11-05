import axios from 'axios'
import { getDomain } from '../utils/usual'
import nProgress from 'nprogress' // 引入nprogress插件
import 'nprogress/nprogress.css'
nProgress.configure({ easing: 'ease', speed: 300 })
const request = axios.create({
  baseURL: getDomain(),
  timeout: 9000
})
request.interceptors.request.use(config => {
  console.log('nProgress.start()')
  nProgress.start()
  return config
  error => {
    // do something with request error
    console.log(error) // for debug
    return Promise.reject(error)
  }
})
request.interceptors.response.use(response => {
  nProgress.done()
  const res = response.data
  if (res.code === 200) {
    return res
  }
})
export { request }
