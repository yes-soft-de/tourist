import { createReducer, on } from "@ngrx/store";
import { setLoadSpinner } from "./shared.actions";
import { initialState } from "./shared.state";

export const SHARED_STATE_KEY = 'shared';

const _sharedReducer = createReducer(
    initialState,
    on(setLoadSpinner, (state, action) => {
        return {
            ...state,
            showLoading: action.status
        }
    })
);

export function SharedReducer(state, action) {
    return _sharedReducer(state, action);
}