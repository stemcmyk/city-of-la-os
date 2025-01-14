import React, { useState } from 'react';

import { i18n } from 'i18next';
import {
  Theme,
  Paper,
  Typography,
  BottomNavigation,
  BottomNavigationAction,
  StyledEngineProvider,
  IconButton,
} from '@mui/material';
import Header, { HEADER_HEIGHT } from './components/Header';
import styled from '@emotion/styled';
import { BrowserRouter, Link , Route, Router, useHistory, useLocation } from 'react-router-dom';
import { path } from '../npwd.config';
import { ArrowBack, HomeRounded, InfoRounded } from '@mui/icons-material';
import ThemeSwitchProvider from './ThemeSwitchProvider';
import { RecoilRoot } from 'recoil';
import { useNuiEvent } from './hooks/useNuiEvent';
import fetchNui from './utils/fetchNui';
import { ServerPromiseResp } from './types/common';
import { Job, JobCenterData, SeparatedJobs } from './types/jobs';
import { buildRespObj } from './utils/misc';
import { MockCurrentJob, MockJobCenter } from './utils/constraints';
import JobList from './components/List';

const Container = styled(Paper)`
  flex: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  max-height: 100%;
`;

export const LinkItem = styled(Link)`
  font-family: sans-serif;
  text-decoration: none;
`;

export const Content = styled.div`
  flex: 1;
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  padding: 1.5rem;
  max-height: calc(100% -  ${HEADER_HEIGHT});
  overflow: auto;
`;

export const Footer = styled.footer`
  margin-top: auto;
`;

interface AppProps {
  theme: Theme;
  i18n: i18n;
  settings: any;
}

export function App(props: AppProps) {
  const history = useHistory();
  const [jobs, setJobs] = useState<SeparatedJobs | undefined>()

  React.useEffect(() => {
    fetchNui<ServerPromiseResp<Job[] | undefined>>(
        'npwd:stem_job_center:getJobs',
        null,
        buildRespObj(MockJobCenter)
    ).then((resp) => {
      const jobs = resp.data?.reduce((acc: SeparatedJobs, job: Job) => {
        if (!job) return acc;
        console.log(job)
        // Check if the job category already exists in the accumulator
        if (acc[job.jobCategory] && job) {
            // If it exists, push the current job to the existing array
            acc[job.jobCategory]?.push(job);
        } else {
            // If it doesn't exist, initialize a new array with the current job
            acc[job.jobCategory] = [job];
        }
        return acc;
    }, {});
    console.log(jobs)
    setJobs(jobs)
    });
}, []);

  return (
    <StyledEngineProvider injectFirst>
      <ThemeSwitchProvider mode={props.theme.palette.mode}>
        <Container square elevation={0}>
          <Content>
            <Header>
              <IconButton color="primary" onClick={() => history.goBack()}>
                <ArrowBack />
              </IconButton>
              <Typography fontSize={24} color="primary" fontWeight="bold">
                Job Center
              </Typography>
            </Header>
            <JobList jobs={jobs} theme={props.theme}></JobList>
          </Content>
        </Container>
      </ThemeSwitchProvider>
    </StyledEngineProvider>
  );
}

export default function WithProviders(props: AppProps) {
  return (
    <RecoilRoot override key="mockapp">
      <App {...props} />
    </RecoilRoot>
  );
}
