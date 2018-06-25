package nationDay.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import dayActivity.event.ActivityEvent;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import nationDay.NationDayControl;   import nationDay.NationDayManager;   import nationDay.model.NationModel;   import road7th.comm.PackageIn;   import road7th.utils.DateUtils;      public class NationalDayView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _closeBtn:SimpleBitmapButton;            private var _activityTime:FilterFrameText;            private var _description:FilterFrameText;            private var _nationModel:NationModel;            private var _haveGoodsBox1:SimpleTileList;            private var _haveGoodsBox2:SimpleTileList;            private var _haveGoodsBox3:SimpleTileList;            private var _haveGoodsBox4:SimpleTileList;            private var _haveGoodsBox:Vector.<SimpleTileList>;            private var _wordVec:Vector.<NationDayWord>;            private var _exchangeCellVec:Vector.<ActivitySeedCell>;            private var _vBox:VBox;            private var _textList:Vector.<FilterFrameText>;            public function NationalDayView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __onKeyDown(event:KeyboardEvent) : void { }
            protected function __onExchangeGoods(event:PkgEvent) : void { }
            public function setViewInfo() : void { }
            private function updateDescription() : void { }
            private function addAwardAnimation() : void { }
            protected function __seedGood(event:ActivityEvent) : void { }
            private function updateHaveGoodsBox() : void { }
            private function updateExchangeGoodsBox() : void { }
            private function getExchangeNum(index:int) : int { return 0; }
            private function cleanExchangeCell() : void { }
            private function updateTimeShow() : void { }
            private function updateGetTimes() : void { }
            private function addZero(value:Number) : String { return null; }
            private function __onCloseEventHandler(event:MouseEvent) : void { }
            public function dispose() : void { }
            private function removeEvent() : void { }
            public function show() : void { }
   }}