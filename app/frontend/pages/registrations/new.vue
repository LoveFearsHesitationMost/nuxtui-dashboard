<script setup lang="ts">
import AuthLayout from "@/layouts/AuthLayout.vue";
import { router } from "@inertiajs/vue3";
import { signInPath, signUpPath } from "@/routes";
import { AuthFormField, FormSubmitEvent } from "@nuxt/ui";
import { ref } from "vue";
import * as z from "zod";

const fields = ref<AuthFormField[]>([
  {
    name: "email",
    type: "email",
    label: "Email",
    required: true,
  },
  {
    name: "password",
    type: "password",
    label: "Password",
    required: true,
    eagerValidation: true,
  },
  {
    name: "password_confirmation",
    type: "password",
    label: "Password Confirmation",
    required: true,
    eagerValidation: true,
  },
]);

const schema = z.object({
  email: z.email("Not a valid email address"),
  password: z.string("Password is required").min(8, "8 characters minimum"),
  password_confirmation: z.string("Confirmation is required").min(8, "8 characters minimum"),
});
type Schema = z.output<typeof schema>;

function onSubmit(payload: FormSubmitEvent<Schema>) {
  if (payload.data) {
    router.post(signUpPath(), payload.data);
  }
}
</script>

<template>
  <AuthLayout
    title="Sign up"
    :is-password-hint-shown="false"
    icon="i-ph-hand-waving"
    :fields="fields"
    @submit="onSubmit"
    :schema="schema"
  >
    <template #description>
      <p>
        Already a member?
        <ULink :to="signInPath()" class="text-primary font-medium" tabindex="-1"> Sign in </ULink>
      </p>
    </template>
  </AuthLayout>
</template>

<style scoped></style>
