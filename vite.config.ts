import vue from '@vitejs/plugin-vue'
import tailwindcss from '@tailwindcss/vite'
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import ui from '@nuxt/ui/vite'

export default defineConfig({
  plugins: [
    vue(),
    tailwindcss(),
    RubyPlugin(),
    ui({
      router: 'inertia',
      ui: {
        icons: {
          arrowDown: 'i-material-symbols:arrow-downward',
          arrowLeft: 'i-material-symbols:arrow-back',
          arrowRight: 'i-material-symbols:arrow-forward',
          arrowUp: 'i-material-symbols:arrow-upward',
          caution: 'i-material-symbols:error-outline',
          check: 'i-material-symbols:check',
          chevronDoubleLeft: 'i-material-symbols:keyboard-double-arrow-left',
          chevronDoubleRight: 'i-material-symbols:keyboard-double-arrow-right',
          chevronDown: 'i-material-symbols:keyboard-arrow-down',
          chevronLeft: 'i-material-symbols:keyboard-arrow-left',
          chevronRight: 'i-material-symbols:keyboard-arrow-right',
          chevronUp: 'i-material-symbols:keyboard-arrow-up',
          close: 'i-material-symbols:close',
          copy: 'i-material-symbols:content-copy',
          copyCheck: 'i-material-symbols:check-circle-outline',
          dark: 'i-material-symbols:dark-mode',
          drag: 'i-material-symbols:drag-indicator',
          ellipsis: 'i-material-symbols:more-horiz',
          error: 'i-material-symbols:dangerous-outline',
          external: 'i-material-symbols:open-in-new',
          eye: 'i-material-symbols:visibility',
          eyeOff: 'i-material-symbols:visibility-off',
          file: 'i-material-symbols:docs',
          folder: 'i-material-symbols:folder',
          folderOpen: 'i-material-symbols:folder-open',
          hash: 'i-material-symbols:tag',
          info: 'i-material-symbols:info',
          light: 'i-material-symbols:light-mode',
          loading: 'i-material-symbols:clock-loader-20',
          menu: 'i-material-symbols:menu',
          minus: 'i-material-symbols:remove',
          panelClose: 'i-material-symbols:left-panel-close',
          panelOpen: 'i-material-symbols:left-panel-open',
          plus: 'i-material-symbols:add',
          reload: 'i-material-symbols:refresh',
          search: 'i-material-symbols:search',
          stop: 'i-material-symbols:stop',
          success: 'i-material-symbols:check-circle-outline',
          system: 'i-material-symbols:desktop-windows-outline',
          tip: 'i-material-symbols:lightbulb',
          upload: 'i-material-symbols:upload',
          warning: 'i-material-symbols:warning-outline'
        },
        colors: {
          primary: 'amber',
          neutral: 'neutral'
        }
      }
    }),
  ],
})
