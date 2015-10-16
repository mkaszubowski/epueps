jest
  .dontMock '../contactForm.js.jsx.coffee'

React = require('react')
ReactDOM = require('react-dom');
TestUtils = require('react-addons-test-utils')
$ = require('jquery')

ContactForm = require('../contactForm.js.jsx.coffee')

describe 'ContactForm', ->

  it 'shows the correct labels for inputs', ->
    contactForm = TestUtils.renderIntoDocument(
      React.createElement ContactForm
    )

    node = ReactDOM.findDOMNode(contactForm)

    expect(node.textContent)
      .toContain('Imię')
    expect(node.textContent)
      .toContain('Email')
    expect(node.textContent)
      .toContain('Wiadomość')
