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
         var i:* = 0;
         var item:* = null;
         super.init();
         _comBox = ComponentFactory.Instance.creat("chat.FriendListCombo");
         _comBox.addEventListener("addedToStage",__setFocus);
         _textField = ComponentFactory.Instance.creatComponentByStylename("chat.PrivateFrameComboText");
         var descriptionTxt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("chat.PrivateFrameText");
         descriptionTxt.text = LanguageMgr.GetTranslation("tank.view.scenechatII.PrivateChatIIView.nick");
         var listModel:VectorListModel = _comBox.listPanel.vectorListModel;
         _friendList = PlayerManager.Instance.onlineFriendList;
         _comBox.snapItemHeight = _friendList.length < 4;
         _comBox.selctedPropName = "text";
         _comBox.beginChanges();
         for(i = uint(0); i < _friendList.length; )
         {
            item = _friendList[i] as FriendListPlayer;
            listModel.append(item.NickName);
            i++;
         }
         _comBox.listPanel.list.updateListView();
         _comBox.commitChanges();
         _comBox.textField = _textField;
         _textField.maxChars = 15;
         _textField.addEventListener("keyDown",__keyDownHandler);
         _comBox.button.addEventListener("click",__playSound);
         _comBox.addEventListener("stateChange",__comChange);
         addToContent(descriptionTxt);
         addToContent(_comBox);
         addToContent(_comBox.textField);
      }
      
      private function __setFocus(event:Event) : void
      {
         _comBox.removeEventListener("addedToStage",__setFocus);
         StageReferance.stage.focus = _comBox.textField;
      }
      
      private function __comChange(event:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __keyDownHandler(e:KeyboardEvent) : void
      {
         e.stopImmediatePropagation();
         if(e.keyCode == 13)
         {
            dispatchEvent(new FrameEvent(2));
         }
      }
      
      private function __playSound(e:MouseEvent) : void
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
