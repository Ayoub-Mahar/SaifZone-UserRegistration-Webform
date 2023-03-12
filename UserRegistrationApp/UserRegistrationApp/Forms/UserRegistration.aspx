<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserRegistration.aspx.cs" Inherits="UserRegistrationApp.Forms.UserRegistration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/semantic.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"/>
    <script src="../Scripts/jquery-3.4.1.min.js"></script>
    <script src="../Scripts/semantic.js"></script>
    <script src="../Scripts/jquery.payment.js"></script>
   
</head>
<body>
    <div class="ui container">
        <div id="mainContainer" class="ui compact basic left aligned segment" style="min-width:80%; margin:auto;">
            <div class="ui yellow inverted segment">
                <h3 class="ui top attached tertiary basic segment center">
                    User Registration Form
                </h3>
                <form class="ui payment form attached segment" id="payment-form" method="post">
                <%--<form class="ui payment form attached segment" id="payment-form" method="post">--%>
                    <input style="display:none" />

                    <div class="row">
                        <div class="field col-lg-6">
                            <label>First Name <strong style="color:red">*</strong></label>
                            <div class="ui icon input">
                            <i class="credit card alternative icon"></i>
                            <input type="text" id="txtFirstName" placeholder="First Name" required="required"/>
                            </div>
                        </div>
                        <div class="field col-lg-6">
                            <label>Last Name</label>
                            <div class="ui icon input">
                            <i class="credit card alternative icon"></i>
                            <input type="text" id="txtLastName" placeholder="Last Name"/>
                            </div>
                        </div>
                    </div>
                        
                    <div class="row">
                        <div class="field col-lg-6">
                            <label>Email <strong style="color:red">*</strong></label>
                            <div class="ui icon input">
                            <i class="credit card alternative icon"></i>
                            <input type="email" id="txtEmail" placeholder="Email" required="required"/>
                            </div>
                        </div>
                        <div class="field col-lg-6">
                            <label>Mobile Number <strong style="color:red">*</strong></label>
                            <div class="ui icon input">
                            <i class="credit card alternative icon"></i>
                            <input type="tel" id="txtPhoneNumber" placeholder="Mobile Number" required="required"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="field col-lg-4">
                            <label>Card Number <strong style="color:red">*</strong></label>
                            <div class="ui icon input">
                            <i class="credit card alternative icon"></i>
                            <input type="tel" id="txtCreditCardNumber" placeholder="•••• •••• •••• ••••" data-payment='cc-number'/>
                            </div>
                        </div>
                        <div class="field col-lg-4">
                            <label>CVC <strong style="color:red">*</strong></label>
                            <input type="password" id="txtCVV" placeholder="•••" data-payment='cc-cvc'/>
                        </div>
                        <div class="field col-lg-4">
                            <label>Card Expiry (MM/YYYY) <strong style="color:red">*</strong></label>
                            <input type="text" id="ExpireDate" placeholder="•• / ••••" data-payment='cc-exp'/>
                        </div>
                    </div>
                    <div class="paybutton field" style="text-align:center;">
                        <button class="ui red button" type="submit" id="btnSubmit" tabindex="0">
                            Submit
                        </button>
                    </div>
                    <div class="ui error message"></div>
                </form>
            </div>
        </div>
      
    </div>

    <script src="../Scripts/UserRegistration.js"></script>
    <script type="text/javascript">
        (function ($) {

            //$("#btnSubmit").prop("disabled", true);

            var PLUGIN_NS = 'paymentForm';

            var Plugin = function (target, options) {
                this.$T = $(target);
                this._init(target, options);

                /** #### OPTIONS #### */
                this.options = $.extend(
                    true,               // deep extend
                    {
                        DEBUG: false
                    },
                    options
                );

                this._cardIcons = {
                    "visa": "visa icon",
                    "mastercard": "mastercard icon",
                    "amex": "american express icon",
                    "dinersclub": "diners club icon",
                    "discover": "discover icon",
                    "jcb": "japan credit bureau icon",
                    "default": "credit card alternative icon"
                };

                return this;
            }

            /** #### INITIALISER #### */
            Plugin.prototype._init = function (target, options) {
                var base = this;

                base.number = this.$T.find("[data-payment='cc-number']");
                base.exp = this.$T.find("[data-payment='cc-exp']");
                base.cvc = this.$T.find("[data-payment='cc-cvc']");
                base.brand = this.$T.find("[data-payment='cc-brand']");
                base.onlyNum = this.$T.find("[data-numeric]");

                // Set up all payment fields inside the payment form
                base.number.payment('formatCardNumber').data('payment-error-message', 'Please enter a valid credit card number.');
                base.exp.payment('formatCardExpiry').data('payment-error-message', 'Please enter a valid expiration date.');
                base.cvc.payment('formatCardCVC').data('payment-error-message', 'Please enter a valid CVC.');
                base.onlyNum.payment('restrictNumeric');

                // Update card type on input
                base.number.on('input', function () {
                    base.cardType = $.payment.cardType(base.number.val());
                    var fg = base.number.closest('.ui.icon.input');
                    if (base.cardType) {
                        base.brand.text(base.cardType);
                        // Also set an icon
                        var icon = base._cardIcons[base.cardType] ? base._cardIcons[base.cardType] : base._cardIcons["default"];
                        fg.children('i').attr("class", icon);
                        //("<i class='" + icon + "'></i>");
                    } else {
                        $("[data-payment='cc-brand']").text("");
                    }
                });

                // Validate card number on change
                base.number.on('change', function () {
                    base._setValidationState($(this), !$.payment.validateCardNumber($(this).val()));
                });

                // Validate card expiry on change
                base.exp.on('change', function () {
                    base._setValidationState($(this), !$.payment.validateCardExpiry($(this).payment('cardExpiryVal')));
                });

                // Validate card cvc on change
                base.cvc.on('change', function () {
                    base._setValidationState($(this), !$.payment.validateCardCVC($(this).val(), base.cardType));
                });
            };

            /** #### PUBLIC API (see notes) #### */
            Plugin.prototype.valid = function () {
                var base = this;

                var num_valid = $.payment.validateCardNumber(base.number.val());
                var exp_valid = $.payment.validateCardExpiry(base.exp.payment('cardExpiryVal'));
                var cvc_valid = $.payment.validateCardCVC(base.cvc.val(), base.cardType);

                base._setValidationState(base.number, !num_valid);
                base._setValidationState(base.exp, !exp_valid);
                base._setValidationState(base.cvc, !cvc_valid);

                return num_valid && exp_valid && cvc_valid;
            }

            /** #### PRIVATE METHODS #### */
            Plugin.prototype._setValidationState = function (el, erred) {
                var fg = el.closest('.field');
                fg.toggleClass('error', erred).toggleClass('', !erred);
                fg.find('.payment-error-message').remove();
                if (erred) {
                    fg.append("<span class='ui pointing red basic label payment-error-message'>" + el.data('payment-error-message') + "</span>");
                }
                return this;
            }
            Plugin.prototype.DLOG = function () {
                if (!this.DEBUG) return;
                for (var i in arguments) {
                    console.log(PLUGIN_NS + ': ', arguments[i]);
                }
            }
            Plugin.prototype.DWARN = function () {
                this.DEBUG && console.warn(arguments);
            }
            $.fn[PLUGIN_NS] = function (methodOrOptions) {
                if (!$(this).length) {
                    return $(this);
                }
                var instance = $(this).data(PLUGIN_NS);

                // CASE: action method (public method on PLUGIN class)        
                if (instance
                    && methodOrOptions.indexOf('_') != 0
                    && instance[methodOrOptions]
                    && typeof (instance[methodOrOptions]) == 'function') {

                    return instance[methodOrOptions](Array.prototype.slice.call(arguments, 1));


                    // CASE: argument is options object or empty = initialise            
                } else if (typeof methodOrOptions === 'object' || !methodOrOptions) {

                    instance = new Plugin($(this), methodOrOptions);    // ok to overwrite if this is a re-init
                    $(this).data(PLUGIN_NS, instance);
                    return $(this);

                    // CASE: method called before init
                } else if (!instance) {
                    $.error('Plugin must be initialised before using method: ' + methodOrOptions);

                    // CASE: invalid method
                } else if (methodOrOptions.indexOf('_') == 0) {
                    $.error('Method ' + methodOrOptions + ' is private!');
                } else {
                    $.error('Method ' + methodOrOptions + ' does not exist.');
                }
            };
        })(jQuery);

        /* Initialize validation */
        var payment_form = $('#payment-form').paymentForm();

        $('#payment-form').on('submit', function () {

            event.preventDefault();
            var valid = $(this).paymentForm('valid');
            if (valid) {
                SaveData();
               // $("#btnSubmit").removeAttr('disabled');
            } else {
                //$("#btnSubmit").prop("disabled", true);
            }
        });

        //$('#btnSubmit').on('click', function () {
        //    SaveData();
        //});

    </script>
   
</body>
</html>
