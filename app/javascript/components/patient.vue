<template>  
  <div class="mx-auto container px-60 m-6">
  	<div class="flex justify-end">
			<button 
	    	class="text-white text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center" 
	    	@click="newModal()">
	      Add Patient
	    </button>
		</div>
  	<h2 class="flex text-2xl font-medium text-gray-700">Patients List</h2>
		<div class="mt-2 shadow-md rounded-lg border border-gray-200">
			<div class="p-4">
				<table class="w-full text-sm text-left text-gray-500">
					<thead class="text-xs text-gray-700 uppercase bg-gray-200">
						<tr>
							<th scope="col" class="px-6 py-3">
								Id
							</th>
							<th scope="col" class="px-6 py-3">
								First Name
							</th>
							<th scope="col" class="px-6 py-3">
								Last Name
							</th>
							<th scope="col" class="px-6 py-3">
								Actions
							</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="patient in patients" :key="patient.id">
							<td class="px-6 py-4">{{ patient.id }}</td>
							<td class="px-6 py-4">{{ patient.first_name }}</td>
							<td class="px-6 py-4">{{ patient.last_name }}</td>
							<td class="flex px-6 py-4">
								<button 
									@click="editModal(patient)"
									class="mx-1 bg-green-500 hover:bg-green-800 text-white font-bold py-1 px-1 rounded inline-flex items-center"
								>
								  <PencilAltIcon class="h-5 w-5"/>
								</button>
								<button 
									@click="deleteModal(patient)"
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

	<!--New patient modal -->
	<TransitionRoot as="template" :show="openNewModal">
    <Dialog as="div" class="fixed z-10 inset-0 overflow-y-auto" @close="openNewModal = false">
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
                  <DialogTitle as="h3" class="text-lg leading-6 font-medium text-gray-900"> Create new Patient </DialogTitle>
                  <div class="mt-2">
                    <form class="space-y-4">
							      	<div>
							          <label class="block mb-1 text-sm font-medium text-gray-900 ">First Name</label>
							          <input
							          	v-model="newPatient.first_name" 
							            type="text" 
							            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-gray-500 focus:border-gray-500 block w-full p-2.5 "
							          />
							        </div>
							         <div>
							          <label class="block mb-1 text-sm font-medium text-gray-900 ">Last Name</label>
							          <input 
							          	v-model="newPatient.last_name"
							            type="text" 
							            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-gray-500 focus:border-gray-500 block w-full p-2.5 "
							          />
							        </div>
							      </form>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
              <button type="button" class="mx-2 text-white text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center" 
              	@click="addPatient()"
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

	<!--Edit patient modal -->
	<TransitionRoot as="template" :show="openEditModal">
    <Dialog as="div" class="fixed z-10 inset-0 overflow-y-auto" @close="openEditModal = false">
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
                  <DialogTitle as="h3" class="text-lg leading-6 font-medium text-gray-900"> Update Patient </DialogTitle>
                  <div class="mt-2">
                    <form class="space-y-4">
							      	<div>
							          <label class="block mb-1 text-sm font-medium text-gray-900 ">First Name</label>
							          <input
							          	v-model="editedPatient.first_name" 
							            type="text" 
							            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-gray-500 focus:border-gray-500 block w-full p-2.5 "
							          />
							        </div>
							         <div>
							          <label class="block mb-1 text-sm font-medium text-gray-900 ">Last Name</label>
							          <input 
							          	v-model="editedPatient.last_name"
							            type="text" 
							            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-md focus:ring-gray-500 focus:border-gray-500 block w-full p-2.5 "
							          />
							        </div>
							      </form>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
              <button type="button" class="mx-2 text-white text-white bg-gray-700 hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center" 
              	@click="editPatient()"
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

  <!--Delete patient modal -->
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
                  <DialogTitle as="h3" class="text-lg leading-6 font-medium text-gray-900"> Delete Patient </DialogTitle>
                  <div class="mt-2">
                    <p class="text-sm text-gray-500">Are you sure you want to delete this patient?</p>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
              <button 
              	type="button" 
              	class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-green-600 text-base font-medium text-white hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 sm:ml-3 sm:w-auto sm:text-sm" 
              	@click="deletePatient()"
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
	import { TrashIcon,PencilAltIcon } from '@heroicons/vue/solid'
	import { ref } from 'vue'
	import { Dialog, DialogOverlay, DialogTitle, TransitionChild, TransitionRoot } from '@headlessui/vue'

	export default {
		components: {
			TrashIcon,
			PencilAltIcon,
			Dialog,
	    DialogOverlay,
	    DialogTitle,
	    TransitionChild,
	    TransitionRoot,
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
      	patients : [],
      	newPatient: {
      		first_name: '',
        	last_name: '',	
      	},
      	editedPatient: {
      		first_name: '',
        	last_name: '',	
      	},
      	deletePatientIndex : -1,
      }
    },

    created() {
    	this.initialize();
  	},

    methods: {

    	initialize() {
	      return axios
	        .get("/patients")
	        .then(response => {
	          console.log(response.data);
	          this.patients = response.data;
	        })
	        .catch(e => {
	          console.log(e);
	        });
	    },

    	addPatient() {
    		 axios.post("/patients", this.newPatient)
			    .then(response => {
			    	this.newPatient.last_name = '';
			    	this.newPatient.first_name = '';
			      this.$toast.success("Succesfully add the patient.", {
				    	position: 'top-right'
						});
						this.patients.unshift(response.data);
						this.initialize();
			    	console.log(response.data);
			    	this.openNewModal = false
			    })
			    .catch(error => {
			      
			    });
    	},

    	editPatient(){
    		axios
          .put(`/patients/${this.editedPatient.id}`, {
            patient: this.editedPatient
          })
          .then(response => {
	        	this.$toast.success("Succesfully update the patient.", {
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

    	deletePatient() {
	      const index = this.patients.indexOf(this.deletePatientIndex);

	      axios
	        .delete(`/patients/${this.deletePatientIndex}`)
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
	        this.patients.splice(index, 1);
    	},

    	newModal(){
	    	this.openNewModal = true;
	    },

    	editModal(patient) {
    		this.openEditModal = true;
	      this.editedPatient = Object.assign({}, patient);
    	},

    	deleteModal(patient) {
    		this.openDeleteModal = true;
    		this.deletePatientIndex = patient.id;
    	}
    }
  }
</script>
