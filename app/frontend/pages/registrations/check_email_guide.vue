<script setup lang="ts">
import AuthLayout from "@/layouts/AuthLayout.vue"
import { AuthFormField } from "@nuxt/ui"
import { onMounted, onUnmounted, ref } from "vue"
import { identityEmailVerificationPath, rootPath, signInPath } from "@/routes"
import { router } from "@inertiajs/vue3"

const { resend_email } = defineProps<{
  resend_email: string
}>()

const fields = ref<AuthFormField[]>([])
const countdown = ref(60)
let timer: ReturnType<typeof setInterval> | null = null

onMounted(() => {
  timer = setInterval(() => {
    if (countdown.value > 0) {
      countdown.value--
    } else {
      if (timer) clearInterval(timer)
    }
  }, 1000)
})

onUnmounted(() => {
  if (timer) clearInterval(timer)
})

const onResendClick = () => {
  if (countdown.value > 0) return
  router.post(identityEmailVerificationPath(), {
    email: resend_email
  })
}
</script>

<template>
  <AuthLayout
    title="Almost Done"
    :is-password-hint-shown="false"
    icon="i-ph-envelope"
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
          Don't receive the link? Check your address and
          <span class="text-default">
            <span v-if="countdown > 0" class="text-muted">
              resend email in {{ countdown }} seconds.
            </span>
            <ULink
              v-else
              class="text-primary font-medium"
              @click="onResendClick"
            >
              resend email.
            </ULink>
          </span>
          If the issue persists,
          <ULink class="text-primary font-medium">contact us</ULink>
        </ProseLi>
        <ProseLi class="leading-5">
          After verification, you may
          <ULink :to="signInPath()" class="text-primary font-medium"
            >Sign in</ULink
          >
          and join our community
        </ProseLi>
        <ProseLi class="leading-5">
          Check out
          <ULink class="text-primary font-medium">Profile Settings</ULink> for
          personalizing your look
        </ProseLi>
        <ProseLi class="leading-5">
          Have a glance at our
          <ULink :to="rootPath()" class="text-primary font-medium"
            >Home page</ULink
          >
          for popular topics & pages
        </ProseLi>
      </ProseUl>
    </template>
  </AuthLayout>
</template>

<style scoped></style>
