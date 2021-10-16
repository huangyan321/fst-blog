<template>
  <div>
    <div class="title">
      <h1>{{ id ? "编辑" : "创建" }}管理员</h1>
    </div>
    <el-form ref="adminInfo" :model="adminInfo" :rules="rules">
      <el-form-item label="用户名" prop="name">
        <el-input v-model="adminInfo.name" style="width: 50%"> </el-input>
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
        name: "",
        password: "",
      },
      rules: {
        name: [
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
          console.log(this.adminInfo);
          var res = await editOneAdmin(this.adminInfo);
        } else {
          var res = await addAdmin(this.adminInfo);
        }
        res.code == 200
          ? (() => {
              this.$notify.success("请求成功");
              this.$router.replace("/admin/list");
            })()
          : this.$notify.error(res.msg);
        this.loading = false;
      });
    },
    async getAdmin() {
      let res = await getOneAdmin({ user_id: this.id });
      res.code == 200
        ? (() => {
            this.adminInfo = Object.assign({}, this.adminInfo, res.data);
            console.log(res);
          })()
        : this.$notify.error(res.msg);
    },
  },
};
</script>
<style lang="scss" scoped>
</style>