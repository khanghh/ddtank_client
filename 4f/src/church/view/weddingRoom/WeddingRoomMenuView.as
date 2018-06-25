package church.view.weddingRoom{   import church.ChurchManager;   import church.model.ChurchRoomModel;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class WeddingRoomMenuView extends Sprite implements Disposeable   {                   private var _model:ChurchRoomModel;            private var _menuShowName:ScaleFrameImage;            private var _menuShowPao:ScaleFrameImage;            private var _menuShowFire:ScaleFrameImage;            private var hideConfigs:Array;            private var _moonBtn:MovieClip;            private var _roomNameBox:Sprite;            private var _roomNameBg:Scale9CornerImage;            private var _txtRoomNameGroomName:FilterFrameText;            private var _txtRoomNameAnd:FilterFrameText;            private var _txtRoomNameBrideName:FilterFrameText;            private var _txtRoomNameWedding:FilterFrameText;            public function WeddingRoomMenuView(model:ChurchRoomModel) { super(); }
            private function initialize() : void { }
            private function setView() : void { }
            private function removeView() : void { }
            private function setEvent() : void { }
            public function backupConfig() : void { }
            public function revertConfig() : void { }
            private function removeEvent() : void { }
            private function onMenuClick(evt:MouseEvent) : void { }
            public function resetView() : void { }
            private function setMoonBtn() : void { }
            private function setRoomName() : void { }
            private function enterMoonScene(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}