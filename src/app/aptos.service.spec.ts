import { TestBed } from '@angular/core/testing';

import { AptosService } from './aptos.service';

describe('AptosService', () => {
  let service: AptosService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AptosService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
