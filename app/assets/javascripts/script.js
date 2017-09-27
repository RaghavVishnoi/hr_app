$(document).ready(function() {
    $('.datepicker').bootstrapMaterialDatePicker({
        format: 'dddd DD MMMM YYYY',
        clearButton: true,
        weekStart: 1,
        time: false
    });

    $('.datatable').DataTable();

    $('#example-getting-started').multiselect();
    jQuery(".best_in_place").best_in_place();
});

