package signBuff.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import signBuff.SignBuffManager;
   
   public class PowerView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _sp:Sprite;
      
      public function PowerView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.hall.signBuff.bg2");
         addChild(_bg);
         _sp = new Sprite();
         addChild(_sp);
         _sp.x = 91;
         _sp.y = 96;
         _loc2_ = 0;
         while(_loc2_ < SignBuffManager.instance.itemInfoList.length)
         {
            _loc1_ = new PowerItem(SignBuffManager.instance.itemInfoList[_loc2_],_loc2_);
            _loc1_.x = 0;
            _loc1_.y = 56 * _loc2_;
            _sp.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_sp)
         {
            ObjectUtils.disposeObject(_sp);
            _sp = null;
         }
      }
   }
}
