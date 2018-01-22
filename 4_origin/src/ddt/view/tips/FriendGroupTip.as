package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   import im.CustomInfo;
   
   public class FriendGroupTip extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _vbox:VBox;
      
      private var _itemArr:Array;
      
      public function FriendGroupTip()
      {
         super();
         _bg = ComponentFactory.Instance.creatComponentByStylename("friendsGroupTip.bg");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("friendsGroupTip.ItemContainer");
         addChild(_bg);
         addChild(_vbox);
         _itemArr = [];
      }
      
      public function update(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         clearItem();
         var _loc4_:Vector.<CustomInfo> = PlayerManager.Instance.customList;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length - 1)
         {
            _loc2_ = new FriendGroupTItem();
            _loc2_.info = _loc4_[_loc3_];
            _loc2_.NickName = param1;
            _vbox.addChild(_loc2_);
            _itemArr.push(_loc2_);
            _loc3_++;
         }
         _bg.height = _loc4_.length * 21;
      }
      
      private function clearItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemArr.length)
         {
            if(_itemArr[_loc1_])
            {
               ObjectUtils.disposeObject(_itemArr[_loc1_]);
            }
            _itemArr[_loc1_] = null;
            _loc1_++;
         }
         _itemArr = [];
      }
      
      public function dispose() : void
      {
         clearItem();
         _itemArr = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
