const Jwt = require('../../utils/jwtUtils')
const Utils = require('../../utils')
const Tips = require('../../utils/tip')
module.exports = class Img_dao extends require('../../model/common/curd') {
  static async imgUpload(req, res) {
    const file = req.file
    const { uid } = await Jwt.verifysync(
      req.headers.authorization,
      global.globalkey
    )
    const create_time = Utils.getDate19()
    try {
      file.url = `http://127.0.0.1:3000/static/${file.filename}`
      await this.addField(
        't_img',
        ['uid', 'name', 'img_url', 'create_time', 'update_time', 'is_delete'],
        uid,
        file.originalname,
        file.url,
        create_time,
        create_time,
        0
      )
      res.send(file)
    } catch (err) {
      console.log(err)
      res.send(Tips[1008])
    }
  }
}
