function create_buttons()  {
    $("input[type=\"submit\"]").button();
    $("input[type=\"button\"]").button();
    $("button").button();
    $("td>a, div>a").button();
}

function disable_form() {
     $('form.readonly input').prop('disabled', true);
     $('form.readonly select').prop('disabled', true);
}

$(document).ready( function() {
    create_buttons();
    disable_form();
});
