import create from 'zustand';

export interface Assist {
  id: number;
  name: string;
  description: string;
  status: "accepted" | "taken" | "open",
  player: {
    name: string;
    id: string;
  },
  acceptedBy: {
    name: string;
    id: number
  }
}

export const useAssists = create<{ assists: Assist[]; setAssists: (value: Assist[]) => void }>((set) => ({
  assists: [],
  setAssists: (assists: Assist[]) => set({ assists }),
}));
