var a = new Array(78, 2, 34, 89, 789, 1, 90, 7, 66, 77); //We need these as global variables
var ticker = 0; //Same as above
function start() {
  document.body.innerHTML += ("<h1>Για να δούμε τι γίνεται…</h1>");
  inithtmltables(a);
  show("Αρχικά:", a);
  douleia(a);
  showsorted("Τελικά:", a);
}
function show(header, enaa) {
  document.getElementById("p1").innerHTML += header;
  for (var i = 0; i < enaa.length; ++i) {
    document.getElementById("" + i + 1).innerHTML = enaa[i];
  }
}
function showsorted(header, enaa) {
  document.getElementById("p2").innerHTML += header;
  for (var i = 0; i < enaa.length; ++i) {
    document.getElementById("" + i + 2).innerHTML = enaa[i];
  }
}
function douleia(enab) {
  for (var pass = 1; pass < enab.length; ++pass)
    for (var i = 0; i < (enab.length - 1); i++)
      if (enab[i] > enab[i + 1])
        allagi(enab, i, i + 1);
}
function allagi(enac, first, second) {
  var hold;
  hold = enac[first];
  enac[first] = enac[second];
  enac[second] = hold;
}
function inithtmltables(temp) {
  document.body.innerHTML += '<p id="p1"></p><table border="1"><tr id="table1"></tr></table>';
  for (var i = 0; i < temp.length; ++i) {
    document.getElementById("table1").innerHTML += '<td id=' + i + '1></td>';
  }
  document.body.innerHTML += '<p id="p2"></p><table border="1"><tr id="table2"></tr></table>';
  for (var i = 0; i < temp.length; ++i) {
    document.getElementById("table2").innerHTML += '<td id=' + i + '2></td>';
  }
}
//inithtmltables, show and showsorted be implemented better with a wrapper but I'm not writing wrapper functions for only 2 tables. Hardcoding is faster. Also, inithtmltables might be redundant, you could include these in the html file but the exercise is not well posed.
function mean(array) {
  var temp = 0;
  for (var i = 0; i < array.length; i++) {
    temp += (1 / array.length) * array[i];
  }
  return temp;
}
function std(array, mean) { //We include the mean in the definition so our client doesn't calculate the mean for each sum iteration. This might be unnecessary since the js JIT compiler might optimize this by default but I don't know how js compilers work.
  var temp = 0;
  for (var i = 0; i < array.length; i++) {
    temp += (1 / array.length) * Math.pow(array[i] - mean, 2);
  }
  return (Math.sqrt(temp));
}
function showdivs() {
  if (ticker != 1) { //making sure we don't create extra divs each time the onclick event is called
    document.body.innerHTML += ('<div>Η μέση τιμή είναι ' + mean(a) + '</div><div>Η τυπική απόκλιση είναι ' + std(a, mean(a)) + '</div>');
  }
  ticker = 1;
}