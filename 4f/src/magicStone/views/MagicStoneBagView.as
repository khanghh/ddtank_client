package magicStone.views
{
   import baglocked.BaglockedManager;
   import beadSystem.views.BeadFeedInfoFrame;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import magicStone.MagicStoneControl;
   import magicStone.MagicStoneManager;
   import magicStone.components.MgStoneCell;
   import magicStone.components.MgStoneFeedBtn;
   import magicStone.components.MgStoneLockBtn;
   import magicStone.components.MgStoneUtils;
   import road7th.data.DictionaryEvent;
   
   public class MagicStoneBagView extends Sprite implements Disposeable
   {
      
      private static const PAGE_COUNT:int = 2;
       
      
      private var _bg:MutipleImage;
      
      private var _bagList:MagicStoneBagList;
      
      private var _batCombBtn:SimpleBitmapButton;
      
      private var _lockBtn:MgStoneLockBtn;
      
      private var _sortBtn:TextButton;
      
      private var _prevBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBg:Scale9CornerImage;
      
      private var _pageTxt:FilterFrameText;
      
      private var _moneyBg:ScaleBitmapImage;
      
      private var _bindMoneyBg:ScaleBitmapImage;
      
      private var _moneyIcon:Bitmap;
      
      private var _bindMoneyIcon:Bitmap;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bindMoneyTxt:FilterFrameText;
      
      private var _combineLightMC:MovieClip;
      
      private var _curPage:int;
      
      private var _combineArr:Array;
      
      private var _highLevelArr:Array;
      
      private var _allExp:int;
      
      private var _isPlayMc:Boolean = false;
      
      private var _updateItem:InventoryItemInfo;
      
      private var _mgStoneFeedBtn:MgStoneFeedBtn;
      
      private var _isSingleFeed:Boolean;
      
      private var _isPassExp:Boolean;
      
      public function MagicStoneBagView(){super();}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      private function initEvents() : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function updateMoney() : void{}
      
      private function __magicStoneAdd(param1:DictionaryEvent) : void{}
      
      protected function __cellClick(param1:CellEvent) : void{}
      
      protected function __cellDoubleClick(param1:CellEvent) : void{}
      
      protected function __batCombBtnClick(param1:MouseEvent) : void{}
      
      protected function maxJudge() : void{}
      
      protected function __onMaxResponse(param1:FrameEvent) : void{}
      
      private function combineConfirmAlert() : void{}
      
      private function highLevelAlert() : void{}
      
      protected function __onConfirmResponse(param1:FrameEvent) : void{}
      
      protected function __onCombineResponse(param1:FrameEvent) : void{}
      
      protected function __disposeCombineLightMC(param1:Event) : void{}
      
      private function updateMagicStone() : void{}
      
      protected function __lockBtnClick(param1:MouseEvent) : void{}
      
      protected function __sortBtnClick(param1:MouseEvent) : void{}
      
      protected function __prevBtnClick(param1:MouseEvent) : void{}
      
      protected function __nextBtnClick(param1:MouseEvent) : void{}
      
      public function get curPage() : int{return 0;}
      
      public function set curPage(param1:int) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
