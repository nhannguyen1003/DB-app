import { configureStore } from "@reduxjs/toolkit";
import SiderStateSlice from "./features/sider";

export const store = configureStore({
  reducer: {
    siderState: SiderStateSlice
  }
});

export type RootState = ReturnType<typeof store.getState>;