import React from "react";
import "./styles.css";

import { Home } from "./components/Home";
import { Mission } from "./components/Mission";
import { DefaultPage } from "./components/DefaultPage";

import { BrowserRouter as Router, Switch, Route, Link } from "react-router-dom";

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
