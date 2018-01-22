package ddt.view.chat
{
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.StringUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import hall.event.NewHallEvent;
   
   public class ChatOutputView extends Sprite
   {
      
      public static const CHAT_OUPUT_CLUB:int = 1;
      
      public static const CHAT_OUPUT_CURRENT:int = 0;
      
      public static const CHAT_OUPUT_PRIVATE:int = 2;
      
      private static const IN_GAME:uint = 3;
       
      
      private var _bg:ScaleFrameImage;
      
      private var _consortiaBtn:SelectedTextButton;
      
      private var _currentBtn:SelectedTextButton;
      
      private var _privateBtn:SelectedTextButton;
      
      private var _channel:int = -1;
      
      private var _clearBtn:BaseButton;
      
      private var _currentOffset:int = 0;
      
      private var _goBottomBtn:BaseButton;
      
      private var _isLocked:Boolean = false;
      
      private var _leftBtnContainer:Sprite;
      
      private var _lockBtn:SelectedButton;
      
      private var _model:ChatModel;
      
      private var _outputField:ChatOutputField;
      
      private var _rightBtnContainer:Sprite;
      
      private var _scrollDownBtn:BaseButton;
      
      private var _scrollUpBtn:BaseButton;
      
      private var _goBottomBtnEffect:IEffect;
      
      private var _privateBtnEffect:IEffect;
      
      private var _group:SelectedButtonGroup;
      
      private var _hotAreaInGame:Sprite;
      
      private var _functionEnabled:Boolean;
      
      private var _leftBtnContainerInGame:Sprite;
      
      private var _functionBtnInGame:SelectedButton;
      
      private var _lockBtnInGame:SelectedButton;
      
      private var _scrollUpBtnInGame:SimpleBitmapButton;
      
      private var _scrollDownBtnInGame:SimpleBitmapButton;
      
      private var _goBottomBtnInGame:SimpleBitmapButton;
      
      private var _clearBtnInGame:SimpleBitmapButton;
      
      private var _goBottomEffectInGame:IEffect;
      
      private var _more:SelectedButton;
      
      private var _leftScroll:ChatScrollBar;
      
      private var _ghostState:Boolean;
      
      private var _bgVisible:Boolean = true;
      
      public function ChatOutputView()
      {
         super();
         init();
      }
      
      public function set enableGameState(param1:Boolean) : void
      {
         if(param1)
         {
            if(_more.selected)
            {
               _more.selected = false;
               updateOutputViewState();
               bg = 3;
            }
            _outputField.x = 25;
            _outputField.y = 39;
            graphics.beginFill(16777215,0);
            graphics.drawRect(-10,-10,300,120);
            graphics.endFill();
            isLock = false;
            addChild(_leftBtnContainerInGame);
            if(contains(_leftBtnContainer))
            {
               removeChild(_leftBtnContainer);
            }
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
            addEventListener("rollOver",__onMouseRollOver);
            addEventListener("rollOut",__onMouseRollOut);
         }
         else
         {
            _ghostState = false;
            if(contains(_leftBtnContainerInGame))
            {
               removeChild(_leftBtnContainerInGame);
            }
            addChild(_leftBtnContainer);
            addChildAt(_bg,0);
            graphics.clear();
            removeEventListener("rollOver",__onMouseRollOver);
            removeEventListener("rollOut",__onMouseRollOut);
            updateOutputViewState();
         }
      }
      
      public function set functionEnabled(param1:Boolean) : void
      {
         if(ChatManager.Instance.view.parent)
         {
            ChatManager.Instance.view.parent.addChild(ChatManager.Instance.view);
         }
         if(!isInGame())
         {
            return;
         }
         _functionEnabled = param1;
         _outputField.functionEnabled = _functionEnabled;
         if(_functionEnabled)
         {
            _functionBtnInGame.selected = true;
            _leftBtnContainerInGame.addChild(_functionBtnInGame);
            _leftBtnContainerInGame.addChild(_clearBtnInGame);
            if(_bgVisible)
            {
               addChildAt(_bg,0);
            }
            _outputField.functionEnabled = _functionEnabled;
            updateShine();
         }
         else
         {
            _functionBtnInGame.selected = false;
            if(_leftBtnContainerInGame.contains(_functionBtnInGame))
            {
               _leftBtnContainerInGame.removeChild(_functionBtnInGame);
            }
            if(_leftBtnContainerInGame.contains(_clearBtnInGame))
            {
               _leftBtnContainerInGame.removeChild(_clearBtnInGame);
            }
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
         }
      }
      
      public function set ghostState(param1:Boolean) : void
      {
         _ghostState = param1;
         if(_ghostState)
         {
            graphics.clear();
            removeEventListener("rollOver",__onMouseRollOver);
            removeEventListener("rollOut",__onMouseRollOut);
            if(parent)
            {
               parent.mouseEnabled = false;
            }
            mouseEnabled = false;
         }
      }
      
      private function __onMouseRollOver(param1:MouseEvent) : void
      {
         if(ChatManager.Instance.view.parent)
         {
            ChatManager.Instance.view.parent.addChild(ChatManager.Instance.view);
         }
         _leftBtnContainerInGame.addChild(_functionBtnInGame);
         _leftBtnContainerInGame.addChild(_clearBtnInGame);
         addChildAt(_bg,0);
         if(parent)
         {
            parent.mouseEnabled = true;
         }
         mouseEnabled = true;
      }
      
      private function __onMouseRollOut(param1:MouseEvent) : void
      {
         if(ChatManager.Instance.view.input.parent)
         {
            return;
         }
         if(_leftBtnContainerInGame.contains(_functionBtnInGame))
         {
            _leftBtnContainerInGame.removeChild(_functionBtnInGame);
         }
         if(_leftBtnContainerInGame.contains(_clearBtnInGame))
         {
            _leftBtnContainerInGame.removeChild(_clearBtnInGame);
         }
         if(_bg.parent)
         {
            _bg.parent.removeChild(_bg);
         }
         StageReferance.stage.focus = null;
      }
      
      public function set bg(param1:int) : void
      {
         if(!isNaN(param1))
         {
            _bg.setFrame(param1);
         }
         if(isInGame())
         {
            if(_rightBtnContainer.parent)
            {
               _rightBtnContainer.parent.removeChild(_rightBtnContainer);
            }
         }
         else
         {
            addChild(_rightBtnContainer);
         }
      }
      
      public function set channel(param1:int) : void
      {
         if(param1 < 0 || param1 > 2)
         {
            return;
         }
         if(_channel == param1)
         {
            return;
         }
         _channel = param1;
         updateCurrnetChannel();
      }
      
      public function get contentField() : ChatOutputField
      {
         return _outputField;
      }
      
      public function get currentOffset() : int
      {
         return _currentOffset;
      }
      
      public function set currentOffset(param1:int) : void
      {
         _currentOffset = param1;
         updateCurrnetChannel();
      }
      
      public function goBottom() : void
      {
         _outputField.toBottom();
      }
      
      public function get isLock() : Boolean
      {
         return _isLocked;
      }
      
      public function setIsLock() : void
      {
         _isLocked = false;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         if(_isLocked == param1)
         {
            return;
         }
         _isLocked = param1;
         var _loc2_:* = _isLocked;
         _lockBtn.selected = _loc2_;
         _lockBtnInGame.selected = _loc2_;
         _outputField.mouseEnabled = !_isLocked;
         if(!isInGame())
         {
            if(parent)
            {
               parent.mouseEnabled = !param1;
            }
            mouseEnabled = !param1;
         }
         else if(!_ghostState)
         {
            if(parent)
            {
               parent.mouseEnabled = true;
            }
            mouseEnabled = true;
         }
         if(StateManager.currentStateType == "main")
         {
            _outputField.mouseChildren = ChatManager.HALL_CHAT_LOCK;
         }
         else if(StateManager.currentStateType == "farm")
         {
            _outputField.mouseEnabled = !isLock;
            _outputField.mouseChildren = !isLock;
         }
         else if(StateManager.currentStateType == "demon_chi_you" || StateManager.currentStateType == "consortia_domain")
         {
            _outputField.mouseEnabled = true;
            _outputField.mouseChildren = true;
         }
         setChannelBtnVisible(!param1);
         setBgVisible(!param1);
         setLockBtnTipData(_isLocked);
      }
      
      public function setLockBtnTipData(param1:Boolean) : void
      {
         if(param1)
         {
            var _loc2_:* = LanguageMgr.GetTranslation("chat.UnLock");
            _lockBtn.tipData = _loc2_;
            §§push(_loc2_);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("chat.Lock");
            _lockBtn.tipData = _loc2_;
            §§push(_loc2_);
         }
         §§pop();
         _lockBtnInGame.tipData = _lockBtn.tipData;
         ShowTipManager.Instance.hideTip(_lockBtn);
         ShowTipManager.Instance.hideTip(_lockBtnInGame);
      }
      
      public function set lockEnable(param1:Boolean) : void
      {
         var _loc2_:* = param1;
         _lockBtn.enable = _loc2_;
         _lockBtnInGame.enable = _loc2_;
      }
      
      public function setBgVisible(param1:Boolean) : void
      {
         if(!isInGame())
         {
            if(param1)
            {
               addChildAt(_bg,0);
            }
            else if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
         }
      }
      
      public function set bgVisible(param1:Boolean) : void
      {
         _bgVisible = param1;
         if(param1)
         {
            addChildAt(_bg,0);
         }
         else if(_bg.parent)
         {
            _bg.parent.removeChild(_bg);
         }
      }
      
      public function setChannelBtnVisible(param1:Boolean) : void
      {
         if(!isInGame())
         {
            if(param1)
            {
               addChild(_rightBtnContainer);
            }
            else if(_rightBtnContainer.parent)
            {
               _rightBtnContainer.parent.removeChild(_rightBtnContainer);
            }
         }
      }
      
      private function __leftBtnsClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_lockBtn !== _loc2_)
         {
            if(_lockBtnInGame !== _loc2_)
            {
               if(_clearBtn !== _loc2_)
               {
                  if(_clearBtnInGame !== _loc2_)
                  {
                     if(_goBottomBtn !== _loc2_)
                     {
                        if(_goBottomBtnInGame !== _loc2_)
                        {
                        }
                     }
                     _currentOffset = 0;
                     updateCurrnetChannel();
                  }
               }
               _model.reset();
               updateCurrnetChannel();
               _privateBtnEffect.stop();
            }
            addr115:
            return;
         }
         isLock = !isLock;
         if(StateManager.currentStateType == "main")
         {
            ChatManager.HALL_CHAT_LOCK = isLock;
         }
         setLockBtnTipData(isLock);
         if(_lockBtn.parent != null && !isInGame())
         {
            ShowTipManager.Instance.showTip(_lockBtn);
         }
         if(isInGame() && _lockBtnInGame.parent != null)
         {
            ShowTipManager.Instance.showTip(_lockBtnInGame);
         }
         if(!_isLocked && !isInGame())
         {
            addChild(_rightBtnContainer);
         }
         else if(_rightBtnContainer.parent)
         {
            _rightBtnContainer.parent.removeChild(_rightBtnContainer);
         }
         §§goto(addr115);
      }
      
      private function __onAddChat(param1:ChatEvent) : void
      {
         var _loc2_:ChatData = param1.data as ChatData;
         if(_loc2_.channel == 2 && _loc2_.sender != PlayerManager.Instance.Self.NickName && _channel != 2 && _channel != 0)
         {
            _privateBtnEffect.play();
         }
         if(_model.getInputInOutputChannel(_loc2_.channel,_channel))
         {
            if(_currentOffset == 0)
            {
               updateCurrnetChannel();
            }
         }
      }
      
      private function __onMouseWheel(param1:MouseEvent) : void
      {
         if(param1.delta > 0)
         {
            _currentOffset = Number(_currentOffset) + 1;
         }
         else if(_currentOffset > 0)
         {
            _currentOffset = Number(_currentOffset) - 1;
         }
         updateCurrnetChannel();
      }
      
      private function __onScroll(param1:Event = null) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_scrollDownBtn !== _loc2_)
         {
            if(_scrollDownBtnInGame !== _loc2_)
            {
               if(_scrollUpBtn !== _loc2_)
               {
                  if(_scrollUpBtnInGame !== _loc2_)
                  {
                  }
               }
               _currentOffset = Number(_currentOffset) + 1;
            }
            addr43:
            updateCurrnetChannel();
            return;
         }
         if(_currentOffset > 0)
         {
            _currentOffset = Number(_currentOffset) - 1;
         }
         §§goto(addr43);
      }
      
      private function __textFieldBindScroll(param1:int = 0) : void
      {
         if(_currentOffset == param1)
         {
            return;
         }
         _currentOffset = param1;
         updateCurrnetChannel();
      }
      
      private function __rightBtnsSelected(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_privateBtn !== _loc2_)
         {
            if(_consortiaBtn !== _loc2_)
            {
               if(_currentBtn === _loc2_)
               {
                  channel = 0;
                  ChatManager.Instance.inputChannel = 5;
               }
            }
            else
            {
               channel = 1;
               ChatManager.Instance.inputChannel = 3;
            }
         }
         else
         {
            channel = 2;
            _privateBtnEffect.stop();
         }
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("chat.OutputBg");
         _outputField = ComponentFactory.Instance.creatCustomObject("chat.OutputField");
         _model = new ChatModel();
         _bg.setFrame(1);
         addChild(_bg);
         addChild(_outputField);
         _model = ChatManager.Instance.model;
         initBtns();
         initEvent();
      }
      
      private function initBtns() : void
      {
         _group = new SelectedButtonGroup();
         _leftBtnContainer = ComponentFactory.Instance.creatCustomObject("chat.OutputViewLeftBtnContainer");
         _leftBtnContainerInGame = ComponentFactory.Instance.creatCustomObject("chat.OutputViewLeftBtnContainerInGame");
         _rightBtnContainer = ComponentFactory.Instance.creatCustomObject("chat.OutputViewRightBtnContainer");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("chat.LockBtn");
         _clearBtn = ComponentFactory.Instance.creatComponentByStylename("chat.ClearBtn");
         _scrollUpBtn = ComponentFactory.Instance.creatComponentByStylename("chat.ScrollUpBtn");
         _scrollDownBtn = ComponentFactory.Instance.creatComponentByStylename("chat.ScrollDownBtn");
         _goBottomBtn = ComponentFactory.Instance.creatComponentByStylename("chat.GoBottomBtn");
         _functionBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.FunctionBtnInGame");
         _lockBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.LockBtnInGame");
         _clearBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.ClearBtnInGame");
         _scrollUpBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.ScrollUpBtnInGame");
         _scrollDownBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.ScrollDownBtnInGame");
         _goBottomBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.GoBottomBtnInGame");
         _currentBtn = ComponentFactory.Instance.creat("chat.CurrentBtn");
         _currentBtn.text = StringUtils.trim(LanguageMgr.GetTranslation("tank.data.channel.ChannelType.current"));
         _consortiaBtn = ComponentFactory.Instance.creat("chat.ConsortiaBtn");
         _consortiaBtn.text = StringUtils.trim(LanguageMgr.GetTranslation("tank.data.channel.ChannelType.house"));
         _privateBtn = ComponentFactory.Instance.creat("chat.PrivateBtn");
         _privateBtn.text = StringUtils.trim(LanguageMgr.GetTranslation("tank.view.scenechatII.PrivateChatIIView.privatename"));
         _more = ComponentFactory.Instance.creatComponentByStylename("chat.MoreSwitcher");
         _more.selected = false;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("chat.OriginPos");
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("chat.PrivateBtnEffectPos");
         _goBottomBtnEffect = EffectManager.Instance.creatEffect(1,_goBottomBtn,"asset.chat.GoBottomBtn","chat.ChatGoBottomShineEffect");
         _privateBtnEffect = EffectManager.Instance.creatEffect(1,_privateBtn,"chat.ChatPrivateShineEffect",_loc1_,_loc2_);
         _goBottomEffectInGame = EffectManager.Instance.creatEffect(1,_goBottomBtnInGame,"asset.chat.GoBottomBtnInGame","chat.ChatGoBottomShineEffectInGame");
         _functionEnabled = false;
         var _loc3_:* = true;
         _scrollDownBtn.pressEnable = _loc3_;
         _loc3_ = _loc3_;
         _scrollUpBtn.pressEnable = _loc3_;
         _loc3_ = _loc3_;
         _scrollDownBtnInGame.pressEnable = _loc3_;
         _scrollUpBtnInGame.pressEnable = _loc3_;
         _loc3_ = LanguageMgr.GetTranslation("chat.Lock");
         _lockBtn.tipData = _loc3_;
         _lockBtnInGame.tipData = _loc3_;
         _loc3_ = LanguageMgr.GetTranslation("chat.Clear");
         _clearBtn.tipData = _loc3_;
         _clearBtnInGame.tipData = _loc3_;
         _loc3_ = LanguageMgr.GetTranslation("chat.ScrollUp");
         _scrollUpBtn.tipData = _loc3_;
         _scrollUpBtnInGame.tipData = _loc3_;
         _loc3_ = LanguageMgr.GetTranslation("chat.ScrollDown");
         _scrollDownBtn.tipData = _loc3_;
         _scrollDownBtnInGame.tipData = _loc3_;
         _loc3_ = LanguageMgr.GetTranslation("chat.Bottom");
         _goBottomBtn.tipData = _loc3_;
         _goBottomBtnInGame.tipData = _loc3_;
         _functionBtnInGame.tipData = LanguageMgr.GetTranslation("chat.Function");
         _leftScroll = new ChatScrollBar(__textFieldBindScroll);
         _leftScroll.Height = 220;
         _leftScroll.x = 4;
         _leftScroll.y = 66;
         _leftBtnContainer.addChild(_lockBtn);
         _leftBtnContainer.addChild(_clearBtn);
         _leftBtnContainer.addChild(_scrollUpBtn);
         _leftBtnContainer.addChild(_scrollDownBtn);
         _leftBtnContainer.addChild(_goBottomBtn);
         _leftBtnContainer.addChild(_leftScroll);
         _leftBtnContainerInGame.addChild(_lockBtnInGame);
         _leftBtnContainerInGame.addChild(_scrollUpBtnInGame);
         _leftBtnContainerInGame.addChild(_scrollDownBtnInGame);
         _leftBtnContainerInGame.addChild(_goBottomBtnInGame);
         _group.addSelectItem(_currentBtn);
         _group.addSelectItem(_consortiaBtn);
         _group.addSelectItem(_privateBtn);
         _rightBtnContainer.addChild(_currentBtn);
         _rightBtnContainer.addChild(_consortiaBtn);
         _rightBtnContainer.addChild(_privateBtn);
         _rightBtnContainer.addChild(_more);
         addChild(_leftBtnContainer);
      }
      
      public function setMoreVisible(param1:Boolean) : void
      {
         _more.visible = param1;
      }
      
      public function moreState(param1:Boolean) : void
      {
         if(param1 == _more.selected)
         {
            return;
         }
         _more.selected = param1;
         updateOutputViewState();
      }
      
      public function openPetSprite(param1:Boolean) : void
      {
      }
      
      public function enablePetSpriteSwitcher(param1:Boolean) : void
      {
      }
      
      public function PetSpriteSwitchVisible(param1:Boolean) : void
      {
      }
      
      private function initEvent() : void
      {
         _model.addEventListener("addChat",__onAddChat);
         _outputField.addEventListener("mouseWheel",__onMouseWheel);
         _lockBtn.addEventListener("click",__leftBtnsClick);
         _clearBtn.addEventListener("click",__leftBtnsClick);
         _goBottomBtn.addEventListener("click",__leftBtnsClick);
         _lockBtnInGame.addEventListener("click",__leftBtnsClick);
         _clearBtnInGame.addEventListener("click",__leftBtnsClick);
         _goBottomBtnInGame.addEventListener("click",__leftBtnsClick);
         _scrollUpBtn.addEventListener("change",__onScroll);
         _scrollDownBtn.addEventListener("change",__onScroll);
         _scrollUpBtnInGame.addEventListener("change",__onScroll);
         _scrollDownBtnInGame.addEventListener("change",__onScroll);
         _privateBtn.addEventListener("click",__rightBtnsSelected);
         _consortiaBtn.addEventListener("click",__rightBtnsSelected);
         _currentBtn.addEventListener("click",__rightBtnsSelected);
         _functionBtnInGame.addEventListener("click",__functionSwitch);
         _more.addEventListener("click",__moreSwitcherClick);
      }
      
      private function __moreSwitcherClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         updateOutputViewState();
      }
      
      private function updateOutputViewState() : void
      {
         if(_more.selected)
         {
            bg = 6;
            PositionUtils.setPos(_bg,"chat.Bg.more");
            PositionUtils.setPos(_leftBtnContainer,"chat.LeftBtnContainer.more");
            PositionUtils.setPos(_rightBtnContainer,"chat.RightBtnContainer.more");
            PositionUtils.setPos(_outputField,"chat.outputField.more");
            PositionUtils.setPos(_scrollDownBtn,"chat.scrollDownBtn.more");
            PositionUtils.setPos(_goBottomBtn,"chat.GotoBottomBtn.more");
            _outputField.contentHeight = 300;
            _leftScroll.visible = true;
         }
         else
         {
            bg = 2;
            PositionUtils.setPos(_bg,"chat.Bg.lessen");
            PositionUtils.setPos(_leftBtnContainer,"chat.LeftBtnContainer.lessen");
            PositionUtils.setPos(_rightBtnContainer,"chat.RightBtnContainer.lessen");
            PositionUtils.setPos(_outputField,"chat.outputField.lessen");
            PositionUtils.setPos(_scrollDownBtn,"chat.scrollDownBtn.less");
            PositionUtils.setPos(_goBottomBtn,"chat.GotoBottomBtn.less");
            _outputField.contentHeight = 118;
            _leftScroll.visible = false;
         }
         if(ChatManager.Instance.state == 9)
         {
            bg = 3;
            _bg.visible = false;
            _rightBtnContainer.visible = false;
         }
         else if(ChatManager.Instance.state == 30)
         {
            bg = 7;
            _bg.visible = true;
            _rightBtnContainer.visible = false;
         }
         else
         {
            _bg.visible = true;
            _rightBtnContainer.visible = true;
         }
         updateCurrnetChannel();
      }
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("setselfplayerpos",[param1]));
      }
      
      protected function __switchPetSprite(param1:MouseEvent) : void
      {
      }
      
      private function petSpriteClose(param1:Event) : void
      {
      }
      
      private function petSpriteOpen(param1:Event) : void
      {
      }
      
      private function __functionSwitch(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ChatManager.Instance.switchVisible();
      }
      
      public function isInGame() : Boolean
      {
         return _bg.getFrame == 3;
      }
      
      public function updateCurrnetChannel() : void
      {
         var _loc1_:* = null;
         if(isInGame())
         {
            _loc1_ = _model.getChatsByOutputChannel(_channel,_currentOffset,5);
         }
         else
         {
            _loc1_ = _model.getChatsByOutputChannel(_channel,_currentOffset,!!_more.selected?16:6);
            _leftScroll.length = _model.getRowsByOutputChangel(_channel);
            _leftScroll.currentIndex = _currentOffset;
         }
         _currentOffset = _loc1_["offset"];
         _outputField.setChats(_loc1_["result"]);
         goBottom();
         updateShine();
         var _loc2_:* = false;
         _currentBtn.selected = _loc2_;
         _loc2_ = _loc2_;
         _consortiaBtn.selected = _loc2_;
         _privateBtn.selected = _loc2_;
         _privateBtn.selected = _channel == 2;
         _consortiaBtn.selected = _channel == 1;
         _currentBtn.selected = _channel == 0;
      }
      
      private function updateShine() : void
      {
         _currentOffset != 0?_goBottomBtnEffect.play():_goBottomBtnEffect.stop();
      }
   }
}
