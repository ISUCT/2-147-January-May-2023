import React from "react";
import disign from "./StyleHeder/LogoInformations.module.css"
import logo from "./assets/logoStudent.jpg"

export default function LogoInformations() {
    return(
        <div className={disign.logo}>
            <img src={logo} />
        </div>
    )
}
