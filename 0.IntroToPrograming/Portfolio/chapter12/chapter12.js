
//todo: Create three global variables:

var trainSpeed = 250;

var trainPosition = 0;

var animation;

//todo: Listen for click events on the train element and
//call a function named speedUp when they happen.
var train = document.getElementById("train");
train.addEventListener("click", speedUp);


//todo: Listen for click events on the stop button element
//and call a function called stopTrain when they happen.
var stopButton = document.getElementById("stopButton");
stopButton.addEventListener("click", stopTrain);

function speedUp() {

    //Chapter 12: Making It Functional 201

    //todo: Check whether the train is already going as fastas it can. If not, increase the speed.
    if (trainSpeed > 10) {
        trainSpeed -= 10;
    }

    clearInterval(animation);
    animation = setInterval(frame, trainSpeed);


    //If the train is already moving, stop it and then restart with the new speed by calling a function called frame.

    function frame() {

        //todo: Reposition the train and check whether the train is crashed.

        trainPosition += 2;
        train.style.left = trainPosition + 'px';
        checkPosition(trainPosition);


    }
}

function stopTrain() {
    if (trainPosition < 260) {
        clearInterval(animation);
    }


    //todo: Test whether the train is already crashed. If not, stop the train.
}

///todo: Check the train's current position and crash it if it's at the end of the line.
function checkPosition(currentPosition) {
    if (currentPosition === 260) {
        alert("Crash!");
        console.log("Crash!");
        clearInterval(animation);
    }
}

