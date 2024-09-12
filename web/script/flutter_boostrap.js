{ { flutter_js } }
{ { flutter_build_config } }

console.log("Loading ...")
const loading = document.createElement('div');
document.body.appendChild(loading);
loading.textContent = "Loading Entrypoint...";
_flutter.loader.load({
    onEntrypointLoaded: async function (engineInitializer) {
        loading.textContent = "Initializing engine...";
        const appRunner = await engineInitializer.initializeEngine();

        console.log("App loaded!")
        loading.textContent = "Running app...";
        await appRunner.runApp();
    }
});