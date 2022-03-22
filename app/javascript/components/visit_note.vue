<template>
	<div class="mx-auto container px-60 m-6">
		<div class="flex justify-end">
			<button 
	    	class="text-white text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center" 
	    	@click="newModal()">
	      Add Visit Note
	    </button>
		</div>
  	<h2 class="mt-2 flex text-2xl font-medium text-gray-700">Visit Notes</h2>
		<div class="mt-2 shadow-md rounded-lg border border-gray-200">
			<div class="p-4">
				<table class="w-full text-sm text-left text-gray-500">
					<thead class="text-xs text-gray-700 uppercase bg-gray-200">
						<tr>
							<th scope="col" class="px-6 py-3">
								Id
							</th>
							<th scope="col" class="px-6 py-3">
								Title
							</th>
							<th scope="col" class="px-6 py-3">
								Patient
							</th>
							<th scope="col" class="px-6 py-3">
								Actions
							</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="visitNote in visitNotes" :key="visitNote.id">
							<td class="px-6 py-4">{{ visitNote.id }}</td>
							<td class="px-6 py-4">{{ visitNote.title }}</td>
							<td class="px-6 py-4">{{ visitNote.patient.first_name +" " + visitNote.patient.last_name}}</td>
							<td class="flex px-6 py-4">
								<button 
									@click="editModal(visitNote)"
									class="mx-1 bg-green-500 hover:bg-green-800 text-white font-bold py-1 px-1 rounded inline-flex items-center"
								>
								  <PencilAltIcon class="h-5 w-5"/>
								</button>
								<button 
									@click="deleteModal(visitNote)"
									class="mx-1 bg-red-500 hover:bg-red-800 text-white font-bold py-1 px-1 rounded inline-flex items-center"
								>
								  <TrashIcon class="h-5 w-5"/>
								</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		
		</div>
	</div>
	<!--New visit note modal-->
	<TransitionRoot as="template" :show="openNewModal">
    <Dialog as="div" class="fixed z-10 inset-0 overflow-y-auto">
      <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0" enter-to="opacity-100" leave="ease-in duration-200" leave-from="opacity-100" leave-to="opacity-0">
          <DialogOverlay class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" />
        </TransitionChild>

        <!-- This element is to trick the browser into centering the modal contents. -->
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
        <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" enter-to="opacity-100 translate-y-0 sm:scale-100" leave="ease-in duration-200" leave-from="opacity-100 translate-y-0 sm:scale-100" leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
          <div class="w-7/12 relative inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all my-8 sm:align-middle">
            <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
              <div class="sm:items-start">
                <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                  <DialogTitle as="h3" class="text-lg leading-6 font-medium text-gray-900"> New Visit Note </DialogTitle>
                  <div class="mt-2">
                  	<form class="space-y-4">
							      	<div>
							          <label class="block mb-1 text-sm font-medium text-gray-900 ">Title</label>
							          <input
							          	v-model="newVisitNote.title" 
							            type="text" 
							            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-gray-500 focus:border-gray-500 block w-full p-2.5 "
							          />
							        </div>
										  <Listbox as="div" v-model="selected">
										    <ListboxLabel class="block mb-1 text-sm font-medium text-gray-900"> Patient </ListboxLabel>
										    <div class="mt-1 relative">
										      <ListboxButton class="relative w-full bg-white border border-gray-300 rounded-md shadow-sm p-2.5 text-left cursor-default focus:outline-none focus:ring-1 focus:ring-gray-500 focus:border-gray-500 sm:text-sm">
										        <span class="flex items-center">
										          <span class="ml-3 block truncate">{{ selected.first_name +" "+ selected.last_name}}</span>
										        </span>
										        <span class="ml-3 absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
										          <SelectorIcon class="h-5 w-5 text-gray-400" aria-hidden="true" />
										        </span>
										      </ListboxButton>

										      <transition leave-active-class="transition ease-in duration-100" leave-from-class="opacity-100" leave-to-class="opacity-0">
										        <ListboxOptions class="absolute z-10 mt-1 w-full bg-white shadow-lg max-h-56 rounded-md py-1 text-base ring-1 ring-black ring-opacity-5 overflow-auto focus:outline-none sm:text-sm">
										          <ListboxOption as="template" v-for="patient in patients" :key="patient.id" :value="patient" v-slot="{ active, selected }">
										            <li :class="[active ? 'text-white bg-gray-600' : 'text-gray-900', 'cursor-default select-none relative py-2 pl-3 pr-9']">
										              <div class="flex items-center">
										                <span :class="[selected ? 'font-semibold' : 'font-normal', 'ml-3 block truncate']">
										                  {{ patient.first_name + " "+ patient.last_name}}
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
							        <div>
							          <label class="block mb-1 text-sm font-medium text-gray-900 ">Description</label>
							          <Editor
		                      apiKey="o1gp0nstsr6djvureuc3n7o2hljy5tn4cm0gsepgacxkm583"
		                      v-model="newVisitNote.description"
		                      :init="{
		                        height: 200,
		                        menubar: false,
		                        plugins: [
		                          'advlist autolink lists link image charmap print preview anchor',
		                          'searchreplace visualblocks code fullscreen',
		                          'insertdatetime media table paste code help wordcount'
		                        ],
		                        toolbar:
		                          'undo redo | formatselect | bold italic backcolor | \
		                          alignleft aligncenter alignright alignjustify | \
		                          bullist numlist outdent indent | removeformat | help'
		                      }"
		                    />
							        </div>
							        <NoteObservation
							        	:noteObservation = "newVisitNote.observations" 
							        	:key = "newVisitNote.id"
							        />
						        	<button 
						        		@click="addEmptyNoteObservation()"
						        		type="button"
												class="text-white flex items-center text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center"
											>
											<PlusIcon class="h-3 w-3"/>
												Add note
											</button>
							      </form>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
              <button type="button" class="mx-2 text-white text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center" 
              	@click="addVisitNote()"
              >
            		Add
            	</button>
              <button type="button" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm" 
              	@click="openNewModal = false" 
              	ref="cancelButtonRef"
              >
            		Cancel
            	</button>
            </div>
          </div>
        </TransitionChild>
      </div>
    </Dialog>
  </TransitionRoot>

  <!--Edit visit note modal-->
  <TransitionRoot as="template" :show="openEditModal">
    <Dialog as="div" class="fixed z-10 inset-0 overflow-y-auto">
      <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0" enter-to="opacity-100" leave="ease-in duration-200" leave-from="opacity-100" leave-to="opacity-0">
          <DialogOverlay class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" />
        </TransitionChild>

        <!-- This element is to trick the browser into centering the modal contents. -->
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
        <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" enter-to="opacity-100 translate-y-0 sm:scale-100" leave="ease-in duration-200" leave-from="opacity-100 translate-y-0 sm:scale-100" leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
          <div class="w-7/12 relative inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all my-8 sm:align-middle">
            <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
              <div class="sm:items-start">
                <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                  <DialogTitle as="h3" class="text-lg leading-6 font-medium text-gray-900"> New Visit Note </DialogTitle>
                  <div class="mt-2">
                  	<form class="space-y-4">
							      	<div>
							          <label class="block mb-1 text-sm font-medium text-gray-900 ">Title</label>
							          <input
							          	v-model="editVisitNote.title" 
							            type="text" 
							            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-gray-500 focus:border-gray-500 block w-full p-2.5 "
							          />
							        </div>
							        <div>
							          <label class="block mb-1 text-sm font-medium text-gray-900 ">Description</label>
							          <Editor
		                      apiKey="o1gp0nstsr6djvureuc3n7o2hljy5tn4cm0gsepgacxkm583"
		                      v-model="editVisitNote.description"
		                      :init="{
		                        height: 200,
		                        menubar: false,
		                        plugins: [
		                          'advlist autolink lists link image charmap print preview anchor',
		                          'searchreplace visualblocks code fullscreen',
		                          'insertdatetime media table paste code help wordcount'
		                        ],
		                        toolbar:
		                          'undo redo | formatselect | bold italic backcolor | \
		                          alignleft aligncenter alignright alignjustify | \
		                          bullist numlist outdent indent | removeformat | help'
		                      }"
		                    />
							        </div>
							      	 <NoteObservation
							        	:noteObservation = "editVisitNote.observations" 
							        	:key = "editVisitNote.id"
							        />
							      </form>
                  </div>
                </div>
              </div>
            </div>
            <div class="mt-14 bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
              <button type="button" class="mx-2 text-white text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center" 
              	@click="updateVisitNote()"
              >
            		Update
            	</button>
              <button type="button" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm" 
              	@click="openEditModal = false" 
              	ref="cancelButtonRef"
              >
            		Cancel
            	</button>
            </div>
          </div>
        </TransitionChild>
      </div>
    </Dialog>
  </TransitionRoot>

  <!--Delete visit note modal -->
  <TransitionRoot as="template" :show="openDeleteModal">
    <Dialog as="div" class="fixed z-10 inset-0 overflow-y-auto" @close="openDeleteModal = false">
      <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
        <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0" enter-to="opacity-100" leave="ease-in duration-200" leave-from="opacity-100" leave-to="opacity-0">
          <DialogOverlay class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" />
        </TransitionChild>

        <!-- This element is to trick the browser into centering the modal contents. -->
        <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
        <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" enter-to="opacity-100 translate-y-0 sm:scale-100" leave="ease-in duration-200" leave-from="opacity-100 translate-y-0 sm:scale-100" leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
          <div class="relative inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
            <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
              <div class="sm:items-start">
                <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                  <DialogTitle as="h3" class="text-lg leading-6 font-medium text-gray-900"> Delete Visit Note </DialogTitle>
                  <div class="mt-2">
                    <p class="text-sm text-gray-500">Are you sure you want to delete this visit note?</p>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
              <button 
              	type="button" 
              	class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-green-600 text-base font-medium text-white hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 sm:ml-3 sm:w-auto sm:text-sm" 
              	@click="deleteVisitNote()"
              >
            		Yes
            	</button>
              <button 
              	type="button" 
              	class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm" @click="openDeleteModal = false" ref="cancelButtonRef"
              >
            		Cancel
            	</button>
            </div>
          </div>
        </TransitionChild>
      </div>
    </Dialog>
  </TransitionRoot>

</template>

<script>
	import axios from "axios";
	import { PlusIcon, TrashIcon, PencilAltIcon, CheckIcon, SelectorIcon } from '@heroicons/vue/solid'
	import { ref } from 'vue'
	import { 
		Dialog, 
		DialogOverlay, 
		DialogTitle, 
		TransitionChild, 
		TransitionRoot,
		Listbox, 
		ListboxButton, 
		ListboxLabel, 
		ListboxOption, 
		ListboxOptions 
	} from '@headlessui/vue'
	import Editor from '@tinymce/tinymce-vue'
	import NoteObservation from './note_observation.vue'

	export default {
		components: {
			TrashIcon,
			PencilAltIcon,
			Dialog,
	    DialogOverlay,
	    DialogTitle,
	    TransitionChild,
	    TransitionRoot,
	    Editor,
	    Listbox,
	    ListboxButton,
	    ListboxLabel,
	    ListboxOption,
	    ListboxOptions,
	    CheckIcon,
	    SelectorIcon,
	    PlusIcon,
	    NoteObservation,
		},

		setup() {
			const openNewModal = ref(false)
	    const openEditModal = ref(false)
	    const openDeleteModal = ref(false)

	    return {
	    	openNewModal,
	      openEditModal,
	      openDeleteModal,
	    }
  	},

		data: function () {
	    return {
	    	visitNotes : [],
	    	newVisitNote: {
      		title: '',
        	description: '',
        	patient_id: '',
        	observations: [{ title: '', body: '', result: 'NA',}]	
      	},
      	editVisitNote: {
      		title: '',
        	description: '',
        	observations: [{ title: '', body: '', result: 'NA',}]
      	},
      	deleteVisitNoteIndex: -1,
      	patients: [],
      	selected: '',
	    }
	  },

	  created() {
    	this.initialize();
    	axios
        .get("/patients")
        .then(response => {
          console.log(response.data);
          this.patients = response.data;
          this.selected = this.patients[0]
        })
        .catch(e => {
          console.log(e);
        });
  	},

    methods: {
    	initialize() {
	      return axios
	        .get("/visit_notes")
	        .then(response => {
	          console.log(response.data);
	          this.visitNotes = response.data;
	        })
	        .catch(e => {
	          console.log(e);
	        });
	    },

	    addVisitNote(){
	    	this.newVisitNote.patient_id = this.selected.id;
	    	axios.post("/visit_notes", this.newVisitNote)
			    .then(response => {
			    	this.newVisitNote.title = '';
			    	this.newVisitNote.description = '';
			      this.$toast.success("Succesfully add visit note.", {
				    	position: 'top-right'
						});
						console.log(response.data)
						this.visitNotes.unshift(response.data);
						this.initialize();
			    	this.openNewModal = false;
			    	this.newVisitNote.observations = [{ title: '', body: '', result: ''}];	
			    })
			    .catch(error => {
			      
			    });
	    },

	    updateVisitNote(){
	    	console.log("hello")
    		axios
          .put(`/visit_notes/${this.editVisitNote.id}`, this.editVisitNote)
          .then(response => {
	        	this.$toast.success("Succesfully update the visit note.", {
				    	position: 'top-right'
						});
	          console.log(response);
	          this.initialize();
	          this.openEditModal = false;
          })
          .catch(error => {
           console.log(error);
        });
    	},

    	deleteVisitNote() {
	      const index = this.visitNotes.indexOf(this.deleteVisitNoteIndex);

	      axios
	        .delete(`/visit_notes/${this.deleteVisitNoteIndex}`)
	        .then(response => {
	          this.$toast.success(response.data.message, {
				    	position: 'top-right'
						});
						this.initialize();
						this.openDeleteModal = false;
	        })
	        .catch(error => {
	          console.log(error);
	        });
	        this.visitNotes.splice(index, 1);
    	},

	    newModal(){
	    	this.openNewModal = true;
	    },

	    editModal(visitNote) {
    		this.openEditModal = true;
	      this.editVisitNote = Object.assign({}, visitNote);
    	},

    	deleteModal(visitNote) {
    		this.openDeleteModal = true;
    		this.deleteVisitNoteIndex = visitNote.id;
    	},

    	addEmptyNoteObservation(){
    		this.newVisitNote.observations.push({title: '',body: '',result: 'NA',})
    	},
	  }
	}
</script>

<style type="text/css">
	.tox-notifications-container {display: none !important;}
</style>