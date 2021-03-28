import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Store } from '@ngrx/store';
import { ToastrService } from 'ngx-toastr';
import { ImageSnippet } from 'src/app/@theme/model/image-snippet';
import { EventState } from '../../store/event.reducer';

@Component({
  selector: 'app-add-event',
  templateUrl: './add-event.component.html',
  styleUrls: ['./add-event.component.scss']
})
export class AddEventComponent implements OnInit {

  isSubmited = false;
  addEventForm: FormGroup;
  uploadButtonValue = 'Upload';
  coverUploadButtonValue = 'Upload';
  imageName = 'Select Image';
  fileSelected = false;
  fileUploaded = false;
  imageUrl: string;
  imagePathReady = false;
  submitButtonValue = 'Waiting Uploading Image';
  selectedFile: ImageSnippet;

  constructor(private store: Store<EventState>,
              private toaster: ToastrService) {
  }

  ngOnInit() {
    // Fetch Form Data
    this.addEventForm = new FormGroup({
      name: new FormControl(''),
      description: new FormControl(''),
      location: new FormControl(''),
      status: new FormControl(''),
      type: new FormControl(''),
    });

  }

  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  processFile(imageInput: any) {
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      // this.categoryService.uploadImage(this.selectedFile.file).subscribe(
      //   (res) => {
      //     console.log(res);
      //     this.imageUrl = res;
      //     this.uploadButtonValue = 'Uploaded';
      //     this.imagePathReady = true;
      //     this.submitButtonValue = 'New Category';
      //   },
      //   (err) => {
      //     console.log(err);
      //   });
    });
    reader.readAsDataURL(file);
  }



  onSubmit() {
    this.isSubmited = true;
    if (!this.addEventForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      this.isSubmited = false;
      return false;
    }
    // Fetch All Form Data On Json Type
    const formObject = this.addEventForm.getRawValue();
    console.log(formObject);
    // this.store.dispatch(addRegion({region: formObject}));    
  }


}
