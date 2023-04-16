import React from "react";
import styles from './HeaderBar.module.scss'
import FlexContainer from "../../common/FlexContainer/FlexContainer";

export let HeaderBar = (props) =>{
    return(
        <div className={styles.HeaderBar}>
            <div className={styles.FontsPosition}>
                <div>Сервесы</div>
                <div>списки</div>
            </div>
            <div className={styles.FontsPosition}>
                <div>Войти</div>
                <div>Создать аккаунт</div>
            </div>                
        </div>
    );
} 
