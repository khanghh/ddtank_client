package bombKing.components{   import bombKing.data.BKingPlayerInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.geom.Point;      public class BKingPlayerItem extends Sprite implements Disposeable   {                   private var _bg:MovieClip;            private var _playerName:FilterFrameText;            private var _info:BKingPlayerInfo;            private var _place:int;            private var _curStatus:int;            private var _pos:Point;            public function BKingPlayerItem(place:int) { super(); }
            private function initView() : void { }
            public function set info(info:BKingPlayerInfo) : void { }
            public function get info() : BKingPlayerInfo { return null; }
            private function setNameTxtStyle() : void { }
            public function dispose() : void { }
   }}