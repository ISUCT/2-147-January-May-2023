import React from "react";
import disign from "./HeaderLink.module.css"

export default function HeaderLink() {
    return (
        <div className={disign.link}>
            <div className={disign.leftButton}>
                <a href="#!">Сервисы</a>
                <a href="#!">Центр поддержки</a>
            </div>
            <div className={disign.rightButton}>
                <a href="#!" >Войти</a>
            </div>
        </div>
    )
}
