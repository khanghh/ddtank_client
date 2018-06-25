package happyLittleGame{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class GameCard extends Sprite implements Disposeable   {                   private var _cardImage:Bitmap;            private var _gameType:int;            private var _selectImage:Bitmap;            private var _select:Boolean;            public function GameCard() { super(); }
            public function set gameType(value:int) : void { }
            private function __overHandler(evt:MouseEvent) : void { }
            private function __outHandler(evt:MouseEvent) : void { }
            public function set select(value:Boolean) : void { }
            public function get select() : Boolean { return false; }
            public function get gameType() : int { return 0; }
            public function dispose() : void { }
   }}