const compassContainer = document.querySelector('.compass-container');
const compassText = document.querySelector('.compass p');
const streetNameText = document.querySelector('.street-name p');
const areaNameText = document.querySelector('.area-name p');


window.addEventListener('message', function(event){
    const data = event.data;

    if (data.toggle === 'show') {
        compassContainer.style.display = 'flex';
        setTimeout(() => {
        compassContainer.classList.add('visible');
        }, 300);
    } 
    else if (data.toggle === 'hide') {
        compassContainer.classList.remove('visible');
        setTimeout(() => {
            compassContainer.style.display = 'none';
        }, 300);
        return;
    };

    if (compassText && data.compass) {
        compassText.textContent = data.compass;
    };

    if (streetNameText && data.streetName) {
        streetNameText.textContent = data.streetName;
    };

    if (areaNameText && data.areaName) {
        areaNameText.textContent = data.areaName;
    };
})