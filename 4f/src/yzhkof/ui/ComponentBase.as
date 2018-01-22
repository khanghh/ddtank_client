package yzhkof.ui
{
   import yzhkof.ui.event.ComponentEvent;
   
   [Event(name="COMPONENT_CHANGE",type="yzhkof.ui.event.ComponentEvent")]
   [Event(name="DRAW_COMPLETE",type="yzhkof.ui.event.ComponentEvent")]
   public class ComponentBase extends CommitingSprite
   {
       
      
      protected var _width:Number = 0;
      
      protected var _height:Number = 0;
      
      public function ComponentBase(){super();}
      
      override public function get width() : Number{return 0;}
      
      override public function set width(param1:Number) : void{}
      
      override public function get height() : Number{return 0;}
      
      override public function set height(param1:Number) : void{}
      
      override protected function commitChage(param1:String = "default_change") : void{}
      
      public function get contentWidth() : Number{return 0;}
      
      public function get contentHeight() : Number{return 0;}
      
      override protected final function afterDraw() : void{}
      
      protected function drawComplete() : void{}
   }
}
