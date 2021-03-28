import { authsFeatureKey, AuthState, authReducer } from "src/app/pages/register/store/auth.reducer";
import { SharedReducer, SHARED_STATE_KEY } from "./shared/shared.reducer";
import { SharedState } from "./shared/shared.state";

export interface AppState {
    [authsFeatureKey]: AuthState;
    [SHARED_STATE_KEY]: SharedState
}

export const appReducer = {
    [authsFeatureKey]: authReducer,
    [SHARED_STATE_KEY]: SharedReducer
};