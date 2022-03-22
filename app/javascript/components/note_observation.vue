<template>
	<div class="flex" v-for="item in observationFields" :key="item"> 
	  <div class="mr-2">
	    <label class="block mb-1 text-sm font-medium text-gray-900 ">Note type</label>
	    <input
	    	v-model="item.title" 
	      type="text" 
	      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-gray-500 focus:border-gray-500 block w-full p-2.5 "
	    />
	  </div>
	  <div class="mr-2">
	    <label class="block mb-1 text-sm font-medium text-gray-900 ">Note body</label>
	    <input
	    	v-model="item.body" 
	      type="text" 
	      class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-gray-500 focus:border-gray-500 block w-full p-2.5 "
	    />
	  </div>
    <Listbox as="div" class="w-1/3" v-model="item.result">
	    <ListboxLabel class="block text-sm font-medium text-gray-700"> Result </ListboxLabel>
	    <div class="mt-1 relative">
	      <ListboxButton class="relative w-full bg-white border border-gray-300 rounded-md shadow-sm p-2.5 text-left cursor-default focus:outline-none focus:ring-1 focus:ring-gray-500 focus:border-gray-500 sm:text-sm">
	        <span class="flex items-center">
	          <span class="ml-3 block truncate">{{ item.result }}</span>
	        </span>
	        <span class="ml-3 absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
	          <SelectorIcon class="h-5 w-5 text-gray-400" aria-hidden="true" />
	        </span>
	      </ListboxButton>

	      <transition leave-active-class="transition ease-in duration-100" leave-from-class="opacity-100" leave-to-class="opacity-0">
	        <ListboxOptions class="absolute z-10 mt-1 w-full bg-white shadow-lg max-h-56 rounded-md py-1 text-base ring-1 ring-black ring-opacity-5 overflow-auto focus:outline-none sm:text-sm">
	          <ListboxOption as="template" v-for="result in resultOptions" :key="result" :value="result" v-slot="{ active, selected }">
	            <li :class="[active ? 'text-white bg-gray-600' : 'text-gray-900', 'cursor-default select-none relative py-2 pl-3 pr-9']">
	              <div class="flex items-center">
	                <span :class="[selected ? 'font-semibold' : 'font-normal', 'ml-3 block truncate']">
	                  {{ result }}
	                </span>
	              </div>

	              <span v-if="selected" :class="[active ? 'text-white' : 'text-gray-600', 'absolute inset-y-0 right-0 flex items-center pr-4']">
	                <CheckIcon class="h-5 w-5" aria-hidden="true" />
	              </span>
	            </li>
	          </ListboxOption>
	        </ListboxOptions>
	      </transition>
	    </div>
	  </Listbox>
	</div>
</template>

<script>
import { Listbox, ListboxButton, ListboxLabel, ListboxOption, ListboxOptions } from '@headlessui/vue'
import { CheckIcon, SelectorIcon } from '@heroicons/vue/solid'
export default {
  props: ["noteObservation"],
  data: function() {
    return {
      observationFields: this.noteObservation,
      resultOptions: ["NA", "Positive", "Negative"],
      selected: '',
    }
  },
  created() {
  	this.selected = this.resultOptions[0]
  },
  components: {
  	Listbox,
    ListboxButton,
    ListboxLabel,
    ListboxOption,
    ListboxOptions,
    CheckIcon,
    SelectorIcon,
  }
};
</script>