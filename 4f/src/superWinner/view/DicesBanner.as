package superWinner.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.MovieClip;   import flash.display.Sprite;      public class DicesBanner extends Sprite implements Disposeable   {                   private var _diceArr:Vector.<MovieClip>;            private var _space:Number;            public function DicesBanner(space:Number = 37.8) { super(); }
            private function init() : void { }
            public function showLastDices(val:Vector.<int>) : void { }
            public function dispose() : void { }
   }}