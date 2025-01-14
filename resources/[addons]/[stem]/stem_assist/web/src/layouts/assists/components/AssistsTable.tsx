import { Table, UnstyledButton, Text, Group, Center, Stack, Pagination, Button } from '@mantine/core';
import {
  ColumnDef,
  flexRender,
  getCoreRowModel,
  getSortedRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  SortingState,
  useReactTable,
} from '@tanstack/react-table';
import { useEffect, useMemo, useState } from 'react';
import { TbSelector, TbChevronDown, TbChevronUp, TbSearch } from 'react-icons/tb';
import { useSearch } from '../../../store/search';
import { useAssists,  type Assist } from '../../../store/doors';
import { useStore } from '../../../store';
import { convertData } from '../../../utils/convertData';
import { useNavigate } from 'react-router-dom';
import { AssistStatus } from './AssistStatus';


const AssistsTable: React.FC = () => {
  const [sorting, setSorting] = useState<SortingState>([]);
  const [currentPage, setCurrentPage] = useState(1);
  const globalFilter = useSearch((state) => state.debouncedValue);
  const data = useAssists((state) => (state.assists).filter((e) => e));
  const navigate = useNavigate();

  const columns = useMemo<ColumnDef<Assist>[]>(
    () => [
      {
        id: 'id',
        header: 'Assist ID',
        accessorKey: 'id',
        cell: (info) => info.getValue(),
        enableHiding: false,
        enableGlobalFilter: false, // id is of type number so it breaks filter function
      },
      {
        id: 'player.name',
        header: 'Player Name',
        accessorKey: 'player.name',
        cell: (info) => info.getValue(),
        enableHiding: true,
        enableGlobalFilter: false, // id is of type number so it breaks filter function
      },
      {
        id: 'description',
        header: 'Description',
        accessorKey: 'description',
        cell: (info) => info.getValue(),
        enableHiding: true,
      },
      {
        id: 'status',
        header: 'Status',
        accessorKey: 'status',
        cell: (info) => <AssistStatus status={info.getValue() as Assist["status"]}></AssistStatus>,
        enableHiding: true,
      },
      {
        id: 'options-menu',
        cell: (data) => <Button size="sm" variant='light' onClick={() => {
          useStore.setState(convertData(data.row.original), true);
          navigate('/assist');
        }}>View Assist</Button>
      },
    ],
    []
  );

  const table = useReactTable({
    data,
    columns,
    initialState: {
      pagination: {
        pageSize: 8,
        pageIndex: 0,
      },
    },
    state: {
      sorting,
      globalFilter,
    },
    onGlobalFilterChange: useSearch((state) => state.setValue),
    onSortingChange: setSorting,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
  });

  useEffect(() => {
    table.setPageIndex(currentPage - 1);
  }, [currentPage, data]);

  return (
    <Stack justify="space-between" align="center" sx={{ height: '100%', paddingBottom: 16, padding: "0px 10px" }} spacing={0}>
      {table.getFilteredRowModel().rows.length > 0 ? (
        <Table>
          <thead>
            {table.getHeaderGroups().map((headerGroup) => (
              <tr key={headerGroup.id}>
                {headerGroup.headers.map((header) => (
                  <th key={header.id}>
                    <UnstyledButton onClick={header.column.getToggleSortingHandler()}>
                      <Group>
                        <Text>{flexRender(header.column.columnDef.header, header.getContext())}</Text>
                        {header.column.getIsSorted() === 'desc' ? (
                          <TbChevronDown />
                        ) : header.column.getIsSorted() === 'asc' ? (
                          <TbChevronUp />
                        ) : !header.column.getCanHide() ? (
                          <TbSelector />
                        ) : (
                          <></>
                        )}
                      </Group>
                    </UnstyledButton>
                  </th>
                ))}
              </tr>
            ))}
          </thead>
          <tbody>
            {table.getRowModel().rows.map((row) => (
              <tr key={row.id}>
                {row.getAllCells().map((cell) => (
                  <td key={cell.id}>{flexRender(cell.column.columnDef.cell, cell.getContext())}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </Table>
      ) : (
        <Center sx={{ height: '100%' }}>
          <Stack align="center">
            <TbSearch size={48} />
            <Text size="lg">No results found</Text>
          </Stack>
        </Center>
      )}
      {table.getPageCount() > 1 && (
        <Pagination page={currentPage} total={table.getPageCount()} onChange={(e) => setCurrentPage(e)} />
      )}
    </Stack>
  );
};

export default AssistsTable;
