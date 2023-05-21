import LoginInfo from '../models/login-info';
import ApiClient from '../services/api-client';
import { Container, Service, ContainerInstance } from 'typedi';
import IRequestHandler from './request';
import Session from '../services/session';

class LoginResponseCommand {
    query : string;

    constructor(query: string ) {
        this.query = query;
    }

    async handle() : Promise<LoginInfo>
    {
        const handler = Container.get(LoginResponseCommandHandler);
        return await handler.handle(this);
    }
}

@Service({ global: true })
class LoginResponseCommandHandler implements IRequestHandler<LoginResponseCommand,LoginInfo>
{
    private apiClient : ApiClient;
    private session : Session;

    constructor(container:ContainerInstance ) {
        this.apiClient = container.get(ApiClient);
        this.session = container.get(Session);
    }

    async handle(request:LoginResponseCommand) : Promise<LoginInfo>
    {
        const queryString = new URLSearchParams(request.query);
        const token = queryString.get('token');

        if(!token)
        {
            console.log("not logged in");
            this.session.loggedIn=false;
            return new LoginInfo();
        }

        this.session.token = token;
        this.session.currentUser = await this.apiClient.getCurrentUser();
        this.session.loggedIn=true;

        console.log(`current user = ${this.session.currentUser.name}`);

        return new LoginInfo(this.session.currentUser, token);
    }
}


export { LoginResponseCommand,LoginResponseCommandHandler};