<template>
  <div>
    <div class="title">
      <el-row>
        <el-col :span="12">
          <h1>{{ id ? "编辑" : "创建" }}文章</h1>
        </el-col>
        <el-col :span="12">
          <el-button
            type="primary"
            @click.stop.prevent="save"
            style="margin-top: 20px"
            :loading="loading"
          >
            保存
          </el-button>
        </el-col>
      </el-row>
      <el-form ref="articleInfo" :model="articleInfo" :rules="rules">
        <el-form-item label="文章标题" prop="title">
          <el-input v-model="articleInfo.title"></el-input>
        </el-form-item>
        <el-form-item label="添加标签" prop="tags">
          <el-input
            placeholder="按下回车添加标签"
            v-model="curTagName"
            @keyup.enter.native="AddTag"
          ></el-input>
          <el-tag
            v-for="tag in articleInfo.tags"
            :key="tag"
            closable
            @close="handleTagClose(tag)"
          >
            {{ tag }}
          </el-tag>
        </el-form-item>
        <el-form-item prop="editText">
          <Markdown v-model="articleInfo.editText" />
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>
<script>
import Markdown from "vue-meditor";
// import { MarkdownPreview } from "vue-meditor";
import { addArticle, getOneArticle, editOneArticle } from "@/api/article";
export default {
  components: {
    Markdown,
  },
  props: {
    id: {
      type: String,
    },
  },
  watch: {
    articleInfo: {
      deep: true,
      handler(nv) {
        console.log(nv.editText);
      },
    },
  },
  created() {
    this.id ? this.getArticle() : "";
    // this.getCategoryList();
  },
  data() {
    return {
      newsList: [],
      articleInfo: {
        title: "",
        editText: "",
        tags: ["标签一", "标签二", "标签三"],
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
      curTagName: "",
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
    AddTag() {
      console.log("asdasd");
      this.articleInfo.tags.push({ name: this.curTagName, type: "" });
    },
    handleTagClose(v) {

      this.articleInfo.tags.splice(this.articleInfo.tags.indexOf(v), 1);
    },
  },
};
</script>
<style lang="scss" scoped>
.el-tag {
  margin-top: 0.5rem;
}
</style>