import { Box,  Button,  Header,  Text,  createStyles } from '@mantine/core';
import Layout from './Layout';
import { useStore } from '../../store';
import { AssistStatus } from '../assists/components/AssistStatus';
import { fetchNui } from '../../utils/fetchNui';


const Asssit: React.FC = () => {
  const store = useStore()

  console.log("ref")

  const action = (type: string) => () => {
    fetchNui("assist_action", {
      id: store.id,
      action: type,
    })
  }

  return (
    <Layout>
      <Box sx={{ height: '100%', display: 'flex', flexDirection: "column", padding: "10px"}}>
        <Header height={32} sx={{ display: "flex", alignItems: "center", padding: "0px 10px", fontWeight: "bold", gap: "10px"}}>Assist Status <AssistStatus status={store.status}></AssistStatus></Header>
        <Box sx={{ padding: "10px 10px", display: "flex", gap: "10px", flexDirection: "column"}}>
          <Box  sx={{
            gap: "6px",
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center" 
          }}>
            <Box sx={{ display: "flex", gap: "6px", alignItems: "center" }}><Text weight="bold"> Requested by: </Text> {store.player.name} ({store.player.id})</Box>
            {store.status == "taken" && <Box sx={{ display: "flex", gap: "6px" }}><Text weight="bold"> Accepted by: </Text> {store.acceptedBy.name} ({store.acceptedBy.id})</Box>}
          </Box>
          <Box  sx={{
            gap: "6px",
            display: "flex", 
            alignItems: "center" 
          }}>
            <Text weight="bold"> Description: </Text> {store.description}
          </Box>
        </Box>  
        <Box sx={{
          opacity: store.status == "accepted" ? "100%" : "50%" 
        }}>
          <Header height={32} sx={{ display: "flex", alignItems: "center", padding: "0px 10px", fontWeight: "bold"}}>Teleport</Header>
          <Box sx={{ padding: "10px 0px", display: "flex", gap: "10px"}} >
            <Button variant="filled" onClick={action("tp:bring")} disabled={store.status != "accepted"}>Bring Player</Button>
            <Button variant="outline" onClick={action("tp:goto")} disabled={store.status != "accepted"}>Go To Player</Button>
            <Button variant="outline" onClick={action("tp:tolegion")} disabled={store.status != "accepted"}>Teleport To Legion</Button>
            {/* <Button variant="filled" onClick={action("heal")} bg ="green" color="white" disabled={store.status != "accepted"}>Heal</Button> */}
          </Box>
        </Box>
      </Box>
    </Layout>
  );
};

export default Asssit;
