<script setup lang="ts">
import DashboardLayout from '~/layouts/DashboardLayout.vue'
import {ref} from "vue";

const studyStats = ref({
  todayStudyTime: 120,
  totalPoints: 2580,
  completedCourses: 12,
  totalCourses: 20,
  streakDays: 7
})

const todayPlan = ref([
  {
    id: 1,
    title: 'JavaScript 基础语法',
    type: 'video',
    duration: 45,
    progress: 60,
    status: 'in-progress'
  },
  {
    id: 2,
    title: '算法练习题',
    type: 'practice',
    duration: 30,
    progress: 0,
    status: 'pending'
  },
  {
    id: 3,
    title: 'React 组件开发',
    type: 'project',
    duration: 90,
    progress: 100,
    status: 'completed'
  }
])

const recommendedCourses = ref([
  {
    id: 1,
    title: 'Vue 3 完整教程',
    instructor: '张老师',
    rating: 4.8,
    students: 1234,
    image: 'https://via.placeholder.com/300x200/4F46E5/ffffff?text=Vue+3',
    price: '¥99',
    level: '中级'
  },
  {
    id: 2,
    title: 'TypeScript 进阶',
    instructor: '李老师',
    rating: 4.9,
    students: 856,
    image: 'https://via.placeholder.com/300x200/059669/ffffff?text=TypeScript',
    price: '¥129',
    level: '高级'
  },
  {
    id: 3,
    title: 'Node.js 后端开发',
    instructor: '王老师',
    rating: 4.7,
    students: 2341,
    image: 'https://via.placeholder.com/300x200/DC2626/ffffff?text=Node.js',
    price: '¥149',
    level: '中级'
  }
])

const recommendedProblems = ref([
  {
    id: 1,
    title: '两数之和',
    difficulty: '简单',
    tags: ['数组', '哈希表'],
    acceptance: '68.5%',
    points: 10
  },
  {
    id: 2,
    title: '最长公共前缀',
    difficulty: '中等',
    tags: ['字符串'],
    acceptance: '52.3%',
    points: 20
  },
  {
    id: 3,
    title: '有效的括号',
    difficulty: '简单',
    tags: ['栈', '字符串'],
    acceptance: '44.8%',
    points: 15
  }
])

const getDifficultyColor = (difficulty: string) => {
  switch (difficulty) {
    case '简单':
      return 'green'
    case '中等':
      return 'yellow'
    case '困难':
      return 'red'
    default:
      return 'gray'
  }
}

const getTypeIcon = (type: string) => {
  switch (type) {
    case 'video':
      return 'i-lucide-play-circle'
    case 'practice':
      return 'i-lucide-edit-3'
    case 'project':
      return 'i-lucide-folder'
    default:
      return 'i-lucide-file'
  }
}
</script>

<template>
  <DashboardLayout>
    <UDashboardPanel>
      <template #header>
        <UDashboardNavbar title="Home" :ui="{ right: 'gap-3' }">
          <template #leading>
            <UDashboardSidebarCollapse/>
          </template>

          <template #right>
            <UTooltip text="Notifications" :shortcuts="['N']">
              <UButton
                  color="neutral"
                  variant="ghost"
                  square
              >
                <UChip color="error" inset>
                  <UIcon name="i-lucide-bell" class="size-5 shrink-0"/>
                </UChip>
              </UButton>
            </UTooltip>

            <UButton icon="i-lucide-plus" size="md" class="rounded-full"/>
          </template>
        </UDashboardNavbar>

      </template>
      <template #body>
        <div class="space-y-6">
          <!-- 学习统计卡片 -->
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <UCard>
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-sm text-gray-500">今日学习时长</p>
                  <p class="text-2xl font-bold">{{ studyStats.todayStudyTime }}分钟</p>
                </div>
                <div class="p-3 bg-blue-100 rounded-lg">
                  <UIcon name="i-lucide-clock" class="w-6 h-6 text-blue-600"/>
                </div>
              </div>
            </UCard>

            <UCard>
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-sm text-gray-500">学习积分</p>
                  <p class="text-2xl font-bold">{{ studyStats.totalPoints }}</p>
                </div>
                <div class="p-3 bg-green-100 rounded-lg">
                  <UIcon name="i-lucide-star" class="w-6 h-6 text-green-600"/>
                </div>
              </div>
            </UCard>

            <UCard>
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-sm text-gray-500">课程进度</p>
                  <p class="text-2xl font-bold">{{ studyStats.completedCourses }}/{{ studyStats.totalCourses }}</p>
                </div>
                <div class="p-3 bg-purple-100 rounded-lg">
                  <UIcon name="i-lucide-book" class="w-6 h-6 text-purple-600"/>
                </div>
              </div>
            </UCard>

            <UCard>
              <div class="flex items-center justify-between">
                <div>
                  <p class="text-sm text-gray-500">连续学习</p>
                  <p class="text-2xl font-bold">{{ studyStats.streakDays }}天</p>
                </div>
                <div class="p-3 bg-red-100 rounded-lg">
                  <UIcon name="i-lucide-fire" class="w-6 h-6 text-red-600"/>
                </div>
              </div>
            </UCard>
          </div>

          <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- 今日学习计划 -->
            <div class="lg:col-span-2">
              <UCard>
                <template #header>
                  <div class="flex items-center justify-between">
                    <h3 class="text-lg font-semibold">今日学习计划</h3>
                    <UButton color="gray" variant="ghost" size="sm">
                      查看全部
                    </UButton>
                  </div>
                </template>

                <div class="space-y-4">
                  <div
                      v-for="plan in todayPlan"
                      :key="plan.id"
                      class="flex items-center gap-4 p-4 border rounded-lg"
                  >
                    <div class="flex-shrink-0">
                      <div class="p-2 bg-gray-100 rounded-lg">
                        <UIcon :name="getTypeIcon(plan.type)" class="w-5 h-5"/>
                      </div>
                    </div>

                    <div class="flex-1 min-w-0">
                      <h4 class="font-medium truncate">{{ plan.title }}</h4>
                      <div class="flex items-center gap-4 mt-1 text-sm text-gray-500">
                        <span>{{ plan.duration }}分钟</span>
                        <span v-if="plan.progress > 0">{{ plan.progress }}% 完成</span>
                      </div>
                      <UProgress
                          :value="plan.progress"
                          class="mt-2"
                          :color="plan.status === 'completed' ? 'green' : 'primary'"
                      />
                    </div>

                    <div class="flex-shrink-0">
                      <UButton
                          v-if="plan.status === 'pending'"
                          size="sm"
                          color="primary"
                      >
                        开始学习
                      </UButton>
                      <UButton
                          v-else-if="plan.status === 'in-progress'"
                          size="sm"
                          color="gray"
                          variant="ghost"
                      >
                        继续学习
                      </UButton>
                      <div v-else class="flex items-center gap-1 text-green-600">
                        <UIcon name="i-lucide-check-circle" class="w-4 h-4"/>
                        <span class="text-sm">已完成</span>
                      </div>
                    </div>
                  </div>
                </div>
              </UCard>
            </div>

            <!-- 推荐题目 -->
            <div>
              <UCard>
                <template #header>
                  <div class="flex items-center justify-between">
                    <h3 class="text-lg font-semibold">推荐题目</h3>
                    <UButton color="gray" variant="ghost" size="sm">
                      更多
                    </UButton>
                  </div>
                </template>

                <div class="space-y-3">
                  <div
                      v-for="problem in recommendedProblems"
                      :key="problem.id"
                      class="p-3 border rounded-lg hover:bg-gray-50 cursor-pointer"
                  >
                    <div class="flex items-center justify-between mb-2">
                      <h4 class="font-medium text-sm">{{ problem.title }}</h4>
                      <UBadge :color="getDifficultyColor(problem.difficulty)" size="xs">
                        {{ problem.difficulty }}
                      </UBadge>
                    </div>

                    <div class="flex items-center gap-2 mb-2">
                      <UBadge
                          v-for="tag in problem.tags"
                          :key="tag"
                          color="gray"
                          variant="subtle"
                          size="xs"
                      >
                        {{ tag }}
                      </UBadge>
                    </div>

                    <div class="flex items-center justify-between text-xs text-gray-500">
                      <span>通过率: {{ problem.acceptance }}</span>
                      <span class="text-primary-600">+{{ problem.points }}积分</span>
                    </div>
                  </div>
                </div>
              </UCard>
            </div>
          </div>

          <!-- 推荐课程 -->
          <UCard>
            <template #header>
              <div class="flex items-center justify-between">
                <h3 class="text-lg font-semibold">推荐课程</h3>
                <UButton color="gray" variant="ghost" size="sm">
                  查看全部
                </UButton>
              </div>
            </template>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              <UCard
                  v-for="course in recommendedCourses"
                  :key="course.id"
                  class="overflow-hidden"
              >
                <img
                    :src="course.image"
                    :alt="course.title"
                    class="w-full h-32 object-cover rounded-lg mb-3"
                >

                <h4 class="font-semibold mb-2">{{ course.title }}</h4>

                <div class="flex items-center gap-2 mb-2 text-sm text-gray-600">
                  <UIcon name="i-lucide-user" class="w-4 h-4"/>
                  <span>{{ course.instructor }}</span>
                </div>

                <div class="flex items-center gap-4 mb-3 text-sm text-gray-600">
                  <div class="flex items-center gap-1">
                    <UIcon name="i-lucide-star" class="w-4 h-4 text-yellow-500"/>
                    <span>{{ course.rating }}</span>
                  </div>
                  <span>{{ course.students }}人学习</span>
                  <UBadge color="gray" variant="subtle" size="xs">
                    {{ course.level }}
                  </UBadge>
                </div>

                <div class="flex items-center justify-between">
                  <span class="text-lg font-bold text-primary-600">{{ course.price }}</span>
                  <UButton size="sm" color="primary">
                    立即学习
                  </UButton>
                </div>
              </UCard>
            </div>
          </UCard>
        </div>
      </template>
    </UDashboardPanel>
  </DashboardLayout>
</template>

<style scoped>
</style>