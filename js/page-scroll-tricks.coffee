---
# Toggle Go Top button and go up smoothly
---

toggle_gotop_button = (win, goTop) ->
  threshold = 500

  set_status = ->
  	current_position = win.scrollTop()

  	if current_position < threshold
  		goTop.removeClass 'show-gotop'
  	else
  	  goTop.addClass 'show-gotop' if !goTop.hasClass 'show-gotop'

  go_top = ->
    $('html, body').animate { scrollTop: 0 }, '3000' 


  win.scroll set_status
  goTop.click go_top

  set_status()


$ ->
  if window.matchMedia("only screen and (max-width: 767px)").matches
    return false
  else
    win = $(window)
    topButton  = $('#go-top-button')
    toggle_gotop_button(win, topButton)
