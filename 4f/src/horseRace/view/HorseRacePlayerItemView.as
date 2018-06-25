package horseRace.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;   import flash.display.Bitmap;   import flash.display.BitmapData;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.geom.Point;   import flash.geom.Rectangle;      public class HorseRacePlayerItemView extends Sprite implements Disposeable   {            private static var HeadWidth:int = 120;            private static var HeadHeight:int = 103;                   private var _selectbg:Bitmap;            private var _isSelf:Boolean;            private var _headBg:Bitmap;            private var _rakeImg:MovieClip;            private var _playerNameTxt:FilterFrameText;            private var _spName:Sprite;            private var _lblName:FilterFrameText;            private var _walkingPlayer:HorseRaceWalkPlayer;            private var _headLoader:SceneCharacterLoaderHead;            private var _headBitmap:Bitmap;            private var _clickSp:Sprite;            private var _buffList:HBox;            private var _pingzhangBuff:MovieClip;            public function HorseRacePlayerItemView(walkingPlayer:HorseRaceWalkPlayer) { super(); }
            public function getPlayerInfo() : HorseRaceWalkPlayer { return null; }
            private function initView() : void { }
            public function setBgVisible(bool:Boolean) : void { }
            public function flashBuffList(buffArr:Array) : void { }
            public function flushRank() : void { }
            public function showPingzhangBuff(bool:Boolean) : void { }
            private function getBuffByType(type:int) : Bitmap { return null; }
            public function loadHead() : void { }
            private function headLoaderCallBack(headLoader:SceneCharacterLoaderHead, isAllLoadSucceed:Boolean = true) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}