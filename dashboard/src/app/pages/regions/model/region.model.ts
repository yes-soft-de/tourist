export interface Region {
  id?: number;
  name?: string;
  description?: string;
  location?:  string;
  commentNumber?: number;
  ratingAverage?: number;
  path?: [
      {
          path:  string;
          pathURL:  string;
          baseURL:  string;
      }
  ],
  placeId?: string;
}
