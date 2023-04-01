import React from 'react';
import { useState } from 'react';

function TodoInput(props: { onTextEntered: (text: string) => void }){

    const [text, setText] = useState('');

    const handleKeyDown = (event: React.KeyboardEvent<HTMLInputElement>) => {
        if (event.key === 'Enter') {
          event.preventDefault();
          props.onTextEntered(text);
        }
      };

    const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setText(event.target.value);
    };

    return (

        <div>
            <input 
                type='text'
            />

            <input 
                type='text'
                value={text}
                onKeyDown={handleKeyDown}
                onChange={handleChange}
            />
        </div>
    );
}

export default TodoInput;
