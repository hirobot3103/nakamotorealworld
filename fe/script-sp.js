const api = 'http://localhost:3000/api/users'; // API の URL に置き換える

function addUser1() {
  const un = document.getElementById('username').value;
  const em = document.getElementById('email').value;
  const ps1 = document.getElementById('password').value;
  const ps2 = document.getElementById('passwordc').value;
  
  fetch(`${api}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ user: { username: un, email: em, password: ps1, password_confirmation: ps2} })
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
    document.getElementById('username').value = '';
    document.getElementById('email').value = '';
    document.getElementById('password').value = '';
    document.getElementById('passwordc').value = '';
  });
}
