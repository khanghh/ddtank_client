package yzhkof.ui
{
   public class CommitingSprite extends DelayRendSprite
   {
       
      
      protected var changes:Object;
      
      public var autoDraw:Boolean = true;
      
      public function CommitingSprite(){super();}
      
      private function init() : void{}
      
      protected function commitChage(param1:String = "default_change") : void{}
      
      override protected function beforDraw() : void{}
      
      override protected function afterDraw() : void{}
   }
}
