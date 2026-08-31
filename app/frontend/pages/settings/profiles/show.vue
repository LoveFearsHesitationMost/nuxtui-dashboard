<script setup lang="ts">
import { reactive } from "vue"
import SettingsLayout from "@/layouts/SettingsLayout.vue"
import AppLayout from "@/layouts/AppLayout.vue"

const state = reactive({
  name: "",
  bio: "",
  url: "",
  location: ""
})

function onSubmit() {
  // TODO: implement save
}
</script>

<template>
  <AppLayout>
    <SettingsLayout>
      <UCard>
        <template #header>
          <div>
            <h2 class="text-lg font-semibold">Public profile</h2>
            <p class="text-muted mt-1 text-sm">
              This information will be displayed publicly.
            </p>
          </div>
        </template>

        <UForm :state="state" class="space-y-6" @submit="onSubmit">
          <UFormField
            name="name"
            label="Name"
            description="Your public display name."
            required
          >
            <UInput v-model="state.name" placeholder="Your name" />
          </UFormField>

          <UFormField
            name="bio"
            label="Bio"
            description="A short bio about yourself."
          >
            <UTextarea
              v-model="state.bio"
              placeholder="Tell us a little about yourself"
              :rows="3"
              autoresize
              :maxrows="6"
            />
          </UFormField>

          <UFormField
            name="url"
            label="Website"
            description="Your personal website or blog."
          >
            <UInput
              v-model="state.url"
              placeholder="https://example.com"
              icon="i-ph-link"
            />
          </UFormField>

          <UFormField
            name="location"
            label="Location"
            description="Where are you based?"
          >
            <UInput
              v-model="state.location"
              placeholder="City, Country"
              icon="i-ph-map-pin"
            />
          </UFormField>

          <div class="flex justify-end">
            <UButton type="submit" label="Save changes" />
          </div>
        </UForm>
      </UCard>
    </SettingsLayout>
  </AppLayout>
</template>
