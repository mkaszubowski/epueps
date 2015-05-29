jest
  .dontMock '../subjects.js.jsx.coffee'
  .dontMock '../subject.js.jsx.coffee'

React = require('react/addons')
TestUtils = React.addons.TestUtils
Subjects = require('../subjects.js.jsx.coffee')
$ = require('jquery')

describe 'subjects', ->

  it 'should display popular/recent toggle', ->
    subjects = TestUtils.renderIntoDocument(
      React.createElement Subjects
    )

    expect(subjects.getDOMNode().textContent)
      .toBe('Popularne / Najnowsze')

  it 'displays popular subjects by default', ->
    subjects = TestUtils.renderIntoDocument(
      React.createElement Subjects
    )

    expect($.ajax).lastCalledWith {
      error: jasmine.any(Function),
      success: jasmine.any(Function),
      dataType: 'JSON',
      url: 'subjects?scope=popular'
    }

  describe 'clicking on recent/popular links', ->

    it 'should change subjects scope', ->
      subjects = TestUtils.renderIntoDocument(
        React.createElement Subjects
      )
      recentLink = TestUtils.findRenderedDOMComponentWithClass(
        subjects, 'subjects-recent')
      popularLink = TestUtils.findRenderedDOMComponentWithClass(
        subjects, 'subjects-popular')

      TestUtils.Simulate.click(recentLink)

      expect(subjects.state.scope).toBe('recent')
      expect($.ajax).lastCalledWith {
        error: jasmine.any(Function),
        success: jasmine.any(Function),
        dataType: 'JSON',
        url: 'subjects?scope=recent'
      }

      TestUtils.Simulate.click(popularLink)
      expect(subjects.state.scope).toBe('popular')

      expect($.ajax).lastCalledWith {
        error: jasmine.any(Function),
        success: jasmine.any(Function),
        dataType: 'JSON',
        url: 'subjects?scope=popular'
      }
