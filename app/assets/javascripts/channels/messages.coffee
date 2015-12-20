App.messages = App.cable.subscriptions.create 'MessagesChannel',
  received: (data) ->
    if data.message == "New Photo Processing..."
      $('#photo_holder').hide()
    else
      $('#list').prepend @renderMessage(data)
      url = data.bigUrl
      $("#photo_holder").show().css("background-image", 'url(' + url + ')' )
      $('#photo_email_photo_id').val(data.photo)
    
  renderMessage: (data) ->
    img = $("<img src='#{data.thumbUrl}'>")
    img.data( data )
    li = $("<li></li>")
    li.html( img )
    window.current_photo = img.data()
    li