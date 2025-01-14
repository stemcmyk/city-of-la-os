import React from 'react';
import { Job, SeparatedJobs } from '../types/jobs';
import { ServerPromiseResp } from '../types/common';
import fetchNui from '../utils/fetchNui';
import { Box, Collapse, Divider, IconButton, List, ListItem, ListItemText, ListSubheader, Theme } from '@mui/material';
import KeyboardTabIcon from '@mui/icons-material/KeyboardTab';
import TaskAltRoundedIcon from '@mui/icons-material/TaskAltRounded';
import { buildRespObj } from '../utils/misc';
import { MockCurrentJob } from '../utils/constraints';
import { Check, Clear } from '@mui/icons-material';

export default function JobList({ jobs,  theme}: { jobs?: Job[], theme: Theme}) {
  if (!jobs) {
    return "Loading"
  }

  return (
    <Box>
        {jobs?.map((job: Job, index) =>  {
          return (
            <Box sx={{ background: "#ffffff05"}}>
              <Divider hidden={index === 0}></Divider>
              <ListItem
                secondaryAction={
                  <Box display={"flex"} gap={2} alignItems={"center"}>{job.amount} {job.amount >= 1 ? <Check color="success"></Check> : <Clear></Clear>}</Box>
                }
              >
                <ListItemText
                  primaryTypographyProps={{
                  }}
                  primary={job.title}
                />
              </ListItem>
            </Box>
          )
        })}
    </Box>
  );
}
