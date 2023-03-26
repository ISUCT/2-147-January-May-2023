import React from "react";

import logo from "../Assets/Logo/logoStudent.jpg"
// import cssHeader from "./Header.module.css";

import "./Header.scss";

import HeaderLink from "./HeaderLink/HeaderLink";
import LogoInformations from "./LogoInformations/LogoInformations";
import SeekFooter from "./SeekFooter/SeekFooter";

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