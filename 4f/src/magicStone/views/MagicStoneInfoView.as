package magicStone.views{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.PlayerInfo;   import ddt.data.player.SelfInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.interfaces.ICell;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.RoomCharacter;   import ddt.view.tips.OneLineTip;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.Dictionary;   import game.GameManager;   import magicStone.MagicStoneControl;   import magicStone.MagicStoneManager;   import magicStone.components.EmbedMgStoneCell;   import magicStone.components.MagicStoneConfirmView;   import magicStone.components.MagicStoneProgress;   import magicStone.components.MgStoneCell;   import magicStone.components.MgStoneUtils;   import magicStone.event.MagicStoneEvent;   import magicStone.stoneExploreView.StoneExploreView;   import playerDress.PlayerDressManager;   import playerDress.components.DressModel;   import playerDress.components.DressUtils;   import playerDress.data.DressVo;   import road7th.data.DictionaryData;   import trainer.view.NewHandContainer;      public class MagicStoneInfoView extends Sprite implements Disposeable   {            private static const CELL_LEN:int = 9;            public static const UPDATE_CELL:int = 31;                   private var _bg:Bitmap;            private var _lightBg:Bitmap;            private var _whiteStone:Bitmap;            private var _blueStone:Bitmap;            private var _purpleStone:Bitmap;            private var _scoreTxt:FilterFrameText;            private var _covertBtn:TextButton;            private var _exploreBtn:SimpleBitmapButton;            private var _exploreBatBtn:SimpleBitmapButton;            private var _oneLineTip:OneLineTip;            private var _lightFilters:Array;            private var _progress:MagicStoneProgress;            private var _mgStoneCells:Vector.<EmbedMgStoneCell>;            private var _cells:Dictionary;            public var selectedIndex:int;            private var _mgStonebag:BagInfo;            private var _character:RoomCharacter;            private var _currentModel:DressModel;            private var _helpTxt:FilterFrameText;            private var _stoneExploreBtn:SimpleBitmapButton;            private var _stoneExploreView:StoneExploreView;            private var _confirmFrame:BaseAlerFrame;            private var _confirmFrame1:BaseAlerFrame;            public function MagicStoneInfoView() { super(); }
            public function updataCharacter(_info:PlayerInfo) : void { }
            private function initView() : void { }
            public function createEmbedMgStoneCell(place:int = 0, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell { return null; }
            private function fillTipProp(cell:ICell) : void { }
            public function updateModel() : void { }
            private function initData() : void { }
            private function updateProgress() : void { }
            private function clearCells() : void { }
            private function initEvent() : void { }
            private function __magicStoneDoubleScore(evt:MagicStoneEvent) : void { }
            protected function __cellClickHandler(event:InteractiveEvent) : void { }
            protected function __doubleClickHandler(event:InteractiveEvent) : void { }
            private function isBagFull() : Boolean { return false; }
            protected function __cellClick(event:CellEvent) : void { }
            protected function __updateGoods(event:BagEvent) : void { }
            public function setCellInfo(index:int, info:InventoryItemInfo) : void { }
            protected function __covertBtnClick(event:MouseEvent) : void { }
            protected function __frameEvent(event:FrameEvent) : void { }
            protected function __exploreBtnClick(event:MouseEvent) : void { }
            private function comfirmHandler(event:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            public function getNeedMoney() : int { return 0; }
            public function getNeedMoney2(index:int) : int { return 0; }
            protected function __exploreBatBtnClick(event:MouseEvent) : void { }
            private function confirmBatHandler(event:FrameEvent) : void { }
            protected function onBatCheckComplete() : void { }
            private function getBagRemain() : int { return 0; }
            private function __stoneExploreClick(e:MouseEvent) : void { }
            private function __showExploreView(e:Event) : void { }
            public function updateScore(num:int) : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}