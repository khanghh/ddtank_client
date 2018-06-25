package yzhkof.ui
{
   import flash.filters.DropShadowFilter;
   
   public class BackGroudContainer extends ComponentBase
   {
       
      
      protected var _color:uint;
      
      private var _alpha:Number;
      
      private var _shadow:Boolean = false;
      
      public function BackGroudContainer(color:uint = 16777215, alpha:Number = 1)
      {
         super();
         this._color = color;
         this._alpha = alpha;
         this.shadow = true;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(value:uint) : void
      {
         if(this._color == value)
         {
            return;
         }
         this._color = value;
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
      
      public function set shadow(value:Boolean) : void
      {
         if(this._shadow == value)
         {
            return;
         }
         this._shadow = value;
         filters = [new DropShadowFilter(0,0,0)];
      }
   }
}
