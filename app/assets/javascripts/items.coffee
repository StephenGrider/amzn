class Amzn.ItemsView
  constructor: ->
    $('.like').click @onLikeClick
    
  onLikeClick: (e) =>
    $item = $(e.target)
    id = $item.closest('tr').data('id')
    $.post('/line_items', { item_id: id })
      .done( => @onLikeDone($item))
      
  onLikeDone: ($item) =>
    $item.parent().find('.unlike').removeClass('hidden')
    $item.addClass('hidden')

