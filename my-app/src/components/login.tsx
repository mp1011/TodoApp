import React, { MouseEvent } from 'react';
import { useEffect} from 'react';
import Session from '../services/session';
import { Container } from 'typedi';
import Mediator from '../services/mediator';
import { LoginResponseCommand } from '../requests/login-reponse-command';
import LoginInfo from '../models/login-info';

function LoginComponent() {
    const session = Container.get(Session);

    const onLoginClick = (event: MouseEvent<HTMLInputElement>) => {  
        window.location.href = `http://localhost:3000/login?return=${window.location.href}`;
    };

    const onLogoutClick = (event: MouseEvent<HTMLInputElement>) => {          

        session.currentUser = null;
        session.token = null;
        session.loggedIn = false;
        window.location.href = `http://localhost:3000/logout?return=${window.location.href}`;
    };
    
  
    useEffect(()=> {

        async function fetchData() {

            if(!session.loggedIn)
            {
                const loginInfo : LoginInfo = await Mediator.send(new LoginResponseCommand(window.location.search));
                const queryString = new URLSearchParams(window.location.search);
                if(queryString.get('token'))
                {
                    queryString.delete('token');
                    window.location.href  = `${window.location.pathname}?${queryString.toString()}`;                    
                }
            }
        }

        fetchData();
    })

    if(session.loggedIn) {
        return ( 
        <div>
            <p>Welcome, {session.currentUser?.name}</p>
            <input  type='button'
                        value='Log Out'
                        onClick={onLogoutClick} />  
        </div>)
    }
    else {
        return (
            <div>
                <input  type='button'
                        value='Log In'
                        onClick={onLoginClick} />           
            </div>     
            );
    }
}


export default LoginComponent;
