function isNull(obj) {
    var exp = obj;
    
    var isnull = false;
    if (!exp && typeof(exp) != "undefined") {
        isnull = true
    }
    
    
    return isnull
}

function iosClickAction(element) {
    var msg = {obj_id: 'err', obj_type: 'err'};
    try {
        var obj_id = element.getAttribute('obj_id');
        if (!isNull(obj_id)) {
            msg.obj_id = obj_id
        }
        var obj_type = element.getAttribute('obj_type');
        if (!isNull(obj_type)) {
            msg.obj_type = obj_type
        }
    } catch (err) {
    }
    
    window.webkit.messageHandlers.search.postMessage(msg);
}


function postToApp(object){
    window.webkit.messageHandlers.search.postMessage(object);
}

function getAppInfo(object){
    return getIOSAppInfo(object)
}

function getIOSAppInfo(object)
{
    
}

function enableTouchCallout()

{
    
    document.documentElement.style.webkitTouchCallout = "none"; //禁止弹出菜单
    
    document.documentElement.style.webkitUserSelect = "none";//禁止选中
    
}

