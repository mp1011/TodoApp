import React from 'react';
import logo from './logo.svg';
import './App.css';
import TodoInput from './components/todo-input'; 

function App() {

  const onTodoTextEntered = (text: string) => {
    alert(`you said ${text}`);
  };

  return (
    <div className="App">
      <header className="App-header">

        <TodoInput onTextEntered={onTodoTextEntered} />
        
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload. (ok)
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
