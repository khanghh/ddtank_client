package ddt.view.roulette{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.box.BoxGoodsTempInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.RouletteManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Timer;   import flash.utils.clearTimeout;   import flash.utils.setTimeout;   import road7th.comm.PackageIn;      public class RouletteView extends Sprite implements Disposeable   {            public static const GLINT_ALL_GOODSTYPE:int = 4;            public static const SELECTGOODS_SUM:int = 8;            public static const GLINT_ONE_TIME:int = 3100;            public static const GLINT_ALL_TIME:int = 7500;                   private var _keyCount:int = 0;            private var _turnControl:TurnControl;            private var _startButton:BaseButton;            private var _oneKeyStartBtn:BaseButton;            private var _buyKeyButton:BaseButton;            private var _pointArray:Array;            private var _selectNumber:int = 0;            private var _needKeyCount:Array;            private var _goodsList:Vector.<RouletteGoodsCell>;            private var _templateIDList:Array;            private var _selectGoodsList:Vector.<RouletteGoodsCell>;            private var _selectGoogsNumber:int = 0;            private var _turnSlectedNumber:int = 0;            private var _selectedGoodsInfo:InventoryItemInfo;            private var _selectedGoodsNumberInTemplateIDList:int = 0;            private var _isTurn:Boolean = false;            private var _isCanClose:Boolean = true;            private var _isLoadSucceed:Boolean = false;            private var _winTimeOut:uint = 1;            private var _glintView:RouletteGlintView;            private var _selectedItemType:int;            private var _selectedCount:int;            private var _selectedCellBox:HBox;            private var _keyConutText:FilterFrameText;            private var _selectNumberText:FilterFrameText;            private var _needKeyText:FilterFrameText;            private var _itemList:Vector.<RouletteGoodsCell>;            private var _type:int;            private var _index:int;            private var _selectedGoodsInfoList:Array;            private var _selectedGoodsCountList:Array;            public function RouletteView(templateIDList:Array) { super(); }
            private function init() : void { }
            private function getAllGoodsPoint() : void { }
            private function initEvent() : void { }
            private function _getItem(e:PkgEvent) : void { }
            private function timerHander(e:TimerEvent) : void { }
            private function timerCompHander(e:TimerEvent) : void { }
            private function _oneKeyClick(e:MouseEvent) : void { }
            private function _turnClick(e:MouseEvent) : void { }
            private function sendStartRoulette(type:int = 0) : void { }
            private function totalKeyCount() : int { return 0; }
            private function _startTurn() : void { }
            private function _buyKeyClick(e:MouseEvent) : void { }
            private function _keyUpdate(e:RouletteEvent) : void { }
            private function _turnComplete(e:Event) : void { }
            private function _updateTurnList() : void { }
            private function _bigGlintComplete(e:Event) : void { }
            private function _moveToSelctViewTimer(index:int) : void { }
            private function _moveToSelctView() : void { }
            private function _findCellByItemID(itemId:int, _count:int) : int { return 0; }
            private function _findSelectedGoodsNumberInTemplateIDList(itemId:int, _count:int) : int { return 0; }
            private function _finish() : void { }
            public function set keyCount(value:int) : void { }
            public function get keyCount() : int { return 0; }
            public function set selectNumber(value:int) : void { }
            private function get needKeyCount() : int { return 0; }
            public function get selectNumber() : int { return 0; }
            public function set turnSlectedNumber(value:int) : void { }
            public function get turnSlectedNumber() : int { return 0; }
            public function set isTurn(value:Boolean) : void { }
            public function get isTurn() : Boolean { return false; }
            public function get isCanClose() : Boolean { return false; }
            private function getTemplateInfo(id:int) : InventoryItemInfo { return null; }
            public function dispose() : void { }
   }}