window.onload = function () {
    initImageClickEvent();
    initHighlightCode();
}

// 初始化代码高亮
function initHighlightCode() {
    try {
        //转换其他的高亮代码至hljs
        var elementList = document.getElementsByClassName("cnblogs_Highlighter");
        for (let i = 0; i < elementList.length; i++) {
            const element = elementList[i];
            var code = element.getElementsByTagName("pre")[0].innerHTML;
            element.getElementsByTagName("pre")[0].innerHTML = '<code class="language">' + code + '</code>';
        }
    } catch (e) {
        console.log("无法转换cnblogs_Highlighter:" + e)
    }
    hljs.highlightAll();
}

var allImgs = [];
// 添加图片点击事件
function initImageClickEvent() {
    allImgs = [];
    var elementList = document.getElementsByClassName("content")[0].getElementsByTagName("img");
    for (let i = 0; i < elementList.length; i++) {
        const element = elementList[i];
        //跳过计数器
        if (element.src.indexOf("counter.cnblogs.com") != -1) {
            continue;
        }
        allImgs.push(element.src);
        element.onclick = function (e) {
            openImage(e.target.src)
        }
    }
}
// 打开作者主页
function openAuthor() {
    window.flutter_inappwebview.callHandler('showAuthor');
}
// 打开图片浏览
function openImage(src) {
    window.flutter_inappwebview.callHandler('showImage', src, allImgs);
}