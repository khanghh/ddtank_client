package luckStar.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import luckStar.model.LuckStarPlayerInfo;      public class LuckStarRankItem extends Sprite implements Disposeable   {                   private var _vipName:GradientText;            private var _rankName:FilterFrameText;            private var _rankText:FilterFrameText;            private var _rankScore:FilterFrameText;            private var _rankIcon:ScaleFrameImage;            private var _info:LuckStarPlayerInfo;            public function LuckStarRankItem() { super(); }
            public function set info(value:LuckStarPlayerInfo) : void { }
            private function updateView() : void { }
            public function resetItem() : void { }
            private function updateRank() : void { }
            private function updateName() : void { }
            private function updateScore() : void { }
            public function dispose() : void { }
   }}