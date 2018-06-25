package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;      public class Battle extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _battle_txt:FilterFrameText;            public function Battle(battle:int) { super(); }
            public function get bg() : Bitmap { return null; }
            public function get battle_txt() : FilterFrameText { return null; }
            private function init() : void { }
            public function set BattleNum(battleNum:int) : void { }
            public function dispose() : void { }
   }}