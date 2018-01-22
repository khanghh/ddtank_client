package flowerGiving.components
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class FlowerSendRewardItem extends Sprite implements Disposeable
   {
       
      
      private var _itemIndex:int;
      
      private var _back:Bitmap;
      
      private var _backOverBit:Bitmap;
      
      private var _contentTxt:FilterFrameText;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _haveGot:Bitmap;
      
      private var _hBox:HBox;
      
      private var index:int;
      
      public var num:int;
      
      public function FlowerSendRewardItem(param1:int){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      protected function __clickHanlder(param1:MouseEvent) : void{}
      
      protected function __onOutHandler(param1:MouseEvent) : void{}
      
      protected function __onOverHanlder(param1:MouseEvent) : void{}
      
      public function set info(param1:GiftBagInfo) : void{}
      
      public function setBtnEnable(param1:int) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
