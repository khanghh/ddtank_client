package com.pickgliss.ui{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.core.ITransformableTipedDisplay;   import com.pickgliss.ui.tip.ITip;   import com.pickgliss.ui.vo.DirectionPos;   import com.pickgliss.utils.DisplayUtils;   import flash.display.DisplayObjectContainer;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.Dictionary;      public final class ShowTipManager   {            public static const StartPoint:Point = new Point(0,0);            private static var _instance:ShowTipManager;                   private var _currentTipObject:ITipedDisplay;            private var _simpleTipset:Object;            private var _tipContainer:DisplayObjectContainer;            private var _tipedObjects:Vector.<ITipedDisplay>;            private var _tips:Dictionary;            private var _updateTempTarget:ITipedDisplay;            public function ShowTipManager() { super(); }
            public static function get Instance() : ShowTipManager { return null; }
            public function addTip(tipedDisplay:ITipedDisplay) : void { }
            public function getTipPosByDirction(tip:ITip, target:ITipedDisplay, direction:int) : Point { return null; }
            public function hideTip(target:ITipedDisplay) : void { }
            public function removeCurrentTip() : void { }
            public function removeAllTip() : void { }
            public function removeTip(tipedDisplay:ITipedDisplay) : void { }
            public function setSimpleTip(target:ITipedDisplay, tipMsg:String = "") : void { }
            public function setup() : void { }
            public function tempChangeTipContainer() : void { }
            public function showTip(target:*) : void { }
            public function getTipInstanceByStylename(stylename:String) : ITip { return null; }
            public function updatePos() : void { }
            private function setCommonTip(target:*, tip:*) : void { }
            public function createTipByStyleName(stylename:String) : * { return null; }
            private function configPosition(target:*, tip:*) : void { }
            private function __onOut(event:MouseEvent) : void { }
            private function __onOver(event:MouseEvent) : void { }
            private function getTipPriorityDirction(tip:ITip, target:ITipedDisplay, directions:String) : DirectionPos { return null; }
            private function searchFixedDirectionPos(tempDirections:Vector.<DirectionPos>) : DirectionPos { return null; }
            private function creatDirectionPos(startPos:Point, endPos:Point, direction:int) : DirectionPos { return null; }
            private function removeTipedObject(tipedDisplay:ITipedDisplay) : void { }
   }}