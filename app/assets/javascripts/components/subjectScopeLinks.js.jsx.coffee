React = require('react')
$ = require('jquery')

R = React.DOM

SubjectScopeLinks = React.createClass
  getInitialState: ->
    return {
      scope: @props.scope || 'popular'
    }

  handlePopularClick: (e) ->
    @setState(scope: 'popular')
    @props.handlePopularClick(e)

  handleRecentClick: (e) ->
    @setState(scope: 'recent')
    @props.handleRecentClick(e)

  render: ->
    recentClass = if @state.scope == 'recent' then 'subjects-recent active' else 'subjects-recent'
    popularClass = if  @state.scope == 'popular' then 'subjects-popular active' else 'subjects-popular'

    R.div
      className: 'subject-scope-options'
      R.a({href: '#', onClick: @handlePopularClick, className: popularClass}, 'Popularne ')
      '/'
      R.a({href: '#', onClick: @handleRecentClick, className: recentClass}, ' Najnowsze')

module.exports = SubjectScopeLinks
