import { createAsyncThunk, createEntityAdapter, createSlice } from "@reduxjs/toolkit";
import axios from "axios"

const battlesAdapter = createEntityAdapter()

const initialState = battlesAdapter.getInitialState({
  loadingBattlesError: null,
  creatingBattleStatus: "idle",
  creatingBattleError: null
})

/**
 * Fetch all active battles
 * TODO Ruleset
 */
export const fetchActiveBattles = createAsyncThunk(
  "lobby/fetchActiveBattles",
  async () => {
    try {
      const response = await axios.get("/battles")
      return response.data
    } catch (err) {
      return rejectWithValue(err.response.data)
    }
  }
)

export const createBattle = createAsyncThunk(
  "lobby/createBattle",
  async ({ name, size, rulesetId, initialCompanyId }) => {
    try {
      const response = await axios.post("/battles/player/create_match", { name, size, rulesetId, initialCompanyId })
      return response.data
    } catch (err) {
      return rejectWithValue(err.response.data)
    }
  }
)

export const leaveBattle = createAsyncThunk(
  "lobby/leaveBattle",
  async ({ battleId, playerId }) => {
    try {
      const response = await axios.post("/battles/player/leave_match", { battleId, playerId })
      return response.data
    } catch (err) {
      return rejectWithValue(err.response.data)
    }
  }
)


const lobbySlice = createSlice({
  name: "lobby",
  initialState,
  reducers: {
    addNewBattle(state, action) {
      const { battle } = action.payload
      battlesAdapter.setOne(state, battle)
    },
    updateBattle(state, action) {
      const { battle } = action.payload
      battlesAdapter.setOne(state, battle)
    },
    removeBattle(state, action) {
      const {battle} = action.payload
      battlesAdapter.removeOne(state, battle.id)
    }
  },
  extraReducers(builder) {
    builder
      .addCase(fetchActiveBattles.fulfilled, (state, action) => {
        battlesAdapter.setAll(state, action.payload)
      })
      .addCase(fetchActiveBattles.rejected, (state, action) => {
        state.loadingBattlesError = action.payload.error
      })

      .addCase(createBattle.pending, (state, action) => {
        state.creatingBattleStatus = "pending"
        state.creatingBattleError = null
      })
      .addCase(createBattle.fulfilled, (state, action) => {
        state.creatingBattleStatus = "fulfilled"
      })
      .addCase(createBattle.rejected, (state, action) => {
        state.creatingBattleStatus = "rejected"
        state.creatingBattleError = action.payload.error
      })
  }
})

export default lobbySlice.reducer

export const { addNewBattle, updateBattle, removeBattle } = lobbySlice.actions

export const {
  selectAll: selectAllActiveBattles,
  selectById: selectBattleById
} = battlesAdapter.getSelectors(state => state.lobby)
