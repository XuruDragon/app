<template>
  <a
    :class="{
      'panel-btn-clear': clear,
      'panel-btn-clean': clean,
      'panel-btn-small': small,
      'panel-btn-large': large,
      'panel-btn-block': block,
      'panel-btn-mobile-block': mobileBlock,
    }"
    :href="url"
    target="_blank"
    rel="noopener"
    class="panel-btn"
  >
    <div class="panel-btn-inner">
      <slot />
    </div>
  </a>
</template>

<script>
export default {
  props: {
    url: {
      type: String,
      required: true,
    },
    clear: {
      type: Boolean,
      default: false,
    },
    clean: {
      type: Boolean,
      default: false,
    },
    large: {
      type: Boolean,
      default: false,
    },
    small: {
      type: Boolean,
      default: false,
    },
    block: {
      type: Boolean,
      default: false,
    },
    mobileBlock: {
      type: Boolean,
      default: false,
    },
  },
}
</script>
