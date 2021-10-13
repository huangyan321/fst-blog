const gulp = require('gulp')
const GulpSSH = require('gulp-ssh')

const {
  // APP_ENV,
  npm_package_name
} = process.env
// const isProduct = APP_ENV === 'production';

// 需要上传到服务器的路径
const remotePath = `/root/git/${npm_package_name}/`
const config = {
  // ssh: { // 正式
  //   host: isProduct ? '' : '192.168.31.227',
  //   port: isProduct ? 22 : 8822,
  //   username: 'root',
  //   password: isProduct ? '' : 'a1234567',
  // },
  ssh: { // 正式
    host: '121.196.101.73',
    port: 22,
    username: 'root',
    password: 'wwp19980729~'
  },
  remotePath,
  commands: [
    // 删除现有文件
    `rm -rf ${remotePath}`,
    `nginx -s reload`,
    `pm2 restart 0`
  ]
}
const gulpSSH = new GulpSSH({
  ignoreErrors: false,
  sshConfig: config.ssh
})
/**
 * 上传前先删除服务器上现有文件...
 */
gulp.task('execSSH', () => {
  console.log('删除服务器文件...')
  return gulpSSH.shell(config.commands[0], {
    filePath: 'commands.log'
  })
    .pipe(gulp.dest('logs'))
})

/**
 * 等待2s
 */
gulp.task('await', gulp.series('execSSH', (done) => {
  console.log('2s后开始上传文件到服务器...')
  setTimeout(() => {
    done()
  }, 2000)
}))
/**
 * 上传文件到服务器
 */
gulp.task('upload', gulp.series('await', (done) => {
  return gulp.src(`./dist/**`)
    .pipe(gulpSSH.dest(config.remotePath))
}))
/**
 * 重新加载nginx
 */
gulp.task('nginx', gulp.series('upload', () => {
  console.log('上传完毕.....')
  console.log('nginx重加载...')
  return gulpSSH.shell(config.commands[1], {
    filePath: 'commands.log'
  })
    .pipe(gulp.dest('logs'))
}))
/**
 * 重新加载pm2
 */
gulp.task('deploy', gulp.series('nginx', () => {
  console.log('上传完毕.....')
  console.log('重启pm2...')
  return gulpSSH.shell(config.commands[2], {
    filePath: 'commands.log'
  })
    .pipe(gulp.dest('logs'))
}))

