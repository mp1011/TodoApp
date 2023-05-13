import React, { MouseEvent } from 'react';

function LoginComponent() {

    const onClick = (event: MouseEvent<HTMLInputElement>) => {  
        window.location.href = `http://localhost:3000/login?return=${window.location.href}`;
    };
    
    const queryString = new URLSearchParams(window.location.search);
    const token = queryString.get('token');

    return (

        <div>
            <p>Token = {token}</p>
            <input  type='button'
                    value='Log In'
                    onClick={onClick} />           
        </div>
    );
}


export default LoginComponent;
