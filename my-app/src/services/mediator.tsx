import { Container } from 'typedi';
import IRequestHandler from '../requests/request';
import { AddTodoRequestHandler } from '../requests/add-todo';

class Mediator {
    static myStaticProperty: string = "Hello, world!";
    
    static send<TIn,TOut>(input:TIn) : TOut {          
        
        let inputAny:any = input;
        let handlerName = `${inputAny.constructor.name}Handler`;

        try {
            let handler : IRequestHandler<TIn,TOut> = Container.get(handlerName);
            return handler.handle(input);
        } 
        catch(e) {
            console.error(`Cannot create instance of type ${handlerName}`);  
            throw(e);          
        }
    }
  }

  export default Mediator