// Boot-screen copy rotator. The engine swaps this whole page out once it
// boots, so keep it dependency-free and cheap. Light/dark and the logo
// swap are handled in CSS via prefers-color-scheme.
(() => {
  const HOLD = 3200; // ms a line stays on screen
  const FADE = 400; // ms the out-transition takes (matches loader.css)

  const lines = [
    "Welcome to Flutter WidgetHub",
    "Templates, blocks, animations and effects — production-ready",
    "Copy any component straight into your project",
    "Setting up your workspace",
    "First load takes a moment while the engine warms up",
  ];

  const el = document.querySelector(".animated-text");
  if (!el) return;

  let index = 0;
  let timer;

  const show = () => {
    el.textContent = lines[index];
    el.classList.remove("hidden");
    el.classList.add("active");
    index = (index + 1) % lines.length;
    timer = setTimeout(hide, HOLD);
  };

  const hide = () => {
    el.classList.remove("active");
    el.classList.add("hidden");
    timer = setTimeout(show, FADE);
  };

  // Pause while the tab is hidden so the copy isn't halfway through a
  // rotation when the visitor comes back.
  document.addEventListener("visibilitychange", () => {
    if (document.hidden) {
      clearTimeout(timer);
    } else {
      clearTimeout(timer);
      show();
    }
  });

  show();
})();
