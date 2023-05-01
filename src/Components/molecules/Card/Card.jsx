import React from "react";
import { HeaderCard } from "../../atoms/HeaderCard";
import styles from './Card.module.scss'

export let Card = () =>{
    return(
        <div className={styles.Card}>
            <HeaderCard />
        </div>
    );
} 
