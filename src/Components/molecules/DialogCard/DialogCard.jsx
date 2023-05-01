import React from "react";
import { HeaderCard } from "../../atoms/HeaderCard";
import styles from './DialogCard.module.scss'

export let DialogCard = () =>{
    return(
        <div className={styles.Card}>
            <HeaderCard />
        </div>
    );
} 
