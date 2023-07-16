const api = 'http://localhost:3000/api/login'; // API の URL に置き換える

function addUser1() {

  const em = document.getElementById('email').value;
  const ps1 = document.getElementById('password').value;
  const ps2 = document.getElementById('password').value;
  
  fetch(`${api}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email: em, password: ps1})
  })
  .then(response => response.json())
  .then(data => {
    const todoList = document.getElementById('notion');
    todoList.innerHTML = '';
    let listItem = document.createElement('li');
    listItem.className = 'todo-item';
    listItem.innerHTML = `${data.notion}`;
	  todoList.appendChild(listItem);
   })  
  .then(() => {
    document.getElementById('email').value = '';
    document.getElementById('password').value = '';
  });
}
