import React from 'react';
import './styles.css';

import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import Home from './components/Home';
import Mission from './components/Mission';
import DefaultPage from './components/DefaultPage';


export default function App() {
  return (
    <Router>
      <Switch>
        <Route path="/home">
          <Home />
        </Route>
        <Route path="/mission">
          <Mission />
        </Route>
        <Route path="/">
          <DefaultPage />
        </Route>
      </Switch>
    </Router>
  );
}
