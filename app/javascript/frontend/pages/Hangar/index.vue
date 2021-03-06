<template>
  <section class="container hangar">
    <div class="row">
      <div class="col-xs-12 col-md-12">
        <div class="row">
          <div class="col-xs-12">
            <h1 class="sr-only">{{ t('headlines.hangar') }}</h1>
          </div>
        </div>
        <div class="hangar-header">
          <div>
            <ModelClassLabels
              v-if="vehiclesCount"
              :label="t('labels.hangar')"
              :count-data="vehiclesCount"
              filter-key="classificationIn"
            />
            <GroupLabels
              v-if="!mobile && (vehicles.length || fleetchartVehicles.length
              || (!vehicles.length && !fleetchartVehicles.length && isFilterSelected))"
              :hangar-groups="hangarGroups"
              :label="t('labels.groups')"
            />
          </div>
          <div class="page-actions">
            <ExternalLink
              v-tooltip="t('labels.poweredByStarship42')"
              :url="starship42Url"
            >
              {{ t('labels.3dView') }}
            </ExternalLink>
            <ExternalLink :url="publicUrl">
              {{ t('labels.publicUrl') }}
            </ExternalLink>
          </div>
        </div>
        <div
          v-if="vehicles.length > 0 && vehiclesCount && vehiclesCount.metrics"
          class="row"
        >
          <div class="col-xs-12 hangar-metrics metrics-block">
            <div class="metrics-item">
              <div class="metrics-label">{{ t('labels.hangarMetrics.totalMoney') }}:</div>
              <div class="metrics-value">{{ toDollar(vehiclesCount.metrics.totalMoney) }}</div>
            </div>
            <div class="metrics-item">
              <div class="metrics-label">{{ t('labels.hangarMetrics.totalMinCrew') }}:</div>
              <div class="metrics-value">
                {{ toNumber(vehiclesCount.metrics.totalMinCrew, 'people') }}
              </div>
            </div>
            <div class="metrics-item">
              <div class="metrics-label">{{ t('labels.hangarMetrics.totalMaxCrew') }}:</div>
              <div class="metrics-value">
                {{ toNumber(vehiclesCount.metrics.totalMaxCrew, 'people') }}
              </div>
            </div>
            <div class="metrics-item">
              <div class="metrics-label">{{ t('labels.hangarMetrics.totalCargo') }}:</div>
              <div class="metrics-value">
                {{ toNumber(vehiclesCount.metrics.totalCargo, 'cargo') }}
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12 col-md-6">
            <div class="page-actions page-actions-left">
              <Btn
                v-tooltip="t('actions.saveScreenshot')"
                v-show="hangarFleetchartVisible && fleetchartVehicles.length"
                :disabled="downloading"
                :aria-label="t('actions.saveScreenshot')"
                small
                @click.native="download"
              >
                {{ t('actions.saveScreenshot') }}
              </Btn>
              <Btn
                v-tooltip="toggleDetailsTooltip"
                v-show="!hangarFleetchartVisible && vehicles.length"
                :active="hangarDetailsVisible"
                :aria-label="toggleDetailsTooltip"
                small
                @click.native="toggleDetails"
              >
                <i class="fas fa-list" />
              </Btn>
              <Btn
                v-tooltip="toggleFiltersTooltip"
                :active="hangarFilterVisible"
                :aria-label="toggleFiltersTooltip"
                small
                @click.native="toggleFilter"
              >
                <i
                  v-if="isFilterSelected"
                  class="fas fa-filter"
                />
                <i
                  v-else
                  class="fal fa-filter"
                />
              </Btn>
              <Btn
                small
                @click.native="toggleFleetchart"
              >
                <template v-if="hangarFleetchartVisible">
                  {{ t('actions.hideFleetchart') }}
                </template>
                <template v-else>{{ t('actions.showFleetchart') }}</template>
              </Btn>
            </div>
          </div>
          <div class="col-xs-12 col-md-6">
            <div class="pull-right">
              <Paginator
                v-if="!hangarFleetchartVisible && vehicles.length"
                :page="currentPage"
                :total="totalPages"
              />
            </div>
          </div>
        </div>
        <div class="row">
          <transition
            name="slide"
            appear
            @before-enter="toggleFullscreen"
            @after-leave="toggleFullscreen"
          >
            <div
              v-show="hangarFilterVisible"
              class="col-md-3 col-xlg-2"
            >
              <VehiclesFilterForm :hangar-groups-options="hangarGroups" />
            </div>
          </transition>
          <div
            :class="{
              'col-md-9 col-xlg-10': !fullscreen,
            }"
            class="col-xs-12 col-animated"
          >
            <div
              v-if="hangarFleetchartVisible && fleetchartVehicles.length"
              class="row"
            >
              <div class="col-xs-12 col-md-4 col-md-offset-4 fleetchart-slider">
                <vue-slider
                  ref="scaleSlider"
                  v-model="scale"
                  :min="0.5"
                  :max="4"
                  :interval="0.1"
                  formatter="{value}x"
                  tooltip="hover"
                />
              </div>
            </div>
            <div
              v-if="hangarFleetchartVisible"
              class="row"
            >
              <div class="col-xs-12 fleetchart-wrapper">
                <transition-group
                  id="fleetchart"
                  name="fade-list"
                  class="flex-row fleetchart"
                  tag="div"
                  appear
                >
                  <FleetchartItem
                    v-for="vehicle in fleetchartVehicles"
                    :key="vehicle.id"
                    :model="vehicle.model"
                    :scale="scale"
                  />
                </transition-group>
              </div>
            </div>
            <transition-group
              v-else
              name="fade-list"
              class="flex-row"
              tag="div"
              appear
            >
              <div
                v-for="vehicle in vehicles"
                :key="vehicle.id"
                :class="{
                  'col-lg-4': fullscreen,
                  'col-xlg-4': !fullscreen,
                }"
                class="col-xs-12 col-sm-6 col-xxlg-2-4 fade-list-item"
              >
                <ModelPanel
                  :model="vehicle.model"
                  :vehicle="vehicle"
                  :details="hangarDetailsVisible"
                  :hangar-groups="hangarGroups"
                />
              </div>
            </transition-group>
            <EmptyBox v-if="emptyBoxVisible" />
            <HangarGuideBox v-if="guideVisible" />
            <Loader
              :loading="loading"
              fixed
            />
          </div>
        </div>
        <div class="row">
          <div class="col-xs-12">
            <div class="pull-right">
              <Paginator
                v-if="!hangarFleetchartVisible && vehicles.length"
                :page="currentPage"
                :total="totalPages"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import qs from 'qs'
import I18n from 'frontend/mixins/I18n'
import MetaInfo from 'frontend/mixins/MetaInfo'
import Pagination from 'frontend/mixins/Pagination'
import Hash from 'frontend/mixins/Hash'
import Loader from 'frontend/components/Loader'
import Btn from 'frontend/components/Btn'
import ExternalLink from 'frontend/components/ExternalLink'
import ModelPanel from 'frontend/partials/Models/Panel'
import FleetchartItem from 'frontend/partials/Models/FleetchartItem'
import VehiclesFilterForm from 'frontend/partials/Vehicles/FilterForm'
import ModelClassLabels from 'frontend/partials/Models/ClassLabels'
import GroupLabels from 'frontend/partials/Vehicles/GroupLabels'
import Filters from 'frontend/mixins/Filters'
import { mapGetters } from 'vuex'
import EmptyBox from 'frontend/partials/EmptyBox'
import HangarGuideBox from 'frontend/partials/HangarGuideBox'
import vueSlider from 'vue-slider-component'
import html2canvas from 'html2canvas'
import download from 'downloadjs'

export default {
  components: {
    FleetchartItem,
    EmptyBox,
    HangarGuideBox,
    ModelPanel,
    Loader,
    Btn,
    ExternalLink,
    VehiclesFilterForm,
    ModelClassLabels,
    GroupLabels,
    vueSlider,
  },
  mixins: [I18n, MetaInfo, Filters, Pagination, Hash],
  data() {
    return {
      loading: false,
      downloading: false,
      vehicles: [],
      filters: [],
      fleetchartVehicles: [],
      hangarGroups: [],
      fullscreen: false,
      vehiclesCount: null,
      tooltipTrigger: 'click',
      scale: this.$store.state.hangarFleetchartScale,
    }
  },
  computed: {
    ...mapGetters([
      'currentUser',
      'hangar',
      'hangarDetailsVisible',
      'hangarFleetchartVisible',
      'hangarFilterVisible',
      'mobile',
    ]),
    emptyBoxVisible() {
      return !this.loading && ((!this.vehicles.length && !this.hangarFleetchartVisible)
      || (!this.fleetchartVehicles.length && this.hangarFleetchartVisible))
      && (this.isFilterSelected || this.$route.query.page)
    },
    guideVisible() {
      return !this.loading && !this.vehicles.length && !this.isFilterSelected
        && !this.fleetchartVehicles.length
    },
    toggleDetailsTooltip() {
      if (this.hangarDetailsVisible) {
        return this.t('actions.hideDetails')
      }
      return this.t('actions.showDetails')
    },
    toggleFiltersTooltip() {
      if (this.hangarFilterVisible) {
        return this.t('actions.hideFilter')
      }
      return this.t('actions.showFilter')
    },
    publicUrl() {
      if (!this.currentUser) {
        return ''
      }
      return `/hangar/${this.currentUser.username}`
    },
    starship42Url() {
      const shipList = this.fleetchartVehicles.map(vehicle => vehicle.model.rsiName)
      const data = { source: 'FleetYards', type: 'matrix', s: shipList }
      const startship42Params = qs.stringify(data)
      return `http://www.starship42.com/fleetview/?${startship42Params}`
    },
  },
  watch: {
    $route() {
      this.fetch()
    },
    scale(value) {
      this.$store.commit('setHangarFleetchartScale', value)
    },
    currentUser() {
      if (this.currentUser) {
        this.setupUpdates()
      }
    },
  },
  created() {
    this.fetch()
    this.$comlink.$on('vehicleSave', this.fetch)
    this.$comlink.$on('vehicleDelete', this.fetch)
    this.$comlink.$on('hangarGroupDelete', this.fetch)
    this.$comlink.$on('hangarGroupSave', this.fetchGroups)
    if (this.mobile) {
      this.$store.commit('setHangarFilterVisible', false)
    }
    this.toggleFullscreen()
  },
  methods: {
    toggleFullscreen() {
      this.fullscreen = !this.hangarFilterVisible
    },
    download() {
      this.downloading = true
      html2canvas(document.querySelector('#fleetchart'), {
        backgroundColor: null,
        useCORS: true,
      }).then((canvas) => {
        this.downloading = false
        download(canvas.toDataURL(), 'fleetchart.png')
      })
    },
    toggleFilter() {
      this.$store.dispatch('toggleHangarFilter')
    },
    toggleDetails() {
      this.$store.dispatch('toggleHangarDetails')
    },
    toggleFleetchart() {
      this.$store.dispatch('toggleHangarFleetchart')
    },
    fetch() {
      this.fetchFleetchart()
      this.fetchVehicles()
      this.fetchGroups()
      this.fetchCount()
    },
    async fetchVehicles() {
      this.loading = true
      const response = await this.$api.get('vehicles', {
        q: this.$route.query.q,
        page: this.$route.query.page,
      })
      this.loading = false
      if (!response.error) {
        this.vehicles = response.data
        this.scrollToAnchor()
      }
      this.setPages(response.meta)
    },
    async fetchCount() {
      const response = await this.$api.get('vehicles/count', {
        q: this.$route.query.q,
      })
      if (!response.error) {
        this.vehiclesCount = response.data
      }
    },
    async fetchFleetchart() {
      this.loading = true
      const response = await this.$api.get('vehicles/fleetchart', {
        q: this.$route.query.q,
      })
      this.loading = false
      this.$nextTick(() => {
        if (this.$refs.scaleSlider) {
          setTimeout(this.$refs.scaleSlider.refresh, 500)
        }
      })
      if (!response.error) {
        this.fleetchartVehicles = response.data
      }
    },
    setupUpdates() {
      this.vehiclesChannel = this.$cable.subscriptions.create({
        channel: 'HangarChannel',
        username: this.currentUser.username,
      }, {
        received: this.fetch,
      })
    },
    async fetchGroups() {
      const response = await this.$api.get('hangar-groups')
      if (!response.error) {
        this.hangarGroups = response.data
      }
    },
  },
  metaInfo() {
    return this.getMetaInfo({
      title: this.t('title.hangar'),
    })
  },
}
</script>

<style lang="scss" scoped>
  @import "./styles/index";
</style>
