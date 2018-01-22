package yzhkof.ui
{
   public class CommitingSprite extends DelayRendSprite
   {
       
      
      protected var changes:Object;
      
      public var autoDraw:Boolean = true;
      
      public function CommitingSprite()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.changes = new Object();
      }
      
      protected function commitChage(param1:String = "default_change") : void
      {
         this.changes[param1] = hasOwnProperty(param1) && this[param1] || null;
      }
      
      override protected function beforDraw() : void
      {
      }
      
      override protected function afterDraw() : void
      {
         this.changes = new Object();
      }
   }
}
