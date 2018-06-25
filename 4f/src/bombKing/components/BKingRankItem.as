package bombKing.components{   import bombKing.data.BKingRankInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.GradientText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.text.TextFormat;   import vip.VipController;      public class BKingRankItem extends Sprite implements Disposeable   {                   private var _sprite:Sprite;            private var _backOverImg:Scale9CornerImage;            private var _topThreeIcon:ScaleFrameImage;            private var _placeTxt:FilterFrameText;            private var _vipName:GradientText;            private var _nameTxt:FilterFrameText;            private var _areaName:FilterFrameText;            private var _numTxt:FilterFrameText;            private var _info:BKingRankInfo;            public function BKingRankItem() { super(); }
            private function initView() : void { }
            private function addEvents() : void { }
            protected function __onOutHandler(event:MouseEvent) : void { }
            protected function __onOverHanlder(event:MouseEvent) : void { }
            public function set info(info:BKingRankInfo) : void { }
            private function addNickName() : void { }
            private function setRankNum(num:int) : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}