package sanXiao.view
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.GridBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.pageSelector.PageSelector;
   import ddt.view.pageSelector.PageSelectorFactory;
   import ddt.view.tips.SanXiaoPropTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import road7th.utils.DateUtils;
   import sanXiao.SanXiaoManager;
   import sanXiao.game.SXGame;
   import sanXiao.game.SanXiaoGameMediator;
   import sanXiao.model.SXRewardItemData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class SanXiaoViewGame extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _game:SXGame;
      
      private var _mask:Shape;
      
      private var _btnPropCrossBomb:SimpleBitmapButton;
      
      private var _btnPropSquareBomb:SimpleBitmapButton;
      
      private var _btnPropClearColor:SimpleBitmapButton;
      
      private var _btnPropChangeColor:SimpleBitmapButton;
      
      private var _propCursor:ScaleFrameImage;
      
      private var _btnSelectedProp:Bitmap;
      
      private var _cursorOffsetX:Number;
      
      private var _cursorOffsetY:Number;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _stepRemainTxt:FilterFrameText;
      
      private var _crystalTxt:FilterFrameText;
      
      private var _btnBuyStep:SimpleBitmapButton;
      
      private var _iconBoxBagCell:BagCell;
      
      private var _progress:MovieClip;
      
      private var _progressTips:RichesButton;
      
      private var _progressText:FilterFrameText;
      
      private var _timeRemainBmp:Bitmap;
      
      private var _timeRemainText:FilterFrameText;
      
      private var _timeRemainTimer:TimerJuggler;
      
      private var _bagListView:GridBox;
      
      private var _pageSelector:PageSelector;
      
      private var _rewardItemList:Vector.<SXDropOutItem>;
      
      private var _curPage:int;
      
      private var _propBtnListened:Boolean = false;
      
      public function SanXiaoViewGame(){super();}
      
      private function init() : void{}
      
      private function __timeRemainHandler(param1:Event) : void{}
      
      private function getTimeRemainStr() : String{return null;}
      
      private function addEvents() : void{}
      
      private function removeEvents() : void{}
      
      protected function onClick(param1:MouseEvent) : void{}
      
      protected function onPropBtnClick(param1:MouseEvent) : void{}
      
      private function showPropCursor() : void{}
      
      private function hidePropCursor() : void{}
      
      protected function onCursorMove(param1:MouseEvent) : void{}
      
      private function onBuy(param1:Number, param2:Boolean) : void{}
      
      public function lockProps() : void{}
      
      public function unLockProps() : void{}
      
      public function updateDropOutItem() : void{}
      
      public function update() : void{}
      
      public function dispose() : void{}
   }
}
