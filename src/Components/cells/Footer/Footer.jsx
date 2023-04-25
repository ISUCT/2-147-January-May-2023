import React from "react";
import styles from './Footer.module.scss'
import { Icon } from "../../atoms/Icon";

import facebook from '../../../Public/Img/facebook.png'
import inst from '../../../Public/Img/inst.png'
import telega from '../../../Public/Img/telega.png'
import vk from '../../../Public/Img/vk.png'
import ws from '../../../Public/Img/ws.png'

export let Footer = (props) =>{
    return(
        <div className={styles.Footer}>
                <Icon src={facebook}/>
                <Icon src={inst}/>
                <Icon src={telega}/>
                <Icon src={vk}/>
                <Icon src={ws}/>
        </div>
    );
} 
