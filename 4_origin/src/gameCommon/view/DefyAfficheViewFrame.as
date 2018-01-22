package gameCommon.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.ExternalInterfaceManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import room.model.RoomInfo;
   
   public class DefyAfficheViewFrame extends Frame
   {
      
      private static const ANNOUNCEMENT_FEE:int = 500;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _defyAffichebtn:TextButton;
      
      private var _defyAffichebtn1:TextButton;
      
      private var _roomInfo:RoomInfo;
      
      private var _str:String;
      
      private var _textInput:TextInput;
      
      private var _titText:FilterFrameText;
      
      private var _titleInfoText:FilterFrameText;
      
      public function DefyAfficheViewFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _defyAffichebtn = null;
         _defyAffichebtn1 = null;
         _textInput = null;
         _titText = null;
         _titleInfoText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function inputCheck() : Boolean
      {
         if(_textInput.text != "")
         {
            if(FilterWordManager.isGotForbiddenWords(_textInput.text,"name"))
            {
               MessageTipManager.getInstance().show("Thông báo chứa ký tự không hợp lệ");
               return false;
            }
         }
         return true;
      }
      
      public function set roomInfo(param1:RoomInfo) : void
      {
         _roomInfo = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __alertSendDefy(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__alertSendDefy);
         SoundManager.instance.play("008");
         handleString();
         _str = _str + _textInput.text;
         if(!(int(param1.responseCode) - 3))
         {
            CheckMoneyUtils.instance.checkMoney(param1.currentTarget.isBand,500,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendDefyAffiche(_str,CheckMoneyUtils.instance.isBind);
         handleString();
         dispose();
      }
      
      private function __cancelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      private function __leaveToFill(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__alertSendDefy);
         SoundManager.instance.play("008");
         if(!(int(param1.responseCode) - 3))
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function __okClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!inputCheck())
         {
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.DefyAfficheView.hint",500),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__alertSendDefy);
      }
      
      private function __texeInput(param1:Event) : void
      {
         var _loc2_:String = String(30 - _textInput.text.length);
         _titText.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.afficheTitText",_loc2_);
      }
      
      private function handleString() : void
      {
         var _loc1_:int = 0;
         _str = "";
         _str = "[" + PlayerManager.Instance.Self.NickName + "]";
         _str = _str + LanguageMgr.GetTranslation("tank.view.DefyAfficheView.afficheCaput");
         if(_roomInfo.defyInfo)
         {
            _loc1_ = 0;
            while(_loc1_ < _roomInfo.defyInfo[1].length)
            {
               _str = _str + ("[" + _roomInfo.defyInfo[1][_loc1_] + "]");
               _loc1_++;
            }
         }
         _str = _str + LanguageMgr.GetTranslation("tank.view.DefyAfficheView.afficheLast");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _textInput.textField.addEventListener("change",__texeInput);
         _defyAffichebtn.addEventListener("click",__okClick);
         _defyAffichebtn1.addEventListener("click",__cancelClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _defyAffichebtn.removeEventListener("click",__okClick);
         _defyAffichebtn1.removeEventListener("click",__cancelClick);
      }
      
      private function selectedBandHander(param1:MouseEvent) : void
      {
      }
      
      private function initView() : void
      {
         var _loc1_:* = null;
         if(PathManager.solveExternalInterfaceEnabel())
         {
            _loc1_ = PlayerManager.Instance.Self;
            ExternalInterfaceManager.sendToAgent(10,_loc1_.ID,_loc1_.NickName,ServerManager.Instance.zoneName);
         }
         titleText = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.affiche");
         _bg = ComponentFactory.Instance.creatComponentByStylename("game.view.DefyAfficheViewFrame.bg");
         addToContent(_bg);
         _titText = ComponentFactory.Instance.creatComponentByStylename("game.view.titleText");
         _titText.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.afficheTitText","12");
         addToContent(_titText);
         _titleInfoText = ComponentFactory.Instance.creatComponentByStylename("game.view.titleInfoText");
         _titleInfoText.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.afficheInfoText",500);
         addToContent(_titleInfoText);
         _textInput = ComponentFactory.Instance.creatComponentByStylename("game.defyAfficheTextInput");
         _textInput.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.afficheInfo");
         addToContent(_textInput);
         _defyAffichebtn = ComponentFactory.Instance.creatComponentByStylename("game.defyAffichebtn");
         _defyAffichebtn.text = LanguageMgr.GetTranslation("tank.room.RoomIIView2.affirm");
         addToContent(_defyAffichebtn);
         _defyAffichebtn1 = ComponentFactory.Instance.creatComponentByStylename("game.defyAffichebtn1");
         _defyAffichebtn1.text = LanguageMgr.GetTranslation("tank.view.DefyAfficheView.cancel");
         addToContent(_defyAffichebtn1);
      }
   }
}
