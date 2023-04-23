import { Service } from 'typedi';

@Service({ global: true })
class AppSettings {

    readonly host_name:string;

    constructor(){

        this.host_name = "http:\\\\localhost:3000\\"
    }
}

export default AppSettings