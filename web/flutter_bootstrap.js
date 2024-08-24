let currentRotation = 0;
const rotateCube = () => {
    const cube = document.getElementById("cube");
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

            if (currentRotation > 360) {
                console.log("App Loaded!", currentRotation)
                await appRunner.runApp();
                clearInterval(interval);
                hidePreloader();
            } else {
                const timeout = (360 / currentRotation) * 5000;
                console.log("App not Loaded!, addding timeout of ", timeout)
                setTimeout(async () => {
                    await appRunner.runApp();
                    clearInterval(interval);
                    hidePreloader();
                }, timeout);
            }
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
