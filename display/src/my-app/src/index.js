import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'mobx-react';
import 'bootstrap/dist/css/bootstrap.min.css';
import Root from './client/Root';
import * as serviceWorker from './serviceWorker';
import OrderStore from './stores/order'

const orderStore = new OrderStore();

ReactDOM.render(
  <Provider orderStore={orderStore}>
    <Root />
  </Provider>,
  document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
