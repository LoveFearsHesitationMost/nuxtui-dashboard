<script setup lang="ts">

import AppLayout from "@/layouts/AppLayout.vue";
import { ref } from "vue";
import { ButtonProps } from "@nuxt/ui/components/Button.vue";

const STATISTICS = [
  {label: "Pages", value: "245", icon: "i-ph-files-fill"},
  {label: "Merged Proposals", value: "1103", icon: "i-ph-git-pull-request-fill"},
  {label: "Contributors", value: "74", icon: "i-ph-users-three-fill"},
  {label: "Categories", value: "12", icon: "i-ph-books-fill"},
];

const TRENDING_PAGES = [
  {title: "Our Awesome Game", desc: "Core game mechanics and features"},
  {title: "Composite System", desc: "Building and combining elements"},
  {title: "Brewing System", desc: "Crafting potions and consumables"},
  {title: "PVP", desc: "Player versus player combat guide"},
  {title: "P2P Online Mode", desc: "Cooperative multiplayer exploration"},
  {title: "Saury", desc: "Sea creature lore and encounters"},
];

const RECENT_CHANGES = [
  {page: "Composite System", editor: "alex_w", time: "2 hours ago"},
  {page: "Brewing Recipes", editor: "mika_fan", time: "4 hours ago"},
  {page: "PVP Season 3", editor: "gamekeeper", time: "6 hours ago"},
  {page: "Saury Lore", editor: "lorekeeper", time: "8 hours ago"},
  {page: "Map: Azure Coast", editor: "explorer_01", time: "12 hours ago"},
];

const CATEGORIES = [
  {
    name: "Gameplay",
    count: 42,
    icon: "i-ph-lightning",
    featured: ["Combat Basics", "Skill Trees", "Difficulty Modes"],
  },
  {
    name: "Characters",
    count: 35,
    icon: "i-ph-person",
    featured: ["Hero Roster", "Character Builds", "Voice Actors"],
  },
  {
    name: "Items & Equipment",
    count: 28,
    icon: "i-ph-sword",
    featured: ["Legendary Weapons", "Set Bonuses", "Crafting Materials"],
  },
  {
    name: "Locations",
    count: 24,
    icon: "i-ph-map-pin",
    featured: ["World Map", "Hidden Dungeons", "Fast Travel Points"],
  },
];

const CTA_LINKS = ref<ButtonProps[]>([
  {
    label: 'Get started',
    color: 'neutral'
  },
  {
    label: 'Learn more',
    color: 'neutral',
    variant: 'subtle',
    trailingIcon: 'i-lucide-arrow-right'
  }
])
</script>

<template>
  <AppLayout>
    <UPageSection
        class="-mt-8 md:-mt-16"
        title="What are you interested in today?"
        description="Explore the wiki, discover new pages, and contribute to the
            community."
    >
      <template #body>
        <div class="-mt-8 w-full flex flex-col items-center gap-2">
          <UInput
              class="w-xl"
              icon="i-ph-magnifying-glass"
              size="xl"
              placeholder="Search pages, topics, or proposals..."/>
          <div class="flex gap-1">
            <UMarquee
                pause-on-hover
                class="w-2xl"
                :ui="{
              root: 'gap-6',
              content: 'gap-6'
                }"
            >
              <UButton color="neutral" variant="ghost" class="text-dimmed">Hot word</UButton>
              <UButton color="neutral" variant="ghost" class="text-dimmed">Word++</UButton>
              <UButton color="neutral" variant="ghost" class="text-dimmed">Good topic</UButton>
              <UButton color="neutral" variant="ghost" class="text-dimmed">热词新词</UButton>
              <UButton color="neutral" variant="ghost" class="text-dimmed">asdfasdf</UButton>
              <UButton color="neutral" variant="ghost" class="text-dimmed">mise-en-place</UButton>
              <UButton color="neutral" variant="ghost" class="text-dimmed">11q1112fd</UButton>
              <UButton color="neutral" variant="ghost" class="text-dimmed">RubyMine</UButton>
            </UMarquee>

          </div>
        </div>
      </template>
    </UPageSection>

    <div class="md:flex -mt-8 md:-mt-16">
      <div class="grid grid-cols-4 md:grid-cols-2">
        <UPageCard
            spotlight
            v-for="metric in STATISTICS"
            :title="metric.value"
            :description="metric.label"
            class="rounded-none duration-300"
            to="#"
            :ui="{
                root: 'text-center overflow-hidden',
                wrapper: 'items-center',
                title: 'tabular-nums text-4xl font-bold tracking-tight leading-none',
                description: 'font-mono uppercase text-xs tracking-[0.06em] text-dimmed mt-3',
                footer: 'pt-0 absolute -bottom-2 -left-1 text-dimmed/25'
              }"
        >
          <template #footer>
            <UIcon :name="metric.icon" size="64"/>
          </template>
        </UPageCard>
      </div>

      <UPageCard
          spotlight
          class="flex-1 rounded-none"
          title="Welcome to Project Otomo"
          description="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse blandit convallis molestie. Morbi finibus vel risus quis vestibulum. Ut justo tellus, commodo commodo sollicitudin ut, suscipit in enim. Phasellus accumsan maximus egestas. Phasellus consequat leo vel neque mattis tempor. Proin porta quis urna at facilisis. Pellentesque nec risus vitae arcu lacinia dictum sed ut urna. In consectetur nec felis a tempor. Donec aliquet ultrices iaculis."
          icon="i-ph-quotes-duotone"
      />
    </div>

    <div class="mt-8 not-md:px-4">
      <div class="flex gap-2 items-center mb-4">
        <UIcon name="i-ph-trend-up" size="22"/>
        <span class="text-lg font-semibold">Trending Pages</span>
        <div class="flex-1"></div>
        <UButton
            variant="link"
            class="text-base"
        >
          View All
        </UButton>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <UPageCard v-for="page in TRENDING_PAGES" :title="page.title" :description="page.desc"/>
      </div>
    </div>

    <div class="mt-8 not-md:px-4 grid grid-cols-1 md:grid-cols-2 gap-8">
      <div>
        <div class="flex gap-2 items-center mb-2">
          <UIcon name="i-ph-book-open-text-fill" size="22"/>
          <span class="text-lg font-semibold">Categories</span>
          <div class="flex-1"></div>
          <UButton
              variant="link"
              class="text-base"
          >
            View All
          </UButton>
        </div>
        <div class="flex flex-col gap-1">
          <UPageList>
            <div
                v-for="(cat, idx) in CATEGORIES"
                :key="cat.name"
                :class="[
                    'py-2 hover:bg-elevated transition-colors',
                    idx !== CATEGORIES.length - 1 && 'border-b border-b-muted'
                    ]"
            >
              <div class="flex items-center justify-between mb-2">
                <div class="flex items-center gap-3">
                  <UIcon :name="cat.icon" class="text-primary size-5"/>
                  <span class="font-semibold">{{ cat.name }}</span>
                </div>
                <UBadge variant="subtle" size="sm" class="rounded-full px-2">
                  {{ cat.count }}
                </UBadge>
              </div>
              <div class="flex gap-2 pl-8 flex-wrap">
                <ULink
                    v-for="page in cat.featured"
                    :key="page"
                    :to="`/page/${page.toLowerCase().replace(/\s+/g, '_')}`"
                    class="text-xs text-muted hover:text-primary"
                >
                  {{ page }}
                </ULink>
              </div>
            </div>
          </UPageList>
        </div>
      </div>

      <div>
        <div class="flex gap-2 items-center mb-2">
          <UIcon name="i-ph-clock-counter-clockwise-fill" size="22"/>
          <span class="text-lg font-semibold">Recent Changes</span>
          <div class="flex-1"></div>
          <UButton
              variant="link"
              class="text-base"
          >
            View All
          </UButton>
        </div>
        <UPageList class="px-2">
          <div
              v-for="(change, idx) in RECENT_CHANGES"
              :key="`${change.page}-${change.time}`"
          >
            <div class="flex items-center justify-between py-3">
              <div>
                <ULink
                    :to="`/page/${change.page.toLowerCase().replace(/\s+/g, '_')}`"
                    class="font-medium hover:text-primary"
                >
                  {{ change.page }}
                </ULink>
                <p class="text-muted text-xs">by {{ change.editor }}</p>
              </div>
              <span class="text-muted text-xs whitespace-nowrap">{{ change.time }}</span>
            </div>
            <USeparator v-if="idx < RECENT_CHANGES.length - 1"/>
          </div>
        </UPageList>
      </div>
    </div>

    <UPageCTA
        class="my-4 not-md:mx-4"
        variant="subtle"
        title="Ready to contribute?"
        description="Help us build the most comprehensive fan wiki. Every edit matters."
        :links="CTA_LINKS"
    />
  </AppLayout>
</template>