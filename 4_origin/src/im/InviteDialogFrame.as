package im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import road7th.utils.StringHelper;
   
   public class InviteDialogFrame extends AddFriendFrame
   {
       
      
      private var _userName:String;
      
      private var _inviteCaption:String;
      
      private var _inputBG:Scale9CornerImage;
      
      private var _text:String;
      
      private var _initText:String;
      
      public function InviteDialogFrame()
      {
         super();
      }
      
      override protected function initContainer() : void
      {
         _alertInfo = new AlertInfo();
         _alertInfo.title = LanguageMgr.GetTranslation("im.InviteDialogFrame.name");
         _alertInfo.showCancel = false;
         _alertInfo.submitLabel = LanguageMgr.GetTranslation("im.InviteDialogFrame.send");
         info = _alertInfo;
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("im.InviteDialogFrame.inputBg");
         addToContent(_inputBG);
         _inputText = ComponentFactory.Instance.creat("IM.InviteDialogFrame.Textinput");
         _inputText.wordWrap = true;
         _inputText.maxChars = 50;
         setText(LanguageMgr.GetTranslation("IM.InviteDialogFrame.info",ServerManager.Instance.zoneName));
         _inputText.setSelection(_inputText.text.length,_inputText.text.length);
         addToContent(_inputText);
         _inputText.addEventListener("change",__inputChange);
      }
      
      protected function __inputChange(param1:Event) : void
      {
         if(_inputText.text.length > 0)
         {
            _text = _inputText.text;
         }
         else
         {
            _text = _initText;
         }
      }
      
      public function setInfo(param1:String) : void
      {
         _userName = param1;
      }
      
      public function setText(param1:String = "") : void
      {
         _inputText.text = param1;
         _text = param1;
         _initText = param1;
         _inputText.setSelection(_inputText.text.length,_inputText.text.length);
      }
      
      override protected function __fieldKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            submit();
            SoundManager.instance.play("008");
         }
         else if(param1.keyCode == 27)
         {
            hide();
            SoundManager.instance.play("008");
         }
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      override protected function submit() : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc1_:* = null;
         if(!StringHelper.isNullOrEmpty(PathManager.CommunityInvite()))
         {
            if(!FilterWordManager.isGotForbiddenWords(_text))
            {
               _loc6_ = new URLRequest(PathManager.CommunityInvite());
               _loc4_ = new URLVariables();
               _loc4_["fuid"] = String(PlayerManager.Instance.Self.LoginName);
               _loc4_["fnick"] = PlayerManager.Instance.Self.NickName;
               _loc4_["tuid"] = _userName;
               _loc4_["inviteCaption"] = _text;
               _loc4_["rid"] = PlayerManager.Instance.Self.ID;
               _loc4_["serverid"] = String(ServerManager.Instance.AgentID);
               _loc4_["rnd"] = Math.random();
               _loc6_.data = _loc4_;
               _loc3_ = new URLLoader(_loc6_);
               _loc3_.load(_loc6_);
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.inviteInfo"));
               _loc2_ = new URLRequest(PathManager.solveRequestPath("LogInviteFriends.ashx"));
               _loc5_ = new URLVariables();
               _loc5_["Username"] = PlayerManager.Instance.Self.NickName;
               _loc5_["InviteUsername"] = _userName;
               _loc5_["IsSucceed"] = false;
               _loc2_.data = _loc5_;
               _loc1_ = new URLLoader(_loc2_);
               _loc1_.load(_loc2_);
               _loc1_.addEventListener("ioError",onIOError);
               dispose();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.inviteInfo1"));
            }
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         _text = null;
         _inputText.removeEventListener("change",__inputChange);
         if(_inputBG)
         {
            _inputBG.dispose();
         }
         _inputBG = null;
         super.dispose();
      }
   }
}
