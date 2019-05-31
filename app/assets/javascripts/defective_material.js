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
      data: { so_num: so_num,
              format: 'js'}
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