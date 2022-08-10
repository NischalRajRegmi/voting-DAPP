async function get_account() {
  if (typeof window.ethereum !== 'undefined') {
    const addr = await window.ethereum.request({method: 'eth_requestAccounts'});
    return addr[0];
  }
  else {alert("please install metamask")};
}

export {
  get_account
}