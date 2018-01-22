package starling.scene.consortiaGuard
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.guard.ConsortiaGuardBoss;
   import flash.display.Sprite;
   
   public class ConsortiaGuardSceneClick extends Sprite implements Disposeable
   {
       
      
      public function ConsortiaGuardSceneClick()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new ConsortiaGuardBoss(_loc2_);
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
