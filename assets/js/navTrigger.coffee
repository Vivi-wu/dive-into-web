---
# Toggle Navigation on mobile
---

eleTriggerShow = document.getElementById 'nav-trigger-show'
eleTriggerHide = document.getElementById 'nav-trigger-hide'
eleTarget = document.getElementById 'nav-target'

eleTriggerShow.addEventListener 'click', =>
    eleTarget.style.display = 'block'
    eleTriggerShow.style.display = 'none'
    eleTriggerHide.style.display = 'block'
    document.querySelector('.post-content').style.display = 'none'
    window.scrollTo 0,0


eleTriggerHide.addEventListener 'click', =>
    eleTarget.style.display = 'none'
    eleTriggerHide.style.display = 'none'
    eleTriggerShow.style.display = 'block'
    document.querySelector('.post-content').style.display = 'block'
