package yzhkof.ui
{
   import yzhkof.ui.event.ComponentEvent;
   
   [Event(name="COMPONENT_CHANGE",type="yzhkof.ui.event.ComponentEvent")]
   [Event(name="DRAW_COMPLETE",type="yzhkof.ui.event.ComponentEvent")]
   public class ComponentBase extends CommitingSprite
   {
       
      
      protected var _width:Number = 0;
      
      protected var _height:Number = 0;
      
      public function ComponentBase()
      {
         super();
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(param1 == this._width)
         {
            return;
         }
         this._width = param1;
         this.commitChage("width");
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set height(param1:Number) : void
      {
         if(param1 == this._height)
         {
            return;
         }
         this._height = param1;
         this.commitChage("height");
      }
      
      override protected function commitChage(param1:String = "default_change") : void
      {
         super.commitChage(param1);
         if(hasEventListener(ComponentEvent.COMPONENT_CHANGE))
         {
            dispatchEvent(new ComponentEvent(ComponentEvent.COMPONENT_CHANGE));
         }
      }
      
      public function get contentWidth() : Number
      {
         return super.width;
      }
      
      public function get contentHeight() : Number
      {
         return super.height;
      }
      
      override protected final function afterDraw() : void
      {
         super.afterDraw();
         dispatchEvent(new ComponentEvent(ComponentEvent.DRAW_COMPLETE));
         this.drawComplete();
      }
      
      protected function drawComplete() : void
      {
      }
   }
}
