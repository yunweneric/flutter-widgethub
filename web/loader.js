let currentRotation = 0;

const rotateCube = () => {


    const cube = document.getElementById("cube");

    // Update the rotation angle
    currentRotation += 90;

    // Apply the new rotation
    cube.style.transform = `rotateX(${currentRotation}deg)`;

}

const initialize = () => {
    const interval = setInterval(rotateCube, 5000);
}

const hidePreloader = () => {
    const preloader = document.getElementById('preloader');
    preloader.style.display = 'none';
}



try {
    initialize();
} catch (error) {
    console.log(error)
}


// I want to create an onboarding animation with html,css and js.

// I have a list of text to display. After 5 seconds, I want to animate to the next item in the list. This animation is smooth, it should fade in, slide in and rotate the text in the y direction from the bottom to the center of the page. When moving to the next item, the previous item should slide out,fade out and rotate in the -y axis from the center to the top of the page while the next item repeats the next item animation. 

// Do this just with html,css and js