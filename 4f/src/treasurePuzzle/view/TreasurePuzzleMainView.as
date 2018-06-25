package treasurePuzzle.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import treasurePuzzle.controller.TreasurePuzzleManager;   import treasurePuzzle.data.TreasurePuzzlePiceData;      public class TreasurePuzzleMainView extends Frame   {                   private var _topBg:Bitmap;            private var _downBg:Bitmap;            private var _getRewardBnt:BaseButton;            private var _helpBnt:BaseButton;            private var _leftBnt:BaseButton;            private var _rightBnt:BaseButton;            private var _currentPuzzle:int;            private var pice1DataText:FilterFrameText;            private var pice2DataText:FilterFrameText;            private var pice3DataText:FilterFrameText;            private var pice4DataText:FilterFrameText;            private var pice5DataText:FilterFrameText;            private var pice6DataText:FilterFrameText;            private var bg:Bitmap;            private var pic_an1:Bitmap;            private var pic_an2:Bitmap;            private var pic_an3:Bitmap;            private var pic_an4:Bitmap;            private var pic_an5:Bitmap;            private var pic_an6:Bitmap;            private var pic_liang1:Bitmap;            private var pic_liang2:Bitmap;            private var pic_liang3:Bitmap;            private var pic_liang4:Bitmap;            private var pic_liang5:Bitmap;            private var pic_liang6:Bitmap;            public function TreasurePuzzleMainView() { super(); }
            private function initView() : void { }
            public function set currentPuzzle(id:int) : void { }
            public function showLightPic(data:TreasurePuzzlePiceData) : void { }
            public function getCurrentPicMap(id:int) : void { }
            private function initEvent() : void { }
            private function __clickLeftBnt(e:MouseEvent) : void { }
            private function __clickRightBnt(e:MouseEvent) : void { }
            private function __getRewardBntClick(e:MouseEvent) : void { }
            public function showShiwuInfoView() : void { }
            public function flushRewardBnt() : void { }
            private function __helpBntClick(e:MouseEvent) : void { }
            public function showHelpView() : void { }
            private function removeEvent() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            override public function dispose() : void { }
            public function show() : void { }
   }}