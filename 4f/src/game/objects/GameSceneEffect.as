package game.objects{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.BallManager;   import flash.display.MovieClip;   import flash.geom.Point;   import flash.geom.Rectangle;   import game.view.map.MapView;   import phy.object.PhysicalObj;   import road7th.utils.MovieClipVSplice;      public class GameSceneEffect extends PhysicalObj   {                   private var _effectMovie:MovieClipVSplice;            private var _isDispose:Boolean = false;            private var _isDie:Boolean = false;            private var _txt:FilterFrameText;            public function GameSceneEffect(id:int, rect:Rectangle = null, layerType:int = 7, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 0, airResitFactor:Number = 1) { super(null,null,null,null,null,null); }
            private function test() : void { }
            public function initMoving() : void { }
            public function initTxt() : void { }
            public function updateTxt(str:Object) : void { }
            override public function get layer() : int { return 0; }
            override public function get layerType() : int { return 0; }
            private function initView() : void { }
            public function act(action:String, back:Function = null) : void { }
            override public function moveTo(p:Point) : void { }
            override public function collidedByObject(obj:PhysicalObj) : void { }
            public function get effectMovie() : MovieClipVSplice { return null; }
            public function needFocus(offsetX:int = 0, offsetY:int = 0, data:Object = null) : void { }
            public function get map() : MapView { return null; }
            override public function die() : void { }
            override public function stopMoving() : void { }
            public function get isDie() : Boolean { return false; }
            override public function dispose() : void { }
   }}