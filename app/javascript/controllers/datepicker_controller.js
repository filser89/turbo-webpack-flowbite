import { Controller } from "@hotwired/stimulus"
import Datepicker from 'flowbite-datepicker/Datepicker';
import DateRangePicker from 'flowbite-datepicker/DateRangePicker';

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = [ "source" ]
  connect() {
    console.log("datepicker controller connected :))")
    // console.log(this.sourceTarget.value)
    const datepickerEl = this.sourceTarget.querySelector("input");
    // const datepickerEl = document.getElementById('datepickerId');
    console.log({datepickerEl})
    let options = {
      overlayPlaceholder: 'Enter a 4-digit year'
    }
    new Datepicker(datepickerEl, {
        options
    });

    // const dateRangePickerEl = document.getElementById('dateRangePickerId');
    // new DateRangePicker(dateRangePickerEl, {
    // // options
    // });
  }
}
