jest
  .dontMock '../contactForm.js.jsx.coffee'

React = require('react/addons')
TestUtils = React.addons.TestUtils
ContactForm = require('../contactForm.js.jsx.coffee')
$ = require('jquery')

describe 'ContactForm', ->

  it 'shows the correct labels for inputs', ->
    contactForm = TestUtils.renderIntoDocument(
      React.createElement ContactForm
    )

    expect(contactForm.getDOMNode().textContent)
      .toContain('Imię')
    expect(contactForm.getDOMNode().textContent)
      .toContain('Email')
    expect(contactForm.getDOMNode().textContent)
      .toContain('Wiadomość')
