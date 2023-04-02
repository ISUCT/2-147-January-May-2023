import React from "react";
import disign from "./HeaderLink.module.css";
import { Links } from "../../atoms/Links/Links";

export default function HeaderLink() {
    return (
        <div className={disign.link}> {/* molecule */}
            <div className={disign.leftButton}> 
                <Links links="Сервисы"/>  {/* atom */}
                <Links links="Центр поддержки"/>
            </div>
            <div className={disign.rightButton}>
                <Links links="Войти"/>
            </div>
        </div>
    )
}
