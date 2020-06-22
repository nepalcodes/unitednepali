import React from 'react';
import '../styles.css';

import { Router } from '@reach/router';
import Home from '../components/Home';
import Mission from '../components/Mission';
import DefaultPage from '../components/DefaultPage';


export default function App() {
  return (
    <Router>
      <DefaultPage path="/" />
      <Home path="home" />
      <Mission path="mission" />
    </Router>
  );
}
