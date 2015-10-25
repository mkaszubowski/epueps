jest
  .dontMock '../subjectPage.js.jsx.coffee'

  React = require('react')
  ReactDOM = require('react-dom')
  TestUtils = require('react-addons-test-utils')
  $ = require('jquery')

  SubjectPage = require('../subjectPage.js.jsx.coffee')

  subjectMock =
    slug: 'slug'


  describe 'SubjectPage', ->

    it 'should load lessons', ->
      subjectPage = TestUtils.renderIntoDocument(
        React.createElement SubjectPage, subject: subjectMock
      )

      expect($.ajax).lastCalledWith {
        success: jasmine.any(Function),
        error: jasmine.any(Function)
        dataType: 'json',
        url: '/subjects/slug/lessons'
      }
