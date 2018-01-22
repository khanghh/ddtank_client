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
      
      private function onFrameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
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
      
      private function sumbitConfirm(param1:MouseEvent = null) : void
      {
         SoundManager.instance.play("008");
         _controller.refleshList(_currentTab);
      }
      
      private function __changeHandler(param1:Event) : void
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
      
      private function listUpdate(param1:Event = null) : void
      {
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc5_:* = null;
         _currentList = [];
         _loc9_ = 0;
         while(_loc9_ < _model.currentList.length)
         {
            if(_model.currentList[_loc9_] is PlayerInfo)
            {
               _loc2_ = new InvitePlayerInfo();
               _loc6_ = _model.currentList[_loc9_] as PlayerInfo;
               _loc2_.NickName = _loc6_.NickName;
               _loc2_.Sex = _loc6_.Sex;
               _loc2_.Grade = _loc6_.Grade;
               _loc2_.Repute = _loc6_.Repute;
               _loc2_.WinCount = _loc6_.WinCount;
               _loc2_.TotalCount = _loc6_.TotalCount;
               _loc2_.FightPower = _loc6_.FightPower;
               _loc2_.ID = _loc6_.ID;
               _loc2_.Offer = _loc6_.Offer;
               _loc2_.typeVIP = _loc6_.typeVIP;
               _loc2_.invited = false;
               _currentList.push(_loc2_);
            }
            else if(_model.currentList[_loc9_] is ConsortiaPlayerInfo)
            {
               _loc3_ = new InvitePlayerInfo();
               _loc4_ = _model.currentList[_loc9_] as ConsortiaPlayerInfo;
               _loc3_.NickName = _loc4_.NickName;
               _loc3_.Sex = _loc4_.Sex;
               _loc3_.Grade = _loc4_.Grade;
               _loc3_.Repute = _loc4_.Repute;
               _loc3_.WinCount = _loc4_.WinCount;
               _loc3_.TotalCount = _loc4_.TotalCount;
               _loc3_.FightPower = _loc4_.FightPower;
               _loc3_.ID = _loc4_.ID;
               _loc3_.Offer = _loc4_.Offer;
               _loc3_.typeVIP = _loc4_.typeVIP;
               _loc3_.invited = false;
               _currentList.push(_loc3_);
            }
            _loc9_++;
         }
         _listPanel.vectorListModel.clear();
         _loc8_ = 0;
         while(_loc8_ < _model.currentList.length)
         {
            _loc7_ = _currentList[_loc8_] as PlayerInfo;
            _loc5_ = changeData(_loc7_,_loc8_ + 1);
            _listPanel.vectorListModel.insertElementAt(_loc5_,_loc8_);
            _loc8_++;
         }
         _listPanel.list.updateListView();
      }
      
      private function __soundPlay(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function changeData(param1:PlayerInfo, param2:int) : Object
      {
         var _loc3_:Object = {};
         _loc3_["playerInfo"] = param1;
         _loc3_["index"] = param2;
         return _loc3_;
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
      
      public function set model(param1:ChurchInviteModel) : void
      {
         _model = param1;
      }
      
      public function get controller() : ChurchInviteController
      {
         return _controller;
      }
      
      public function set controller(param1:ChurchInviteController) : void
      {
         _controller = param1;
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
