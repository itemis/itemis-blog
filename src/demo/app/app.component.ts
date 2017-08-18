import { Component } from '@angular/core';
import { LibService } from '@itemis/demo-angular-lib';

@Component({
  selector: 'demo-app',
  templateUrl: './app.component.html'
})
export class AppComponent {
  meaning: number;
  constructor(libService: LibService) {
    this.meaning = libService.getMeaning();
  }
}
