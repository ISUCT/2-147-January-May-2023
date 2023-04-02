import React from "react";
import disign from "./LogoInformations.module.css"

import { ImgLogo } from "../../atoms/ImgLogo/ImgLogo";
import logos from "../../atoms/ImgLogo/assets/logoStudent.jpg"
export default function LogoInformations() {
    return(
        <div> {/* molecule */}
           <ImgLogo />{/* atom */}
        </div>
    )
}
