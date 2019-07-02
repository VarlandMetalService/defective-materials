//= require_tree .
function get_so_info(url, so_num){
    $('.dmr_hidden_fields').fadeOut('fast');
    $('.fa-refresh').addClass('fa-spin');
    if (so_num.toString().length == 6) {
      $.ajax({
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
          complete: function(xhr) {
          },
        url: url,
        data: { so_num: so_num }
      })  
    }
}
// error handling
function clear_validation_errors(){
  $.each($('.is-invalid'), function(index, input){
    $(input).removeClass('is-invalid')
    $(input).siblings('.invalid-feedback').remove()
  })
  $.each($('.is-valid'), function(index, input){
    $(input).removeClass('is-valid')
  })
}

function render_validation_errors(errors, prefix){
  $.each(errors, function(key, value){
    $(`#${prefix}${key}`).addClass('is-invalid');
    $(`#${prefix}${key}`).parent().append(`<div class='invalid-feedback'>${value}</div>`);
  });
}

function render_validation_confirmations(form_id, exclude){
  $.each($(`#${form_id}`).find(`.form-control:not(.is-invalid)`), function(index, input){
    $(input).addClass('is-valid')
  })
}

$( document ).on('tubolinks:load', function(){
  
  FilePond.registerPlugin(FilePondPluginFileEncode);
  FilePond.registerPlugin(FilePondPluginImageExifOrientation);
  FilePond.registerPlugin(FilePondPluginImagePreview);
  FilePond.registerPlugin(FilePondPluginFileValidateType);
  
  FilePond.parse(document.body);

  FilePond.setOptions({
    acceptedFileTypes: ['image/*'],
    fileValidateTypeLabelExpectedTypes: 'must be an image'
  })

  $("#dmr_form").on("ajax:success", function(data){ });
  $("#dmr_form").on("ajax:error", function(event){
  // remove all is-invalid and invalid-feedback
    clear_validation_errors();
  // add all current errors
    render_validation_errors(event.detail[0], 'defective_material_');
  // mark non-error fields valid
    $.each($(`#dmr_form`).find(`.form-control:not(.is-invalid, .modal-body, .modal-body *)`), function(index, input){
      $(input).addClass('is-valid')
    })
  });
});