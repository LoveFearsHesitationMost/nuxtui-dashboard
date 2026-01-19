<script setup lang="ts">
import background from "@/assets/login_bg.jpg"
import type {AuthFormField} from '@nuxt/ui'
import {usePage} from "@inertiajs/vue3";
import {computed, PropType} from "vue";
import {z} from "zod";

defineProps({
  title: String,
  isPasswordHintShown: {
    type: Boolean,
    default: true,
  },
  icon: {
    type: String,
    default: "i-lucide-lock",
  },
  fields: Array as PropType<AuthFormField[]>,
  schema: Object as PropType<z.Schema>,
})

const page = usePage();

const errors = computed(() => page.props.errors);

const flatErrors = computed(() => {
  return Object.values(errors.value).flat();
});

</script>

<template>
  <div class="grid min-h-svh lg:grid-cols-5">
    <div class="bg-muted relative hidden lg:block col-span-3 bg-cover bg-center"
         :style="{'backgroundImage': `url(${background})`}">
    </div>
    <div class="flex size-full justify-center items-center col-span-2">
      <UPageCard class="w-full max-w-sm">
        <UAuthForm :fields="fields" :icon="icon" :title="title" :schema="schema" validateOnInputDelay="0">
          <template #description="descriptionSlotProps">
            <slot name="description" v-bind="descriptionSlotProps"></slot>
          </template>
          <template #password-hint v-if="isPasswordHintShown">
            <ULink as="button" class="text-primary font-medium" tabindex="-1">忘记密码？</ULink>
          </template>
          <template v-if="flatErrors.length > 0" #validation>
            <UAlert color="error" icon="ic:baseline-error" title="出错了">
              <template #description>
                <ol class="list-decimal list-inside">
                  <li v-for="(errorMsg, index) in flatErrors" :key="index">
                    {{ errorMsg }}
                  </li>
                </ol>
              </template>
            </UAlert>
          </template>
        </UAuthForm>
      </UPageCard>
    </div>
  </div>
</template>

<style scoped>

</style>