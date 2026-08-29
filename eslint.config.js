import eslintPluginVue from "eslint-plugin-vue"
import tseslint from "typescript-eslint"
import eslintConfigPrettier from "eslint-config-prettier"

export default tseslint.config(
  {
    ignores: [
      "**/node_modules/**",
      "**/dist/**",
      "**/tmp/**",
      "**/vendor/**",
      "**/routes/**"
    ]
  },
  ...tseslint.configs.recommended,
  ...eslintPluginVue.configs["flat/strongly-recommended"],
  {
    files: ["**/*.vue"],
    languageOptions: {
      parserOptions: {
        parser: tseslint.parser
      }
    }
  },
  eslintConfigPrettier,
  {
    files: ["app/frontend/pages/**/*.vue"],
    rules: {
      "vue/multi-word-component-names": "off"
    }
  }
)
