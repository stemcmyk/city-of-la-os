import React, { ReactNode } from 'react';
import { APP_PRIMARY_COLOR } from '../app.theme';
import { Typography, Box, useTheme } from '@mui/material';
import styled from '@emotion/styled';

interface HeaderProps {
  children: ReactNode;
}

const Header = ({ children }: HeaderProps) => {
  const theme = useTheme();
  return (
    <div className="px-4 py-2 pt-4">
      <h3 className="text-4xl font-extrabold text-neutral-900 dark:text-neutral-100">
        Banking
      </h3>
    </div>
  );
};

export default Header;
