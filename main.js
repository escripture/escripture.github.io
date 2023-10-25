
"use strict";


const html = document.querySelector("html");
//const a = document.querySelector("a");
//const div = document.querySelector("div");
//const p = document.querySelector("p");
//const h1 = document.querySelector("h1");
const chap = document.getElementsByClassName("chapterlabel");
const vers = document.getElementsByTagName("sup");

function toggleChap() {
  if (chap[0].style.display !== "block") {
    for (let i = chap.length - 1; i > -1; i--) {
      chap[i].style.display = "block";
    }
  } else {
    for (let i = chap.length - 1; i > -1; i--) {
      chap[i].style.display = "none";
    }
  }
}

function toggleVers() {
  if (vers[0].style.display !== "inline") {
    for (let i = vers.length - 1; i > -1; i--) {
      vers[i].style.display = "inline";
    }
  } else {
    for (let i = vers.length - 1; i > -1; i--) {
      vers[i].style.display = "none";
    }
  }
}




function mainToggle(event) {

  // tap/click feedback for testing
  /*
  if (html.style.backgroundColor !== "tan") {
    html.style.backgroundColor = "tan";
  } else {
    html.style.backgroundColor = "";
  }
  */

  // avoid toggle if clicking chapter link (an <a> tag)
  if (event.target.localName === "a") {
    return;
  }

  // catch psalms
  if (chap.length === 0) {
    // 2-way toggle: add verses, remove verses
    toggleVers();
  } else {
    // 3-way toggle: add chapters, add verses, remove chapter and verses
    // use chap[0] as an indicator of all chapter items
    if (chap[0].style.display !== "block"
      && vers[0].style.display !== "inline") {
      toggleChap();
    } else if (chap[0].style.display === "block"
      && vers[0].style.display !== "inline") {
      toggleVers();
    } else {
      toggleChap();
      toggleVers();
    }
  }
}

/*
let flip = false;
function testa(event) {
  if (flip === false) {
    console.log(event);
    console.log(event.target.localName);
    alert("testa");
    flip = true;
  }
}
html.addEventListener("click", testa);
*/


html.addEventListener("click", mainToggle);

