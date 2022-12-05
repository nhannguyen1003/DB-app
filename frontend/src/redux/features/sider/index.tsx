import { createSlice, PayloadAction } from "@reduxjs/toolkit";

type SiderState = {
  siderState: string;
};

const initialState: SiderState = {
  siderState: "/",
};

export const SiderStateSlice = createSlice({
  name: "SiderState",
  initialState,
  reducers: {
    setSiderState: (state, action: PayloadAction<string>) => {
      state.siderState = action.payload;
    },
  },
});

export const { setSiderState } = SiderStateSlice.actions;

export default SiderStateSlice.reducer;
