import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { TokenService } from 'src/app/@theme/admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { RegionDetailsResponse } from '../model/region-details.response';
import { RegionsResponse } from '../model/region-response.model';

@Injectable({
  providedIn: 'root'
})
export class RegionsService {

  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }

  // All Regions
  getAllRegions(): Observable<RegionsResponse> {
    return this.httpClient.get<RegionsResponse>(
      AdminConfig.regionsAPI,
      this.tokenService.httpOptions()
    );
  }

  // Get Region Details
  getRegion(regionId: number): Observable<RegionDetailsResponse> {
    return this.httpClient.delete<RegionDetailsResponse>(
      `${AdminConfig.regionAPI}/${regionId}`,
      this.tokenService.httpOptions()
    );
  }

  // Create New Regions
  createRegion(data): Observable<any> {
    return this.httpClient.post<any>(
      AdminConfig.regionAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    );
  }

  // Update Exists Region
  updateRegion(regionId: number, data): Observable<any> {
    return this.httpClient.put<any>(
      `${AdminConfig.regionAPI}/${regionId}`,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    );
  }

  // Delete Region
  deleteRegion(regionId: number): Observable<any> {
    return this.httpClient.delete<any>(
      `${AdminConfig.regionAPI}/${regionId}`,
      this.tokenService.httpOptions()
    );
  }

}
