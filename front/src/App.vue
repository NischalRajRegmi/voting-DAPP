<template>
<div class="app-main container relative">

  <!-- notifications -->
  <notifications position="top right" classes="bg-green-700 text-white p-5 rounded"/>

  <!-- <Header />  -->
  <div class="app-body">
    <router-view>
    </router-view> 
  </div>

  <div class="absolute text-green-700 bottom-5 right-1">
    Developed by - Nischal Regmi
  </div>
</div>
</template>

<script setup>
  import Header from "./components/Header.vue";
  import {onMounted} from "vue";

  import Web3 from "web3";
  import contract_json from "@/assets/contracts/Voting.json";

  import { state } from "@/store";

  onMounted(() => {
    if (typeof window.ethereum !== 'undefined') {
      console.log('MetaMask is installed!');
    //   // state.account = await window.ethereum.request({ method: 'eth_requestAccounts' })[0];
    //   // const user_addr = await window.ethereum.request({ method: 'eth_requestAccounts' });
    //   // state.account = user_addr[0];
    //   // while(state.account == null) {}
    //   // console.log(state.account);
    //   window.ethereum.request({method: 'eth_requestAccounts'})
    //   .then(res => {
    //     state.account = res[0];
    //   })
    //   .catch(err => {
    //     notify("Cannot load account!");
    //   })

      const web3 = new Web3("http://localhost:7545");

      // console.log(contract_json);
      state.contract = new web3.eth.Contract(contract_json.abi, state.contract_address);
      // const all_accounts = await web3.eth.getAccounts();
      // state.admin = all_accounts[0];
      // state.account = all_accounts[5];

      // console.log(contract);
      // state.contract.methods.insert_candidate("Saurav", "Independent").send({from: state.account, gas: 1000000});
      // .on("receipt", (receipt) => {
      //     console.log(receipt);
      // })
      // console.log(await state.contract.methods.candidate_count().call({from: state.account}));
    }
    else {
      alert("Please install MetaMask to use this app");
    }


  })


</script>

<style scoped>

</style>
