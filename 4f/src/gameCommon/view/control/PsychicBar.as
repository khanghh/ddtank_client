package gameCommon.view.control{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.LivingEvent;   import ddt.utils.PositionUtils;   import flash.display.BitmapData;   import flash.display.DisplayObject;   import flash.display.Graphics;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.geom.Point;   import flash.geom.Rectangle;   import game.objects.SimpleBox;   import gameCommon.model.LocalPlayer;      public class PsychicBar extends Sprite implements Disposeable   {                   private var _self:LocalPlayer;            private var _back:DisplayObject;            private var _localPsychic:int;            private var _numField:PsychicShape;            private var _movie:MovieClip;            private var _ghostBoxCenter:Point;            private var _ghostBitmapPool:Object;            private var _mouseArea:MouseArea;            public function PsychicBar(self:LocalPlayer) { super(); }
            private function configUI() : void { }
            private function addEvent() : void { }
            private function boxTweenComplete(box:DisplayObject) : void { }
            private function __pickBox(event:LivingEvent) : void { }
            private function __psychicChanged(event:LivingEvent) : void { }
            private function removeEvent() : void { }
            public function enter() : void { }
            public function leaving() : void { }
            public function dispose() : void { }
            private function getGhostShape(type:int) : Shape { return null; }
   }}import com.pickgliss.ui.core.Disposeable;import com.pickgliss.utils.ObjectUtils;import ddt.display.BitmapShape;import ddt.manager.BitmapManager;import flash.display.Sprite;class PsychicShape extends Sprite implements Disposeable{          private var _nums:Vector.<BitmapShape>;      private var _num:int = 0;      private var _bitmapMgr:BitmapManager;      function PsychicShape() { super(); }
      private function draw() : void { }
      private function clear() : void { }
      public function setNum(val:int) : void { }
      public function dispose() : void { }
}import com.pickgliss.ui.ComponentFactory;import com.pickgliss.ui.LayerManager;import com.pickgliss.ui.core.Disposeable;import com.pickgliss.utils.ObjectUtils;import ddt.manager.LanguageMgr;import ddt.view.tips.ChangeNumToolTip;import ddt.view.tips.ChangeNumToolTipInfo;import flash.display.Graphics;import flash.display.Sprite;import flash.events.MouseEvent;import flash.geom.Rectangle;class MouseArea extends Sprite implements Disposeable{          private var _tipData:String;      private var _tipPanel:ChangeNumToolTip;      private var _tipInfo:ChangeNumToolTipInfo;      function MouseArea(radius:int) { super(); }
      public function setPsychic(val:int) : void { }
      private function addEvent() : void { }
      private function removeEvent() : void { }
      public function dispose() : void { }
      private function addTip() : void { }
      private function __mouseOut(evt:MouseEvent) : void { }
      private function __mouseOver(evt:MouseEvent) : void { }
}