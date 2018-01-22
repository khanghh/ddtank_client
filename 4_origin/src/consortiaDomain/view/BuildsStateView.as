package consortiaDomain.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class BuildsStateView extends Sprite implements Disposeable
   {
       
      
      public function BuildsStateView()
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         super();
         UICreatShortcut.creatAndAdd("consortiadomain.buildStateView.bg",this);
         var _loc1_:Array = [5,4,2,1,3];
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = new BuildsStateCell(_loc1_[_loc3_]);
            _loc2_.x = 6;
            _loc2_.y = _loc3_ * 20 + 6;
            addChild(_loc2_);
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
