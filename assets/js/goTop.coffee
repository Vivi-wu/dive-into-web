---
# Toggle Go Top button and go up smoothly
---

toggle_gotop_button = (goTop) ->
  threshold = 500

  set_status = ->
    current_position = window.scrollY

    if current_position < threshold
      goTop.className = ''
    else
      goTop.className = 'show'

  go_top = ->
    FPS = 60
    scrollToTop = window.setInterval( ->
      pos = window.scrollY
      if pos > 0
        window.scrollTo 0, pos - 200
      else
        window.clearInterval scrollToTop
    , 1000/FPS)

  window.addEventListener('scroll', set_status, true)
  goTop.addEventListener('click', go_top, true)

  set_status()

window.onload = ->
    toggle_gotop_button(document.getElementById('go-top-button'))
