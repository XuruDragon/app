<template>
  <button
    :type="type"
    :class="{
      'panel-btn-clear': clear,
      'panel-btn-clean': clean,
      'panel-btn-small': small,
      'panel-btn-large': large,
      'panel-btn-block': block,
      'panel-btn-inline': inline,
      'panel-btn-primary': primary,
      'panel-btn-mobile-block': mobileBlock,
      'active': active,
    }"
    class="panel-btn"
  >
    <div class="panel-btn-inner">
      <template v-if="loading">
        {{ t('actions.loading') }}
      </template>
      <template v-else>
        <slot />
      </template>
    </div>
  </button>
</template>

<script>
import I18n from 'frontend/mixins/I18n'

export default {
  mixins: [I18n],
  props: {
    loading: {
      type: Boolean,
      default: false,
    },
    type: {
      type: String,
      default: 'button',
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
    danger: {
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
    active: {
      type: Boolean,
      default: false,
    },
    primary: {
      type: Boolean,
      default: false,
    },
    inline: {
      type: Boolean,
      default: false,
    },
  },
}
</script>
