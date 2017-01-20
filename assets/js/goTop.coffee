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
    pos = window.scrollY
    if pos > 0
      window.requestAnimationFrame go_top
      window.scrollTo 0, pos - 100

  window.addEventListener 'scroll', set_status, true
  goTop.addEventListener 'click', go_top, true

window.onload = ->
    toggle_gotop_button document.getElementById('go-top-button')
