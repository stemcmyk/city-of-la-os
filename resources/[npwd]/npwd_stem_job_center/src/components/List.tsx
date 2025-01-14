import React from 'react';
import { Job, JobData, JobUpdateData, SeparatedJobs } from '../types/jobs';
import { ServerPromiseResp } from '../types/common';
import fetchNui from '../utils/fetchNui';
import { Box, Collapse, Divider, IconButton, List, ListItem, ListItemText, ListSubheader, Theme } from '@mui/material';
import KeyboardTabIcon from '@mui/icons-material/KeyboardTab';
import TaskAltRoundedIcon from '@mui/icons-material/TaskAltRounded';
import { buildRespObj } from '../utils/misc';
import { MockCurrentJob } from '../utils/constraints';

export default function JobList({ jobs,  theme}: { jobs?: SeparatedJobs, theme: Theme}) {
  const [currentJob, setCurrentJob] = React.useState<JobData | undefined>()


  const handleSetJob = (data: JobUpdateData) => {
    fetchNui<ServerPromiseResp>('npwd:stem_job_center:setJob',data).then((res) => {
      console.log(res.data)
      if (res.data) {
        setCurrentJob({ name: data.id, grade: data.grade })
      }
    }).catch(console.log);
  };

  
  React.useEffect(() => {
    fetchNui<ServerPromiseResp<JobData>>(
        'npwd:stem_job_center:getJob',
        null,
        buildRespObj(MockCurrentJob)
    ).then((resp) => {
      setCurrentJob(resp.data)
    });
}, []);

  if (!jobs) {
    return "Loading"
  }

  console.log(JSON.stringify(jobs))

  return (
    <Box>
      {Object.keys(jobs).map((key) => (
        <List
          subheader={
            <ListSubheader sx={{ background: "#ffffff10"}}>
              {key.toUpperCase()}
            </ListSubheader>
          }
        >
            {jobs[key]?.map((job: Job, index) =>  {
              console.log(job)
              const hasJob = job.id === currentJob?.name && job.grade === currentJob?.grade
              return (
                <Box sx={{ background: "#ffffff05"}}>
                  <Divider hidden={index === 0}></Divider>
                  <ListItem
                    secondaryAction={
                      <IconButton
                        onClick={() => handleSetJob({id: job.id, grade: job.grade})}
                        disabled={hasJob}
                      >
                        {
                          !hasJob ? 
                            <KeyboardTabIcon/> : 
                            <TaskAltRoundedIcon color="success" />
                        }
                      </IconButton>
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
        </List>
      ))}
      <Box sx={{ background: "#ffffff05"}}>
        <ListItem
          secondaryAction={
            <IconButton
              onClick={() => handleSetJob({id: "unemployed", grade: 0})}
              disabled={"unemployed" === currentJob?.name}
            >
              {
                "unemployed" !== currentJob?.name ? 
                  <KeyboardTabIcon/> : 
                  <TaskAltRoundedIcon color="success" />
              }
            </IconButton>
          }
        >
          <ListItemText
            primaryTypographyProps={{
            }}
            primary={"Unemployed"}
          />
        </ListItem>
      </Box>
    </Box>
  );
}
