<script setup lang="ts">
import type { DropdownMenuItem } from "@nuxt/ui"
import { computed, ref } from "vue"
import { router, usePage } from "@inertiajs/vue3"
import { sessionPath } from "@/routes"

defineProps<{
  collapsed?: boolean
}>()

const user = ref({
  name: "Benjamin Canac",
  avatar: {
    src: "https://github.com/benjamincanac.png",
    alt: "Benjamin Canac"
  }
})

const sessionId = computed<string>(() => usePage().props.auth.session.id)

const items = computed<DropdownMenuItem[][]>(() => [
  [
    {
      type: "label",
      label: user.value.name,
      avatar: user.value.avatar
    }
  ],
  [
    {
      label: "Profile",
      icon: "i-lucide-user"
    },
    {
      label: "Billing",
      icon: "i-lucide-credit-card"
    },
    {
      label: "Settings",
      icon: "i-lucide-settings",
      to: "/settings"
    }
  ],
  [
    {
      label: "Templates",
      icon: "i-lucide-layout-template",
      children: [
        {
          label: "Starter",
          to: "https://starter-template.nuxt.dev/"
        },
        {
          label: "Landing",
          to: "https://landing-template.nuxt.dev/"
        },
        {
          label: "Docs",
          to: "https://docs-template.nuxt.dev/"
        },
        {
          label: "SaaS",
          to: "https://saas-template.nuxt.dev/"
        },
        {
          label: "Dashboard",
          to: "https://dashboard-template.nuxt.dev/",
          color: "primary",
          checked: true,
          type: "checkbox"
        },
        {
          label: "Chat",
          to: "https://chat-template.nuxt.dev/"
        },
        {
          label: "Portfolio",
          to: "https://portfolio-template.nuxt.dev/"
        },
        {
          label: "Changelog",
          to: "https://changelog-template.nuxt.dev/"
        }
      ]
    }
  ],
  [
    {
      label: "Documentation",
      icon: "i-lucide-book-open",
      to: "https://ui.nuxt.com/docs/getting-started/installation/nuxt",
      target: "_blank"
    },
    {
      label: "GitHub repository",
      icon: "i-simple-icons-github",
      to: "https://github.com/nuxt-ui-templates/dashboard",
      target: "_blank"
    },
    {
      label: "Log out",
      icon: "i-lucide-log-out",
      onSelect: () => {
        router.delete(sessionPath(sessionId.value))
      }
    }
  ]
])
</script>

<template>
  <UDropdownMenu
    :items="items"
    :content="{ align: 'center', collisionPadding: 12 }"
    :ui="{
      content: collapsed ? 'w-48' : 'w-(--reka-dropdown-menu-trigger-width)'
    }"
  >
    <UButton
      v-bind="{
        ...user,
        label: collapsed ? undefined : user?.name,
        trailingIcon: collapsed ? undefined : 'i-lucide-chevrons-up-down'
      }"
      color="neutral"
      variant="ghost"
      block
      :square="collapsed"
      class="data-[state=open]:bg-elevated"
      :ui="{
        trailingIcon: 'text-dimmed'
      }"
    />

    <template #chip-leading="{ item }">
      <div class="inline-flex size-5 shrink-0 items-center justify-center">
        <span
          class="ring-bg size-2 rounded-full bg-(--chip-light) ring dark:bg-(--chip-dark)"
          :style="{
            '--chip-light': `var(--color-${(item as any).chip}-500)`,
            '--chip-dark': `var(--color-${(item as any).chip}-400)`
          }"
        />
      </div>
    </template>
  </UDropdownMenu>
</template>
