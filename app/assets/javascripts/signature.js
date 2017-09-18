function resizeCanvas(canvas) {
    var ratio =  Math.max(window.devicePixelRatio || 1, 1);
    canvas.width = canvas.offsetWidth * ratio;
    canvas.height = canvas.offsetHeight * ratio;
    canvas.getContext("2d").scale(ratio, ratio);
}

$(document).ready(function () {
  var canvas = document.querySelector("canvas");
  if (canvas){
    canvas.height = canvas.offsetHeight;
    canvas.width = canvas.offsetWidth;
    window.onresize = resizeCanvas(canvas);
    resizeCanvas(canvas);
    signature_pad = new SignaturePad(canvas);
    $('.signature_pad_clear').click(function() { signature_pad.clear() });
    $('.signature_pad_save').click(function(event) {
      $('.signature_pad_input').val(signature_pad.toDataURL());
    });
  }
});