package church.view.weddingRoomList{   import baglocked.BaglockedManager;   import church.ChurchManager;   import church.controller.ChurchRoomListController;   import church.model.ChurchRoomListModel;   import church.view.weddingRoomList.frame.HighClassWeddingFrame;   import church.view.weddingRoomList.frame.WeddingRoomCreateView;   import church.view.weddingRoomList.frame.WeddingUnmarryView;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class WeddingRoomListNavView extends Sprite implements Disposeable   {            public static const DIVORCE_NUM:int = 5214;                   private var _controller:ChurchRoomListController;            private var _model:ChurchRoomListModel;            private var _bgNavAsset:MutipleImage;            private var _highClassWeddingBtn:SimpleBitmapButton;            private var _btnCreateAsset:BaseButton;            private var _btnJoinAsset:BaseButton;            private var _btnDivorceAsset:BaseButton;            private var _createRoomFrame:WeddingRoomCreateView;            private var _weddingUnmarryView:WeddingUnmarryView;            public function WeddingRoomListNavView(controller:ChurchRoomListController, model:ChurchRoomListModel) { super(); }
            protected function initialize() : void { }
            private function setView() : void { }
            private function highClassWeddingBtnEnable() : Boolean { return false; }
            private function removeView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function onClickListener(evt:MouseEvent) : void { }
            private function _openDivorce() : void { }
            private function __mateTime(e:PkgEvent) : void { }
            private function showHighClassWeddingFrame() : void { }
            private function __onRequestSeniorChurch(e:PkgEvent) : void { }
            public function showWeddingRoomCreateView() : void { }
            public function showUnmarryFrame(spouseLastDate:Date, needMoney:int) : void { }
            public function dispose() : void { }
   }}