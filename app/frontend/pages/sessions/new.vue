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
  }
])

function onSubmit(payload: FormSubmitEvent<{
  email: string,
  password: string
}>) {
  router.post(signInPath(), payload.data)
}
</script>

<template>
  <AuthLayout
    title="登录"
    :isPasswordHintShown="true"
    icon="i-ic:baseline-log-in"
    :fields="fields"
    @submit="onSubmit"
  >
    <template #description>
      <p>
        还没有账号？
        <ULink as="button" class="text-primary font-medium" tabindex="-1">
          <Link :to="signUpPath" class="text-primary font-medium" tabindex="-1">
            去注册
          </Link>
        </ULink>
      </p>
    </template>
  </AuthLayout>
</template>

<style scoped>

</style>