const filterDrawer = document.getElementById("filter-drawer");
const filterButton = document.getElementById("filter-button");
const closeFilter = document.getElementById("close-filter");

filterButton.onclick = () => {
    filterDrawer.style += "translate: 0vw";
}

closeFilter.onclick = () => {
    filterDrawer.style = "translate: 100vw";
}
