<template>
  <div class="labels">
    <transition-group
      name="fade-list"
      appear>
      <h3
        key="all"
        class="label-title fade-list-item"
      >
        Groups:
      </h3>
      <a
        v-for="group in hangarGroups"
        :key="group.id"
        :class="{
          'active': isActive(group.slug),
        }"
        class="label label-link fade-list-item"
        @click="filter(group.slug)"
        @click.right.prevent="edit(group)"
      >
        <span class="label-inner">
          <span
            :style="{
              'background-color': group.color
            }"
            class="label-color"
          />
          {{ group.name }}: {{ group.vehiclesCount }}
        </span>
      </a>
      <a
        v-tooltip="t('actions.addGroup')"
        key="add"
        class="label label-link fade-list-item"
        @click="add"
      >
        <span class="label-inner">
          <i class="far fa-plus" />
        </span>
      </a>
    </transition-group>
    <GroupModal
      ref="groupModal"
      :group="selectedGroup"
    />
  </div>
</template>

<script>
import I18n from 'frontend/mixins/I18n'
import GroupModal from 'frontend/partials/Vehicles/GroupModal'

export default {
  components: {
    GroupModal,
  },
  mixins: [I18n],
  props: {
    hangarGroups: {
      type: Array,
      default() {
        return []
      },
    },
  },
  data() {
    return {
      selectedGroup: {},
      delay: 300,
      clicks: 0,
      timer: null,
    }
  },
  methods: {
    filter(filter) {
      const query = JSON.parse(JSON.stringify(this.$route.query.q || {}))

      if ((query.hangarGroupsIn || []).includes(filter)) {
        const index = query.hangarGroupsIn.findIndex(item => item === filter)
        if (index > -1) {
          query.hangarGroupsIn.splice(index, 1)
        }
      } else {
        if (!query.hangarGroupsIn) {
          query.hangarGroupsIn = []
        }
        query.hangarGroupsIn.push(filter)
      }

      this.$router.replace({
        name: this.$route.name,
        query: {
          q: query,
        },
      })
    },
    isActive(classification) {
      if (!this.$route.query.q) {
        return false
      }

      const classFilter = this.$route.query.q.hangarGroupsIn
      if (!classFilter) {
        return false
      }

      if (classFilter.includes(classification)) {
        return true
      }

      return false
    },
    add() {
      this.selectedGroup = {}
      this.$refs.groupModal.open()
    },
    edit(group) {
      this.selectedGroup = group
      this.$refs.groupModal.open()
    },
  },
}
</script>
