package church.view.invite
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.data.InvitePlayerInfo;
   
   public class ChurchInviteView extends BaseAlerFrame
   {
       
      
      private var _bg:Scale9CornerImage;
      
      private var _controller:ChurchInviteController;
      
      private var _model:ChurchInviteModel;
      
      private var _alertInfo:AlertInfo;
      
      private var _currentTab:int;
      
      private var _refleshCount:int;
      
      private var _listPanel:ListPanel;
      
      private var _inviteFriendBtn:SelectedTextButton;
      
      private var _inviteConsortiaBtn:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _currentList:Array;
      
      public function ChurchInviteView()
      {
         super();
         setView();
      }
      
      private function setView() : void
      {
         _refleshCount = 0;
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("tank.invite.InviteView.request");
         _alertInfo.cancelLabel = LanguageMgr.GetTranslation("tank.invite.InviteView.close");
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("tank.invite.InviteView.list");
         info = _alertInfo;
         this.escEnable = true;
         _bg = ComponentFactory.Instance.creat("church.ChurchInviteView.guestListBg");
         addToContent(_bg);
         _inviteFriendBtn = ComponentFactory.Instance.creat("church.room.inviteFriendBtnAsset");
         _inviteFriendBtn.text = LanguageMgr.GetTranslation("tank.view.chat.ChatInputView.friend");
         addToContent(_inviteFriendBtn);
         _inviteConsortiaBtn = ComponentFactory.Instance.creat("church.room.inviteConsortiaBtnAsset");
         _inviteConsortiaBtn.text = LanguageMgr.GetTranslation("tank.view.chat.ChannelListSelectView.consortia");
         addToContent(_inviteConsortiaBtn);
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("church.room.invitePlayerListAsset");
         addToContent(_listPanel);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_inviteFriendBtn);
         _btnGroup.addSelectItem(_inviteConsortiaBtn);
         _btnGroup.selectIndex = 0;
      }
      
      private function setEvent() : void
      {
         addEventListener("response",onFrameResponse);
         if(_model)
         {
            _model.addEventListener("listupdate",listUpdate);
         }
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__changeHandler);
         }
         if(_inviteFriendBtn)
         {
            _inviteFriendBtn.addEventListener("click",__soundPlay);
         }
         if(_inviteConsortiaBtn)
         {
            _inviteConsortiaBtn.addEventListener("click",__soundPlay);
         }
      }
      
      private function onFrameResponse(evt:FrameEvent) : void
      {
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               hide();
               break;
            case 2:
            case 3:
            case 4:
               sumbitConfirm();
         }
      }
      
      private function sumbitConfirm(evt:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
         _controller.refleshList(_currentTab);
      }
      
      private function __changeHandler(event:Event) : void
      {
         SoundManager.instance.play("008");
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               if(_currentTab == 0)
               {
                  return;
               }
               _currentTab = 0;
               break;
            case 1:
               if(_currentTab == 1)
               {
                  return;
               }
               _currentTab = 1;
               break;
         }
         _controller.refleshList(_currentTab);
      }
      
      private function listUpdate(evt:Event = null) : void
      {
         var i:int = 0;
         var inviteInfo:* = null;
         var plyeetInfo:* = null;
         var inviteInfoII:* = null;
         var plyeetInfoII:* = null;
         var j:int = 0;
         var playerInfo:* = null;
         var obj:* = null;
         _currentList = [];
         for(i = 0; i < _model.currentList.length; )
         {
            if(_model.currentList[i] is PlayerInfo)
            {
               inviteInfo = new InvitePlayerInfo();
               plyeetInfo = _model.currentList[i] as PlayerInfo;
               inviteInfo.NickName = plyeetInfo.NickName;
               inviteInfo.Sex = plyeetInfo.Sex;
               inviteInfo.Grade = plyeetInfo.Grade;
               inviteInfo.Repute = plyeetInfo.Repute;
               inviteInfo.WinCount = plyeetInfo.WinCount;
               inviteInfo.TotalCount = plyeetInfo.TotalCount;
               inviteInfo.FightPower = plyeetInfo.FightPower;
               inviteInfo.ID = plyeetInfo.ID;
               inviteInfo.Offer = plyeetInfo.Offer;
               inviteInfo.typeVIP = plyeetInfo.typeVIP;
               inviteInfo.invited = false;
               _currentList.push(inviteInfo);
            }
            else if(_model.currentList[i] is ConsortiaPlayerInfo)
            {
               inviteInfoII = new InvitePlayerInfo();
               plyeetInfoII = _model.currentList[i] as ConsortiaPlayerInfo;
               inviteInfoII.NickName = plyeetInfoII.NickName;
               inviteInfoII.Sex = plyeetInfoII.Sex;
               inviteInfoII.Grade = plyeetInfoII.Grade;
               inviteInfoII.Repute = plyeetInfoII.Repute;
               inviteInfoII.WinCount = plyeetInfoII.WinCount;
               inviteInfoII.TotalCount = plyeetInfoII.TotalCount;
               inviteInfoII.FightPower = plyeetInfoII.FightPower;
               inviteInfoII.ID = plyeetInfoII.ID;
               inviteInfoII.Offer = plyeetInfoII.Offer;
               inviteInfoII.typeVIP = plyeetInfoII.typeVIP;
               inviteInfoII.invited = false;
               _currentList.push(inviteInfoII);
            }
            i++;
         }
         _listPanel.vectorListModel.clear();
         for(j = 0; j < _model.currentList.length; )
         {
            playerInfo = _currentList[j] as PlayerInfo;
            obj = changeData(playerInfo,j + 1);
            _listPanel.vectorListModel.insertElementAt(obj,j);
            j++;
         }
         _listPanel.list.updateListView();
      }
      
      private function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function changeData(info:PlayerInfo, index:int) : Object
      {
         var obj:Object = {};
         obj["playerInfo"] = info;
         obj["index"] = index;
         return obj;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true);
         setEvent();
         listUpdate();
         _controller.refleshList(_currentTab);
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get model() : ChurchInviteModel
      {
         return _model;
      }
      
      public function set model(value:ChurchInviteModel) : void
      {
         _model = value;
      }
      
      public function get controller() : ChurchInviteController
      {
         return _controller;
      }
      
      public function set controller(value:ChurchInviteController) : void
      {
         _controller = value;
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("listupdate",listUpdate);
         }
         removeEventListener("response",onFrameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeHandler);
         }
         if(_inviteFriendBtn)
         {
            _inviteFriendBtn.removeEventListener("click",__soundPlay);
         }
         if(_inviteConsortiaBtn)
         {
            _inviteConsortiaBtn.removeEventListener("click",__soundPlay);
         }
      }
      
      private function removeView() : void
      {
         _controller = null;
         _model = null;
         _alertInfo = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeObject(_inviteFriendBtn);
         _inviteFriendBtn = null;
         ObjectUtils.disposeObject(_inviteConsortiaBtn);
         _inviteConsortiaBtn = null;
         if(_btnGroup)
         {
            _btnGroup.dispose();
         }
         _btnGroup = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("close"));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         removeView();
      }
   }
}
