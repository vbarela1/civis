import React from 'react';
import { Route, IndexRoute, browserHistory } from 'react-router';
import { UserAuthWrapper } from 'redux-auth-wrapper';
import App from './containers/App';

// Components
import NoMatch from './components/NoMatch';
import Login from './components/Login';
import SignUp from './components/SignUp';
import Home from './components/Home';
import AboutUs from './components/AboutUs';
import Rep from './components/Rep';
import About from './components/About';
import ContentWrapper from './components/ContentWrapper';
import Account from './components/Account';

const UserIsAuthenticated = UserAuthWrapper({
  authSelector: state => state.auth,
  predicate: auth => auth.isAuthenticated,
});

export default (
  <Route>
    <Route path="/" component={App}>
      <IndexRoute component={Home} />
      <Route component={ContentWrapper}>
        <Route path='/rep/:id' component={Rep} />
        <Route path='/login' component={Login} />
        <Route path='/sign_up' component={SignUp} />
        <Route path='/account' component={UserIsAuthenticated(Account)} />
      </Route>
    </Route>
    <Route path="*" status={404} component={NoMatch} />
  </Route>
)
