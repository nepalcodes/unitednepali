import React from "react";
import { Parallax, ParallaxLayer } from "react-spring/renderprops-addons";
import styles from "./DefaultPage.module.css";
import { Card } from "./Card";
import { useOrganizations } from "../hooks/useOrganizations";

const url = (name, wrap = false) =>
  `${
    wrap ? "url(" : ""
  }https://awv3node-homepage.surge.sh/build/assets/${name}.svg${
    wrap ? ")" : ""
  }`;

const Background = () => {
  return (
    <>
      <ParallaxLayer
        offset={0.9999}
        speed={1}
        style={{ backgroundColor: "#ff5757AA" }}
      />
      <ParallaxLayer
        offset={1.9999}
        speed={1}
        style={{ backgroundColor: "#87BCDE" }}
      />

      <ParallaxLayer
        offset={0}
        speed={0}
        factor={3}
        style={{
          backgroundImage: url("stars", true),
          backgroundSize: "cover",
        }}
      />

      <ParallaxLayer
        offset={1.3}
        speed={-0.3}
        style={{ pointerEvents: "none" }}
      >
        <img
          src={url("satellite4")}
          style={{ width: "15%", marginLeft: "70%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={1} speed={0.8} style={{ opacity: 0.1 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "55%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "10%", marginLeft: "15%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={1.75} speed={0.5} style={{ opacity: 0.1 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "70%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "40%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={1} speed={0.2} style={{ opacity: 0.2 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "10%", marginLeft: "10%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "75%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={1.6} speed={-0.1} style={{ opacity: 0.4 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "60%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "25%", marginLeft: "30%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "10%", marginLeft: "80%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={2.6} speed={0.4} style={{ opacity: 0.6 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "5%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "15%", marginLeft: "75%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer
        offset={2.5}
        speed={-0.4}
        style={{
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          pointerEvents: "none",
        }}
      >
        <img src={url("earth")} style={{ width: "60%" }} alt="" />
      </ParallaxLayer>
    </>
  );
};

export function DefaultPage() {
  const organizations = useOrganizations();

  return (
    <div className={styles.container}>
      <Parallax pages={2.5} scrolling={true} vertical>
        <Background />

        <ParallaxLayer offset={0} speed={0.5} className={styles.titleSection}>
          <div className={styles.logo}> </div>
          <h1> UNITED NEPALI</h1>
          <h2> सयौं थुँगा फूलका हामी, एउटै माला नेपाली </h2>
        </ParallaxLayer>

        <ParallaxLayer
          offset={0.75}
          speed={0.5}
          className={styles.titleSection}
        >
          <h1>OUR MISSION</h1>
          <div
            style={{
              width: "50%",
              backgroundColor: "rgba(50, 50, 50, 0.3)",
              padding: "15px 15px 15px 15px",
              borderRadius: "15px",
            }}
          >
            <b>
              United Nepali aims to be the go-to site to find Nepali Communities
              in your area. With hundreds of different communities which use
              various ways to spread information about events like meetup,
              eventbrite, community websites, email lists, etc. United Nepali
              will be the one place you can find everything.
            </b>
          </div>
        </ParallaxLayer>

        <ParallaxLayer offset={1.1} speed={0.75}>
          <div className={styles.organizationSection}>
            {organizations.map((organization) => (
              <Card
                key={organization.id}
                title={organization.name}
                description={organization.description}
                link={organization.id}
              />
            ))}
          </div>
        </ParallaxLayer>

        <ParallaxLayer offset={2} speed={0.5} className={styles.joinSection}>
          <a
            href="https://forms.gle/Wjk46ahVCnyuzpTu9"
            style={{ textDecoration: "none", color: "white" }}
          >
            <div className={`${styles.button} ${styles.startButton}`}>
              Getting Started!
            </div>
          </a>
        </ParallaxLayer>
      </Parallax>
    </div>
  );
}
