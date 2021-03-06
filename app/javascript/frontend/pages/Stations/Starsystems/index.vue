<template>
  <section class="container">
    <div class="row">
      <div class="col-xs-12">
        <h1 class="sr-only">{{ t('headlines.starsystems') }}</h1>
      </div>
    </div>
    <!-- <div class="row">
      <div class="col-xs-12">
        <Panel>
          <div class="starmap">
            <img
              :src="require('images/map.png')"
              alt="map"
            >
            <router-link
              v-for="starsystem in starsystems"
              :key="starsystem.slug"
              :to="{
                name: 'starsystem',
                params: {
                  slug: starsystem.slug,
                },
              }"
              :style="{
                left: `${starsystem.mapX}%`,
                top: `${starsystem.mapY}%`
              }"
              class="starsystem"
            />
          </div>
        </Panel>
      </div>
    </div> -->
    <div class="row">
      <div class="col-xs-12">
        <div class="pull-right">
          <Paginator
            v-if="starsystems.length"
            :page="currentPage"
            :total="totalPages"
          />
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12">
        <transition-group
          name="fade-list"
          class="flex-row"
          tag="div"
          appear
        >
          <div
            v-for="starsystem in starsystems"
            :key="starsystem.slug"
            class="col-xs-12 fade-list-item"
          >
            <StarsystemList
              :item="starsystem"
              :route="{
                name: 'starsystem',
                params: {
                  slug: starsystem.slug,
                },
              }"
            >

              <template v-if="starsystem.celestialObjects.length">
                <h3 class="sr-only">{{ t('headlines.celestialObjects') }}</h3>
                <transition-group
                  name="fade-list"
                  class="flex-row"
                  tag="div"
                  appear
                >
                  <div
                    v-for="celestialObject in starsystem.celestialObjects"
                    :key="celestialObject.slug"
                    class="col-xs-12 col-md-3 fade-list-item"
                  >
                    <PlanetPanel
                      :item="celestialObject"
                      :route="{
                        name: 'celestialObject',
                        params: {
                          slug: celestialObject.slug,
                        },
                      }"
                    />
                  </div>
                </transition-group>
              </template>
            </StarsystemList>
          </div>
        </transition-group>
        <EmptyBox v-if="emptyBoxVisible" />
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
            v-if="starsystems.length"
            :page="currentPage"
            :total="totalPages"
          />
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import I18n from 'frontend/mixins/I18n'
import MetaInfo from 'frontend/mixins/MetaInfo'
import Loader from 'frontend/components/Loader'
import Panel from 'frontend/components/Panel'
import StarsystemList from 'frontend/partials/Stations/List'
import PlanetPanel from 'frontend/partials/Stations/Panel'
import EmptyBox from 'frontend/partials/EmptyBox'
import Hash from 'frontend/mixins/Hash'
import Pagination from 'frontend/mixins/Pagination'

export default {
  components: {
    Loader,
    EmptyBox,
    StarsystemList,
    Panel,
    PlanetPanel,
  },
  mixins: [I18n, MetaInfo, Hash, Pagination],
  data() {
    return {
      loading: false,
      starsystems: [],
    }
  },
  computed: {
    emptyBoxVisible() {
      return !this.loading && !this.starsystems.length
    },
  },
  watch: {
    $route() {
      this.fetch()
    },
  },
  created() {
    this.fetch()
  },
  methods: {
    async fetch() {
      this.loading = true
      const response = await this.$api.get('starsystems', {
        q: this.$route.query.q,
        page: this.$route.query.page,
      })
      this.loading = false
      if (!response.error) {
        this.starsystems = response.data
        this.scrollToAnchor()
      }
      this.setPages(response.meta)
    },
  },
  metaInfo() {
    return this.getMetaInfo({
      title: this.t('title.starsystems'),
    })
  },
}
</script>

<style lang="scss" scoped>
  @import './styles/index.scss';
</style>
