import React from "react";
import logo from "../../Assets/Logo/logoStudent.jpg"
import disign from "./LogoInformations.module.css"

export default function LogoInformations() {
    return(
        <div className={disign.logo}>
            <img src={logo} />
        </div>
    )
}
