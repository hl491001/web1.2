(function() {
  var el = document.getElementById('flashMsg');
  if (el) {
    setTimeout(function() {
      el.style.opacity = '0';
      el.style.transition = 'opacity 0.5s ease';
      setTimeout(function() { if (el.parentNode) el.remove(); }, 500);
    }, 3000);
  }
})();

document.addEventListener('click', function(e) {
  var img = e.target.closest('.product-thumb');
  if (!img || img.tagName !== 'IMG') return;
  var existing = document.getElementById('img-overlay');
  if (existing) { existing.remove(); return; }
  var overlay = document.createElement('div');
  overlay.id = 'img-overlay';
  overlay.style.cssText = 'position:fixed;inset:0;z-index:9999;background:rgba(0,0,0,0.75);display:flex;align-items:center;justify-content:center;cursor:pointer;';
  overlay.addEventListener('click', function() { overlay.remove(); });
  var bigImg = document.createElement('img');
  bigImg.src = img.src;
  bigImg.style.cssText = 'max-width:90vw;max-height:90vh;border-radius:12px;box-shadow:0 25px 60px rgba(0,0,0,0.4);';
  overlay.appendChild(bigImg);
  document.body.appendChild(overlay);
});

document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') {
    var overlay = document.getElementById('img-overlay');
    if (overlay) overlay.remove();
  }
});
