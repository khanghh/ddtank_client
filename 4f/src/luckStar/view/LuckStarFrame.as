package luckStar.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.events.BagEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.bossbox.AwardsView;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.MouseEvent;   import luckStar.cell.LuckStarCell;   import luckStar.event.LuckStarEvent;   import luckStar.manager.LuckStarManager;   import luckStar.manager.LuckStarTurnControl;   import shop.manager.ShopBuyManager;   import store.HelpFrame;   import store.HelpPrompt;      public class LuckStarFrame extends Frame   {            private static const MAX_CELL:int = 14;                   private var _bg:ScaleBitmapImage;            private var _superLuckyStarBg:Bitmap;            private var _luckyStarCount:int = 10;            private var _cell:Vector.<LuckStarCell>;            private var _startBtn:BaseButton;            private var _stopBtn:BaseButton;            private var _autoCheck:SelectedCheckButton;            private var _numText:FilterFrameText;            private var _coinsView:LuckStarCoinsView;            private var _rankView:LuckStarRankView;            private var _buyBtn:BaseButton;            private var _helpBtn:BaseButton;            private var _explain:FilterFrameText;            private var _coins:FilterFrameText;            private var _coinsAward:FilterFrameText;            private var _awardAction:MovieClip;            private var _turnControl:LuckStarTurnControl;            private var _select:int;            private var _rewardList:Array;            private var _turnComplete:Boolean = true;            private var _helpNumText:FilterFrameText;            private var _helpRewardPrice:FilterFrameText;            private var _getRewardPrice:int;            private var _frame:BaseAlerFrame;            private var _alert:BaseAlerFrame;            public function LuckStarFrame() { super(); }
            private function initView() : void { }
            private function __onHelpClick(e:MouseEvent) : void { }
            private function __selectedChanged(e:Event) : void { }
            public function getAwardGoods(goods:InventoryItemInfo) : void { }
            private function __onPlayActionEnd(e:LuckStarEvent) : void { }
            private function showAward() : void { }
            private function showAwardFrame() : void { }
            private function __onFrameClose(e:FrameEvent) : void { }
            private function __onTurnComplete(e:Event) : void { }
            private function __onStartLuckyStar(e:MouseEvent) : void { }
            private function __onStopLuckyStar(e:MouseEvent) : void { }
            private function set aotuButton(value:Boolean) : void { }
            private function turnLuckyStar() : void { }
            private function helpBuyAlert() : void { }
            private function __onResponse(e:FrameEvent) : void { }
            private function startTurn() : void { }
            private function playCoinsAction() : void { }
            private function disposeAwardAction(e:Event) : void { }
            public function __onBuyLuckyStar(e:MouseEvent) : void { }
            private function buyStar() : void { }
            public function __onbagUpdate(e:BagEvent) : void { }
            private function updateLuckyStarCount() : void { }
            public function updateCellInfo() : void { }
            public function updateMinUseNum() : void { }
            public function updateLuckyStarCoins() : void { }
            public function updateRankInfo() : void { }
            public function updateActivityDate() : void { }
            public function updatePlayActionList() : void { }
            public function updateNewAwardList(name:String, award:int, count:int) : void { }
            public function get isTurn() : Boolean { return false; }
            override public function dispose() : void { }
   }}