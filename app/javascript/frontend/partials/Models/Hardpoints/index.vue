<template>
  <div class="row flex-row">
    <div class="col-xs-12 col-sm-6 col-md-4">
      <HardpointCategory
        v-for="category in ['RSIAvionic', 'RSIModular']"
        v-if="hardpointsForCategory(category).length > 0"
        :category="category"
        :key="category"
        :hardpoints="hardpointsForCategory(category)"
      />
    </div>
    <div class="col-xs-12 col-sm-6 col-md-4">
      <HardpointCategory
        v-for="category in ['RSIPropulsion', 'RSIThruster']"
        v-if="hardpointsForCategory(category).length > 0"
        :category="category"
        :key="category"
        :hardpoints="hardpointsForCategory(category)"
      />
    </div>
    <div class="col-xs-12 col-sm-6 col-md-4">
      <HardpointCategory
        v-for="category in ['RSIWeapon']"
        v-if="hardpointsForCategory(category).length > 0"
        :category="category"
        :key="category"
        :hardpoints="hardpointsForCategory(category)"
      />
      <div class="row">
        <div class="col-xs-12">
          <h2 class="hardpoint-category-label">Legend</h2>
          <Panel>
            <div class="hardpoint-category hardpoint-legend">
              <div class="row">
                <div class="col-xs-12 col-md-6 test-hardpoint">
                  <h3>Slot taken</h3>
                  <HardpointIcon
                    key="testHardpoint"
                    :hardpoint="testHardpoint"
                    style="float: left;"
                  />
                  <div
                    style="float: left;"
                    class="hardpoint-labels"
                  >
                    <div class="hardpoint-quantity">
                      - {{ t('labels.hardpoint.quantity') }}
                    </div>
                    <div class="hardpoint-size">
                      - {{ t('labels.hardpoint.size') }}
                    </div>
                  </div>
                </div>
                <div class="col-xs-12 col-md-6 test-hardpoint-empty">
                  <h3>Slot available</h3>
                  <HardpointIcon
                    key="testHardpointEmpty"
                    :hardpoint="testHardpointEmpty"
                    style="float: left;"
                  />
                  <div
                    style="float: left;"
                    class="hardpoint-labels"
                  >
                    <div class="hardpoint-quantity">
                      - {{ t('labels.hardpoint.quantity') }}
                    </div>
                    <div class="hardpoint-size">
                      - {{ t('labels.hardpoint.size') }}
                    </div>
                  </div>
                </div>
                <div class="col-xs-12 hardpoint-legend-additions">
                  <div class="hardpoint-legend-addition">
                    <div class="hardpoint-icon">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 47.98 55.4"
                      >
                        <polygon
                          class="hardpoint-icon-part hardpoint-icon-category"
                          points="14,0 7,0 3.5,6.1 7,12.1 14,12.1 17.5,6.1"
                        />
                      </svg>
                      <div class="hardpoint-label hardpoint-category-label">V</div>
                    </div>
                    <div class="hardpoint-labels">
                      {{ t('labels.hardpoint.categoryOrRackSize') }}
                    </div>
                  </div>
                  <div class="hardpoint-legend-addition">
                    <div class="hardpoint-icon hardpoint-icon-legend-mounts ">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 47.98 55.4"
                      >
                        <circle
                          class="hardpoint-icon-part hardpoint-icon-mounts"
                          cx="37.5"
                          cy="6.38"
                          r="6.38"
                        />
                      </svg>
                      <div class="hardpoint-label hardpoint-mounts-label">2</div>
                    </div>
                    <div class="hardpoint-labels">
                      {{ t('labels.hardpoint.mounts') }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </Panel>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import I18n from 'frontend/mixins/I18n'
import Panel from 'frontend/components/Panel'
import HardpointCategory from './Category'
import HardpointIcon from './Icon'

export default {
  components: {
    HardpointCategory,
    HardpointIcon,
    Panel,
  },
  mixins: [I18n],
  props: {
    hardpoints: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      testHardpoint: {
        size: 'S',
        quantity: 6,
      },
      testHardpointEmpty: {
        size: 'S',
        quantity: 6,
        defaultEmpty: true,
      },
    }
  },
  methods: {
    hardpointsForCategory(category) {
      return this.hardpoints.filter(hardpoint => hardpoint.class === category)
    },
  },
}
</script>

<style lang="scss" scoped>
  @import "./styles/index";
</style>
