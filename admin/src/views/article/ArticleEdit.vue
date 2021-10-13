<template>
  <div>
    <div class="title">
      <h1>{{ id ? "编辑" : "创建" }}文章</h1>
    </div>
    <el-form ref="articleInfo" :model="articleInfo" :rules="rules">
      <el-form-item label="上级分类" prop="parent">
        <el-select
          v-model="articleInfo.categories"
          multiple
          placeholder="请选择文章分类"
        >
          <el-option
            v-for="item in newsList"
            :key="item._id"
            :label="item.name"
            :value="item._id"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="标题" prop="title">
        <el-input v-model="articleInfo.title"> </el-input>
      </el-form-item>
      <el-form-item label="内容" prop="editText">
        <tinymce
          style="width:50%; display: block"
          :tinyvalue="articleInfo.editText"
          :height="400"
          @tinymceinput="tinymceinput"
        />
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
import {
  getArticleList,
  addArticle,
  getOneArticle,
  editOneArticle,
} from "@/api/article";
import Tinymce from "@/components/Tinymce";
export default {
  components: {
    Tinymce,
  },
  props: {
    id: {
      type: String,
    },
  },
  created() {
    this.id ? this.getArticle() : "";
    this.getCategoryList();
  },
  data() {
    return {
      newsList: [],
      parentsList: [],
      articleInfo: {
        name: "",
        categories: [],
        editText: "",
      },
      rules: {
        name: [
          { required: true, message: "请输入分类名称", trigger: "blur" },
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
      this.$refs.articleInfo.validate(async (valid) => {
        if (!valid) return;
        this.loading = true;
        if (this.id) {
          var res = await editOneArticle(this.id, this.articleInfo);
        } else {
          var res = await addArticle(this.articleInfo);
        }
        res
          ? (() => {
              this.$notify.success("请求成功");
              this.$router.replace("/article/list");
            })()
          : this.$notify.err("请求失败");
        this.loading = false;
      });
    },
    tinymceinput(txt) {
      this.articleInfo.editText = txt;
    },
    async getArticle() {
      let res = await getOneArticle(this.id);
      this.articleInfo = res;
    },
    async getCategoryList() {
      const { data } = await getCategoryList();
      this.newsList = data.filter((item) => {
        return item.parent ? item.parent.name === "news" : "";
      });
    },
  },
};
</script>
<style lang="scss" scoped>
</style>