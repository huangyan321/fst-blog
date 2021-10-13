<template>
  <div class="tinymce">
    <!-- <h1>tinymce</h1> -->
    <editor id="tinymce" :init="init" v-model="tinymceHtml"></editor>
  </div>
</template>
 
<script>
import tinymce from "tinymce/tinymce";
import "tinymce/themes/silver/theme";
import Editor from "@tinymce/tinymce-vue";

import "tinymce/icons/default"; //引入编辑器图标icon，不引入则不显示对应图标
import "tinymce/plugins/image";
import "tinymce/plugins/link";
import "tinymce/plugins/code";
import "tinymce/plugins/table";
import "tinymce/plugins/lists";
// import "tinymce/plugins/contextmenu";
import "tinymce/plugins/wordcount";
// import "tinymce/plugins/colorpicker";
// import "tinymce/plugins/textcolor";
export default {
  name: "tinymce",
  props: {
    //tinyvalue首先在父组件中定义，用于向本子组件mytinymce发送数据
    //然后在这里声明，用于本子组件接收父组件数据
    tinyvalue: {
      type: String,
      default: "",
    },
    height:{
      type:Number,
      default:600
    }
  },
  data() {
    return {
      // 子组件的数据变量，默认未父组件传递过来的数据
      tinymceHtml: this.tinyvalue,
      // tinymce默认配置参数，含插件，请注意插件路径，如果错误容易保unexpect token ','之类错误
      init: {
        relative_urls: true,
        language_url: "../../tinymce/zh_CN.js",
        language: "zh_CN",
        skin_url: "../../tinymce/skins/ui/oxide-dark",
        height: this.height,
        plugins:
          "link lists image code table   wordcount ",
        toolbar:
          "bold italic underline strikethrough | fontsizeselect | forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist | outdent indent blockquote | undo redo | link unlink image code | removeformat",
        branding: false,
        // 增加下面的images_upload_handler对象，能够支持上传图片到服务器
        images_upload_handler: (blobInfo, success, failure) => {
          if (blobInfo.blob().size / 1024 / 1024 > 5) {
            failure("上传失败，图片大小请控制在 5M 以内");
          } else {
            let params = new FormData();
            params.append("file", blobInfo.blob());
            let config = {
              headers: {
                "Content-Type": "multipart/form-data",
              },
            };
            //aixo的声明在全局main.js中，这里不粘贴了
            this.$http
              .post(`http://localhost/admin/api/upload`, params, config)
              .then((res) => {
                console.log(res.data.up);
                // success(res.data.up);
                if (res.data.up != "") {
                  success("http://localhost/static/" + res.data.up); //上传成功，在成功函数里填入图片路径
                } else {
                  failure("上传失败");
                }
              })
              .catch(() => {
                failure("上传出错，服务器开小差了呢");
              });
          }
        },
      },
    };
  },
  mounted() {
    //初始化加载配置项
    tinymce.init({});
  },
  methods: {},
  //声明最原始的tinymce组件
  components: { Editor },
  watch: {
    //监听内容变化，用于辅助父子组件之间的通讯
    tinyvalue(newValue) {
      //tinyvalue是父组件代理人，父组件值一旦变化，推送给子组件
      this.tinymceHtml = newValue;
    },
    tinymceHtml(newValue) {
      //tinymceHtml是子组件的值，如果改变，直接反馈给父组件
      //   tinymceinput是父组件中的用于接收子组件的事件（名称写死，用于后面调用）
      this.$emit("tinymceinput", newValue);
    },
  },
};
</script>