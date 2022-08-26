import { Controller } from "@hotwired/stimulus"
import $ from 'jquery';
import 'select2';

// Connects to data-controller="select2"
export default class extends Controller {
  connect() {
    console.log('Select2 controller conected')
    $('.select2').select2();
  }
}
