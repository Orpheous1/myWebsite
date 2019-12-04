function add(a, b)  {
  return a+b;
}
function start()  {
  // alert('Hello from JavaScript');
  var a = parseInt(document.getElementById('a').value);
  var b = parseInt(document.getElementById('b').value);
  alert (add(a,b));
}
