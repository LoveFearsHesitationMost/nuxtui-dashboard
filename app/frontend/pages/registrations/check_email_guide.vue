<script setup lang="ts">
import AuthLayout from "@/layouts/AuthLayout.vue";
import { AuthFormField } from "@nuxt/ui";
import { ref } from "vue";

defineProps<{
  resend_email: string;
}>();

const fields = ref<AuthFormField[]>([]);
</script>

<template>
  <AuthLayout
    title="Almost Done"
    :is-password-hint-shown="false"
    icon="i-ph-hand-waving"
    :fields="fields"
  >
    <template #description>
      <p>Confirm your email and continue</p>

      <div class="text-default mt-4">
        We've sent a magic link to <strong>{{ resend_email }}</strong
        >. Check your inbox and follow the guidance — don't forget spams!
      </div>
      <ProseUl class="text-sm">
        <ProseLi class="leading-5">
          Don't receive the link? Check your address and resend the mail in 60 seconds. If the issue
          persists, contact us
        </ProseLi>
        <ProseLi class="leading-5">
          After verification, you may Sign in and join our community
        </ProseLi>
        <ProseLi class="leading-5">
          Check out Profile Settings for personalizing your look
        </ProseLi>
        <ProseLi class="leading-5"> Have a glance at Homepage for popular topics & pages </ProseLi>
      </ProseUl>
    </template>
  </AuthLayout>
</template>

<style scoped></style>
