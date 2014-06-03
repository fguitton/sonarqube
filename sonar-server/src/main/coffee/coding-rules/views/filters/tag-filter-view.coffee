define [
  'navigator/filters/choice-filters'
], (
  ChoiceFilters
) ->

  class TagFilterView extends ChoiceFilters.ChoiceFilterView

    initialize: ->
      super()
      @loadTags()
      # TODO Register an event handler to reload tags when they are modified on a rule


    loadTags: ->
      tagsXHR = jQuery.ajax
        url: "#{baseUrl}/api/rules/tags"

      that = @
      jQuery.when(tagsXHR).done (r) ->
        that.choices = new Backbone.Collection(
          _.map(r.tags, (tag) ->
            new Backbone.Model
              id: tag
              text: tag
          ))

        if that.tagToRestore
          that.restore(that.tagToRestore)
          that.tagToRestore = null
        that.render()

    restore: (value) ->
      unless @choices.isEmpty()
        super(value)
      else
        @tagToRestore = value
