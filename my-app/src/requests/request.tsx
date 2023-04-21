interface IRequestHandler<TIn, TOut> {
    handle(request: TIn): Promise<TOut>;
}

export default IRequestHandler;