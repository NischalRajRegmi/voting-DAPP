<template>
  <div>
  <Header title="Check Live Results" />
  
  <div class="result-main flex flex-col body-container px-20 items-center">
    <div class="candidates mt-5">
      <h2 class="text-green-700 text-2xl flex items-center mb-2">
        Registered candidates
        <span class="total-candidates bg-gray-400 text-white text-sm rounded p-1 ml-2">{{all_candidates.length}}</span>
      </h2>
      <table class="table-auto">
        <thead>
          <tr class="text-xl text-green-700">
            <th>Rank</th>
            <th>Name</th>
            <th>Party</th>
            <th>Votes</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(each, index) in all_candidates" :key="each.id" class="text-gray-600 text-lg">
            <td>{{index+1}}</td>
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
    import {get_account} from "@/extras";
    import {state} from "@/store";

    const all_candidates = ref([]);


    async function get_all_candidates() {
        const account = await get_account();
        var candidates = [];

        state.contract.methods.candidate_count().call({from: account})
        .then(len => {
        for (let i = 0; i < len; i++) {
            state.contract.methods.get_candidate(i).call({from: account})
            .then(res => {
                candidates.push({id: i, name: res[0], party: res[1], votes: res[2]});

                if (i == len-1) sort_candidates(candidates);
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

    function sort_candidates(candidates) {

        for( let i = 0; i<candidates.length - 1; i++) {
            for (let j = 0; j<candidates.length - 1; j++) {
                if(candidates[j].votes < candidates[j+1].votes) {
                    let temp = candidates[j];
                    candidates[j] = candidates[j+1];
                    candidates[j+1] = temp;
                }
            }
        }

        all_candidates.value = candidates;
    }

    onMounted(() => {
        get_all_candidates();
    })
</script>
