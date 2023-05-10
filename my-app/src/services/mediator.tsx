import { Container } from 'typedi';
import IRequestHandler from '../requests/request';

class Mediator {
    static myStaticProperty: string = "Hello, world!";
    
    static async send<TIn,TOut>(input:TIn) : Promise<TOut> {          
        
        let inputAny:any = input;
        let handlerName = `${inputAny.constructor.name}Handler`;

        let handler = {} as IRequestHandler<TIn,TOut>;
        
        try {
            handler = Container.get(handlerName);           
        } 
        catch(e) {
            console.error(`Cannot create instance of type ${handlerName}`);  
            throw(e);          
        }

        return await handler.handle(input);
    }
  }

  export default Mediator