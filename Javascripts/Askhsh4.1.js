var x = document.getElementsByClassName('panel');
var data = new Array("url('../Images/claus1.png')", "url('../Images/claus2.jpg')", "url('../Images/claus3.jpg')", "url('../Images/claus4.jpg')");
function main() {
  var stack = data;
  stack.push(stack[0]);
  stack.shift();
  for (l = 0; l < 4; l++) {
    x[l].style.backgroundImage = stack[l];
  }
    x[2].style.backgroundImage = stack[3];
    x[3].style.backgroundImage = stack[2];
  console.log(stack);
}