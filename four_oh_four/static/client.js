let fd = new FormData();
fd.set('href', location.href);

fetch('http://localhost:8080/', {
    method: 'POST',
    cache: 'no-cache',
    body: fd
}).then((response) => {
    console.log('four-oh-four fetch complete, ' + response.status);
});
