<script setup lang="ts">

import AuthLayout from "@/layouts/AuthLayout.vue";
import {Link, router} from "@inertiajs/vue3";
import {signInPath, signUpPath} from "@/routes";
import {AuthFormField, FormSubmitEvent} from "@nuxt/ui";
import {ref} from "vue";
import * as z from 'zod';

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
]);

const schema = z.object({
  email: z.email("请输入正确的邮箱格式"),
  password: z.string("请输入密码").min(12, "密码不能少于 12 个字符")
});

type Schema = z.output<typeof schema>;

function onSubmit(payload: FormSubmitEvent<Schema>) {
  if (payload.data) {
    router.post(signInPath(), payload.data)
  }
}
</script>

<template>
  <AuthLayout
    title="登录"
    :isPasswordHintShown="true"
    icon="i-ic:baseline-log-in"
    :fields="fields"
    @submit="onSubmit"
    :schema="schema"
  >
    <template #description>
      <p>
        还没有账号？
        <ULink as="button" class="text-primary font-medium" tabindex="-1">
          <Link :href="signUpPath()" class="text-primary font-medium" tabindex="-1">
            去注册
          </Link>
        </ULink>
      </p>
    </template>
  </AuthLayout>
</template>

<style scoped>

</style>