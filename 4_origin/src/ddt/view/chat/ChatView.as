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
      
      private function updateViewState(param1:int) : void
      {
         if(param1 == 20)
         {
            ChatManager.Instance.view.parent.removeChild(ChatManager.Instance.view);
         }
         if(param1 != 8)
         {
            if(_stateArr[param1].inputVisible)
            {
               addChild(_input);
            }
            else if(_input.parent)
            {
               _input.parent.removeChild(_input);
            }
         }
         _input.faceEnabled = _stateArr[param1].inputFaceEnabled;
         _input.x = _stateArr[param1].inputX;
         _input.y = _stateArr[param1].inputY;
         ChatManager.Instance.visibleSwitchEnable = _stateArr[param1].inputVisibleSwitchEnabled;
         _output.isLock = _stateArr[param1].outputIsLock;
         _output.lockEnable = _stateArr[param1].outputLockEnabled;
         _output.bg = _stateArr[param1].outputBackground;
         _output.contentField.style = _stateArr[param1].outputContentFieldStyle;
         if(_stateArr[param1].outputChannel != -1)
         {
            _output.channel = _stateArr[param1].outputChannel;
         }
         _output.x = _stateArr[param1].outputX;
         _output.y = _stateArr[param1].outputY;
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
         _output.bgVisible = _stateArr[param1].outputBackgroundVisible;
         _output.updateCurrnetChannel();
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         if(_state == 1)
         {
            _input.enableGameState = false;
            _output.enableGameState = false;
         }
         var _loc2_:int = _state;
         _state = param1;
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
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _input = ComponentFactory.Instance.creatCustomObject("chat.InputView");
         _output = ComponentFactory.Instance.creatCustomObject("chat.OutputView");
         _stateArr = new Vector.<ChatViewInfo>();
         _loc3_ = 0;
         while(_loc3_ <= 37)
         {
            _loc2_ = new ChatViewInfo();
            _loc1_ = ComponentFactory.Instance.getCustomStyle("chatViewInfo.state_" + String(_loc3_));
            if(!_loc1_)
            {
               _stateArr.push(_loc2_);
            }
            else
            {
               ObjectUtils.copyPorpertiesByXML(_loc2_,_loc1_);
               _stateArr.push(_loc2_);
            }
            _loc3_++;
         }
         addChild(_output);
         addChild(_input);
      }
   }
}
