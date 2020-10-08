import "stylesheets/application.scss";
import "jquery";
import "bootstrap";
import { config, library, dom } from "@fortawesome/fontawesome-svg-core";

import {
  faUserCircle,
  faSearch,
  faEllipsisV,
  faCheck,
  faPlus,
} from "@fortawesome/free-solid-svg-icons";

import "controllers";

require("turbolinks").start();
require("@rails/ujs").start();
require("@rails/activestorage").start();

require("channels");

config.mutateApproach = "sync";

library.add(faUserCircle, faSearch, faEllipsisV, faCheck, faPlus);

dom.watch();
