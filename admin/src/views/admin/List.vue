<template>
  <div>
    <!-- 用户列表区域 -->
    <template>
      <el-table :data="adminList" style="width: 100%" stripe border>
        <el-table-column label="序号" prop="_id" />
        <el-table-column label="用户名" prop="username" />
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              type="primary"
              size="mini"
              :loading="loading"
              @click="$router.push(`/admin/edit/${scope.row._id}`)"
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
import { getAdminList, deleteOneAdmin } from "@/api/admin";
export default {
  data() {
    return {
      adminList: [],
      loading: false,
      queryInfo: {
        currPage: 1,
        pageSize: 10,
      },
      total: 0,
    };
  },
  created() {
    this.getList();
  },
  mounted() {},
  methods: {
    async getList() {
      let res = await getAdminList(this.queryInfo);
      this.adminList = res.data;
      this.total = res.total;
    },
    remove(row) {
      this.loading = true;
      this.$confirm(`是否确定删除分类${row.name}`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
      }).then(async () => {
        const res = await deleteOneAdmin(row._id);
        res.success
          ? (() => {
              this.$notify.success("删除成功");
              this.getList();
            })()
          : this.$notify.error("删除失败");
      });
      this.loading = false;
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
    },
  },
};
</script>
<style lang="scss" scoped>
</style>