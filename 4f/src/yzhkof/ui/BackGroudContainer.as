package yzhkof.ui
{
   import flash.filters.DropShadowFilter;
   
   public class BackGroudContainer extends ComponentBase
   {
       
      
      protected var _color:uint;
      
      private var _alpha:Number;
      
      private var _shadow:Boolean = false;
      
      public function BackGroudContainer(param1:uint = 16777215, param2:Number = 1){super();}
      
      public function get color() : uint{return null;}
      
      public function set color(param1:uint) : void{}
      
      override protected function onDraw() : void{}
      
      protected function drawBackGround() : void{}
      
      public function get shadow() : Boolean{return false;}
      
      public function set shadow(param1:Boolean) : void{}
   }
}
