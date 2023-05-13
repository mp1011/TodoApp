import { Service } from 'typedi';
import User from '../models/user';

@Service({ global: true })
class Session {

    private _currentUser : User | null = null;
    private _token : string | null = null;
    private _loggedIn : boolean = false;
   
    get currentUser() : User | null {
        const json = localStorage.getItem("currentUser");
        if(json)
            return JSON.parse(json);
        else 
            return null;
    }
    
    set currentUser(value: User | null ) {
        if(value) 
            localStorage.setItem("currentUser", JSON.stringify(value));
        else 
            localStorage.removeItem("currentUser");
    }

    get token() : string | null {
        return localStorage.getItem("token");
    }
    
    set token(value: string | null ) {
        if(value) 
            localStorage.setItem("token", value);
        else 
            localStorage.removeItem("token");
    }

    get loggedIn() : boolean {
        return localStorage.getItem("loggedIn") === "true";;
    }
    
    set loggedIn(value: boolean) {
        if(value) 
            localStorage.setItem("loggedIn", "true");
        else 
            localStorage.removeItem("loggedIn");
    }
}

export default Session;