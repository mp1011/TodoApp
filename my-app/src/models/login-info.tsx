import User from "./user";

class LoginInfo {

    readonly user: User;
    readonly token: string;
    readonly loggedIn : boolean;

    constructor(user?: User, token?: string | null) {
        this.user = user || new User(0,"","");
        this.token = token || "";
        if(user && token)
            this.loggedIn=true;
        else 
            this.loggedIn=false;
    }
}

export default LoginInfo;