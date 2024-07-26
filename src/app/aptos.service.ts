import { Injectable } from '@angular/core';
import { AptosClient, AptosAccount, FaucetClient } from 'aptos';

@Injectable({
  providedIn: 'root'
})
export class AptosService {
  private client: AptosClient;
  private faucetClient: FaucetClient;

  constructor() {
    const nodeUrl = 'https://fullnode.devnet.aptoslabs.com/v1';
    const faucetUrl = 'https://faucet.devnet.aptoslabs.com';
    this.client = new AptosClient(nodeUrl);
    this.faucetClient = new FaucetClient(nodeUrl, faucetUrl);
  }

  async createAccount() {
    const account = new AptosAccount();
    await this.faucetClient.fundAccount(account.address(), 1000000);
    return account;
  }

  async deploySmartContract(account: AptosAccount, email: string, cin: string) {
    const payload = {
      type: 'entry_function_payload',
      function: `${account.address()}::MyModule::create_identity`,
      type_arguments: [],
      arguments: [email, cin]
    };

    const txnRequest = await this.client.generateTransaction(account.address(), payload);
    const signedTxn = await this.client.signTransaction(account, txnRequest);
    const transaction = await this.client.submitTransaction(signedTxn);

    await this.client.waitForTransaction(transaction.hash);
    return transaction.hash;
  }


  async verifyIdentity(account: AptosAccount, email: string, cin: string): Promise<any> {
    const payload = {
      type: 'entry_function_payload',
      function: `${account.address()}::MyModule::verify_identity`,
      type_arguments: [],
      arguments: [email, cin]
    };

    const txnRequest = await this.client.generateTransaction(account.address(), payload);
    const signedTxn = await this.client.signTransaction(account, txnRequest);
    const transaction = await this.client.submitTransaction(signedTxn);

    await this.client.waitForTransaction(transaction.hash);

    const result = await this.client.getTransactionByHash(transaction.hash);
    return result;
  }
}
