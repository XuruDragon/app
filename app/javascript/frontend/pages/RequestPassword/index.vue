<template>
  <section class="container">
    <div class="row">
      <div class="col-xs-12">
        <form @submit.prevent="requestPassword">
          <h1>
            <router-link
              to="/"
              exact>
              {{ t('app') }}
            </router-link>
          </h1>
          <div
            :class="{'has-error has-feedback': errors.has('email')}"
            class="form-group"
          >
            <transition name="fade">
              <label
                v-show="form.email"
                for="email"
              >
                {{ t('labels.email') }}
              </label>
            </transition>
            <input
              v-tooltip.right="errors.first('email')"
              v-validate="'required|email'"
              id="email"
              v-model="form.email"
              :data-vv-as="t('labels.email')"
              :placeholder="t('labels.email')"
              name="email"
              type="email"
              class="form-control"
              autofocus
            >
            <span
              v-show="errors.has('email')"
              class="form-control-feedback"
            >
              <i class="fal fa-exclamation-triangle" />
            </span>
          </div>
          <submit-button
            :loading="submitting"
            class="btn-block"
          >
            {{ t('actions.requestPassword') }}
          </submit-button>
          <div class="clearfix"/>
          <br>
          <br>
          <p class="text-center">{{ t('labels.alreadyRegistered') }}</p>
          <router-link
            class="btn btn-default btn-block"
            to="/login">
            {{ t('actions.login') }}
          </router-link>
        </form>
      </div>
    </div>
  </section>
</template>

<script>
import { success } from 'frontend/lib/Noty'
import I18n from 'frontend/mixins/I18n'
import MetaInfo from 'frontend/mixins/MetaInfo'
import SubmitButton from 'frontend/components/SubmitButton'

export default {
  components: {
    SubmitButton,
  },
  mixins: [I18n, MetaInfo],
  data() {
    return {
      submitting: false,
      form: {
        email: null,
      },
    }
  },
  methods: {
    async requestPassword() {
      const result = await this.$validator.validateAll()
      if (!result) {
        return
      }
      this.submitting = true
      await this.$api.post('password/request', this.form)
      this.submitting = false
      success(this.t('messages.requestPasswordChange.success'))
      this.$router.push('/')
    },
  },
  metaInfo() {
    return this.getMetaInfo({
      title: this.t('title.requestPassword'),
    })
  },
}
</script>

<style lang="scss" scoped>
  @import "./styles/index";
</style>
