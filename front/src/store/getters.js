const getters = {
  sideBoxOpen: state => state.side.sideBoxOpen,
  tags: state => state.side.tags,
  selectTags: state => state.side.selectTags,
  blogs: state => state.list.blogs,
  pageNum: state => state.list.pageNum,
  pageSize: state => state.list.pageSize,
  currentlyCompiledBlog: state => state.list.currentlyCompiledBlog,
  currentBlogs: state => state.list.currentBlogs
}
export default getters
