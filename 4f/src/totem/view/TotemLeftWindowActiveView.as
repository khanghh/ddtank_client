package totem.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.PositionUtils;   import dragonBoat.DragonBoatManager;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.filters.ColorMatrixFilter;   import flash.filters.GlowFilter;   import flash.geom.Point;   import totem.TotemManager;   import totem.data.TotemDataVo;   import totem.mornUI.TotemLeftWindowActiveViewUI;   import trainer.view.NewHandContainer;      public class TotemLeftWindowActiveView extends TotemLeftWindowActiveViewUI   {                   private var _totemPointBgList:Vector.<BitmapData>;            private var _totemPointIconList:Vector.<BitmapData>;            private var _totemPointSprite:Sprite;            private var _totemPointList:Vector.<TotemLeftWindowTotemCell>;            private var _curCanClickPointLocation:int;            private var _totemPointLocationList:Array;            private var _windowBorder:Bitmap;            private var _lineShape:Shape;            private var _lightGlowFilter:GlowFilter;            private var _grayGlowFilter:ColorMatrixFilter;            private var _openCartoonSprite:TotemLeftWindowOpenCartoonView;            private var _propertyTxtSprite:TotemLeftWindowPropertyTxtView;            private var _tipView:TotemPointTipView;            private var _selectBtn:SelectedCheckButton;            private var confirmFrame:BaseAlerFrame;            public function TotemLeftWindowActiveView() { super(); }
            override protected function initialize() : void { }
            public function refreshView(nextPointInfo:TotemDataVo, callback:Function = null) : void { }
            public function openFailHandler(nextPointInfo:TotemDataVo) : void { }
            private function enableCurCanClickBtn() : void { }
            private function disenableCurCanClickBtn() : void { }
            public function show(page:int, nextPointInfo:TotemDataVo, isSelf:Boolean) : void { }
            private function addTotemPoint(location:Array, page:int, nextPointInfo:TotemDataVo, isSelf:Boolean) : void { }
            private function refreshGlowFilter(page:int, nextPointInfo:TotemDataVo) : void { }
            private function refreshTotemPoint(page:int, nextPointInfo:TotemDataVo, isSelf:Boolean) : void { }
            public function scalePropertyTxtSprite(scale:Number) : void { }
            private function openTotem(event:MouseEvent) : void { }
            private function __onClickSelectedBtn(e:MouseEvent) : void { }
            private function __openOneTotemConfirms(evt:FrameEvent) : void { }
            protected function onCheckCancel() : void { }
            protected function onCheckComplete() : void { }
            private function __openOneTotemConfirm(evt:FrameEvent) : void { }
            protected function onCheckComplete2() : void { }
            private function doOpenOneTotem(isBind:Boolean) : void { }
            private function showTip(event:MouseEvent) : void { }
            private function hideTip(event:MouseEvent) : void { }
            private function drawTestPoint() : void { }
            private function drawLine(page:int, nextPointInfo:TotemDataVo, isSelf:Boolean) : void { }
            override public function dispose() : void { }
   }}