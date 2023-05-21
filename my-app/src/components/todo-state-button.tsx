function TodoStateButton(props: { iconClass:string, value:boolean, value_changed:(newValue: boolean) => void }) {    
    const iconClass = `fa-solid ${props.iconClass} text-dark`;
    const buttonClass = `btn ${ props.value ? 'btn-info' : 'btn-outline-info' } me-2`;

    const onClick = () => props.value_changed(!props.value);

    return  <button type='button' className={buttonClass} onClick={onClick}>
                <i className={iconClass}></i>
            </button> 
}

export default TodoStateButton;
