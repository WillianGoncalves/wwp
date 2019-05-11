<template>
  <div class="card">
    <p><strong>{{ title }}</strong></p>
    <p>{{ date }}</p>
    <p>{{ time_distance }}</p>
  </div>
</template>

<script lang="coffee">
export default
  props:
    title:
      type: String
      required: true
    date:
      type: String
      required: true
    time_distance:
      type: String
      required: true
</script>
