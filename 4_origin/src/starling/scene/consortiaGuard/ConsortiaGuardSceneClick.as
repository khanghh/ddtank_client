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
         var i:int = 0;
         var bossClick:* = null;
         for(i = 0; i < 4; )
         {
            bossClick = new ConsortiaGuardBoss(i);
            addChild(bossClick);
            i++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
