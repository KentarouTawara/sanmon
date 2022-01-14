const btn = document.getElementById("toggle-button");
const menu = document.getElementById("hanbager");

btn.addEventListener("click", () => {
	menu.classList.toggle("hidden");
});