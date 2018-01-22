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
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Arial";
         _loc1_.bold = true;
         this._text.defaultTextFormat = _loc1_;
         this._text.multiline = false;
         this._text.autoSize = "left";
         this._text.height = 20;
         this._text.background = true;
         this._text.backgroundColor = 16711680;
      }
      
      public function draw(param1:DisplayObject) : void
      {
         var _loc2_:Rectangle = param1.getRect(stage);
         var _loc3_:Graphics = this.graphics;
         _loc3_.lineStyle(2,16711680);
         _loc3_.drawRect(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
         this._text.text = "x=" + param1.x.toString() + "  y=" + param1.y.toString() + "   " + _loc2_.width.toString() + " * " + _loc2_.height.toString();
         if(param1.hasOwnProperty("stylename"))
         {
            this._text.appendText(" stylename=" + param1["stylename"]);
         }
         this._text.x = _loc2_.x;
         this._text.y = _loc2_.y - 20;
         addChild(this._text);
      }
      
      public function clear() : void
      {
         var _loc1_:Graphics = this.graphics;
         _loc1_.clear();
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
