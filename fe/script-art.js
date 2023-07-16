const api = 'http://localhost:3000/api/article'; // API の URL に置き換える

function addUser1() {

  const tt = document.getElementById('title').value;
  const des = document.getElementById('description').value;
  const bd = document.getElementById('body').value;
  
  fetch(`${api}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ article: { title: tt, description:des, body: bd} })
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
