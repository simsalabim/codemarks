define ['text!../../templates/codemark.html'], (template) ->
  CodemarkView = Backbone.View.extend
    className: 'codemark'
    tagName: 'section'

    initialize: ->
      console.log @model
      #console.log template

    render: ->
      @$el.append(@toHTML())

    toHTML: ->
      console.log @model.attributes.topics.title
      facile(template, @model.attributes)
