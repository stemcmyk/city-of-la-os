import { Stack } from '@mantine/core';
import Header from './components/Header';
import AssistsTable from './components/AssistsTable';

const Assists: React.FC = () => {
  return (
    <Stack sx={{ height: '100%' }}>
      <Header />
      <AssistsTable />
    </Stack>
  );
};

export default Assists;
