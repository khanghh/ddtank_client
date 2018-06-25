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
      
      public function update(nickName:String) : void
      {
         var i:int = 0;
         var item:* = null;
         clearItem();
         var customList:Vector.<CustomInfo> = PlayerManager.Instance.customList;
         for(i = 0; i < customList.length - 1; )
         {
            item = new FriendGroupTItem();
            item.info = customList[i];
            item.NickName = nickName;
            _vbox.addChild(item);
            _itemArr.push(item);
            i++;
         }
         _bg.height = customList.length * 21;
      }
      
      private function clearItem() : void
      {
         var i:int = 0;
         for(i = 0; i < _itemArr.length; )
         {
            if(_itemArr[i])
            {
               ObjectUtils.disposeObject(_itemArr[i]);
            }
            _itemArr[i] = null;
            i++;
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
