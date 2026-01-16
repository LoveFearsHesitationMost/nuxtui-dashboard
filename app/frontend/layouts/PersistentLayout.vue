<script setup lang="ts">
import {zh_cn} from "@nuxt/ui/locale";
import {onMounted, onUnmounted} from "vue";
import {router} from "@inertiajs/vue3";

const toast = useToast()

let removeListener: (() => void) | undefined

onMounted(() => {
  removeListener = router.on("flash", (event) => {
    const flash = event.detail.flash
    if (flash.alert) {
      toast.add({
        icon: "ic:baseline-error",
        title: "出错了",
        color: "error",
        description: flash.alert
      })
    }
    if (flash.notice) {
      toast.add({
        icon: "ic:baseline-check-circle",
        title: "操作成功",
        color: "success",
        description: flash.notice
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
  <UApp :locale="zh_cn">
    <slot></slot>
  </UApp>
</template>

<style scoped>

</style>