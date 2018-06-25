package happyLittleGame.bombshellGame.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.MouseEvent;   import uiModeManager.bombUI.model.bomb.BombRankInfo;      public class BombRankItem extends Sprite implements Disposeable   {                   private var _icon:ScaleFrameImage;            private var _rankTxt:FilterFrameText;            private var _nameTxt:FilterFrameText;            private var _scoreTxt:FilterFrameText;            private var _outPosTxt:FilterFrameText;            private var _rank:int;            private var _info:BombRankInfo;            private var _nameDis:String;            private var _tipbackgound:Image;            private var _tipDis:FilterFrameText;            public function BombRankItem() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __overHandler(e:MouseEvent) : void { }
            private function __outHandler(e:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function set Info(info:BombRankInfo) : void { }
            public function clear() : void { }
            public function setRank(ranking:int) : void { }
            private function getComponentByStylename(stylename:String) : * { return null; }
            public function dispose() : void { }
   }}