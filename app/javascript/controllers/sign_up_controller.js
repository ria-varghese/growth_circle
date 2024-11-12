import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sign-up"
export default class extends Controller {
  connect() {
    console.log("connected")
  }
  
  initialize(){
    this.toggleSubmitButton();
  }

  selectRole() {
    $("input[name='role']").change(function() {
      $("label").closest("div.role-option").removeClass("bg-blue-500 text-white").addClass("bg-white");

      $(this).closest("div.role-option").first().removeClass("bg-white").addClass("bg-blue-500 text-white");
    });
  }

  submitRole(event){
    event.preventDefault();
    const selectedRole = $('input[name="role"]:checked').val();

    if (selectedRole == "coach"){
      window.location.href = "/coaches/new"
    }
    else if(selectedRole == "employee"){
      window.location.href = "/employees/new"
      
    }
    else {
        alert("Please choose a role.");
    }
  }

  toggleSubmitButton() {
    const submitButton = $("input[type='submit']")
    const radioButtons = $("input[type='radio']")
    submitButton.disabled = !Array.from(radioButtons).some(radio => radio.checked);
  }
}
