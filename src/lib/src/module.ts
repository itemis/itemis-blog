import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';

import { LibComponent } from './component/lib.component';
import { LibService } from './service/lib.service';

@NgModule({
  declarations: [LibComponent],
  providers: [LibService],
  imports: [HttpModule],
  exports: [LibComponent]
})
export class LibModule { }
