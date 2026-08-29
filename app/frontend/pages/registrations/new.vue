<script setup lang="ts">
import AuthLayout from "@/layouts/AuthLayout.vue"
import { router } from "@inertiajs/vue3"
import { signInPath, signUpPath } from "@/routes"
import { AuthFormField, FormSubmitEvent } from "@nuxt/ui"
import { ref } from "vue"
import * as z from "zod"

const fields = ref<AuthFormField[]>([
  {
    name: "email",
    type: "email",
    label: "Email",
    required: true
  },
  {
    name: "password",
    type: "password",
    label: "Password",
    description: "8 characters minimum",
    required: true
  },
  {
    name: "password_confirmation",
    type: "password",
    label: "Password Confirmation",
    required: true
  },
  {
    name: "terms_of_service",
    type: "checkbox",
    label: "Accept conditions",
    description: "I agree to this site's Terms of Service & Privacy Policy.",
    required: true
  }
])

const schema = z.object({
  email: z.email("Not a valid email address"),
  password: z.string("Password is required").min(8, "8 characters minimum"),
  password_confirmation: z
    .string("Confirmation is required")
    .min(8, "8 characters minimum"),
  terms_of_service: z.any().optional()
})
type Schema = z.output<typeof schema>

function onSubmit(payload: FormSubmitEvent<Schema>) {
  if (payload.data) {
    router.post(signUpPath(), {
      ...payload.data,
      terms_of_service: payload.data.terms_of_service ? "1" : "0"
    })
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
        <ULink
          :to="signInPath()"
          class="text-primary font-medium"
          tabindex="-1"
        >
          Sign in
        </ULink>
      </p>
    </template>
  </AuthLayout>
</template>
