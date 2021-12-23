import React, { useEffect, useRef, useState } from 'react'
import { useDispatch, useSelector } from "react-redux";
import { CircularProgress, Container, Grid, Paper, Typography } from "@mui/material";
import { useParams } from "react-router-dom";
import { makeStyles } from "@mui/styles";

import { CompanyGridDropTarget } from "./CompanyGridDropTarget";
import { CompanyGridTabs } from "./CompanyGridTabs";
import { UnitCardDroppable } from "./UnitCardDroppable";

import { CORE } from "../../../constants/company";
import { RIFLEMEN, SHERMAN } from "../../../constants/units/americans";

import riflemen from '../../../../assets/images/doctrines/americans/units/riflemen.png'
import sherman from '../../../../assets/images/doctrines/americans/units/sherman.png'
import {
  fetchCompanyAvailableUnits,
  selectAvailableUnits,
  selectAvailableUnitsStatus,
  selectCompanyById
} from "../companiesSlice";
import { AmericanUnits } from "./available_units/AmericanUnits";

const useStyles = makeStyles(theme => ({
  placementBox: {
    minHeight: '10rem',
    minWidth: '4rem'
  },
  statsBox: {
    minHeight: '10rem'
  }
}))

const defaultTab = CORE
export const CompanyManager = () => {
  const [currentTab, setCurrentTab] = useState(defaultTab)
  const [selectedUnit, setSelectedUnit] = useState("")

  const classes = useStyles()

  let params = useParams()
  const companyId = params.companyId

  const company = useSelector(state => selectCompanyById(state, companyId))

  const dispatch = useDispatch()
  useEffect(() => {
    dispatch(fetchCompanyAvailableUnits({ companyId }))
  }, [companyId])

  // TODO use this to constrain the drag area
  const constraintsRef = useRef(null)

  const onDrop = () => {
    // console.log("dropped the unit card")
    // TODO REMOVE IF NOT NEEDED
  }

  const onTabChange = (newTab) => {
    console.log(`Manager changed to new tab ${newTab}`)
    setCurrentTab(newTab)
  }

  const onUnitSelect = (unit) => {
    /** Called when a unit is selected. Populates the unit stats box with relevant data
     * TODO if a squad is clicked, should take upgrades into account
     */
    setSelectedUnit(unit)
  }

  const onUnitDrop = (unit, index) => {
    console.log(`Added ${unit} to category ${currentTab} position ${index}`)
  }

  const availableUnitsStatus = useSelector(selectAvailableUnitsStatus)
  const availableUnits = useSelector(selectAvailableUnits)
  let availableUnitsContent
  if (availableUnitsStatus === "pending") {
    console.log("Loading available units")
    availableUnitsContent = <CircularProgress />
  } else {
    console.log("Selected available units")
    console.log(availableUnits)
    availableUnitsContent = <AmericanUnits companyId={companyId} onDrop={onDrop} onUnitSelect={onUnitSelect} />
  }

  return (
    <Container maxWidth="xl" ref={constraintsRef}>
      <Typography variant="h5">Company {companyId}</Typography>

      <Grid container spacing={2}>
        <Grid item container spacing={2}>
          <Grid item md={6}>
            {availableUnitsContent}
            {/*TODO read available units for this company from backend */}
            {/*TODO maybe populate by type, alphabetically or cost ASC */}
          </Grid>
          <Grid item md={6}>
            <Paper key='statsBox' className={classes.statsBox}>
              {/*TODO connect selectedUnit to stats*/}
              {selectedUnit}
            </Paper>
          </Grid>
        </Grid>
        <Grid item>
          <CompanyGridTabs selectedTab={currentTab} changeCallback={onTabChange} />
        </Grid>
        <Grid item container spacing={2}>
          <Grid item xs={3}>
            <CompanyGridDropTarget index={0} onHitCallback={onUnitDrop} onUnitClick={onUnitSelect} />
          </Grid>
          <Grid item xs={3}>
            <CompanyGridDropTarget index={1} onHitCallback={onUnitDrop} onUnitClick={onUnitSelect} />
          </Grid>
          <Grid item xs={3}>
            <CompanyGridDropTarget index={2} onHitCallback={onUnitDrop} onUnitClick={onUnitSelect} />
          </Grid>
          <Grid item xs={3}>
            <CompanyGridDropTarget index={3} onHitCallback={onUnitDrop} onUnitClick={onUnitSelect} />
          </Grid>
        </Grid>
        <Grid item container spacing={2}>
          <Grid item xs={3}>
            <CompanyGridDropTarget index={4} onHitCallback={onUnitDrop} onUnitClick={onUnitSelect} />
          </Grid>
          <Grid item xs={3}>
            <CompanyGridDropTarget index={5} onHitCallback={onUnitDrop} onUnitClick={onUnitSelect} />
          </Grid>
          <Grid item xs={3}>
            <CompanyGridDropTarget index={6} onHitCallback={onUnitDrop} onUnitClick={onUnitSelect} />
          </Grid>
          <Grid item xs={3}>
            <CompanyGridDropTarget index={7} onHitCallback={onUnitDrop} onUnitClick={onUnitSelect} />
          </Grid>
        </Grid>
      </Grid>
    </Container>
  )
}