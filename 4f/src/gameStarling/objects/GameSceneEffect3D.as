package gameStarling.objects{   import bones.display.BoneMovieStarling;   import bones.display.IBoneMovie;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.manager.BallManager;   import flash.geom.Point;   import flash.geom.Rectangle;   import gameStarling.view.map.MapView3D;   import road7th.utils.BoneMovieVSplice;   import starlingPhy.object.PhysicalObj3D;   import starlingui.core.text.TextLabel;      public class GameSceneEffect3D extends PhysicalObj3D   {                   private var _effectMovie:BoneMovieVSplice;            private var _isDispose:Boolean = false;            private var _isDie:Boolean = false;            private var _txt:TextLabel;            private var _backFun:Function;            public function GameSceneEffect3D(id:int, rect:Rectangle = null, layerType:int = 7, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 0, airResitFactor:Number = 1) { super(null,null,null,null,null,null); }
            public function initMoving() : void { }
            public function updateTxt(str:Object) : void { }
            override public function get layer() : int { return 0; }
            override public function get layerType() : int { return 0; }
            private function initView() : void { }
            public function act(action:String, back:Function = null) : void { }
            public function set bombBackFun(fun:Function) : void { }
            override public function moveTo(p:Point) : void { }
            override public function collidedByObject(obj:PhysicalObj3D) : void { }
            public function get effectMovie() : BoneMovieVSplice { return null; }
            public function needFocus(offsetX:int = 0, offsetY:int = 0, data:Object = null) : void { }
            public function get map() : MapView3D { return null; }
            override public function die() : void { }
            override public function stopMoving() : void { }
            public function get isDie() : Boolean { return false; }
            override public function dispose() : void { }
   }}