import React from 'react'
import { useSelector } from "react-redux";
import { Box, Container, Typography } from "@mui/material";

import { CreateCompaniesForm } from "./creation/CreateCompaniesForm";
import { selectIsAuthed } from "../player/playerSlice";
import { selectAllCompanies } from "./companiesSlice";
import { DisplayCompanies } from "./display/DisplayCompanies";
import { Fingerprint } from "@mui/icons-material";

export const Companies = () => {
  // Companies page container
  //    Create new companies
  //    Display current companies
  //    Enter company builder
  const isAuthed = useSelector(selectIsAuthed)
  const companies = useSelector(selectAllCompanies)

  let content
  // If not authenticated, display message telling player to log in first
  if (!isAuthed) {
    content = (
      <Box pt={5} sx={{ "display": "flex" }}>
        <Fingerprint  fontSize={"large"} color="warning" />
        <Typography variant={"h5"} pl={"5px"} sx={{ alignSelf: 'end' }}>Sign in to manage companies</Typography>
      </Box>
    )
  } else if (companies.length === 0) {
    // No companies for the player, show creation form
    content = <CreateCompaniesForm />
  } else {
    // Show companies
    content = <DisplayCompanies />
  }

  return (
    <Container maxWidth="xl" disableGutters>
      <Box p={3} pt={5} display="flex" justifyContent="center" alignItems="center">
        {content}
      </Box>
    </Container>
  )
}