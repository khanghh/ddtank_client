package flowerGiving.components
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flowerGiving.FlowerGivingManager;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftRewardInfo;
   
   public class FlowerSendFrameItem extends Sprite implements Disposeable
   {
       
      
      private var _selectBtn:SelectedCheckButton;
      
      private var _sendTxt:FilterFrameText;
      
      private var _sendNumTxt:FilterFrameText;
      
      private var _canGetTxt:FilterFrameText;
      
      private var _shineBit:Bitmap;
      
      private var _giftData:GiftBagInfo;
      
      private var _sendBagCell:BagCell;
      
      private var _getIconSp:Sprite;
      
      private var _getIcon:Image;
      
      private var _baseTip:GoodTipInfo;
      
      public function FlowerSendFrameItem(param1:GiftBagInfo){super();}
      
      private function addEvent() : void{}
      
      protected function __clickHandler(param1:MouseEvent) : void{}
      
      private function initView() : void{}
      
      private function initViewWithData() : void{}
      
      private function createBagCell(param1:int) : BagCell{return null;}
      
      private function removeEvent() : void{}
      
      public function updateShine() : void{}
      
      public function get selectBtn() : SelectedCheckButton{return null;}
      
      public function set selectBtn(param1:SelectedCheckButton) : void{}
      
      public function dispose() : void{}
   }
}
