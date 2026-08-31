<script setup lang="ts">
import { computed } from "vue"
import OtomoLogo from "@/assets/otomo.svg?component"
import { sessionPath, signInPath, signUpPath } from "@/routes"
import { router, usePage } from "@inertiajs/vue3"

defineProps({
  showSearch: {
    type: Boolean,
    default: true
  }
})

const page = usePage()
const isLoggedIn = computed(() => !!page.props.auth.session)
const userEmail = computed(() => page.props.auth.user?.email ?? "")
const userName = "Li Hua"
const userAvatar = computed(
  () =>
    `https://api.dicebear.com/10.x/notionists/svg?seed=${encodeURIComponent(userEmail.value)}`
)

const sessionId = computed(() => page.props.auth.session?.id)

const userMenuItems = computed(() => [
  [
    {
      slot: "profile" as const
    }
  ],
  [
    {
      label: "Settings",
      icon: "i-ph-gear-six",
      to: "#"
    },
    {
      label: "My following",
      icon: "i-ph-heart",
      to: "#"
    },
    {
      label: "My proposals",
      icon: "i-ph-git-pull-request",
      to: "#"
    },
    {
      label: "My pages",
      icon: "i-ph-files",
      to: "#"
    }
  ],
  [
    {
      label: "Log out",
      icon: "i-ph-sign-out",
      color: "error",
      onSelect: () => {
        if (sessionId.value) {
          router.delete(sessionPath(sessionId.value))
        }
      }
    }
  ]
])

const navItems = computed(() => [
  {
    label: "News",
    to: "/page/news"
  },
  {
    label: "Explore",
    children: [
      {
        label: "Pages",
        to: "/popular",
        description: "Discover popular pages"
      },
      {
        label: "Categories",
        to: "/categories",
        description: "Find specific topics"
      },
      {
        label: "Recents",
        to: "/recents",
        description: "What's recently changed?"
      },
      {
        label: "Random",
        to: "/random",
        description: "I'm feeling lucky today"
      }
    ]
  },
  {
    label: "About",
    children: [
      {
        label: "Community",
        to: "/page/community",
        description: "Discuss with fellows"
      },
      {
        label: "Statistics",
        to: "/statistics",
        description: "Total activity of this site"
      },
      {
        label: "Getting involved",
        to: "/page/getting_involved",
        description: "Guidance for new user"
      },
      {
        label: "Legal",
        to: "/page/terms_of_service",
        description: "ToS & Privacy Policy"
      }
    ]
  }
])

const mobileNavItems = computed(() => {
  if (isLoggedIn.value) return [userMenuItems.value[1], userMenuItems.value[2]]
  else
    return [
      [
        {
          label: "Sign in",
          to: signInPath(),
          icon: "ph:sign-in"
        },
        {
          label: "Sign up",
          to: signUpPath(),
          icon: "ph:user-plus"
        }
      ]
    ]
})

const columns = [
  {
    label: "Community",
    children: [
      {
        label: "Nuxters",
        to: "https://nuxters.nuxt.com",
        target: "_blank"
      },
      {
        label: "Video Courses",
        to: "https://masteringnuxt.com/nuxt3?ref=nuxt",
        target: "_blank"
      },
      {
        label: "Nuxt on GitHub",
        to: "https://github.com/nuxt",
        target: "_blank"
      }
    ]
  },
  {
    label: "Solutions",
    children: [
      {
        label: "Nuxt Content",
        to: "https://content.nuxt.com/",
        target: "_blank"
      },
      {
        label: "Nuxt DevTools",
        to: "https://devtools.nuxt.com/",
        target: "_blank"
      },
      {
        label: "Nuxt Image",
        to: "https://image.nuxt.com/",
        target: "_blank"
      },
      {
        label: "Nuxt UI",
        to: "https://ui.nuxt.com/",
        target: "_blank"
      }
    ]
  }
]
</script>

<template>
  <UHeader mode="slideover">
    <template #left>
      <UIcon :name="OtomoLogo" class="text-primary size-10" />
      <UNavigationMenu
        content-orientation="vertical"
        class="ml-3"
        :items="navItems"
      />
    </template>

    <template v-if="showSearch">
      <UInput
        class="w-sm"
        icon="i-ph-magnifying-glass"
        placeholder="Search pages, topics, or proposals..."
      />
    </template>

    <template #right>
      <template v-if="isLoggedIn">
        <UButton
          icon="i-ph-bell"
          color="neutral"
          variant="ghost"
          class="hidden lg:flex"
        />
        <UDropdownMenu
          :items="userMenuItems"
          :content="{ align: 'end', collisionPadding: 12 }"
          :ui="{ content: 'w-56' }"
        >
          <UButton color="neutral" variant="ghost" class="hidden lg:flex">
            <UAvatar :src="userAvatar" />
          </UButton>

          <template #profile>
            <UUser
              :name="userName"
              :description="userEmail"
              :avatar="{
                src: userAvatar,
                loading: 'lazy',
                icon: 'i-ph-image'
              }"
              :ui="{
                root: 'text-left'
              }"
            />
          </template>
        </UDropdownMenu>
      </template>
      <template v-else>
        <UButton
          label="Sign in"
          color="neutral"
          variant="ghost"
          class="hidden lg:flex"
          :to="signInPath()"
        />
        <UButton
          label="Get started"
          class="hidden lg:flex"
          :to="signUpPath()"
        />
      </template>
    </template>

    <template #body>
      <UNavigationMenu :items="mobileNavItems" orientation="vertical" />
    </template>
  </UHeader>

  <UContainer>
    <slot></slot>
  </UContainer>

  <UFooter
    :ui="{
      top: 'border-b border-default',
      container: 'border-t border-default lg:py-8',
      right: 'gap-x-0 flex-wrap'
    }"
  >
    <template #top>
      <UContainer>
        <UFooterColumns :columns="columns">
          <template #right>
            <UFormField
              name="email"
              label="Subscribe to our newsletter"
              size="lg"
            >
              <UInput type="email" class="w-full">
                <template #trailing>
                  <UButton
                    type="submit"
                    size="xs"
                    color="neutral"
                    label="Subscribe"
                  />
                </template>
              </UInput>
            </UFormField>
          </template>
        </UFooterColumns>
      </UContainer>
    </template>

    <template #left>
      <p class="text-dimmed text-sm">Powered by Project Otomo</p>
    </template>

    <template #right>
      <p class="text-dimmed text-sm">
        © {{ new Date().getFullYear() }} All rights reserved.
      </p>
    </template>
  </UFooter>
</template>
