<script setup lang="ts">

import AuthLayout from "@/layouts/AuthLayout.vue";
import {Link, router} from "@inertiajs/vue3";
import {signInPath, signUpPath} from "@/routes";
import {AuthFormField, FormSubmitEvent} from "@nuxt/ui";
import {ref} from "vue";

const fields = ref<AuthFormField[]>([
  {
    name: 'email',
    type: 'email',
    label: '邮箱',
    required: true
  },
  {
    name: 'password',
    type: 'password',
    label: '密码',
    required: true
  },
  {
    name: 'password_confirmation',
    type: 'password',
    label: '确认密码',
    required: true
  }
])

function onSubmit(payload: FormSubmitEvent<{
  email: string,
  password: string,
  password_confirmation: string
}>) {
  router.post(signUpPath(), payload.data)
}
</script>

<template>
  <AuthLayout
      title="注册"
      :isPasswordHintShown="false"
      icon="i-material-symbols:account-box"
      :fields="fields"
      @submit="onSubmit"
  >
    <template #description>
      <p>
        已经有账号吗？
        <ULink as="button" class="text-primary font-medium" tabindex="-1">
          <Link :href="signInPath()" class="text-primary font-medium" tabindex="-1">
            去登录
          </Link>
        </ULink>
      </p>
    </template>
  </AuthLayout>
</template>

<style scoped>

</style>