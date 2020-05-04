import React from 'react';
import styles from './DefaultPage.module.css';

export function Card({ title, description, link }) {
  return (
    <div
      className={styles.card}
    >
      <b>{title}</b>
      <hr />
      {description}
      <div className={`${styles.cardButton}`}>
        <a href={link}>Read more</a>
      </div>
    </div>
  );
}
