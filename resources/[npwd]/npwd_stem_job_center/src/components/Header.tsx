import React, { ReactNode } from 'react';
import { Typography, Box, useTheme } from '@mui/material';
import styled from '@emotion/styled';

export const HEADER_HEIGHT = '4rem';
const Container = styled.div<{ backgroundColor: string }>`
  display: flex;
  align-items: center;

  min-height: ${HEADER_HEIGHT};
  padding-left: 1.5rem;
  background-color: ${({ backgroundColor }) => backgroundColor};
`;

interface HeaderProps {
  children: ReactNode;
}

export const Header = styled("div")({
  width: "100%",
  justifyContent: "flex-start",
  display: "flex",
  alignItems: "center",
  gap: 20,
  marginBottom: 20,
});


export default Header;
