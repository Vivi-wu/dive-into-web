---
# Toggle size of site's fixed header and Go Top button
---

toggle_fixed_header_size = ->
  win        = $(window)
  element    = $("#fixed-site-header")
  el_height  = $(element).height() + 2
  isMobile   = window.matchMedia("only screen and (max-width: 767px)").matches
  set_height = ->
    current_position = win.scrollTop()
    newH = 0

    if current_position < el_height/2
      newH = el_height - current_position
    else
      # border width included in the total height
      newH = el_height/2 + 1

    element.css
      "height":      newH + "px",
      "line-height": newH + "px"

  return false if isMobile

  win.scroll set_height
  set_height()


toggle_gotop_button = ->
  win       = $(window)
  go_top    = $("#go-top-button")
  threshold = 500
  set_status = ->
  	current_position = win.scrollTop()

  	if current_position < threshold
  		go_top.removeClass "show-gotop"
  	else
  	  go_top.addClass "show-gotop" if !go_top.hasClass "show-gotop"

  win.scroll set_status
  set_status()

$ ->
  toggle_fixed_header_size()
  toggle_gotop_button()
