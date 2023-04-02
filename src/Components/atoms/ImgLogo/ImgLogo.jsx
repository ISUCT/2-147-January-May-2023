import React from "react";
import logos from "./assets/logoStudent.jpg"
import "./ImgLogo.scss"

export let ImgLogo = () =>{
    return(
    <div className='logo'>
        <img src={logos} />
    </div>
    )
}
