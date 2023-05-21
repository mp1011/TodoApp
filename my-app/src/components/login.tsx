import React, { MouseEvent } from 'react';
import { useEffect} from 'react';
import Session from '../services/session';
import { Container } from 'typedi';
import { LoginResponseCommand } from '../requests/login-reponse-command';

function Login() {
    const session = Container.get(Session);

    const onLoginClick = (event: MouseEvent<HTMLButtonElement>) => {  
        window.location.href = `http://localhost:3000/login?return=${window.location.href}`;
    };

    const onLogoutClick = (event: MouseEvent<HTMLButtonElement>) => {          

        session.currentUser = null;
        session.token = null;
        session.loggedIn = false;
        window.location.href = `http://localhost:3000/logout?return=${window.location.href}`;
    };
    
  
    useEffect(()=> {

        async function fetchData() {

            if(!session.loggedIn)
            {
                await new LoginResponseCommand(window.location.search).handle();
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

            <span className="badge bg-info m-0 ps-2 pe-0 py-0">
                <div className="d-flex align-items-center">
                    <p className="fs-6 p-0 m-0">Welcome, {session.currentUser?.name}!</p>
                    <button type="button"
                                className="btn btn-light m-2"
                                onClick={onLogoutClick}>Log out</button>
                </div>
            </span>)
    }
    else {
        return (
            <div>
                <button type="button"
                        className="btn btn-light"
                        onClick={onLoginClick}>Log in</button>
            </div>     
            );
    }
}


export default Login;
