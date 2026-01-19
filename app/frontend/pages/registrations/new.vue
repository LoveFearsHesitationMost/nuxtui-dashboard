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
  },
  {
    name: 'password_confirmation',
    type: 'password',
    label: '确认密码',
    required: true
  }
]);

const hasUpperCase = /[A-Z]/;
const hasLowerCase = /[a-z]/;
const hasNumber = /[0-9]/;
const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/;

const schema = z.object({
  email: z.email("邮箱格式错误"),
  password: z.string("密码不能为空")
      .min(12, "密码不能少于 12 个字符"),
  password_confirmation: z.string("确认密码不能为空")
      .min(12, "确认密码不能少于 12 个字符"),
}).refine(
    (data) => data.password === data.password_confirmation, {
      message: "两次输入的密码不一致",
      path: ["password_confirmation"],
    })
    .refine((data) => {
      const {password} = data;
      // 检查密码满足多少种条件
      let conditionsMet = 0;
      if (hasUpperCase.test(password)) conditionsMet++;
      if (hasLowerCase.test(password)) conditionsMet++;
      if (hasNumber.test(password)) conditionsMet++;
      if (hasSpecialChar.test(password)) conditionsMet++;
      // 需要满足至少两种条件
      return conditionsMet >= 2;
    }, {
      message: "密码需要包含大写字母、小写字母、数字、特殊符号中的至少两种",
      path: ["password"],
    });
type Schema = z.output<typeof schema>;

function onSubmit(payload: FormSubmitEvent<Schema>) {
  if(payload.data) {
    router.post(signUpPath(), payload.data)
  }
}
</script>

<template>
  <AuthLayout
      title="注册"
      :isPasswordHintShown="false"
      icon="i-material-symbols:account-box"
      :fields="fields"
      @submit="onSubmit"
      :schema="schema"
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