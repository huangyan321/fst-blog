import axios from 'axios'
import nProgress from 'nprogress'
const request = axios.create({
  baseURL: 'http://121.196.101.73:9000',
  timeout: 9000
})
request.interceptors.request.use(config => {
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
