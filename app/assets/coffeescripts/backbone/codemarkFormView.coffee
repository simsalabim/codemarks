App.CodemarkFormView = Backbone.View.extend
  className: 'codemark form-mode'
  tagName: 'article'

  events:
    'click .cancel': 'cancel'
    'submit': 'submit'

  render: ->
    #console.log 'AHHH no resource' unless @model.get('resource')?
    if @model.get('resource')? && !@model.get('resource').id?
      @fetchFullFormFor(@model.get('resource').url)
      return

    @$el.html(@toHtml())
    @selectTopics()

  fetchFullFormFor: (url) ->
    data = { url: url }
    $.ajax
      type: 'GET'
      url: '/codemarks/new'
      data: { url: url }
      success: (response) =>
        @model = new App.Codemark(response)
        @render()

  selectTopics: ->
    $topics = @$('.topics')
    _.map @model.get('topics'), (topic) ->
      $topics.find("option[value=#{topic.id}]").prop('selected', true)

  toHtml: ->
    template = angelo('codemarkForm.html')
    facile(template, @presentedAttributes())

  presentedAttributes: ->
    title: @model.get('title')
    description: @model.get('description') || ''
    topics: @presentedTopics()

  presentedTopics: ->
    _.map App.topics.models, (topic) ->
      possible_topic:
        value: topic.get('id')
        content: topic.get('title')

  cancel: ->
    @trigger('cancel')

  mode: ->
    if @model.get('id')?
      'update'
    else
      'new'

  submit: (e) ->
    e.preventDefault()
    @updateCodemark()

  updateCodemark: ->
    if @model.get('id')
      $.ajax
        type: 'PUT'
        url: "codemarks/#{@model.get('id')}"
        data: @data()
        success: (response) =>
          @model.attributes = JSON.parse(response.codemark)
          @trigger('updated')
    else
      $.ajax
        type: 'POST'
        url: 'codemarks'
        data: @data()
        success: (response) =>
          @trigger('created', JSON.parse(response.codemark))

  data: ->
    console.log @model
    data = codemark:
      title: @$('.title').val()
      description: @$('.description').val()
      resource_type: 'LinkRecord'
      resource_id: @model.get('resource').id
    data.codemark['topic_ids'] = @$('.topics').val() if @$('.topics').val()?
    data
