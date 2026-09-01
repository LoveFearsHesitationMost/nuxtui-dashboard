<script setup lang="ts">
import { computed, ref } from "vue"
import { router, usePage } from "@inertiajs/vue3"
import { settingsProfilePath } from "@/routes"

const { userId } = defineProps<{
  userId?: number
  avatar: string
  background?: string
  name: string
  email?: string
  bio?: string
  badges?: { icon?: string; label: string; class?: string }[]
  stats?: {
    proposals?: number
    pages?: number
    following?: number
    followers?: number
  }
}>()

const isMyself = computed(() => {
  return userId === usePage().props.auth.user?.id
})

const bgInput = ref<HTMLInputElement>()
const uploading = ref(false)

function onPickBackground() {
  bgInput.value?.click()
}

function onBackgroundSelected(event: Event) {
  const file = (event.target as HTMLInputElement).files?.[0]
  if (!file) return

  uploading.value = true
  // const upload = new DirectUpload(file, railsDirectUploadsPath())
  // upload.create((error, blob) => {
  //   if (error) {
  //     console.error("Background upload failed:", error)
  //     uploading.value = false
  //     return
  //   }
  //   useForm({ background: blob.signed_id }).patch("/settings/profile", {
  //     preserveScroll: true,
  //     onFinish: () => {
  //       uploading.value = false
  //     }
  //   })
  // })
  router.patch(
    settingsProfilePath(),
    {
      background: file
    },
    { preserveState: false } // reset `uploading`
  )
}
</script>

<template>
  <div class="overflow-hidden rounded-lg">
    <!-- Background -->
    <div
      class="bg-muted relative h-40 bg-cover bg-center"
      :style="
        background ? { backgroundImage: `url(${background})` } : undefined
      "
    >
      <input
        ref="bgInput"
        type="file"
        accept="image/jpeg, image/png, image/webp"
        class="hidden"
        @change="onBackgroundSelected"
      />
      <UButton
        v-if="isMyself"
        icon="i-ph-upload-simple"
        class="absolute right-4 bottom-2"
        color="neutral"
        size="sm"
        variant="subtle"
        :loading="uploading"
        @click="onPickBackground"
      >
        Change photo...
      </UButton>
    </div>

    <!-- Profile area -->
    <div class="bg-elevated relative flex w-full flex-wrap px-6 py-3">
      <!-- Avatar -->
      <img
        :alt="name"
        :src="avatar"
        class="absolute bottom-4 left-4 size-22 rounded-xl ring-9 ring-(--ui-bg-elevated) lg:left-12"
      />

      <!-- Info -->
      <div
        class="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between"
      >
        <div class="ml-24 lg:ml-32">
          <div class="flex flex-wrap items-baseline gap-2">
            <span class="text-2xl font-bold">{{ name }}</span>
            <UBadge
              v-for="badge in (badges || []).slice(0, 2)"
              :key="badge.label"
              :icon="badge.icon"
              :class="badge.class"
            >
              {{ badge.label }}
            </UBadge>
            <UTooltip arrow v-if="(badges || []).length > 2">
              <span class="text-muted text-xs font-medium hover:cursor-help"
                >and {{ (badges || []).length - 2 }} more</span
              >

              <template #content>
                <div class="flex gap-2">
                  <UBadge
                    v-for="badge in (badges || []).slice(2)"
                    :key="badge.label"
                    :icon="badge.icon"
                    :class="badge.class"
                  >
                    {{ badge.label }}
                  </UBadge>
                </div>
              </template>
            </UTooltip>
          </div>

          <div class="flex items-center gap-2">
            <ULink
              :to="`mailto:${email}`"
              v-if="email"
              class="shrink-0 font-medium"
            >
              <UIcon name="i-ph-envelope-bold" />
            </ULink>
            <span
              class="text-muted cjk-autospace inline-block max-w-sm min-w-0 truncate text-sm md:max-w-lg lg:max-w-2xl"
              >{{ bio }}</span
            >
          </div>
        </div>
      </div>

      <!-- Stats -->
      <div
        v-if="stats"
        class="flex flex-1 justify-end gap-4 text-sm not-md:w-full"
      >
        <div v-if="stats.proposals != null" class="flex flex-col items-center">
          <span class="text-xl font-semibold tabular-nums">{{
            stats.proposals
          }}</span>
          <span class="text-muted -mt-1">Proposals</span>
        </div>
        <div v-if="stats.pages != null" class="flex flex-col items-center">
          <span class="text-xl font-semibold tabular-nums">{{
            stats.pages
          }}</span>
          <span class="text-muted -mt-1">Pages</span>
        </div>
        <div v-if="stats.following != null" class="flex flex-col items-center">
          <span class="text-xl font-semibold tabular-nums">{{
            stats.following
          }}</span>
          <span class="text-muted -mt-1">Following</span>
        </div>
        <div v-if="stats.followers != null" class="flex flex-col items-center">
          <span class="text-xl font-semibold tabular-nums">{{
            stats.followers
          }}</span>
          <span class="text-muted -mt-1">Followers</span>
        </div>
      </div>
    </div>
  </div>
</template>
