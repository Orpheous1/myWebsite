var t = 0;
var slideIndex = 1;
var autoslide = setInterval(function () { plusSlides(1); }, 3000);
var d = ["1"];
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
  var c = slideIndex;
  document.getElementById(c).src = "../Images/80x80/img" + c + ".jpg";
  for (var j = 1; j <= 6; j++) {
    if (j != c) {
      document.getElementById(j).src = "../Images/50x50/img" + j + ".jpg";
    }
  }
}

function currentSlide(n) {
  showSlides(slideIndex = n);
  document.getElementById(n).src = "../Images/80x80/img" + n + ".jpg";
  for (let j = 1; j <= 6; j++) {
    if (j != n) {
      document.getElementById(j).src = "../Images/50x50/img" + j + ".jpg";
    }
  }
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  var captionText = document.getElementById("caption");
  if (n > slides.length) { slideIndex = 1 }
  if (n < 1) { slideIndex = slides.length }
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex - 1].style.display = "block";
  dots[slideIndex - 1].className += " active";
  captionText.innerHTML = dots[slideIndex - 1].alt;
}
function start() {
  document.getElementsByClassName("button")[0].disabled = true;
  document.getElementsByClassName("button")[1].disabled = true;
  autoslide;
}
function init() {
  if ((d.length)) {
    clearInterval(autoslide);
    document.getElementsByClassName("button")[0].disabled = false;
    document.getElementsByClassName("button")[1].disabled = false;
  }
  d.push("1");
}
function buttonstart() {
  autoslide = setInterval(function () { plusSlides(1); }, 3000);
  autoslide;
  document.getElementsByClassName("button")[0].disabled = true;
  document.getElementsByClassName("button")[1].disabled = true;
  d = [];
}