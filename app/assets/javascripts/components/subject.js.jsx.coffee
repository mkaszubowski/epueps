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

    R.article
      className: 'subject'
      R.h2(null, R.a({href: path}, this.props.subject.name ))
      R.img({src: this.props.subject.image.url, alt: this.props.subject.name})

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
