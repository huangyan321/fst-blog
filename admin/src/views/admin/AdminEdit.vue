<template>
  <div>
    <div class="title">
      <h1>{{ id ? "编辑" : "创建" }}管理员</h1>
    </div>
    <el-form ref="adminInfo" :model="adminInfo" :rules="rules">
      <el-form-item label="用户名" prop="username">
        <el-input v-model="adminInfo.username" style="width: 50%"> </el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="adminInfo.password" style="width: 50%"> </el-input>
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          @click.stop.prevent="save"
          style="margin-top: 20px"
          :loading="loading"
        >
          保存
        </el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
import { addAdmin, getOneAdmin, editOneAdmin } from "@/api/admin";
export default {
  props: {
    id: {
      type: String,
    },
  },
  created() {
    this.id ? this.getAdmin() : "";
  },
  data() {
    return {
      newsList: [],
      parentsList: [],
      adminInfo: {
        username: '',
        password: ''
      },
      rules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          {
            min: 1,
            message: "至少1个字符",
            trigger: "blur",
          },
        ],
      },
      loading: false,
    };
  },
  mounted() {},

  methods: {
    save() {
      this.$refs.adminInfo.validate(async (valid) => {
        if (!valid) return;
        this.loading = true;
        if (this.id) {
          var res = await editOneAdmin(this.id, this.adminInfo);
        } else {
          var res = await addAdmin(this.adminInfo);
        }
        res
          ? (() => {
              this.$notify.success("请求成功");
              this.$router.replace("/admin/list");
            })()
          : this.$notify.err("请求失败");
        this.loading = false;
      });
    },
    async getAdmin() {
      let res = await getOneAdmin(this.id);
      this.adminInfo = Object.assign({}, this.adminInfo, res);
    },
  },
};
</script>
<style lang="scss" scoped>
</style>