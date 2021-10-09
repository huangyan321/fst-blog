var express = require('express');
var router = express.Router();
const note = require('../dao/note_dao');
/* GET users listing. */
router.post('/add', function (req, res, next) {
	note.add(req, res)
});
router.post('/delete', function (req, res, next) {
	note.delete(req, res)
});
router.post('/edit', function (req, res, next) {
	note.edit(req, res)
});
router.get('/query', function (req, res, next) {
	note.queryOne(req, res)
});
router.get('/queryAll', function (req, res, next) {
	note.queryByType(req, res)
});
module.exports = router;