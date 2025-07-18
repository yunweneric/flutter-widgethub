
var appRunner;
const button = document.getElementById("skip_btn")
const alwaysSkipButton = document.getElementById("always_skip_btn")

alwaysSkipButton.addEventListener(("click"), async () => {
    localStorage.setItem("always_skip", "true")
    await appRunner.runApp();
    document.getElementById("preloader").style.display = "none";
})

button.addEventListener(("click"), async () => {
    await appRunner.runApp();
    document.getElementById("preloader").style.display = "none";
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
            // console.log("App not Loaded!, adding timeout of ", timeout, "timeout", timeout)
            setTimeout(async () => {
                await appRunner.runApp();
                document.getElementById("preloader").style.display = "none";
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
