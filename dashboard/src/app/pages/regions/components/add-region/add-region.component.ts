import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { ImageSnippet } from 'src/app/@theme/model/image-snippet';
import { RegionsService } from '../../services/regions.service';

@Component({
  selector: 'app-add-region',
  templateUrl: './add-region.component.html',
  styleUrls: ['./add-region.component.scss']
})
export class AddRegionComponent implements OnInit {

  isSubmited = false;
  addRegionForm: FormGroup;
  uploadButtonValue = 'Upload';
  coverUploadButtonValue = 'Upload';
  imageName = 'Select Image';
  fileSelected = false;
  fileUploaded = false;
  imageUrl: string;
  imagePathReady = false;
  submitButtonValue = 'Waiting Uploading Image';
  selectedFile: ImageSnippet;

  constructor(private formBuilder: FormBuilder,
              private regionService: RegionsService,
              private toaster: ToastrService,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {
    // Fetch Form Data
    this.addRegionForm = new FormGroup({
      name: new FormControl(''),
      description: new FormControl(''),
      location: new FormControl(''),
      path: new FormControl(''),
      placeId: new FormControl(''),
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
    console.log(this.addRegionForm.getRawValue());
    this.regionService.createRegion(this.addRegionForm.getRawValue()).subscribe(
      data => console.log('data : ', data),
      error => console.log('error : ', error));
    // this.isSubmitted = true;

    // if (!this.addRegionForm.valid) {
    //   this.toaster.error('Error : Form Not Valid');
    //   this.isSubmitted = false;
    //   return false;
    // } else {
    //   // Fetch All Form Data On Json Type
    //   const formObject = this.addRegionForm.getRawValue();
    //   formObject.titleShow = formObject.titleShow == 0 ? false : true;
    //   formObject.createdBy = this.tokenService.userName;
    //   formObject.image = this.imageUrl;
    //   formObject.coverImage = this.coverImageUrl;
    //   this.categoryService.createCategory(formObject).subscribe(
    //     (createResponse: any) => console.log(createResponse),
    //     error => {
    //       this.isSubmitted = false;
    //       console.log('Error : ', error);
    //     },
    //     () => {
    //       this.isSubmitted = false;
    //       this.router.navigate(['../'], {relativeTo: this.activatedRoute});
    //     }
    //   );
    // }
  }


}
