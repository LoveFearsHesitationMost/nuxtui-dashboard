<script setup lang="ts">
import { onMounted, onUnmounted } from "vue"
import { router } from "@inertiajs/vue3"

const toast = useToast()

const toaster = { position: "bottom-right" }

let removeListener: (() => void) | undefined

onMounted(() => {
  removeListener = router.on("flash", (event) => {
    const flash = event.detail.flash
    if (flash.alert) {
      toast.add({
        icon: "i-ph-warning-circle-fill",
        title: flash.alert,
        color: "error"
      })
    }
    if (flash.notice) {
      toast.add({
        title: flash.notice
      })
    }
  })
})

onUnmounted(() => {
  if (removeListener) {
    removeListener()
  }
})
</script>

<template>
  <UApp :toaster="toaster">
    <slot></slot>
  </UApp>
</template>

<style scoped></style>
