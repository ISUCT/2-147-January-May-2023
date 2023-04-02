import React from "react";

import "./Header.scss";
import {HeaderLink, LogoInformations, SeekFooter} from "../../atoms/HeaderAtoms";

const Header = () => {
    return (
        <header className="header">
            <div className="headerWiwe">
            <HeaderLink />
            <LogoInformations />
            <SeekFooter />
            </div>
        </header>
    )
}

export default Header;