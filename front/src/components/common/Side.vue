<template>
  <div class="sideBox">
    <div
      class="sideBox__mask"
      :class="{ 'sideBox__mask--show': sideBoxOpen }"
      @click="closeSideBox"
    ></div>
    <div class="sideBox__main" :class="{ 'sideBox__main--open': sideBoxOpen }">
      这里是侧边栏
    </div>
  </div>
</template>
<script>
import { mapGetters, mapMutations } from "vuex";
export default {
  data() {
    return {};
  },
  watch: {
    sideBoxOpen: {
      handler(v) {
        console.log(v);
      },
    },
  },
  computed: {
    ...mapGetters(["sideBoxOpen"]),
  },
  mounted() {},
  methods: {
    ...mapMutations("side", {
      closeSideBox: "CLOSE_SIDE_BOX",
    }),
  },
};
</script>
<style lang="stylus" scoped>
.sideBox {
  width: 250px;
  float: left;
  text-align: center;

  &__img {
    width: 150px;
    border-radius: 50%;
    box-shadow: 0 0 2px black;
    margin-top: 10px;
    cursor: pointer;
  }

  @media screen and (max-width: 850px) {
    .sideBox {
      position: absolute;
      top: 0;
      left: 0;

      &__main {
        position: fixed;
        left: 0px;
        top: 60px;
        bottom: 0;
        width: 250px;
        transform: translateX(-250px);
        transition: transform 0.3s;
        background-color: white;

        &--open {
          box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
          transform: translateX(0px);
          transition: transform 0.3s;
        }
      }

      &__mask {
        position: fixed;
        top: 60px;
        left: 250px;
        right: 0;
        bottom: 0;
        display: block;
        z-index: 1;
        display: none;
      }

      &__mask--show {
        display: block;
      }

      &__tagItem:hover {
        color: $grey;
      }

      &_tagItem--active:hover {
        color: $blue;
      }
    }
  }
}
</style>