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
      
      protected function commitChage(changeThing:String = "default_change") : void
      {
         this.changes[changeThing] = hasOwnProperty(changeThing) && this[changeThing] || null;
         this.autoDraw && upDateNextRend();
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
