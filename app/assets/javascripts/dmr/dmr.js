//= require_tree .
$( document ).on('turbolinks:load', function(){
  init_filepond();
});

function init_filepond(){
  FilePond.registerPlugin(FilePondPluginFileEncode);
  FilePond.registerPlugin(FilePondPluginImageExifOrientation);
  FilePond.registerPlugin(FilePondPluginImagePreview);
  FilePond.registerPlugin(FilePondPluginFileValidateType);
  FilePond.parse(document.body);
  FilePond.setOptions({
    acceptedFileTypes: ['image/*'],
    fileValidateTypeLabelExpectedTypes: 'must be an image'
  });
  FilePond.parse(document.body);
}

function get_so_info(url, so_num){
    $('.dmr_hidden_fields').fadeOut('fast');
    $('.fa-refresh').addClass('fa-spin');
    if (so_num.toString().length == 6) {
      $.ajax({
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
          complete: function(xhr) {
            $('.fa-refresh').removeClass('fa-spin');
            FilePond.parse(document.body);
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