import { Component } from '@angular/core';
import { AptosService } from './aptos.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
 

  constructor(private aptosService: AptosService) { }

  email = '';
  cin = '';
  verifyResult: boolean | null = null;


  async createIdentity() {
    const account = await this.aptosService.createAccount();
    const txHash = await this.aptosService.deploySmartContract(account, this.email, this.cin);
    console.log('Transaction Hash:', txHash);
  }

  async verifyIdentity() {
    const account = await this.aptosService.createAccount();
    this.verifyResult = await this.aptosService.verifyIdentity(account, this.email, this.cin);
    console.log('Verify Result:', this.verifyResult);
  }
}