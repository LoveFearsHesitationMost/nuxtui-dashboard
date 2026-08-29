<script setup lang="ts">
import { computed } from "vue";
import OtomoLogo from "@/assets/otomo.svg?component";
import { FooterColumn } from "@nuxt/ui/components/FooterColumns.vue";
import { signInPath, signUpPath, sessionPath } from "@/routes";
import { router, usePage } from "@inertiajs/vue3";
import type { DropdownMenuItem } from "@nuxt/ui";

const page = usePage();
const isLoggedIn = computed(() => !!page.props.auth.session);
const userEmail = computed(() => page.props.auth.user?.email ?? "");
const userName = "Li Hua";
const userAvatar = computed(
  () => `https://api.dicebear.com/10.x/notionists/svg?seed=${encodeURIComponent(userEmail.value)}`,
);

const sessionId = computed(() => page.props.auth.session?.id);

const userMenuItems = computed<DropdownMenuItem[][]>(() => [
  [
    {
      slot: "profile" as const,
    },
  ],
  [
    {
      label: "Settings",
      icon: "i-ph-gear-six",
      to: "#",
    },
    {
      label: "My following",
      icon: "i-ph-heart",
      to: "#",
    },
    {
      label: "My proposals",
      icon: "i-ph-git-pull-request",
      to: "#",
    },
    {
      label: "My pages",
      icon: "i-ph-files",
      to: "#",
    },
  ],
  [
    {
      label: "Log out",
      icon: "i-ph-sign-out",
      color: "error",
      onSelect: () => {
        if (sessionId.value) {
          router.delete(sessionPath(sessionId.value));
        }
      },
    },
  ],
]);

const items = computed(() => [
  {
    label: "Features",
  },
  {
    label: "Metrics",
  },
]);

const columns: FooterColumn[] = [
  {
    label: "Community",
    children: [
      {
        label: "Nuxters",
        to: "https://nuxters.nuxt.com",
        target: "_blank",
      },
      {
        label: "Video Courses",
        to: "https://masteringnuxt.com/nuxt3?ref=nuxt",
        target: "_blank",
      },
      {
        label: "Nuxt on GitHub",
        to: "https://github.com/nuxt",
        target: "_blank",
      },
    ],
  },
  {
    label: "Solutions",
    children: [
      {
        label: "Nuxt Content",
        to: "https://content.nuxt.com/",
        target: "_blank",
      },
      {
        label: "Nuxt DevTools",
        to: "https://devtools.nuxt.com/",
        target: "_blank",
      },
      {
        label: "Nuxt Image",
        to: "https://image.nuxt.com/",
        target: "_blank",
      },
      {
        label: "Nuxt UI",
        to: "https://ui.nuxt.com/",
        target: "_blank",
      },
    ],
  },
];
</script>

<template>
  <UHeader>
    <template #left>
      <UIcon :name="OtomoLogo" class="text-primary size-10" />
    </template>

    <UNavigationMenu :items="items" variant="link" />

    <template #right>
      <template v-if="isLoggedIn">
        <UButton icon="i-ph-bell" color="neutral" variant="ghost" class="hidden lg:flex" />
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
                icon: 'i-ph-image',
              }"
              :ui="{
                root: 'text-left',
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
        <UButton label="Get started" class="hidden lg:flex" :to="signUpPath()" />
      </template>
    </template>

    <template #body>
      <UNavigationMenu :items="items" orientation="vertical" />

      <div class="mt-4 flex flex-col gap-2">
        <template v-if="isLoggedIn">
          <div class="flex items-center gap-3 px-2 py-2">
            <UAvatar :src="userAvatar" />
            <div>
              <p class="text-sm font-semibold">{{ userName }}</p>
              <p class="text-muted text-xs">{{ userEmail }}</p>
            </div>
          </div>
          <UButton
            label="Settings"
            icon="i-ph-gear-six"
            color="neutral"
            variant="ghost"
            block
            to="#"
          />
          <UButton
            label="My following"
            icon="i-ph-heart"
            color="neutral"
            variant="ghost"
            block
            to="#"
          />
          <UButton
            label="My proposals"
            icon="i-ph-git-pull-request"
            color="neutral"
            variant="ghost"
            block
            to="#"
          />
          <UButton
            label="My pages"
            icon="i-ph-files"
            color="neutral"
            variant="ghost"
            block
            to="#"
          />
          <UButton
            label="Log out"
            icon="i-ph-sign-out"
            color="neutral"
            variant="ghost"
            block
            @click="sessionId && router.delete(sessionPath(sessionId))"
          />
        </template>
        <template v-else>
          <UButton label="Sign in" color="neutral" variant="soft" block />
          <UButton label="Get started" block :to="signUpPath()" />
        </template>
      </div>
    </template>
  </UHeader>

  <UContainer>
    <slot></slot>
  </UContainer>

  <UFooter
    :ui="{
      top: 'border-b border-default',
      container: 'border-t border-default lg:py-8',
      right: 'gap-x-0 flex-wrap',
    }"
  >
    <template #top>
      <UContainer>
        <UFooterColumns :columns="columns">
          <template #right>
            <UFormField name="email" label="Subscribe to our newsletter" size="lg">
              <UInput type="email" class="w-full">
                <template #trailing>
                  <UButton type="submit" size="xs" color="neutral" label="Subscribe" />
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
      <p class="text-dimmed text-sm">© {{ new Date().getFullYear() }} All rights reserved.</p>
    </template>
  </UFooter>
</template>
