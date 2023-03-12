function SaveData() {
    var FirstName1 = $("#txtFirstName").val();
    var LastName1 = $("#txtLastName").val();
    var Email = $("#txtEmail").val();
    var PhoneNumber = $("#txtPhoneNumber").val();
    var CreditCardNumber = $("#txtCreditCardNumber").val();
    var CVV = $("#txtCVV").val();
    var ExpireDate = $("#ExpireDate").val();

    if (FirstName1 == '' || Email == '' || PhoneNumber == '') {
        return false;
    }

    $.ajax({
        type: 'POST',
        url: 'UserRegistration.aspx/InsertData',
        data: JSON.stringify({ firstName: FirstName1, LastName: LastName1, Email: Email, PhoneNumber: PhoneNumber, CreditCardNumber: CreditCardNumber, CVV: CVV, ExpireDate: ExpireDate}),
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        async: false,
        success: function (data) {
            if (data.d == 'Success') {
                window.location.href = "../Forms/ShowData.aspx";
            }
        },
        error: function () {
            alert("Insert Error");
        }
    });
}