React = require('react')
$ = require('jquery')

R = React.DOM

ContactForm = React.createClass
  getInitialState: ->
    return {
      name: "",
      email: "",
      message: ""
    }
  checkIfValid: (target) ->
    valid = @state.name != "" &&
            @state.email != "" &&
            @state.message != ""
    valid
  handleNameChange: (e) ->
    @setState(name: e.target.value, ->
      @checkIfValid(e))
  handleEmailChange: (e) ->
    @setState(email: e.target.value, ->
      @checkIfValid(e))
  handleMessageChange: (e) ->
    @setState(message: e.target.value, ->
      @checkIfValid(e))
  clearFields: ->
    @setState(
      name: ""
      email: ""
      message: ""
    )
  sendContactEmail: (e) ->
    e.preventDefault()
    $.ajax
      url: '/contact_emails'
      method: 'POST'
      dataType: 'JSON',
      data:
        contact_email: @state
      beforeSend: (xhr) ->
        token = $("meta[name='csrf-token']").attr("content");
        xhr.setRequestHeader("X-CSRF-Token", @getCSRFTokenValue());
      success: (contact_email) =>
        @clearFields()
      error: (xhr, status, error) =>
        console.log(status + " " + error.toString())
        console.log(xhr)
  render: ->
    R.form
      onSubmit: @sendContactEmail,
      className: 'custom-form'
      R.h1(null, 'Kontakt')
      R.label(for: 'name', 'Imię:')
      R.input(type: 'text', name: 'name', value: @state.name, onChange: @handleNameChange)
      R.label(for: 'email', 'Email:')
      R.input(type: 'text', name: 'email', value: @state.email, onChange: @handleEmailChange)
      R.label(for: 'message', 'Wiadomość:')
      R.textarea(name: 'message', value: @state.message, onChange: @handleMessageChange)
      R.input(type: 'submit', value: 'Wyślij', className: 'button button-primary')

module.exports = ContactForm
