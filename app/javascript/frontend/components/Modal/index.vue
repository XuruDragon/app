<template>
  <div
    ref="modal"
    :class="{
      in: isOpen,
      show: isShow
    }"
    class="modal fade"
    @click.self="close"
  >
    <div class="modal-dialog">
      <Panel :outer-spacing="false">
        <div class="modal-content">
          <div class="modal-header">
            <a
              class="close"
              aria-label="Close"
              @click="close"
            >
              <i class="fal fa-times" />
            </a>
            <h2 class="modal-title">{{ title }}</h2>
          </div>
          <div class="modal-body">
            <slot />
          </div>
        </div>
      </Panel>
      <div
        v-if="$slots['footer']"
        class="modal-footer"
      >
        <slot name="footer"/>
        <div class="clearfix" />
      </div>
    </div>
  </div>
</template>

<script>
import I18n from 'frontend/mixins/I18n'
import Panel from 'frontend/components/Panel'

export default {
  components: {
    Panel,
  },
  mixins: [I18n],
  props: {
    visible: {
      type: Boolean,
      default: false,
    },
    title: {
      type: String,
      required: true,
    },
    onClose: {
      type: Function,
      default: null,
    },
  },
  data() {
    return {
      isShow: this.visible,
      isOpen: this.visible,
    }
  },
  methods: {
    open() {
      this.isShow = true
      this.$nextTick(function onOpen() {
        this.isOpen = true
        this.$refs.modal.focus()
      })
    },
    close() {
      this.isOpen = false
      this.$nextTick(function onClose() {
        setTimeout(() => {
          this.isShow = false
          if (this.onClose) {
            this.onClose()
          }
        }, 500)
      })
    },
  },
}
</script>

<style lang="scss" scoped>
  @import "./styles/index";
</style>
