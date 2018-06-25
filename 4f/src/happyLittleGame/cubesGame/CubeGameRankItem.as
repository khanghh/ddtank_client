package happyLittleGame.cubesGame{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import funnyGames.cubeGame.data.CubeGameRankData;      public class CubeGameRankItem extends Sprite implements Disposeable   {                   private var _rankTxt:FilterFrameText;            private var _nameTxt:FilterFrameText;            private var _scoreTxt:FilterFrameText;            public function CubeGameRankItem() { super(); }
            private function init() : void { }
            public function set data(value:CubeGameRankData) : void { }
            public function clear() : void { }
            public function dispose() : void { }
   }}