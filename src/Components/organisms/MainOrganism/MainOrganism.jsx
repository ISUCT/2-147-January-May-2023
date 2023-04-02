import React from "react";
import {Header, Border, Forum} from "../../cells/"

import "../../templates/tamplateMainPage.scss"

export let MainOrganism = () => {
    return(
        <div className="wrapper">
            <Header />
            <Border />
            <div className='wrapper-content'>
                <Forum />
            </div>
        </div>
    )
} 
