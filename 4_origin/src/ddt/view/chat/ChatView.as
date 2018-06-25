package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import flash.display.Sprite;
   
   use namespace chat_system;
   
   public class ChatView extends Sprite
   {
      
      public static const STATE_LENGTH:int = 37;
       
      
      private var _input:ChatInputView;
      
      private var _output:ChatOutputView;
      
      private var _state:int = -1;
      
      private var _stateArr:Vector.<ChatViewInfo>;
      
      public function ChatView()
      {
         super();
         init();
      }
      
      public function get input() : ChatInputView
      {
         return _input;
      }
      
      public function get output() : ChatOutputView
      {
         return _output;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      private function updateViewState(value:int) : void
      {
         if(value == 20)
         {
            ChatManager.Instance.view.parent.removeChild(ChatManager.Instance.view);
         }
         if(value != 8)
         {
            if(_stateArr[value].inputVisible)
            {
               addChild(_input);
            }
            else if(_input.parent)
            {
               _input.parent.removeChild(_input);
            }
         }
         _input.faceEnabled = _stateArr[value].inputFaceEnabled;
         _input.x = _stateArr[value].inputX;
         _input.y = _stateArr[value].inputY;
         ChatManager.Instance.visibleSwitchEnable = _stateArr[value].inputVisibleSwitchEnabled;
         _output.isLock = _stateArr[value].outputIsLock;
         _output.lockEnable = _stateArr[value].outputLockEnabled;
         _output.bg = _stateArr[value].outputBackground;
         _output.contentField.style = _stateArr[value].outputContentFieldStyle;
         if(_stateArr[value].outputChannel != -1)
         {
            _output.channel = _stateArr[value].outputChannel;
         }
         _output.x = _stateArr[value].outputX;
         _output.y = _stateArr[value].outputY;
         if(_state == 1)
         {
            _input.enableGameState = true;
            _output.enableGameState = true;
            _output.functionEnabled = false;
         }
         else
         {
            _output.enableGameState = false;
         }
         _output.bgVisible = _stateArr[value].outputBackgroundVisible;
         _output.updateCurrnetChannel();
      }
      
      public function set state(state:int) : void
      {
         if(_state == state)
         {
            return;
         }
         if(_state == 1)
         {
            _input.enableGameState = false;
            _output.enableGameState = false;
         }
         var preState:int = _state;
         _state = state;
         if(_state == 30 || _state == 99)
         {
            _output.contentField.contentWidth = 288;
         }
         else
         {
            _output.contentField.contentWidth = 440;
         }
         ChatManager.Instance.setFocus();
         _input.hidePanel();
         updateViewState(_state);
         _output.setChannelBtnVisible(!_output.isLock);
         _output.setLockBtnTipData(_output.isLock);
      }
      
      private function init() : void
      {
         var i:int = 0;
         var info:* = null;
         var xml:* = null;
         _input = ComponentFactory.Instance.creatCustomObject("chat.InputView");
         _output = ComponentFactory.Instance.creatCustomObject("chat.OutputView");
         _stateArr = new Vector.<ChatViewInfo>();
         for(i = 0; i <= 37; )
         {
            info = new ChatViewInfo();
            xml = ComponentFactory.Instance.getCustomStyle("chatViewInfo.state_" + String(i));
            if(!xml)
            {
               _stateArr.push(info);
            }
            else
            {
               ObjectUtils.copyPorpertiesByXML(info,xml);
               _stateArr.push(info);
            }
            i++;
         }
         addChild(_output);
         addChild(_input);
      }
   }
}
