// JS
import Rails from 'rails-ujs';
import GOVUKFrontend from 'govuk-frontend';

import '../../../vendor/shared-web/app/assets/application/javascripts/location_picker';

import '../application/javascripts/investigations/attachment_description';
import '../application/javascripts/investigations/corrective_actions';
import '../application/javascripts/investigations/legislation_picker';
import '../application/javascripts/autocomplete';
import '../application/javascripts/creation_flow';
import '../application/javascripts/investigations';

// Styles
import 'govuk-country-and-territory-autocomplete/dist/location-autocomplete.min.css';
import 'accessible-autocomplete/dist/accessible-autocomplete.min.css';

// Images
import 'govuk-frontend/assets/images/favicon.ico';
import 'govuk-frontend/assets/images/govuk-mask-icon.svg';
import 'govuk-frontend/assets/images/govuk-crest-2x.png';
import 'govuk-frontend/assets/images/govuk-apple-touch-icon-180x180.png';
import 'govuk-frontend/assets/images/govuk-apple-touch-icon-167x167.png';
import 'govuk-frontend/assets/images/govuk-apple-touch-icon-152x152.png';
import 'govuk-frontend/assets/images/govuk-apple-touch-icon.png';
import 'govuk-frontend/assets/images/govuk-opengraph-image.png';
import 'govuk-frontend/assets/images/govuk-logotype-crown.png';

import '../application/images/document_placeholder.png';

Rails.start();
window.GOVUKFrontend = GOVUKFrontend;
