package ddt.command
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuickBuyAlertBase extends Frame
   {
       
      
      protected var _bg:Image;
      
      protected var _number:NumberSelecter;
      
      protected var _selectedBtn:SelectedCheckButton;
      
      protected var _selectedBandBtn:SelectedCheckButton;
      
      protected var _totalTipText:FilterFrameText;
      
      protected var totalText:FilterFrameText;
      
      protected var _moneyTxt:FilterFrameText;
      
      protected var _bandMoney:FilterFrameText;
      
      protected var _submitButton:TextButton;
      
      protected var _movieBack:MovieClip;
      
      protected var _sprite:Sprite;
      
      protected var _cell:BagCell;
      
      protected var _perPrice:int;
      
      protected var _isBand:Boolean;
      
      protected var _shopGoodsId:int;
      
      public function QuickBuyAlertBase(){super();}
      
      protected function initView() : void{}
      
      protected function initEvents() : void{}
      
      protected function __buy(param1:MouseEvent) : void{}
      
      protected function onCheckComplete() : void{}
      
      protected function getNeedMoney() : int{return 0;}
      
      protected function submit(param1:Boolean) : void{}
      
      protected function selectedBandHander(param1:MouseEvent) : void{}
      
      protected function seletedHander(param1:MouseEvent) : void{}
      
      private function selectHandler(param1:Event) : void{}
      
      protected function refreshNumText() : void{}
      
      public function setData(param1:int, param2:int, param3:int) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function removeEvnets() : void{}
      
      override public function dispose() : void{}
   }
}
