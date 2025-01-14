import { Box, Button, Checkbox, CloseButton, Group, Stack, Text, Tooltip, createStyles } from '@mantine/core';
import { TbChevronLeft, TbPlus } from 'react-icons/tb';
import { useStore } from '../../store';
import { fetchNui } from '../../utils/fetchNui';
import { useVisibility } from '../../store/visibility';
import { useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { Assist, useAssists } from '../../store/doors';

interface Props {
  children: React.ReactNode;
}
const useStyles = createStyles({
  main: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    paddingBottom: 0,
  },
});



const Layout: React.FC<Props> = ({ children }) => {
  const setVisible = useVisibility((state) => state.setVisible);
  const navigate = useNavigate()
  const { classes } = useStyles();
  const [readyToClose, setReadyToClose] = useState(false)
  const {assists, setAssists} = useAssists((state) => state);

  const updateAssistStatus = (status: string) => () => {
    fetchNui("assist_update", {
      id: useStore.getState().id,
      status,
    }).then((response) => {
      if (!response) return;
      if (status == "accepted"){
        useStore.setState({
          ...useStore.getState(),
          status: "accepted",
          acceptedBy: response
        })
      } 

      if (status == "closed") {
        let index = assists.length;
        for (let i = 0; i < index; i++) {
          const assist = Object.values(assists)[i];
          if (assist.id == useStore.getState().id) {
            index = i;
            break;
          }
        }

        setAssists(Object.values({ ...assists, [index]: undefined } as Assist[]));

        navigate("/")
      }
    })
  }

  return (
    <Stack justify="space-between" align="center" sx={{ height: "100%"}} >
      <Box sx={{ width: '100%', overflowY: 'auto', height: "100%" }}>
        <Group className={classes.main}>
          <Button
            variant='light'
            size="sm"
            px={6}
            onClick={() => {
              navigate("/")
            }}
          >
            <TbChevronLeft size={24}></TbChevronLeft>
          </Button>
          <Box sx={{ display: "flex", flex: 1,  alignItems: "center"}}>
            <Text sx={{ fontWeight: "bold", paddingRight: "6px", display: "flex", whiteSpace: "nowrap" }}>{useStore.getState().id} | Assisting:</Text>{useStore.getState().player.name} 
          </Box>
          <CloseButton
            iconSize={20}
            size="lg"
            onClick={() => {
              setVisible(false);
              fetchNui('exit');
            }}
          />
        </Group>
        {children}
      </Box>
      {/* { Close Asssit } */}
      <Box sx={{
        // width: "100%",
        display: useStore.getState().status == "accepted" ? "flex" : "none",
        flexDirection: "column",
        gap: "6px",
        padding: "20px"
      }}>
        <Box sx={{ display: "flex", alignItems: "center", gap: "10px"}}>
          Are you ready to close? <Checkbox checked={readyToClose} onChange={(e) => setReadyToClose(e.currentTarget.checked)}></Checkbox>
        </Box>
        <Box sx={{
          display: "flex",
        }}>
          <Button color="red" uppercase fullWidth disabled={!readyToClose} onClick={updateAssistStatus("closed")}>
            Close Assist
          </Button>
        </Box>
      </Box>
      {/* { Accept Asssit } */}
      <Box sx={{
        // width: "100%",
        display: useStore.getState().status == "open" ? "flex" : "none",
        flexDirection: "column",
        gap: "6px",
        padding: "20px"
      }}>
        <Box sx={{
          display: "flex",
        }}>
          <Button color="green" uppercase fullWidth onClick={updateAssistStatus("accepted")}>
            Accept Assist
          </Button>
        </Box>
      </Box>
    </Stack>
  );
};

export default Layout;
