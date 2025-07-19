
var appRunner;
const button = document.getElementById("skip_btn")
const alwaysSkipButton = document.getElementById("always_skip_btn")

alwaysSkipButton.addEventListener(("click"), async () => {
    localStorage.setItem("always_skip", "true")
    await appRunner.runApp();
})

button.addEventListener(("click"), async () => {
    await appRunner.runApp();
})

const initialize = () => {
    {{flutter_js}}
    {{flutter_build_config}}
    _flutter.loader.load({
        onEntrypointLoaded: async function (engineInitializer) {
            appRunner = await engineInitializer.initializeEngine();
            // const timeout = 25000;
            const timeout = localStorage.getItem("always_skip") ? 0 : 25000;
            
            button.classList.add('active')
            alwaysSkipButton.classList.add('active')
            await appRunner.runApp();
            // console.log("App not Loaded!, adding timeout of ", timeout, "timeout", timeout)
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
