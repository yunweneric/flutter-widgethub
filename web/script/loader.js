
// Hide preloader once the app is fully loaded
window.addEventListener('load', () => {
    const preloader = document.getElementById('preloader');
    preloader.style.display = 'none';
    console.log("Page loaded!")
});
