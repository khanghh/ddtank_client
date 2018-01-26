package lotteryTicket.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelperHelpBtnCreate;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import lotteryTicket.LotteryManager;
   import lotteryTicket.data.LotteryRewardInfo;
   import lotteryTicket.data.LotteryTicketInfo;
   import lotteryTicket.event.LotteryTicketEvent;
   
   public class LotteryMainView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _prizeMoney:Sprite;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _openTimeTxt:FilterFrameText;
      
      private var _randomBtn:BaseButton;
      
      private var _okBtn:BaseButton;
      
      private var _buyBtn:BaseButton;
      
      private var _prizeListBtn:BaseButton;
      
      private var firstTicket:MovieClip;
      
      private var secondTicket:MovieClip;
      
      private var thirdTicket:MovieClip;
      
      private var fourthTicket:MovieClip;
      
      private var isFour:Array;
      
      private var count:int = 16;
      
      private var selectArr:Array;
      
      private var ticketArr:Array;
      
      private var _list:ListPanel;
      
      private var prizeBox:Sprite;
      
      private var closeBtn:BaseButton;
      
      private var _help:HelperHelpBtnCreate;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var canBuyArr:Array;
      
      private var _frame:LotteryPrizeView;
      
      public function LotteryMainView(){super();}
      
      private function initView() : void{}
      
      public function initData() : void{}
      
      private function ticketHandler(param1:MouseEvent) : void{}
      
      private function cleanAllSelect() : void{}
      
      private function selectHandler(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      private function closeHandler(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      private function randomBtnHander(param1:MouseEvent) : void{}
      
      private function okBtnHander(param1:MouseEvent) : void{}
      
      private function buyBtnHander(param1:MouseEvent) : void{}
      
      private function __confirm(param1:FrameEvent) : void{}
      
      private function onCompleteHandler() : void{}
      
      private function prizeListBtnHander(param1:MouseEvent) : void{}
      
      private function deleteHandler(param1:LotteryTicketEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
