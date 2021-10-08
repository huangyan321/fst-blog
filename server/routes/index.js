const imgRouter = require('./img');
const blogRouter = require('./blog');
const noteRouter = require('./note');
const userRouter = require('./user');

module.exports = (app) => {
	app.use('/img', imgRouter);
	app.use('/blog', blogRouter);
	app.use('/note', noteRouter);
	app.use('/user', userRouter);
}