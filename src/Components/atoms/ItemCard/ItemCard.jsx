import React from "react";
import FlexContainer from "../../common/FlexContainer/FlexContainer";

import styles from './ItemCard.module.scss'

export let ItemCard = (props) =>{
    return(
        <div>
            <div className={styles.leftTitle}>
                                <div className={styles.rightInformations}>
                                    <img src={props.src}/> 
                                    <a href="#">{props.text}</a>
                                </div>
                                <div>
                                    <span className={styles.leftInformations}>{props.teme}</span>
                                    <span>{props.like} like</span>
                                </div>
            </div>
            <div className={styles.divLine} />
        </div>

    );
} 
