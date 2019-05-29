// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import 'sanitize.css';
import 'sanitize.css/typography.css';
import 'sanitize.css/forms.css';
import css from "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import LiveSocket from "phoenix_live_view";

let liveSocket = new LiveSocket("/live");
liveSocket.connect();

document.addEventListener("phx:update", function(event) {
  const chatHeaderElement = document.querySelector(".js-chat-header")
  if (chatHeaderElement) {
    const chatUsersElement = document.querySelector(".js-chat-users")
    const chatContentElement = document.querySelector(".js-chat-content")
    chatHeaderElement.addEventListener("click", function (event) {
      console.log(chatContentElement.style.display);

      if (chatContentElement.style.display == "flex") {
        chatContentElement.style.display = "none";
        chatUsersElement.style.display = "block";
      } else {
        chatUsersElement.style.display = "none";
        chatContentElement.style.display = "flex";
      }
    })
  }
});

