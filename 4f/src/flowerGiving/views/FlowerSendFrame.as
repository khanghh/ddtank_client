package flowerGiving.views
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flowerGiving.FlowerGivingController;
   import flowerGiving.FlowerGivingManager;
   import flowerGiving.components.FlowerSendFrameItem;
   import flowerGiving.components.FlowerSendFrameNameInput;
   import flowerGiving.data.FlowerSendRecordInfo;
   import flowerGiving.events.FlowerSendRecordEvent;
   import road7th.comm.PackageIn;
   import road7th.utils.StringHelper;
   import shop.manager.ShopBuyManager;
   
   public class FlowerSendFrame extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _sendBtnBg:ScaleBitmapImage;
      
      private var _leftBit:Bitmap;
      
      private var _rightBit:Bitmap;
      
      private var _sendRecordBtn:SimpleBitmapButton;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _numTxt:FilterFrameText;
      
      private var _otherNumTxt:FilterFrameText;
      
      private var _otherSelectBtn:SelectedCheckButton;
      
      private var _selectBtnGroup:SelectedButtonGroup;
      
      private var _sendBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _sendToOtherTxt:FilterFrameText;
      
      private var _itemArr:Array;
      
      private var _sendRecordFrame:Frame;
      
      private var _dataArr:Array;
      
      private var _myFlowerBagCell:BagCell;
      
      private var _maxNum:int;
      
      private var _nameInput:FlowerSendFrameNameInput;
      
      private var _dropList:DropList;
      
      public function FlowerSendFrame(){super();}
      
      private function initView() : void{}
      
      private function initViewWithData() : void{}
      
      private function createBagCell(param1:int) : BagCell{return null;}
      
      protected function __onReceiverChange(param1:Event) : void{}
      
      private function filterRepeatInArray(param1:Array) : Array{return null;}
      
      private function filterSearch(param1:Array, param2:String) : Array{return null;}
      
      protected function __hideDropList(param1:Event) : void{}
      
      private function removeEvent() : void{}
      
      private function addEvent() : void{}
      
      protected function _huiKuiHandler(param1:FlowerSendRecordEvent) : void{}
      
      protected function __flowerBuyHandler(param1:PkgEvent) : void{}
      
      protected function __buyHandler(param1:MouseEvent) : void{}
      
      protected function __getRecordHandler(param1:PkgEvent) : void{}
      
      protected function __giveHandler(param1:PkgEvent) : void{}
      
      private function updateFlowerNum() : void{}
      
      protected function __sendHandler(param1:MouseEvent) : void{}
      
      protected function __changeHandler(param1:Event) : void{}
      
      protected function __inputHandler(param1:Event) : void{}
      
      protected function __maxHandler(param1:MouseEvent) : void{}
      
      protected function __recordHandler(param1:MouseEvent) : void{}
      
      protected function _responseHandle(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
