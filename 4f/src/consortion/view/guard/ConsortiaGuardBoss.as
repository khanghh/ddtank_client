package consortion.view.guard{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Shape;   import flash.display.Sprite;   import flash.geom.Point;   import flash.geom.Rectangle;      public class ConsortiaGuardBoss extends Sprite implements Disposeable   {                   private var _index:int;            private var _location:Point;            public function ConsortiaGuardBoss(index:int) { super(); }
            private function init() : void { }
            public function get index() : int { return 0; }
            public function get location() : Point { return null; }
            public function dispose() : void { }
   }}