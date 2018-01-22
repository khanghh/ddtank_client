package yzhkof.ui
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class DelayRendSprite extends Sprite
   {
       
      
      private var _isCanceled:Boolean = false;
      
      public function DelayRendSprite()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.__addToStage);
      }
      
      protected function upDateNextRend() : void
      {
         this._isCanceled = false;
         if(stage)
         {
            stage.invalidate();
            removeEventListener(Event.RENDER,this.__onScreenRend);
            addEventListener(Event.RENDER,this.__onScreenRend);
         }
      }
      
      protected function cancelUpDataNextRend() : void
      {
         removeEventListener(Event.RENDER,this.__onScreenRend);
      }
      
      protected function cancelCurrentRend() : void
      {
         this._isCanceled = true;
      }
      
      protected function beforDraw() : void
      {
      }
      
      protected function onDraw() : void
      {
      }
      
      protected function afterDraw() : void
      {
      }
      
      private function __addToStage(param1:Event) : void
      {
         this.upDateNextRend();
      }
      
      public final function draw() : void
      {
         this.beforDraw();
         this.onDraw();
         this.afterDraw();
         this._isCanceled = false;
         removeEventListener(Event.RENDER,this.__onScreenRend);
      }
      
      private function __onScreenRend(param1:Event) : void
      {
         this.beforDraw();
         if(this._isCanceled == false)
         {
            this.onDraw();
            this.afterDraw();
         }
         this._isCanceled = false;
         removeEventListener(Event.RENDER,this.__onScreenRend);
      }
   }
}
