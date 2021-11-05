<template>
  <div>
    <!-- 用户列表区域 -->
    <template>
      <el-table :data="articleList" style="width: 100%" stripe border>
        <el-table-column label="序号" prop="_id" />
        <el-table-column label="标题" prop="title" />
        <el-table-column label="简介" prop="brief" />
        <el-table-column label="发布状态" :formatter="publishStatus" />
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              type="primary"
              size="mini"
              :loading="loading"
              @click="$router.push(`/article/edit/${scope.row.blog_id}`)"
            >
              修改
            </el-button>
            <el-button
              type="primary"
              :loading="loading"
              size="mini"
              @click="remove(scope.row)"
            >
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </template>
    <el-pagination
      :current-page="queryInfo.currPage"
      :page-sizes="[1, 2, 5, 10]"
      :page-size="queryInfo.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>
<script>
import { getArticleList, deleteOneArticle } from "@/api/article";
export default {
  data() {
    return {
      articleList: [],
      loading: false,
      queryInfo: {
        pageNum: 1,
        pageSize: 10,
        type: 0
      },
      total: 0
    };
  },
  created() {
    this.getList();
  },
  mounted() {},
  methods: {
    async getList() {
      const res = await getArticleList(this.queryInfo);
      this.articleList = res.data;
      this.total = res.total;
    },
    remove(row) {
      this.loading = true;
      this.$confirm(`是否确定删除文章${row.title}`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消"
      }).then(async() => {
        const res = await deleteOneArticle({ blog_id: row.blog_id });
        res.code === 200
          ? (() => {
            this.$notify.success("删除成功");
            this.getList();
          })()
          : this.$notify.error("删除失败");
      });
      this.loading = false;
    },
    publishStatus(v) {
      return v.publish === "1" ? "已发布" : "待发布";
    },
    // 监听pagesize改变的事件
    handleSizeChange(newSize) {
      this.queryInfo.pageSize = newSize;
      this.getList();
    },
    // 监听页码值改变的事件
    handleCurrentChange(newPage) {
      this.queryInfo.currPage = newPage;
      this.getList();
    }
  }
};
</script>
<style lang="scss" scoped></style>
