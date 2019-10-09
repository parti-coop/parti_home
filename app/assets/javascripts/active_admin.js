//= require active_admin/base
//= require activeadmin/simplemde/simplemde
//= require activeadmin/simplemde_editor_input
//= require inline-attachment
//= require codemirror-4.inline-attachment
//= require input.inline-attachment

$(function() {
  $.each($('.simplemde-editor'), function(i, elm) {
    var editor = $(elm).data('editor')
    if(editor) {
      inlineAttachment.editors.codemirror4.attach(editor.codemirror, {
        onFileUploadResponse: function(xhr) {
          var result = JSON.parse(xhr.responseText),
          filename = result[this.settings.jsonFieldName];
          console.log(filename);
          console.log(this.filenameTag);
          if (result && filename) {
            var newValue;
            if (typeof this.settings.urlText === 'function') {
              newValue = this.settings.urlText.call(this, filename, result);
            } else {
              newValue = this.settings.urlText.replace(this.filenameTag, filename);
            }
            console.log(newValue);
            var text = this.editor.getValue().replace(this.lastValue, newValue);
            this.editor.setValue(text);
            this.settings.onFileUploaded.call(this, filename);
          }
          return false;
        },
        uploadUrl: '/attachments',
        jsonFieldName: 'filename',
        urlText: "![Image]({filename})"
      });
    }
  });
});