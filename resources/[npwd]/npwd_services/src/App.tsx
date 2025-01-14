import React, { useEffect, useState } from "react";
import { useHistory } from "react-router-dom";
import styled from "@emotion/styled";
import { Header } from "./styles/header.styles";
import { IPhoneSettings } from "@project-error/npwd-types";
import { i18n } from "i18next";
import {
  IconButton,
  Theme,
  StyledEngineProvider,
  ThemeProvider,
  Typography,
} from "@mui/material";
import { ArrowBack } from "@mui/icons-material";
import { Player } from "./types/service";
import fetchNui from "./utils/fetchNui";
import { ServerPromiseResp } from "./types/common";
import { PlayersList } from "./components/PlayersList";

const Container = styled.div<{ isDarkMode: any }>`
  flex: 1;
  padding: 1.5rem;
  display: flex;
  box-sizing: border-box;
  flex-direction: column;
  overflow: auto;
  max-height: 100%;
  background-color: #fafafa;
  ${({ isDarkMode }) =>
    isDarkMode &&
    `
    background-color: #212121;
  `}
`;

interface AppProps {
  theme: Theme;
  i18n: i18n;
  settings: IPhoneSettings;
}

const App = (props: AppProps) => {
  const history = useHistory();
  const [players, setPlayers] = useState<Player[] | undefined>([]);
  const [mappedPlayers, setMappedPlayers] = useState<any>(null);

  const isDarkMode = props.theme.palette.mode === "dark";

  useEffect(() => {
    fetchNui<ServerPromiseResp<Player[]>>("npwd:services:getPlayers").then(
      (resp) => {
        setPlayers(resp.data);
      }
    );
  }, []);

  useEffect(() => {
    if (players) {
      const mappedPlayer = players?.reduce((playersGroup: any, player: any) => {
        if (!playersGroup[player.job]) playersGroup[player.job] = [];
        playersGroup[player.job].push(player);
        return playersGroup;
      }, {});

      setMappedPlayers(mappedPlayer);
    }
  }, [players]);

  return (
    <StyledEngineProvider injectFirst>
      <ThemeProvider theme={props.theme}>
        <Container isDarkMode={isDarkMode}>
          <Header>
            <IconButton color="primary" onClick={() => history.goBack()}>
              <ArrowBack />
            </IconButton>
            <Typography fontSize={24} color="primary" fontWeight="bold">
              Services
            </Typography>
          </Header>
          {mappedPlayers && (
            <PlayersList isDarkMode={isDarkMode} players={mappedPlayers} />
          )}
        </Container>
      </ThemeProvider>
    </StyledEngineProvider>
  );
};

const WithProviders: React.FC<AppProps> = (props) => <App {...props} />;

export default WithProviders;
