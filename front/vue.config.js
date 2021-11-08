'use strict'
const path = require('path')
const defaultSettings = require('./src/settings.js')
//绝对路径拼接
function resolve(dir) {
  return path.join(__dirname, dir)
}
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin
const name = defaultSettings.title // page title

module.exports = {
  publicPath: '/',
  outputDir: 'dist',
  assetsDir: 'static',
  productionSourceMap: false,
  configureWebpack: {
    name: name,
    resolve: {
      alias: {
        '@': resolve('src')
      }
    },
    externals: {
      // CDN 的 Element 依赖全局变量 Vue， 所以 Vue 也需要使用 CDN 引入
      vue: 'Vue',
      'vue-router': 'VueRouter',
      axios: 'axios'
    }
    // plugins: [new BundleAnalyzerPlugin()]
  }
}
