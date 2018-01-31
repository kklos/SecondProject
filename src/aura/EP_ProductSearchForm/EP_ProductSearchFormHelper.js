/**
 * Created by klaud on 27.01.2018.
 */
({

    showToast : function(event, title, message, type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type": type
        });
        toastEvent.fire();
    },

})