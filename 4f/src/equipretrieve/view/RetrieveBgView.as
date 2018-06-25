package equipretrieve.view{   import bagAndInfo.cell.BagCell;   import com.greensock.TimelineLite;   import com.greensock.TweenLite;   import com.pickgliss.effect.IEffect;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickBuyFrame;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import equipretrieve.RetrieveController;   import equipretrieve.RetrieveModel;   import equipretrieve.effect.AnimationControl;   import equipretrieve.effect.GlowFilterAnimation;   import equipretrieve.effect.MovieClipControl;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import store.StoreCell;      public class RetrieveBgView extends Sprite implements Disposeable   {                   private var _retrieveBt:SelectedButton;            private var _helpBt:SelectedButton;            private var _needGoldText:FilterFrameText;            private var _GoldBitmap:Bitmap;            private var _background:MovieImage;            private var _dropArea:RetrieveDragInArea;            private var _pointArray:Vector.<Point>;            private var _cells:Vector.<StoreCell>;            private var _moveCells:Vector.<StoreCell>;            private var _tweenInt:int = 0;            private var _retrieveBtLightBoo:Boolean;            private var _startStrthTip:MutipleImage;            private var _trieveShine:MovieImage;            private var _retrieveffect:IEffect;            private var _effectMcArr:Vector.<MovieImage>;            private var _titleBg:Bitmap;            private var _needMoneyIcon:Bitmap;            public function RetrieveBgView() { super(); }
            public function _initView() : void { }
            private function _getCellsPoint() : void { }
            private function _buildCell() : void { }
            public function startShine() : void { }
            public function stopShine() : void { }
            private function addEvt() : void { }
            private function removeEvt() : void { }
            private function showArr() : void { }
            private function hideArr() : void { }
            private function executeRetrieve(e:MouseEvent) : void { }
            private function _bingResponse(event:FrameEvent) : void { }
            private function _responseV(evt:FrameEvent) : void { }
            public function refreshData(items:Dictionary) : void { }
            public function cellDoubleClick(cell:BagCell) : void { }
            public function returnBag() : void { }
            private function _cellslightMovie() : void { }
            private function _cellslightMovieOver(e:Event) : void { }
            private function _cellsMove() : void { }
            private function _tweenlineComplete() : void { }
            private function _tweenline1Complete() : void { }
            public function clearCellInfo() : void { }
            public function dispose() : void { }
   }}