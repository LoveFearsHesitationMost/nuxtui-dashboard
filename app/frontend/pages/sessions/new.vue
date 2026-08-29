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
  },
]);

const schema = z.object({
  email: z.email("Not a valid email address"),
  password: z.string("Password is required").min(8, "8 characters minimum"),
});

type Schema = z.output<typeof schema>;

function onSubmit(payload: FormSubmitEvent<Schema>) {
  if (payload.data) {
    router.post(signInPath(), payload.data);
  }
}
</script>

<template>
  <AuthLayout
    title="Sign in"
    :is-password-hint-shown="true"
    icon="i-ph-sign-in"
    :fields="fields"
    @submit="onSubmit"
    :schema="schema"
  >
    <template #description>
      <p>
        Don't have an account yet?
        <ULink :to="signUpPath()" class="text-primary font-medium" tabindex="-1"> Sign up </ULink>
      </p>
    </template>
  </AuthLayout>
</template>

<style scoped></style>
