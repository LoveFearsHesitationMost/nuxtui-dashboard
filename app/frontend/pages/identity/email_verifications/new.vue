<script setup lang="ts">
import AuthLayout from "@/layouts/AuthLayout.vue"
import { router } from "@inertiajs/vue3"
import { identityEmailVerificationPath, signInPath, signUpPath } from "@/routes"
import { AuthFormField, FormSubmitEvent } from "@nuxt/ui"
import { ref } from "vue"
import * as z from "zod"

const fields = ref<AuthFormField[]>([
  {
    name: "email",
    type: "email",
    label: "Email",
    description: "We'll send a verification link to this address.",
    required: true
  }
])

const schema = z.object({
  email: z.email("Not a valid email address")
})

type Schema = z.output<typeof schema>

function onSubmit(payload: FormSubmitEvent<Schema>) {
  if (payload.data) {
    router.post(identityEmailVerificationPath(), payload.data)
  }
}
</script>

<template>
  <AuthLayout
    title="Resend Verification"
    icon="i-ph-envelope"
    :fields="fields"
    :schema="schema"
    :is-email-hint-shown="false"
    @submit="onSubmit"
  >
    <template #description>
      <p>Enter your email to receive a new verification link</p>
      <p>
        <ULink
          :to="signInPath()"
          class="text-primary font-medium"
          tabindex="-1"
        >
          Back to Sign in
        </ULink>
        |
        <ULink
          :to="signUpPath()"
          class="text-primary font-medium"
          tabindex="-1"
        >
          Create account
        </ULink>
      </p>
    </template>
  </AuthLayout>
</template>

<style scoped></style>
