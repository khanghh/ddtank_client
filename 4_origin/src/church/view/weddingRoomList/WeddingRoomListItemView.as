package church.view.weddingRoomList
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChurchRoomInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WeddingRoomListItemView extends Sprite implements Disposeable
   {
       
      
      private var _selected:Boolean;
      
      private var _churchRoomInfo:ChurchRoomInfo;
      
      private var _highClassWeddingBg:MutipleImage;
      
      private var _weddingRoomListItemAsset:Scale9CornerImage;
      
      private var _weddingRoomListItemNumber:FilterFrameText;
      
      private var _roomListItemLockAsset:Bitmap;
      
      private var _weddingRoomListItemName:FilterFrameText;
      
      private var _weddingRoomListItemCount:FilterFrameText;
      
      public function WeddingRoomListItemView()
      {
         super();
         initialize();
         initEvent();
      }
      
      protected function initialize() : void
      {
         mouseChildren = false;
         selected = false;
         buttonMode = true;
         _highClassWeddingBg = ComponentFactory.Instance.creatComponentByStylename("church.highClassWeddingItemBg");
         addChild(_highClassWeddingBg);
         _highClassWeddingBg.visible = false;
         _weddingRoomListItemAsset = ComponentFactory.Instance.creatComponentByStylename("church.main.WeddingRoomListItem.light");
         addChild(_weddingRoomListItemAsset);
         _weddingRoomListItemAsset.visible = false;
         _weddingRoomListItemNumber = ComponentFactory.Instance.creat("asset.church.main.weddingRoomListItemNumberAsset");
         addChild(_weddingRoomListItemNumber);
         _roomListItemLockAsset = ComponentFactory.Instance.creatBitmap("asset.church.roomListItemLockAsset");
         _roomListItemLockAsset.visible = false;
         addChild(_roomListItemLockAsset);
         _weddingRoomListItemName = ComponentFactory.Instance.creat("asset.church.main.weddingRoomListItemNameAsset");
         addChild(_weddingRoomListItemName);
         _weddingRoomListItemCount = ComponentFactory.Instance.creat("asset.church.main.weddingRoomListItemCountAsset");
         addChild(_weddingRoomListItemCount);
      }
      
      private function update() : void
      {
         var _loc1_:int = 0;
         if(_churchRoomInfo)
         {
            _weddingRoomListItemNumber.text = _churchRoomInfo.id.toString();
            _roomListItemLockAsset.visible = _churchRoomInfo.isLocked;
            _weddingRoomListItemName.text = _churchRoomInfo.roomName;
            _weddingRoomListItemName.x = !!_churchRoomInfo.isLocked?60:60;
            _weddingRoomListItemName.width = !!_churchRoomInfo.isLocked?186:Number(212);
            _loc1_ = 100;
            switch(int(_churchRoomInfo.seniorType) - 1)
            {
               case 0:
                  _loc1_ = 80;
                  break;
               case 1:
                  _loc1_ = 100;
                  break;
               case 2:
                  _loc1_ = 120;
            }
            if(_churchRoomInfo.status == "wedding_ing" && _churchRoomInfo.currentNum < 2)
            {
               _weddingRoomListItemCount.text = "2/" + _loc1_;
            }
            else
            {
               _weddingRoomListItemCount.text = String(_churchRoomInfo.currentNum) + "/" + _loc1_;
            }
            if(_churchRoomInfo.currentNum >= _loc1_ || _churchRoomInfo.status == "wedding_ing")
            {
               this.filters = ComponentFactory.Instance.creatFilters("grayFilter");
            }
            else
            {
               this.filters = ComponentFactory.Instance.creatFilters("lightFilter");
            }
            _highClassWeddingBg.visible = _churchRoomInfo.seniorType > 0;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _weddingRoomListItemAsset.visible = true;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _weddingRoomListItemAsset.visible = false;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_weddingRoomListItemAsset)
         {
            _weddingRoomListItemAsset.visible = param1;
         }
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         update();
      }
      
      public function get churchRoomInfo() : ChurchRoomInfo
      {
         return _churchRoomInfo;
      }
      
      public function set churchRoomInfo(param1:ChurchRoomInfo) : void
      {
         _churchRoomInfo = param1;
         update();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _churchRoomInfo = null;
         ObjectUtils.disposeObject(_highClassWeddingBg);
         _highClassWeddingBg = null;
         if(_weddingRoomListItemAsset)
         {
            if(_weddingRoomListItemAsset.parent)
            {
               _weddingRoomListItemAsset.parent.removeChild(_weddingRoomListItemAsset);
            }
            _weddingRoomListItemAsset.dispose();
         }
         _weddingRoomListItemAsset = null;
         if(_weddingRoomListItemNumber)
         {
            if(_weddingRoomListItemNumber.parent)
            {
               _weddingRoomListItemNumber.parent.removeChild(_weddingRoomListItemNumber);
            }
            _weddingRoomListItemNumber.dispose();
         }
         _weddingRoomListItemNumber = null;
         if(_weddingRoomListItemName)
         {
            if(_weddingRoomListItemName.parent)
            {
               _weddingRoomListItemName.parent.removeChild(_weddingRoomListItemName);
            }
            _weddingRoomListItemName.dispose();
         }
         _weddingRoomListItemName = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
