
var appRunner;
const button = document.getElementById("skip_btn")

button.addEventListener(("click"), async () => {
    await appRunner.runApp();
})

const initialize = () => {
    { { flutter_js } }
    { { flutter_build_config } }
    _flutter.loader.load({
        onEntrypointLoaded: async function (engineInitializer) {
            appRunner = await engineInitializer.initializeEngine();
            const timeout = 25000;
            button.classList.add('active')
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
