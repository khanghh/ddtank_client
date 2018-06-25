package treasurePuzzle.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.text.TextField;   import treasurePuzzle.controller.TreasurePuzzleManager;   import treasurePuzzle.data.TreasurePuzzlePiceData;   import treasurePuzzle.data.TreasurePuzzleRewardData;      public class TreasurePuzzleHelpView extends Frame   {                   private var _view:Sprite;            private var _bg:ScaleBitmapImage;            private var _topBg:Bitmap;            private var _downBg:Bitmap;            private var _panel:ScrollPanel;            private var _panel2:ScrollPanel;            private var _vbox:VBox;            public function TreasurePuzzleHelpView() { super(); }
            private function initView() : void { }
            private function createRewardContent() : void { }
            private function setRewardInfo(type:int) : void { }
            private function createContent() : void { }
            private function addEvent() : void { }
            private function _response(e:FrameEvent) : void { }
            private function close() : void { }
            override public function dispose() : void { }
   }}