jest
  .dontMock '../subjects.js.jsx.coffee'
  .dontMock '../subject.js.jsx.coffee'
  .dontMock '../subjectScopeLinks.js.jsx.coffee'

React = require('react/addons')
ReactDOM = require('react-dom');
TestUtils = React.addons.TestUtils
Subjects = require('../subjects.js.jsx.coffee')
SubjectScopeLinks = require('../subjectScopeLinks.js.jsx.coffee')
$ = require('jquery')

describe 'Subjects', ->

  it 'should display popular/recent toggle', ->
    subjects = TestUtils.renderIntoDocument(
      React.createElement Subjects
    )

    expect(
      ReactDOM.findDOMNode(subjects).childNodes[0].className
    ).toBe('subject-scope-options')

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
