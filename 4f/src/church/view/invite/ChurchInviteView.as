package church.view.invite{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedTextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.player.ConsortiaPlayerInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;   import invite.data.InvitePlayerInfo;      public class ChurchInviteView extends BaseAlerFrame   {                   private var _bg:Scale9CornerImage;            private var _controller:ChurchInviteController;            private var _model:ChurchInviteModel;            private var _alertInfo:AlertInfo;            private var _currentTab:int;            private var _refleshCount:int;            private var _listPanel:ListPanel;            private var _inviteFriendBtn:SelectedTextButton;            private var _inviteConsortiaBtn:SelectedTextButton;            private var _btnGroup:SelectedButtonGroup;            private var _currentList:Array;            public function ChurchInviteView() { super(); }
            private function setView() : void { }
            private function setEvent() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function sumbitConfirm(evt:MouseEvent = null) : void { }
            private function __changeHandler(event:Event) : void { }
            private function listUpdate(evt:Event = null) : void { }
            private function __soundPlay(event:MouseEvent) : void { }
            private function changeData(info:PlayerInfo, index:int) : Object { return null; }
            public function show() : void { }
            public function hide() : void { }
            public function get model() : ChurchInviteModel { return null; }
            public function set model(value:ChurchInviteModel) : void { }
            public function get controller() : ChurchInviteController { return null; }
            public function set controller(value:ChurchInviteController) : void { }
            private function removeEvent() : void { }
            private function removeView() : void { }
            override public function dispose() : void { }
   }}