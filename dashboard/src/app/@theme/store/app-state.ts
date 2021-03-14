import { authsFeatureKey, AuthState, authReducer } from "src/app/pages/register/store/auth.reducer";

export interface AppState {
    [authsFeatureKey]: AuthState
}

export const appReducer = {
    [authsFeatureKey]: authReducer
};