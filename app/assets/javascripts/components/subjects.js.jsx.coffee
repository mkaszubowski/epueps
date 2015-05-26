React = require('react')

R = React.DOM

Subject = React.createClass
  render: ->
    if this.props.subject.description.length > 200
      description = this.props.subject.description.substring(0, 200) + '...'
    else
      description = this.props.subject.description

    R.article
      className: 'subject'
      R.h2(null, R.a({href: this.props.path}, this.props.subject.name ))
      R.img({src: this.props.subject.image.url, alt: this.props.subject.name})

      R.section
        className: 'description'
        description

      R.a(
        {
          href: this.props.path + '/info',
          className: 'button button-primary',
          id: 'subject-' + this.props.subject.id
        }
        'Zobacz kurs')


Subjects  = React.createClass
  getInitialState: ->
    return {
      subjects: [],
      scope: @props.scope || 'popular'
      }
  loadSubjectsFromServer: (scope)->
    url = 'subjects?'
    if @props.hasOwnProperty('limit')
      url += 'limit=' + @props.limit + '&'

    url += 'scope=' + scope

    $.ajax
      url: url
      dataType: 'JSON'
      success: (subjects) =>
        @setState({subjects: subjects})
      error: (xhr, status, error) ->
        console.log(error.toString())
  loadRecentSubjects: ->
    @loadSubjectsFromServer('recent')
  loadPopularSubjects: ->
    @loadSubjectsFromServer('popular')

  handlePopularClick: (e) ->
    e.preventDefault()
    @loadPopularSubjects()

  handleRecentClick: (e) ->
    e.preventDefault()
    @loadRecentSubjects()


  componentDidMount: ->
    @loadSubjectsFromServer(@props.scope || 'popular')

  render: ->
    R.div
      className: 'subject-section'
      R.div
        className: 'subject-scope-options'
        R.a({href: '#', onClick: @handlePopularClick}, 'Popularne ')
        '/'
        R.a({href: '#', onClick: @handleRecentClick}, ' Najnowsze')
      R.div
        className: 'subjects'
        for subject in @state.subjects
          React.createElement Subject, subject: subject

module.exports = Subjects
