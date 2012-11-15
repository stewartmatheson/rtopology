//= ocanvas-2.2.2.js

window.onload = function(){
    var canvas      = oCanvas.create({ canvas: "#top", background: "#222" }),
        nodes       = [],
        homepage;

    canvas.width = document.width;
    canvas.height = 600;

    function Node(index, item){
        this.item = item; 

        this.x = function(){ 
            if(this.isHomepage()) {
                return canvas.width / 2;
            } else {
                return index * 100 + 5;
            }
        }; 

        this.y = function(){ 
            if(this.isHomepage()) {
                return canvas.height / 2;
            } else {
                return 400; 
            }
        };

        this.isHomepage = function(){
            if(this.item.path === '/') {
                return true;
            } else {
                return false;
            }
        };
        
        this.fillColor = function(){
            if(this.isHomepage()) {
                return "#E6DB74";
            } else {
                return "#fff";
            }
        };
 
        this.draw = function(){
            if(!this.isHomepage()) {
                canvas.display.line({
                    start   : { x : this.x(), y : this.y() },
                    end     : { x : homepage.x(), y : homepage.y() },
                    stroke  : "1px #0aa",
                    cap     : "round"
                }).add(); 
            }

            canvas.display.ellipse({
                x       : this.x(), 
                y       : this.y(),
                radius  : 6,
                fill    : this.fillColor()
            }).add();

            canvas.display.text({
                x       : this.x(), 
                y       : this.y() + 5,
                font    : "bold 10px sans-serif",
                text    : item.path,
                fill    : "#0aa"
            }).add();
        };
    }

    $.getJSON(document.URL, function(data){
        $.each(data.pages.slice(0, 10), function(index, item){
            var n = new Node(index, item);
            console.log(n.isHomepage());
            if(n.isHomepage()) { 
                homepage = n; 
            }
            n.draw();
            nodes.push(n);
        });
    });
}
