package ddt.view.chat
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class ChatPrivateFrame extends BaseAlerFrame
   {
       
      
      private var _friendList:Array;
      
      private var _comBox:ComboBox;
      
      private var _textField:FilterFrameText;
      
      public function ChatPrivateFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc4_:* = 0;
         var _loc1_:* = null;
         super.init();
         _comBox = ComponentFactory.Instance.creat("chat.FriendListCombo");
         _comBox.addEventListener("addedToStage",__setFocus);
         _textField = ComponentFactory.Instance.creatComponentByStylename("chat.PrivateFrameComboText");
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("chat.PrivateFrameText");
         _loc3_.text = LanguageMgr.GetTranslation("tank.view.scenechatII.PrivateChatIIView.nick");
         var _loc2_:VectorListModel = _comBox.listPanel.vectorListModel;
         _friendList = PlayerManager.Instance.onlineFriendList;
         _comBox.snapItemHeight = _friendList.length < 4;
         _comBox.selctedPropName = "text";
         _comBox.beginChanges();
         _loc4_ = uint(0);
         while(_loc4_ < _friendList.length)
         {
            _loc1_ = _friendList[_loc4_] as FriendListPlayer;
            _loc2_.append(_loc1_.NickName);
            _loc4_++;
         }
         _comBox.listPanel.list.updateListView();
         _comBox.commitChanges();
         _comBox.textField = _textField;
         _textField.maxChars = 15;
         _textField.addEventListener("keyDown",__keyDownHandler);
         _comBox.button.addEventListener("click",__playSound);
         _comBox.addEventListener("stateChange",__comChange);
         addToContent(_loc3_);
         addToContent(_comBox);
         addToContent(_comBox.textField);
      }
      
      private function __setFocus(param1:Event) : void
      {
         _comBox.removeEventListener("addedToStage",__setFocus);
         StageReferance.stage.focus = _comBox.textField;
      }
      
      private function __comChange(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         if(param1.keyCode == 13)
         {
            dispatchEvent(new FrameEvent(2));
         }
      }
      
      private function __playSound(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         setChildIndex(_container,numChildren - 1);
      }
      
      public function get currentFriend() : String
      {
         return _textField.text;
      }
      
      override public function dispose() : void
      {
         _comBox.removeEventListener("addedToStage",__setFocus);
         if(ChatManager.Instance.input.inputField.privateChatName == "")
         {
            if(StateManager.currentStateType == "consortia_domain")
            {
               ChatManager.Instance.inputChannel = 3;
            }
            else
            {
               ChatManager.Instance.inputChannel = 5;
            }
         }
         _friendList = null;
         _textField.removeEventListener("keyDown",__keyDownHandler);
         _comBox.button.removeEventListener("click",__playSound);
         _comBox.removeEventListener("stateChange",__comChange);
         _comBox.dispose();
         _comBox = null;
         _textField = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
