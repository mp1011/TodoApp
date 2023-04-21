import { Container } from 'typedi';
import IRequestHandler from '../requests/request';

class Mediator {
    static myStaticProperty: string = "Hello, world!";
    
    static async send<TIn,TOut>(input:TIn) : Promise<TOut> {          
        
        let inputAny:any = input;
        let handlerName = `${inputAny.constructor.name}Handler`;

        try {
            let handler : IRequestHandler<TIn,TOut> = Container.get(handlerName);
            return await handler.handle(input);
        } 
        catch(e) {
            console.error(`Cannot create instance of type ${handlerName}`);  
            throw(e);          
        }
    }
  }

  export default Mediator