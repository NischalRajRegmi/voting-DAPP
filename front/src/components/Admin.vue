<template>
<div>
  <Header title="Admin Dashboard" />
  <div class="admin-main flex flex-col body-container px-20 justify-center">
    <div class="add-candidates">
      <h2 class="text-green-700 text-2xl">
        Add candidate
      </h2>
      <div class="flex gap-2 mt-2">
        <input v-model="name" class="border-2 border-green-700 rounded p-2" placeholder="Candidate's name" type="text">
        <input v-model="party" class="border-2 border-green-700 rounded p-2" placeholder="Candidate's party" type="text">
      </div>
      <button @click="candidate_inserted" class="mt-2 bg-green-700 text-white p-3 rounded">Insert</button>
    </div> 
    <div class="change-admin mt-5">
      <h2 class="text-green-700 text-2xl">
        Change admin
      </h2>
      <div class="flex mt-2">
        <input v-model="new_admin" class="border-2 border-green-700 rounded p-2 w-full" placeholder="New admin address" type="text">
      </div>
      <button @click="change_admin" class="mt-2 bg-green-700 text-white p-3 rounded">Change</button>
    </div>
    <div class="remove-candidate mt-5">
      <h2 class="text-green-700 text-2xl">
        Remove candidate
      </h2>
      <div class="flex mt-2">
        <input v-model="candidate_id" class="border-2 border-green-700 rounded p-2 w-full" placeholder="Candidate S.N." type="text">
      </div>
      <button @click="remove_candidate" class="mt-2 bg-green-700 text-white p-3 rounded">Remove</button>
    </div>
    <div class="candidates mt-5">
      <h2 class="text-green-700 text-2xl flex items-center mb-2">
        Registered candidates
        <span class="total-candidates bg-gray-400 text-white text-sm rounded p-1 ml-2">{{ all_candidates.length }}</span>
      </h2>
      <table class="table-auto">
        <thead>
          <tr class="text-xl text-green-700">
            <th>S.N.</th>
            <th>Name</th>
            <th>Party</th>
            <th>Votes</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="each in all_candidates" :key="each.id" class="text-gray-600 text-lg">
            <td>{{each.id}}</td>
            <td>{{each.name}}</td>
            <td>{{each.party}}</td>
            <td>{{each.votes}}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  </div>
</template>

<script setup>
  import Header from "@/components/Header.vue";
  import { notify } from "@kyvg/vue3-notification";
  import {ref, onMounted} from "vue";

  import {state} from "@/store";
  import {get_account} from "@/extras";

  const name = ref('');
  const party = ref('');
  const candidate_id = ref('');
  const new_admin = ref('');

  const all_candidates = ref([]);

  async function change_admin() {
    if(new_admin.value != "") {
      const account = await get_account();
      state.contract.methods.change_admin(new_admin.value).send({from: account})
      .then(res => {
        notify({
          title: 'Success',
          text: 'Admin changed successfully'
        });
      })
      .catch(err => {
        notify({
          title: 'Error',
          text: err.message
        });
      })
    }
    else notify("Enter address");
  }

  async function remove_candidate() {
    const account = await get_account();
    state.contract.methods.remove_candidate(candidate_id.value).send({from: account})
    .then((receipt) => {
      notify({
        title: 'Success',
        text : 'Candidate removed successfully',
      });
      setTimeout(() => {
        window.location.reload();
      }, 1000);
    })
    .catch((error) => {
      notify({
        title: 'Error',
        text : error.message,
      });
    })
  }

  async function candidate_inserted() {
    if(name.value == '' || party.value == '') {
      notify({
        title : 'Error!',
        text : 'Please fill all the fields'
      });
    } else {
      const account = await get_account();
      state.contract.methods.insert_candidate(name.value, party.value).send({from: account, gas: 3000000})
      .then(res => {
        notify("Candidate inserted successfully");
        setTimeout(() => {
          window.location.reload();
        }, 1000);
        reset_fields(); 
      })
      .catch(err => {
        notify({
          title : 'Error!',
          text : err.message
        });
      }) 
    }
  }

  async function get_all_candidates() {
    const account = await get_account();
    state.contract.methods.candidate_count().call({from: account})
    .then(res => {
      for (let i = 0; i < res; i++) {
        state.contract.methods.get_candidate(i).call({from: account})
        .then(res => {
          all_candidates.value.push({id: i, name: res[0], party: res[1], votes: res[2]});
        })
        .catch(err => {
          notify({
            title : 'Error!',
            text : err.message
          });
        })
      }
    })
    .catch(err => {
      notify({
        title : 'Error!',
        text : err.message
      });
    })
  }

  function reset_fields() {
    name.value = '';
    party.value = '';
  }

  onMounted(() => {
    get_all_candidates();
  })
</script>

<style scoped>
</style>