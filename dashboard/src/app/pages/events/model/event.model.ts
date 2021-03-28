export interface Events {
  id: number;
  name: string;
  commentNumber: number;
  comments: [];
  date: { timestamp: number };
  description: string;
  images: [];
  location: string;
  status: string;
  subType: string;
  type: string;
}
