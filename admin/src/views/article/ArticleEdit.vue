<template>
  <div>
    <div class="title">
      <el-row>
        <el-col :span="12">
          <h1>{{ id ? "编辑" : "创建" }}文章</h1>
        </el-col>
        <el-col :span="12" :push="5">
          <el-button
            type="primary"
            style="margin-top: 20px"
            :loading="loading"
            @click.stop.prevent="save"
          >
            保存
            <i class="el-icon-upload el-icon--right" />
          </el-button>
        </el-col>
      </el-row>
      <el-form ref="articleInfo" :model="articleInfo" :rules="rules">
        <el-form-item>
          <el-switch
            v-model="articleInfo.publish"
            active-value="1"
            inactive-value="0"
            active-text="发布"
            inactive-text="暂存"
          />
        </el-form-item>
        <el-form-item label="文章标题" prop="title">
          <el-input v-model="articleInfo.title" />
        </el-form-item>
        <el-form-item label="添加标签" prop="tags">
          <div class="addTagInput">
            <el-input
              v-model="curTagName"
              placeholder="按下回车添加标签"
              @keyup.enter.native="AddTag"
            />
          </div>
          <div class="tag">
            <el-tag
              v-for="(tag, index) in articleInfo.tags"
              :key="index"
              closable
              @close="handleTagClose(tag)"
            >
              {{ tag.name }}
            </el-tag>
          </div>
        </el-form-item>
        <el-form-item label="简介" prop="title">
          <el-input v-model="articleInfo.brief" />
        </el-form-item>
        <el-form-item prop="content">
          <Markdown v-model="articleInfo.content" />
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
    Markdown
  },
  props: {
    id: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      articleInfo: {
        tags: [],
        publish: false
      },
      rules: {
        name: [
          { required: true, message: "请输入分类名称", trigger: "blur" },
          {
            min: 1,
            message: "至少1个字符",
            trigger: "blur"
          }
        ]
      },
      loading: false,
      curTagName: ""
    };
  },
  created() {
    this.id ? this.getArticle() : "";
  },
  mounted() {},

  methods: {
    save() {
      this.$refs.articleInfo.validate(async valid => {
        if (!valid) return;
        this.loading = true;
        var res
        console.log(this.articleInfo);
        if (this.id) {
          res = await editOneArticle(this.articleInfo);
        } else {
          res = await addArticle(this.articleInfo);
        }
        res.code === 200
          ? (() => {
            this.$notify.success("请求成功");
            this.$router.replace("/article/list");
          })()
          : this.$notify.error(res.msg);
        this.loading = false;
      });
    },
    async getArticle() {
      const res = await getOneArticle({ blog_id: this.id });
      res.code === 200
        ? (() => {
          this.articleInfo = res.data;
          console.log(res);
        })()
        : this.$notify.error(res.msg);
    },
    AddTag() {
      this.articleInfo.tags.push({ name: this.curTagName });
      this.curTagName = "";
    },
    handleTagClose(v) {
      this.articleInfo.tags.splice(this.articleInfo.tags.indexOf(v), 1);
    }
  }
};
</script>
<style lang="scss" scoped>
.title {
  padding: 0 0.5rem;
}
.tag {
  width: 40%;
  margin-top: 0.1rem;
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start;
}
.el-tag {
  margin-right: 0.1rem;
}
</style>
