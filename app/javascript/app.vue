<template>
  <div id="app">
    <nav class="flex bg-gray-50 text-gray-700 border border-gray-200 py-3 px-5 rounded-lg mb-4" aria-label="Breadcrumb">
      <ol class="inline-flex items-baseline items-center space-x-1 md:space-x-3">
        <li class="inline-flex items-center">
          <div class="text-2xl font-medium text-gray-700">
            {{ message }}
          </div>
        </li>
        <li class="inline-flex items-center underline">
          <router-link to="/" class="text-gray-700 hover:text-gray-900 inline-flex items-center">
            Visit Note
          </router-link>
        </li>
        <li class="inline-flex items-center underline">
          <router-link to="/patient" class="text-gray-700 hover:text-gray-900 inline-flex items-center">
            Patient
          </router-link>
        </li>
      </ol>
    </nav>
    <router-view />
  </div>
</template>

<script>

  export default {
    data: function () {
      return {
        message: "Therapy Notes App"
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
