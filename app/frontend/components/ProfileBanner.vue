<script setup lang="ts">
defineProps<{
  avatar: string
  background?: string
  name: string
  email?: string
  badges?: { icon?: string; label: string; class?: string }[]
  stats?: {
    proposals?: number
    pages?: number
    following?: number
    followers?: number
  }
}>()
</script>

<template>
  <div class="overflow-hidden rounded-lg">
    <!-- Background -->
    <div
      class="bg-muted h-40 bg-cover bg-center"
      :style="
        background ? { backgroundImage: `url(${background})` } : undefined
      "
    />

    <!-- Profile area -->
    <div class="bg-elevated relative flex w-full flex-wrap px-6 py-3">
      <!-- Avatar -->
      <div class="bg-muted absolute bottom-4 left-4 lg:left-12">
        <img
          :alt="name"
          :src="avatar"
          class="size-22 rounded-xl ring-8 ring-(--ui-bg-elevated)"
        />
      </div>

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
          <div v-if="email" class="text-muted -mt-1 text-base">{{ email }}</div>
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
