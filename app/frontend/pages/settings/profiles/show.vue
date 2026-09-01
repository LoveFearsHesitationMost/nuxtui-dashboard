<script setup lang="ts">
import { computed } from "vue"
import { useForm, usePage } from "@inertiajs/vue3"
import SettingsLayout from "@/layouts/SettingsLayout.vue"
import AppLayout from "@/layouts/AppLayout.vue"
import type { ProfileData } from "@/types"
import { settingsProfilePath } from "@/routes"
import { z } from "zod"

const page = usePage()
const profile = computed<ProfileData>(() => page.props.profile as ProfileData)

const form = useForm<{
  name: string
  bio: string
  private_email: boolean
  avatar: File | null
}>({
  name: profile.value.name,
  bio: profile.value.bio ?? "",
  private_email: profile.value.private_email,
  avatar: null
})

const schema = z.object({
  name: z
    .string("Name is required")
    .max(20, { error: "20 characters maximum" }),
  bio: z.string().optional(),
  private_email: z.boolean()
})

function onSubmit() {
  form.patch(settingsProfilePath(), {
    onSuccess: () => {
      form.avatar = null
    }
  })
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

        <UForm
          :schema="schema"
          :state="form"
          class="space-y-6"
          @submit="onSubmit"
        >
          <UFormField
            name="avatar"
            label="Avatar"
            description="Pick an avatar image here."
            :error="form.errors.avatar?.[0]"
            required
          >
            <img
              :src="profile.avatar_url"
              class="my-2 size-36 rounded-xl object-cover"
            />
            <UFileUpload
              v-model="form.avatar"
              label="Drop your image here"
              accept="image/jpeg, image/png, image/webp, image/tiff, image/bmp"
              class="h-26 w-96"
            />
          </UFormField>

          <UFormField
            name="name"
            label="Name"
            description="Your public display name."
            :error="form.errors.name?.[0]"
            required
          >
            <UInput
              class="min-w-96"
              v-model="form.name"
              placeholder="Your name"
            />
          </UFormField>

          <UFormField
            name="bio"
            label="Bio"
            description="A short bio about yourself."
            :error="form.errors.bio?.[0]"
          >
            <UTextarea
              v-model="form.bio"
              class="min-w-96"
              placeholder="Tell us a little about yourself"
              :rows="3"
              autoresize
              :maxrows="6"
            />
          </UFormField>

          <UFormField name="private_email">
            <UCheckbox
              class="w-96"
              v-model="form.private_email"
              label="Make my email address private"
              description="We'll hide your email address from public profiles and unauthorized API. It will still be visible to administrators of this site."
            />
          </UFormField>

          <div class="flex justify-end">
            <UButton
              type="submit"
              label="Save changes"
              :loading="form.processing"
            />
          </div>
        </UForm>
      </UCard>
    </SettingsLayout>
  </AppLayout>
</template>
