React = require('react')
$ = require('jquery')

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

module.exports = Subject
