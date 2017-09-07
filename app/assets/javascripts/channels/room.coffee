App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("tbody#cast_messages").prepend(data['message_html']);

    $(".b_msg_body").text(data['message_text'])
    
    $(".b_msg_body").on "click", ->
      window.location.replace("/gen/show_message/"+data['m_link']);

    $(".b_message").show();
    setTimeout (->
      $(".b_message").hide(1000);
    ), 5000 
    # Called when there's incoming data on the websocket for this channel

  message: (text) ->
    @perform 'message', message: text

$(document).ready ->
  $("#send_message").on "click", ->
    if $("#boradcast_msg").val().length
      App.room.message $("#boradcast_msg").val();
      $("#boradcast_msg").val("");