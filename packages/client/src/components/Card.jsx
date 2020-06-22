import React from 'react';
import PropTypes from 'prop-types';
import styles from './DefaultPage.module.css';

export default function Card({ title, description, link }) {
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

Card.propTypes = {
  title: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  link: PropTypes.string.isRequired,
};
