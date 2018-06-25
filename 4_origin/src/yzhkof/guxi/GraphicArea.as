package yzhkof.guxi
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class GraphicArea extends Sprite
   {
       
      
      private var _text:TextField;
      
      public function GraphicArea()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._text = new TextField();
         var tf:TextFormat = new TextFormat();
         tf.font = "Arial";
         tf.bold = true;
         this._text.defaultTextFormat = tf;
         this._text.multiline = false;
         this._text.autoSize = "left";
         this._text.height = 20;
         this._text.background = true;
         this._text.backgroundColor = 16711680;
      }
      
      public function draw(display:DisplayObject) : void
      {
         var rect:Rectangle = display.getRect(stage);
         var g:Graphics = this.graphics;
         g.lineStyle(2,16711680);
         g.drawRect(rect.x,rect.y,rect.width,rect.height);
         this._text.text = "x=" + display.x.toString() + "  y=" + display.y.toString() + "   " + rect.width.toString() + " * " + rect.height.toString();
         if(display.hasOwnProperty("stylename"))
         {
            this._text.appendText(" stylename=" + display["stylename"]);
         }
         this._text.x = rect.x;
         this._text.y = rect.y - 20;
         addChild(this._text);
      }
      
      public function clear() : void
      {
         var g:Graphics = this.graphics;
         g.clear();
         if(this._text)
         {
            if(this._text.parent)
            {
               this._text.parent.removeChild(this._text);
            }
         }
      }
   }
}
