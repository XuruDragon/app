<template>
  <div class="row">
    <div class="col-xs-12 col-md-3">
      <div class="metrics-title">
        {{ t('labels.metrics.base') }}
      </div>
    </div>
    <div class="col-xs-12 col-md-9 metrics-block">
      <div class="row">
        <div class="col-xs-6">
          <div class="metrics-label">{{ t('starsystem.type') }}:</div>
          <div
            v-tooltip="starsystem.type"
            class="metrics-value"
          >
            {{ starsystem.type }}
          </div>
        </div>
        <div class="col-xs-6">
          <div class="metrics-label">{{ t('starsystem.size') }}:</div>
          <div
            v-tooltip="starsystem.size"
            class="metrics-value"
          >
            {{ toAu(starsystem.size) }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import I18n from 'frontend/mixins/I18n'

export default {
  mixins: [I18n],
  props: {
    starsystem: {
      type: Object,
      required: true,
    },
  },
}
</script>
