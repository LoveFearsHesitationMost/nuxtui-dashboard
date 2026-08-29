<script setup lang="ts">
import background from "@/assets/login_bg.jpg";
import type { AuthFormField } from "@nuxt/ui";
import { usePage } from "@inertiajs/vue3";
import { computed, PropType } from "vue";
import { z } from "zod";

const props = defineProps({
  title: String,
  isPasswordHintShown: {
    type: Boolean,
    default: true,
  },
  icon: {
    type: String,
    default: "i-ph-lock",
  },
  fields: Array as PropType<AuthFormField[]>,
  schema: Object as PropType<z.Schema>,
});

const page = usePage();
const errors = computed(() => page.props.errors);
const flatErrors = computed(() => {
  return Object.values(errors.value).flat();
});
</script>

<template>
  <div class="grid min-h-svh lg:grid-cols-5">
    <div
      class="bg-muted relative col-span-3 hidden bg-cover bg-center shadow-[10px_0_10px_rgba(0,0,0,0.25)] lg:block"
      :style="{ backgroundImage: `url(${background})` }"
    ></div>
    <div class="col-span-2 flex size-full items-center justify-center">
      <UAuthForm class="max-w-sm" :fields="fields" :icon="icon" :title="title" :schema="schema">
        <template #description="descriptionSlotProps">
          <slot name="description" v-bind="descriptionSlotProps"></slot>
        </template>
        <template #password-hint v-if="isPasswordHintShown">
          <ULink as="button" class="text-primary font-medium" tabindex="-1">Forgot Password?</ULink>
        </template>
        <template v-if="flatErrors.length > 0" #validation>
          <UAlert color="error" icon="ic:baseline-error" title="Something goes wrong.">
            <template #description>
              <ol class="list-inside list-decimal">
                <li v-for="(errorMsg, index) in flatErrors" :key="index">
                  {{ errorMsg }}
                </li>
              </ol>
            </template>
          </UAlert>
        </template>
        <template #footer>
          <span class="text-xs">Powered by Project Otomo</span>
        </template>
      </UAuthForm>
    </div>
  </div>
</template>

<style scoped></style>
