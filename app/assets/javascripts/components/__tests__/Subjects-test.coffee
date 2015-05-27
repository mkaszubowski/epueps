jest
  .dontMock '../subjects.js.jsx.coffee'
  .dontMock 'jquery'

describe 'subjects', ->
  it 'should tell use it is a demo component', ->
    React = require('react/addons')
    TestUtils = React.addons.TestUtils
    Subjects = require('../subjects.js.jsx.coffee')
    demoComponent = TestUtils.renderIntoDocument(React.createElement Subjects)
    expect(demoComponent.getDOMNode().textContent).toBe('Popularne / Najnowsze')
