


const initialize = () => {
    {{flutter_js}}
    {{flutter_build_config}}
    _flutter.loader.load({
        onEntrypointLoaded: async function (engineInitializer) {
            const appRunner = await engineInitializer.initializeEngine();           
                const timeout = 10000;
                console.log("App not Loaded!, adding timeout of ", timeout, "timeout", timeout)
                setTimeout(async () => {
                    await appRunner.runApp();
                }, timeout);
    
        },
    });
};


try {
    window.addEventListener("load", () => {
        console.log("flutter loaded!")
        initialize();
    });
} catch (error) {
    console.log(error);
}
