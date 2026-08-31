<script setup lang="ts">
import type { NavigationMenuItem } from "@nuxt/ui"
import ProfileBanner from "@/components/ProfileBanner.vue"
import { usePage } from "@inertiajs/vue3"
import { computed } from "vue"
import { settingsProfilePath } from "@/routes"

const page = usePage()

const navItems = computed<NavigationMenuItem[]>(() => [
  {
    label: "Profile",
    icon: "i-ph-user",
    to: settingsProfilePath(),
    active: page.component === "settings/profiles/show"
  },
  {
    label: "Account",
    icon: "i-ph-gear-six",
    to: "#"
  },
  {
    label: "Notifications",
    icon: "i-ph-bell",
    to: "#"
  },
  {
    label: "Security",
    icon: "i-ph-shield-check",
    to: "#"
  }
])
</script>

<template>
  <div class="py-8 lg:py-10">
    <div class="mb-6 lg:mb-8">
      <ProfileBanner
        avatar="https://api.dicebear.com/10.x/shapes/svg"
        background="https://images.unsplash.com/photo-1776695799247-b15851a1aa2d"
        name="tistest"
        email="user@example.com"
        :stats="{ proposals: 123, pages: 123, following: 123, followers: 123 }"
        :badges="[
          { icon: 'ph:rocket', label: 'Badge 1', class: 'bg-primary' },
          { icon: 'i-ph-rocket', label: 'Badge 2', class: 'bg-teal-400' },
          { icon: 'i-ph-rocket', label: 'Badge 3', class: 'bg-indigo-400' },
          { icon: 'i-ph-network', label: 'Badge 4', class: 'bg-cyan-400' }
        ]"
      />

      <!--      <h1 class="text-xl font-bold">{{ title ?? "Settings" }}</h1>-->
      <!--      <p v-if="description" class="text-muted mt-1 text-sm">-->
      <!--        {{ description }}-->
      <!--      </p>-->
    </div>

    <div class="flex flex-col gap-8 lg:flex-row">
      <aside class="w-full shrink-0 lg:w-56">
        <UNavigationMenu
          :items="navItems"
          orientation="vertical"
          class="lg:block"
        />
      </aside>

      <div class="min-w-0 flex-1">
        <slot />
      </div>
    </div>
  </div>
</template>
