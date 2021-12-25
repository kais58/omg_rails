import { createAsyncThunk, createEntityAdapter, createSlice } from "@reduxjs/toolkit";
import axios from "axios"

const availableUnitsAdapter = createEntityAdapter()

const initialState = availableUnitsAdapter.getInitialState({
  availableUnits: [],
  availableUnitsStatus: "idle",
  loadingAvailableUnitsError: null,
  creatingStatus: "idle",
  creatingError: null,
  deletingError: null
})

export const fetchCompanyAvailableUnits = createAsyncThunk("companies/fetchCompanyAvailableUnits", async ({ companyId }) => {
  const response = await axios.get(`/companies/${companyId}/available_units`)
  return response.data
})

// export const createCompany = createAsyncThunk("companies/createCompany", async ({ name, doctrineId }) => {
//   const response = await axios.post("/companies", { name, doctrineId })
//   return response.data
// })
//
// export const deleteCompanyById = createAsyncThunk("companies/deleteCompany", async ({ companyId }) => {
//   const response = await axios.delete(`/companies/${companyId}`)
//   return response.data
// })

const renormalizeAvailableUnits = (availableUnits) => {
  /**
   * More useful to key available units by unit id
   */
  return availableUnits.map(au => ({
    ...au,
    id: au.unitId,
    availableUnitId: au.id
  }))
}

const availableUnitsSlice = createSlice({
  name: "availableUnits",
  initialState,
  reducers: {},
  extraReducers(builder) {
    builder
      .addCase(fetchCompanyAvailableUnits.pending, (state, action) => {
        state.availableUnitsStatus = "pending"
        state.loadingAvailableUnitsError = null
      })
      .addCase(fetchCompanyAvailableUnits.fulfilled, (state, action) => {
        availableUnitsAdapter.setAll(state, renormalizeAvailableUnits(action.payload))
        state.availableUnitsStatus = "idle"
      })
      .addCase(fetchCompanyAvailableUnits.rejected, (state, action) => {
        state.availableUnitsStatus = "idle"
        state.loadingAvailableUnitsError = action.error.message
      })
  }
})

export default availableUnitsSlice.reducer

export const {
  selectAll: selectAllAvailableUnits,
  selectById: selectAvailableUnitByUnitId
} = availableUnitsAdapter.getSelectors(state => state.availableUnits)

// export const selectAvailableUnits = state => state.availableUnits.availableUnits
// export const selectAvailableUnitByUnitId = (state, unitId) => state.availableUnits.availableUnits.find(au => au.unitId === unitId)
export const selectAvailableUnitsStatus = state => state.availableUnits.availableUnitsStatus
