import React from 'react';
import Articles from '../components/Articles.js';
import renderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import store from './helpers/store';

test('Component is rendered', () => {
  const component = renderer.create(
    <Articles articles={[]}/>
  );

  let tree = component.toJSON();
  expect(tree).toMatchSnapshot();
});
