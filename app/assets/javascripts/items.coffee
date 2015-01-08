class Amzn.ItemsView
  constructor: ->
    $('.like').click @onLikeClick
    $('.unlike').click @onUnlikeClick
    
  onLikeClick: (e) =>
    $item = $(e.target)
    id = $item.closest('tr').data('id')
    $.post('/api/v1/line_items', { item_id: id })
      .done( => @onLikeDone($item))
      
  onLikeDone: ($item) =>
    $item.parent().find('.unlike').removeClass('hidden')
    $item.addClass('hidden')
    
  onUnlikeClick: (e) =>
    $item = $(e.target)
    id = $item.closest('tr').data('id')
    $.ajax
      type: 'DELETE'
      url: "api/v1/line_items/#{id}"
      success: => @onUnlikeDone($item)
      
  onUnlikeDone: ($item) =>
    $item.parent().find('.like').removeClass('hidden')
    $item.addClass('hidden')

