import React from "react";
import "./Header.scss";
import {HeaderLink, LogoInformations, SeekFooter} from'../../molecules/index'

export const Header = () => {
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
