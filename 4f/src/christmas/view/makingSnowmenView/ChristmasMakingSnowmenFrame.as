package christmas.view.makingSnowmenView
{
   import bagAndInfo.cell.BagCell;
   import christmas.ChristmasCoreController;
   import christmas.ChristmasCoreManager;
   import christmas.event.ChristmasRoomEvent;
   import christmas.info.ChristmasSystemItemsInfo;
   import christmas.items.ExpBar;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import org.aswing.KeyboardManager;
   
   public class ChristmasMakingSnowmenFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _bagitem:BagCell;
      
      private var _selfInfo:SelfInfo;
      
      private var _completeText:FilterFrameText;
      
      private var _expBar:ExpBar;
      
      private var _addSnowBnt:BaseButton;
      
      private var _addCountText:FilterFrameText;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _conditionTxt:FilterFrameText;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _mSnoRight:ChristmasMakingSnowmenRightFrame;
      
      private var _christmasSnowmenView:ChristmasSnowmenView;
      
      public function ChristmasMakingSnowmenFrame(){super();}
      
      private function initView() : void{}
      
      public function get expBar() : ExpBar{return null;}
      
      private function initText() : void{}
      
      private function goodsCell() : void{}
      
      protected function updateCount(param1:BagEvent) : void{}
      
      public function upDatafitCount() : void{}
      
      private function initEvent() : void{}
      
      protected function __updateBag(param1:BagEvent) : void{}
      
      private function __onClickAddSnowHander(param1:MouseEvent) : void{}
      
      private function showIsBuyFrame(param1:int = 1) : void{}
      
      private function sendBuyToSnowPackDouble(param1:int = 1) : void{}
      
      private function __scoreConvertEventHandler(param1:ChristmasRoomEvent) : void{}
      
      public function snowmenAction(param1:ChristmasSystemItemsInfo) : void{}
      
      private function removeEvent() : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
