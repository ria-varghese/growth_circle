import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sign-up"
export default class extends Controller {
  connect() {
    console.log("connected")
  }

  selectRole() {
    $("input[name='role']").change(function() {
      $("label").closest("div.role-option").removeClass("bg-blue-500 text-white").addClass("bg-white");

      $(this).closest("div.role-option").first().removeClass("bg-white").addClass("bg-blue-500 text-white");
    });
  }
}
