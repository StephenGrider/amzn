$ ->  
  $('.search-button').click ->
    options = {}
    if $('.option1-key').val()
      options[$('.option1-key').val()] = $('.option1-value').val()
      
    data = 
      type: $('.search-type:selected').text()
      term: $('.search-term').val()
      searchOptions: options
      
    $.post('/admin/amazon_items/search', data)
      .done (res) ->
        console.log res
        