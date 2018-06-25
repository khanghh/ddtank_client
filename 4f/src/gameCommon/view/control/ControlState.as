package gameCommon.view.control{   import com.greensock.TweenLite;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.display.Sprite;   import gameCommon.model.LocalPlayer;      public class ControlState extends Sprite implements Disposeable   {                   protected var _self:LocalPlayer;            protected var _container:DisplayObjectContainer;            protected var _leavingFunc:Function;            protected var _background:DisplayObject;            public function ControlState(self:LocalPlayer) { super(); }
            protected function configUI() : void { }
            protected function addEvent() : void { }
            protected function removeEvent() : void { }
            public function enter(container:DisplayObjectContainer) : void { }
            protected function tweenIn() : void { }
            protected function tweenOut() : void { }
            public function leaving(onComplete:Function = null) : void { }
            protected function enterComplete() : void { }
            protected function leavingComplete() : void { }
            public function dispose() : void { }
   }}