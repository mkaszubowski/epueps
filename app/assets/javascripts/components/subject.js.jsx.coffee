React = require('react')
$ = require('jquery')

R = React.DOM

Subject = React.createClass
  render: ->
    path = '/subjects/' + this.props.subject.slug
    if this.props.subject.description.length > 200
      description = this.props.subject.description.substring(0, 200) + '...'
    else
      description = this.props.subject.description

    R.section
      className: 'subject-wrapper col-md-4 col-sm-6'
      R.article
        className: 'subject col-md-4 col-sm-6'
        R.header
          className: 'subject-header'
          R.section(className: 'gradient-overlay', '')
          R.h2(null, R.a({href: path}, this.props.subject.name ))
          R.img({src: this.props.subject.image_url, alt: this.props.subject.name})

        R.section
          className: 'description'
          description

        R.a(
          {
            href: path + '/info',
            className: 'button button-primary',
            id: 'subject-' + this.props.subject.id
          }
          'Zobacz kurs')

module.exports = Subject
