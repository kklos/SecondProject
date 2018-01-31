/**
 * Created by klaud on 27.01.2018.
 */
({
     showHideSpinner : function(component, event, action) {
                console.log('spinner');
                var spinner = component.find("spinner");
                if(action) {
                    console.log('show');
                    $A.util.removeClass(spinner, "slds-hide");
                }else {
                    console.log('hide');
                    $A.util.addClass(spinner, "slds-hide");
                }

            }
})