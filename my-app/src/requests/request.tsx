interface IRequestHandler<TIn, TOut> {
    handle(request: TIn): TOut;
}

export default IRequestHandler;