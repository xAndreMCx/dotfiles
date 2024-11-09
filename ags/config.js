import { bar } from './widgets/bar.js';
import { powerMenu } from './widgets/powerMenu.js';

function applyScss() {
  const scss = `${App.configDir}/styles/style.scss`;
  const css = `${App.configDir}/style.css`;

  Utils.exec(`sassc ${scss} ${css}`);

  App.resetCss;
  App.applyCss(css);

  // TODO: Maybe add a notification here
}

applyScss();
Utils.monitorFile(`${App.configDir}/styles`, applyScss);

App.addIcons(`${App.configDir}/assets/icons/`);

App.config({
  windows: [bar(), powerMenu()],
});