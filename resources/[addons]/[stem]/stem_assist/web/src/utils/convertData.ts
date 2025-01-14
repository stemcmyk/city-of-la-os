import { Assist } from '../store/doors';

// Converts groups data into array format
export const convertData = (data: Assist) => {
  return {
    ...data,
  };
};
