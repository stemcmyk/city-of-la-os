import create, { GetState, SetState } from 'zustand';
import { Assist } from './doors';

export type StringField = string | null | undefined;
export type NumberField = number | null | undefined;

interface StateSetters {
  sounds: string[];
  setSounds: (value: string[]) => void;
}

export const useStore = create<Assist>(() => ({
  name: '',
  description: "",
  player: {
    id: "",
    name: ""
  },
  acceptedBy: {
    name: "",
    id: 0,
  },
  status: "open",
  id: 0
}));


export const defaultState = useStore.getState();

export const useSetters = create<StateSetters>((set: SetState<StateSetters>, get: GetState<StateSetters>) => ({
  sounds: [''],
  setSounds: (value) => set({ sounds: value }),
}));
