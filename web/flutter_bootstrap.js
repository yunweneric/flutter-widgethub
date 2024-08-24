// Detects the user's preferred color scheme
const userPrefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;

const cube =document.getElementById("cube");
// Apply the dark mode class if the user prefers dark mode
if (userPrefersDark) {
  document.body.classList.add('dark-mode');
  cube.classList.add('dark-mode');
}

// Listen for changes to the user's color scheme preference
window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
  if (e.matches) {
    document.body.classList.add('dark-mode');
    cube.classList.add('dark-mode');
} else {
    document.body.classList.remove('dark-mode');
    cube.classList.remove('dark-mode');
  }
});

let currentRotation = 90;
const rotateCube = () => {
    currentRotation += 90;
    cube.style.transform = `rotateX(${currentRotation}deg)`;
    console.log("currentRotation", currentRotation)
}

const initialize = () => {
    {{flutter_js}}
    {{flutter_build_config}}
    const interval = setInterval(rotateCube, 5000);
    _flutter.loader.load({
        onEntrypointLoaded: async function (engineInitializer) {
            const appRunner = await engineInitializer.initializeEngine();
            // if (currentRotation > 360) {
            //     console.log("App Loaded!", currentRotation)
            //     await appRunner.runApp();
            //     clearInterval(interval);
            //     hidePreloader();
            // } else {
            //     const timeout = (360 / currentRotation) * 5000;
            //     console.log("App not Loaded!, addding timeout of ", timeout,"currentRotation",currentRotation)
            //     setTimeout(async () => {
            //         await appRunner.runApp();
            //         clearInterval(interval);
            //         hidePreloader();
            //     }, timeout);
            // }
        }
    });
}

const hidePreloader = () => {
    const preloader = document.getElementById('preloader');
    preloader.style.display = 'none';
}

try {
    window.addEventListener("load",()=>{
        initialize();
    })
} catch (error) {
    console.log(error)
}
