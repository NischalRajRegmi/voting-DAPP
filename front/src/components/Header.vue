<template>
  <nav class="h-40 container flex items-center justify-center">
    <router-link to="/">
      <h1 :class="props.showAnimation ? 'animated-header' : '' " class="text-4xl uppercase font-bold text-green-700 cursor-pointer ">
        <!-- <span class="a1">Blockchain </span>
        <span class="a2">based </span>
        <span class="a3">online </span>
        <span class="a4">voting </span>
        <span class="a5">system</span> -->
        <!-- Blockchain based online voting system -->
        {{props.title}}
      </h1>
    </router-link>
  </nav>
</template>

<script setup>
import {defineProps} from "vue";

const props = defineProps(["title", "showAnimation"]);

</script>


<style scoped>

/* .a1 {
  position: relative;
  scaleX: 
  animation: popup 2s infinte;
}

@keyframes popup {
  from { top: 0px; }
  to { top: 100px; }
} */

.animated-header
{
   text-transform: uppercase;
  background-image: linear-gradient(
    -225deg,
    #017414 0%,
    #00c050 29%,
    #95b90f 67%,
    #ad5400 100%
  );
  background-size: auto auto;
  background-clip: border-box;
  background-size: 200% auto;
  color: #fff;
  background-clip: text;
  text-fill-color: transparent;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: textclip 2s linear infinite;
  display: inline-block;
      /* font-size: 190px; */
}

@keyframes textclip {
  to {
    background-position: 200% center;
  }
}


</style>