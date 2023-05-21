import User from "../../models/user";

class MockSession {

    private _currentUser : User | null = null;
    private _token : string | null = null;
    private _loggedIn : boolean = false;
   
    get currentUser() : User | null {
        return new User(1,"System","System");
    }
    
    set currentUser(value: User | null ) {
    }

    get token() : string | null {
        return "test123abc";
    }
    
    set token(value: string | null ) {
    }

    get loggedIn() : boolean {
        return true;
    }
    
    set loggedIn(value: boolean) {
    }
}

export default MockSession;