const Jwt = require('../utils/jwtUtils')
const Utils = require('../utils')
const Tips = require('../utils/tip')
const { number } = require('is')

module.exports = class Blog_dao extends require('../model/common/curd') {
  //新增博客
  static async add(req, res) {
    const data = Utils.filter(req.body, [
      'title',
      'publish',
      'content',
      'tags',
      'brief',
    ])
    const { uid } = await Jwt.verifysync(
      req.headers.authorization,
      global.globalkey
    )
    if (!uid) {
      return res.send({
        ...Tips[1005],
      })
    }
    console.log(data)
    //字段校验
    const result = Utils.formatData(data, [
      {
        key: 'tags',
        type: 'array',
      },
      {
        key: 'title',
        type: 'string',
      },
      {
        key: 'brief',
        type: 'string',
      },
      {
        key: 'content',
        type: 'string',
      },
      {
        key: 'publish',
        type: 'string',
      },
    ])
    if (!result) {
      return res.send({
        ...Tips[1007],
      })
    }
    let {
      title = '无标题',
      content = '',
      tags = '',
      brief = '',
      publish = 0,
      create_time = '',
    } = data
    create_time = Utils.getDate19()
    try {
      let { insertId } = await this.addField(
        't_blog',
        [
          'title',
          'content',
          'create_time',
          'update_time',
          'publish',
          'brief',
          'uid',
        ],
        title,
        content,
        create_time,
        create_time,
        publish,
        brief,
        uid
      )
      for (let i = 0; i < tags.length; i++) {
        await this.addField(
          't_tag',
          ['name', 'blog_id', 'create_time', 'update_time', 'uid'],
          tags[i].name,
          insertId,
          create_time,
          create_time,
          uid
        )
      }
      res.send(Tips[0])
    } catch (err) {
      res.send(Tips[1008])
    }
  }
  //删除博客
  static async delete(req, res) {
    const data = Utils.filter(req.body, ['blog_id'])
    const { uid } = await Jwt.verifysync(
      req.headers.authorization,
      global.globalkey
    )
    if (!uid) {
      return res.send({
        ...Tips[1005],
      })
    }
    let result = Utils.formatData(data, [
      {
        key: 'blog_id',
        type: 'number',
      },
    ])
    if (!result) {
      return res.send({
        ...Tips[1007],
      })
    }
    const { blog_id } = data
    try {
      await this.deleteField('t_blog', ['blog_id', 'uid'], blog_id, uid)
      await this.deleteField('t_tag', ['blog_id', 'uid'], blog_id, uid)
      res.send(Tips[0])
    } catch (err) {
      res.send(Tips[1008])
    }
  }
  //修改
  static async edit(req, res) {
    console.log('修改')
    const data = Utils.filter(req.body, [
      'title',
      'content',
      'tags',
      'blog_id',
      'brief',
      'publish',
    ])
    const { uid } = await Jwt.verifysync(
      req.headers.authorization,
      global.globalkey
    )
    if (!uid) {
      return res.send({
        ...Tips[1005],
      })
    }
    console.log(data)
    const result = Utils.formatData(data, [
      {
        key: 'tags',
        type: 'array',
      },
      {
        key: 'blog_id',
        type: 'number',
      },
      {
        key: 'title',
        type: 'string',
      },
      {
        key: 'brief',
        type: 'string',
      },
      {
        key: 'content',
        type: 'string',
      },
      {
        key: 'publish',
        type: 'string',
      },
    ])
    if (!result) {
      return res.send({
        ...Tips[1007],
      })
    }
    let {
      title,
      content,
      tags,
      blog_id,
      brief,
      publish = 0,
      update_time = '',
    } = data
    blog_id = Number(blog_id)
    update_time = Utils.getDate19()
    try {
      await this.editField(
        't_blog ',
        ['title', 'content', 'brief', 'publish', 'update_time'],
        ['blog_id', 'uid'],
        title,
        content,
        brief,
        publish,
        update_time,
        blog_id,
        uid
      )
      await this.deleteField('t_tag', ['blog_id', 'uid'], blog_id, uid)
      for (let i = 0; i < tags.length; i++) {
        await this.addField(
          't_tag',
          ['name', 'blog_id', 'create_time', 'update_time', 'uid'],
          tags[i].name,
          blog_id,
          update_time,
          update_time,
          uid
        )
      }
      res.send(Tips[0])
    } catch (err) {
      console.log(err)
      res.send(Tips[1008])
    }
  }
  //TODO 待验证
  //发布博客
  static async changeBlogPublicStatus(req, res) {
    console.log('进来了')
    const data = Utils.filter(req.body, ['blog_id', 'publish'])
    const { uid } = await Jwt.verifysync(
      req.headers.authorization,
      global.globalkey
    )
    if (!uid) {
      return res.send({
        ...Tips[1005],
      })
    }
    const result = Utils.formatData(data, [
      {
        key: 'blog_id',
        type: 'number',
      },
      {
        key: 'publish',
        type: 'string',
      },
    ])
    if (!result) {
      return res.send({
        ...Tips[1007],
      })
    }
    const { blog_id, publish } = data
    const update_time = Utils.getDate19()
    try {
      let { changedRows } = await this.editField(
        't_blog',
        ['publish'],
        ['uid', 'blog_id'],
        publish,
        uid,
        blog_id
      )
      changedRows ? res.send(Tips[0]) : res.send(Tips[1011])
    } catch (err) {
      console.log(err)
      res.send(Tips[1008])
    }
  }
  //查询博客详情
  static async queryOne(req, res) {
    const data = Utils.filter(req.query, ['blog_id'])
    const { uid } = await Jwt.verifysync(
      req.headers.authorization,
      global.globalkey
    )
    if (!uid) {
      return res.send({
        ...Tips[1005],
      })
    }
    const result = Utils.formatData(data, [
      {
        key: 'blog_id',
        type: 'number',
      },
    ])
    if (!result) {
      return res.send({
        ...Tips[1007],
      })
    }
    let { blog_id } = data
    blog_id = parseInt(blog_id)
    try {
      const queryRes = await this.queryOneOfField(
        't_blog',
        [
          'title',
          'content',
          'blog_id',
          'brief',
          'publish',
          'create_time',
          'update_time',
        ],
        ['blog_id', 'is_delete'],
        blog_id,
        0
      )
      const queryTags = await this.queryOneOfField(
        't_tag',
        ['name'],
        ['blog_id', 'is_delete'],
        blog_id,
        0
      )
      res.send({
        ...Tips[0],
        data: {
          ...queryRes[0],
          tags: queryTags,
        },
      })
    } catch (err) {
      console.log(err)
      res.send(Tips[1008])
    }
  }
  //查询所有博客(type：0 分页查询 type：1根据标签查询)
  static async queryByType(req, res) {
    const data = Utils.filter(req.query, [
      'pageSize',
      'pageNum',
      'tag_id',
      'type',
    ])
    const result = Utils.formatData(data, [
      {
        key: 'type',
        type: 'number',
      },
    ])
    if (!result) {
      return res.send({
        ...Tips[1007],
      })
    }
    let { pageSize = 10, pageNum = 1, type = 0, note_id } = data
    pageSize = Number(pageSize)
    pageNum = Number(pageNum)
    const offset = (pageNum - 1) * pageSize
    const { id } = data
    const uid = 1
    try {
      if (type == 1) {
        const count = await this.querySumOfField(
          't_blog',
          ['uid', 'is_delete'],
          uid,
          0
        )
        const list = await this.QueryFieldByPage(
          't_blog',
          [
            'title',
            'note_id',
            'id',
            'brief',
            'publish',
            'create_time',
            'update_time',
          ],
          'create_time',
          ['uid', 'note_id', 'is_delete'],
          offset,
          pageSize,
          uid,
          note_id,
          0
        )
        res.send({
          ...Tips[0],
          total: count[0]['count(1)'],
          data: list,
          pageNum,
          pageSize,
        })
      } else {
        const count = await this.querySumOfField(
          't_blog',
          ['uid', 'is_delete'],
          uid,
          0
        )
        const list = await this.QueryFieldByPage(
          't_blog',
          [
            'blog_id',
            'title',
            'content',
            'create_time',
            'update_time',
            'publish',
            'brief',
            'ext_info',
          ],
          'update_time',
          ['uid', 'is_delete'],
          offset,
          pageSize,
          uid,
          0
        )
        res.send({
          ...Tips[0],
          total: count[0]['count(1)'],
          data: list,
          pageNum,
          pageSize,
        })
      }
    } catch (err) {
      console.log(err)
      res.send(Tips[1008])
    }
  }
}
