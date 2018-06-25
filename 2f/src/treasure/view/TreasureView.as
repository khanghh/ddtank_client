package treasure.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleUpDownImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import farm.FarmModelController;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import treasure.controller.TreasureManager;   import treasure.events.TreasureEvents;   import treasure.model.TreasureModel;      public class TreasureView extends Sprite implements Disposeable   {                   private var _model:TreasureModel;            private var _bg:Bitmap;            private var _loginDaysTitle:Bitmap;            private var _numBg:Bitmap;            private var _digTimesTitle:Bitmap;            private var _helpTimesTitle:Bitmap;            private var _line1:Bitmap;            private var _line2:Bitmap;            private var _loginDaysTf:FilterFrameText;            private var infoFrameBg:ScaleUpDownImage;            private var beginBtn:SimpleBitmapButton;            private var endBtn:SimpleBitmapButton;            private var box:Sprite;            private var fieldView:TreasureField;            private var _treasureReturnBar:TreasureReturnBar;            private var _helpFrame:TreasureHelpFrame;            public function TreasureView() { super(); }
            private function init() : void { }
            private function initData() : void { }
            private function addListener() : void { }
            private function __endGameHandler(e:TreasureEvents) : void { }
            private function __diHandler(e:TreasureEvents) : void { }
            private function __beginGameHandler(e:TreasureEvents) : void { }
            private function __returnHandler(e:TreasureEvents) : void { }
            private function __friendHelpFarmHandler(e:TreasureEvents) : void { }
            private function __onEndBtnClick(e:MouseEvent) : void { }
            protected function __onFeedResponse(event:FrameEvent) : void { }
            private function __onbeginBtnClick(e:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}