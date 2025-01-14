import { Box, createStyles, Transition } from '@mantine/core';
import { Routes, Route, useNavigate } from 'react-router-dom';
import { useNuiEvent } from './hooks/useNuiEvent';
import { defaultState,  useSetters, useStore } from './store';
import Assists from './layouts/assists';
import PlayerAssist from './layouts/assist';
import { useVisibility } from './store/visibility';
import { Assist, useAssists } from './store/doors';
import { useExitListener } from './hooks/useExitListener';
import { convertData } from './utils/convertData';

const useStyles = createStyles((theme) => ({
  container: {
    width: '100%',
    height: '100%',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
  },

  main: {
    width: 700,
    height: 500,
    backgroundColor: theme.colors.dark[8],
    borderRadius: theme.radius.sm,
  },

  search: {
    width: '40%',
    transition: '300ms',
    '&:focus-within': {
      width: '50%',
    },
  },
}));

const App: React.FC = () => {
  const { classes } = useStyles();
  const [visible, setVisible] = useVisibility((state) => [state.visible, state.setVisible]);
  const setAssists = useAssists((state) => state.setAssists);
  const assists = useAssists((state) => state.assists);
  const navigate = useNavigate();

  useNuiEvent('setVisible', (data: number) => {
    setVisible(true);
    if (data === undefined) return navigate('/');
    for (let i = 0; i < assists.length; i++) {
      if (assists[i].id === data) {
        useStore.setState(convertData(assists[i]), true);
        navigate('/assist');
        break;
      }
    }
  });
  
  useNuiEvent('updateAssists', (data: Assist | number) => {
    // Door id sent so delete the filter out the door
    if (typeof data === 'number') return setAssists(assists.filter((door) => door.id !== data));
    else {
      // Single door sent so update the object
      if (data.hasOwnProperty('id')) {
        console.log("singular")
        let index = assists.length;
        for (let i = 0; i < index; i++) {
          const assist = Object.values(assists)[i];
          if (assist.id == data.id) {
            index = i;
            break;
          }
        }

        return setAssists(Object.values({ ...assists, [index]: data } as Assist[]));
      }

      // More than 1 door sent - replace the object
      return setAssists(Object.values(data));
    }
  });

  useExitListener(setVisible);

  return (
    <Box className={classes.container}>
      <Transition transition="slide-up" mounted={visible}>
        {(style) => (
          <Box className={classes.main} style={style}>
            <Routes>
              <Route path="/" element={<Assists />} />
              <Route path="/assist" element={<PlayerAssist />} />
            </Routes>
          </Box>
        )}
      </Transition>
    </Box>
  );
};

export default App;
