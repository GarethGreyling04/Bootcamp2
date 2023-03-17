//document.getElementById("lefteye").style.backgroundColor =
//"purple";

//document.getElementById("head").style.transform =
//"rotate(15deg)";

//document.getElementById("body").style.border = 
//"2px blacksolid";

//document.getElementById("mouth").style.borderRadius =
//"4px";

//document.getElementById("righteye").style.border =
//"4px yellow dotted";

//.getElementById("leftarm").style.backgroundColor =
//"#FF00FF";

//document.getElementById("head").style.borderTop =
//"5px black solid";


//asked

//document.getElementById("head").style.transform =
//"rotate(-15deg)";

//document.getElementById("nose").style.borderRadius =
//"50%";

//document.getElementById("rightarm").style.backgroundColor =
//"green";

//document.getElementById("mouth").style.backgroundColor =
//"pink";

var rightEye = document.getElementById("righteye");
var leftEye = document.getElementById("lefteye");
var leftArm = document.getElementById("leftarm");

rightEye.addEventListener("click", moveUpDown);
leftEye.addEventListener("click", moveUpDown);
leftArm.addEventListener("click", moveRightLeft);


function moveUpDown(e) {
  var robotPart = e.target;
  var top = 0;

  var id = setInterval(frame, 10) // draw every 10ms

  function frame() {
    robotPart.style.top = top + '%';    
    top++;
    if (top === 20){
      clearInterval(id);
    }
  }
  
}


function moveRightLeft(e) {
  var robotPart = e.target;
  var left = 0;
  var id = setInterval(frame, 10) // draw every 10ms
  function frame() {
    robotPart.style.left = left + '%';
    left++;
    if (left === 70){
      clearInterval(id);
    }
  }
}
