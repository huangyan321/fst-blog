'use strict'
const path = require('path')
const defaultSettings = require('./src/settings.js')
//绝对路径拼接
function resolve(dir) {
  return path.join(__dirname, dir)
}

const name = defaultSettings.title // page title

module.exports = {
  publicPath: '/',
  outputDir: 'dist',
  assetsDir: 'static',
  configureWebpack: {
    // provide the app's title in webpack's name field, so that
    // it can be accessed in index.html to inject the correct title.
    name: name,
    resolve: {
      alias: {
        '@': resolve('src')
      }
    }
  }
}
