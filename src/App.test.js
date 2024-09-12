import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

test('renders react app running message', () => {
  render(<App />);
  const messageElement = screen.getByText(/react app \.\.\. up and running/i);
  expect(messageElement).toBeInTheDocument();
});

