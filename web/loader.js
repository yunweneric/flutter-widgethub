
document.addEventListener("DOMContentLoaded", () => {
    // Detects the user's preferred color scheme
    const userPrefersDark =
      window.matchMedia &&
      window.matchMedia("(prefers-color-scheme: dark)").matches;

    // Apply the dark mode class if the user prefers dark mode
    if (userPrefersDark) {
      document.body.classList.add("dark-mode");
    }

    // Listen for changes to the user's color scheme preference
    window
      .matchMedia("(prefers-color-scheme: dark)")
      .addEventListener("change", (e) => {
        if (e.matches) {
          document.body.classList.add("dark-mode");
        } else {
          document.body.classList.remove("dark-mode");
        }
      });
    const textElement = document.querySelector(".animated-text");
    const strings = [
      "Hi!",
      "Welcome to Flutter Widget Hub!",
      "Enjoy Our Vast Collection of Flutter Templates, Blocks, Animations and Effects",
      "We are getting everything ready for you!",
      "Initial Load time might be longer than expected, Please stay put!",
    ];
    let index = 0;

    function animateText() {
      // Remove 'active' class to initiate fade out and zoom out
      textElement.classList.remove("active");
      textElement.classList.add("hidden");

      setTimeout(() => {
        // After the text fades out, change the text content
        textElement.textContent = strings[index];

        // Remove 'hidden' class to reset the scale and opacity before adding 'active'
        textElement.classList.remove("hidden");
        textElement.classList.add("active");

        // Move the current item to the end of the list to create an infinite loop
        // strings.push(strings.shift());

        index = (index + 1) % strings.length;
      }, 1000); // Wait for fade-out and zoom-out to complete (1 second)
    }

    // Initial call to start the animation
    animateText();

    // Set an interval to animate the text every 2 seconds
    setInterval(animateText, 5000);
  });