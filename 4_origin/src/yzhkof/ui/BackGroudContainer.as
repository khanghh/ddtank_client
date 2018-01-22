package yzhkof.ui
{
   import flash.filters.DropShadowFilter;
   
   public class BackGroudContainer extends ComponentBase
   {
       
      
      protected var _color:uint;
      
      private var _alpha:Number;
      
      private var _shadow:Boolean = false;
      
      public function BackGroudContainer(param1:uint = 16777215, param2:Number = 1)
      {
         super();
         this._color = param1;
         this._alpha = param2;
         this.shadow = true;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         commitChage("color");
      }
      
      override protected function onDraw() : void
      {
         this.drawBackGround();
      }
      
      protected function drawBackGround() : void
      {
         graphics.clear();
         graphics.beginFill(this._color,this._alpha);
         graphics.drawRect(0,0,contentWidth,contentHeight);
         graphics.endFill();
      }
      
      public function get shadow() : Boolean
      {
         return this._shadow;
      }
      
      public function set shadow(param1:Boolean) : void
      {
         if(this._shadow == param1)
         {
            return;
         }
         this._shadow = param1;
         filters = [new DropShadowFilter(0,0,0)];
      }
   }
}
