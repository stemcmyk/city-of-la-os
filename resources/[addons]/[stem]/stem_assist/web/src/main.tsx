import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import { debugData } from './utils/debugData';
import { MantineProvider } from '@mantine/core';
import { customTheme } from './theme';
import { isEnvBrowser } from './utils/misc';
import { HashRouter } from 'react-router-dom';
import { ModalsProvider } from '@mantine/modals';
import { Assist } from './store/doors';

debugData<Assist[]>([
  {
    action: 'updateAssists',
    data: [
      {
        name: 'Bing bong',
        description: "Testing, this is a fucking robbery",
        id: 14,
        status: "open",
        player: {
          id: "1231",
          name: "daasd"
        },
        acceptedBy: {
          id: 1,
          name: "diddly"
        }
      },
    ],
  },
]);


debugData(
  [
    {
      action: 'setVisible',
      data: undefined,
    },
  ],
  2000
);

debugData<string[]>([
  {
    action: 'setSoundFiles',
    data: ['button-remote', 'door-bolt-4', 'metal-locker', 'metallic-creak'],
  },
]);

if (isEnvBrowser()) {
  const root = document.getElementById('root');

  // https://i.imgur.com/iPTAdYV.png - Night time img
  root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
  root!.style.backgroundSize = 'cover';
  root!.style.backgroundRepeat = 'no-repeat';
  root!.style.backgroundPosition = 'center';
}

ReactDOM.render(
  <React.StrictMode>
    <MantineProvider withNormalizeCSS theme={customTheme} >
      <ModalsProvider modalProps={{ transition: 'slide-up' }}>
        <HashRouter>
          <App />
        </HashRouter>
      </ModalsProvider>
    </MantineProvider>
  </React.StrictMode>,
  document.getElementById('root')
);
