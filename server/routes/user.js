var express = require('express');
var router = express.Router();
const user = require('../dao/user_dao');
/* GET users listing. */
router.post('/login', function(req, res, next) {
  user.login(req,res)
});

module.exports = router;
