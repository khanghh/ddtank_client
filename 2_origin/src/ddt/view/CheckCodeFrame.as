package ddt.view
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.CheckCodeData;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class CheckCodeFrame extends BaseAlerFrame
   {
      
      private static var _instance:CheckCodeFrame;
       
      
      private const BACK_GOUND_GAPE:int = 3;
      
      private var _time:int;
      
      private var _bgI:Bitmap;
      
      private var _bgII:Scale9CornerImage;
      
      private var _isShowed:Boolean = true;
      
      private var _inputArr:Array;
      
      private var _input:String;
      
      private var _countDownTxt:FilterFrameText;
      
      private var _secondTxt:FilterFrameText;
      
      private var coutTimer:Timer;
      
      private var coutTimer_1:Timer;
      
      private var checkCount:int = 0;
      
      private var _alertInfo:AlertInfo;
      
      private var okBtn:BaseButton;
      
      private var clearBtn:BaseButton;
      
      private var _numberArr:Array;
      
      private var _numViewArr:Array;
      
      private var _NOBtnIsOver:Boolean = false;
      
      private var _cheatTime:uint = 0;
      
      private var speed:Number = 10;
      
      private var currentPic:Bitmap;
      
      private var _showTimer:Timer;
      
      private var count:int;
      
      public function CheckCodeFrame()
      {
         _showTimer = new Timer(1000);
         super();
         try
         {
            initCheckCodeFrame();
            return;
         }
         catch(e:Error)
         {
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__LoadCore2Complete);
            UIModuleLoader.Instance.addEventListener("uiModuleError",__LoadCore2Error);
            UIModuleLoader.Instance.addUIModuleImp("ddtcoreii");
            return;
         }
      }
      
      public static function get Instance() : CheckCodeFrame
      {
         if(_instance == null)
         {
            _instance = ComponentFactory.Instance.creatCustomObject("core.checkCodeFrame");
         }
         return _instance;
      }
      
      private function __LoadCore2Complete(pEvent:UIModuleEvent) : void
      {
         if(pEvent.module == "ddtcoreii")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__LoadCore2Complete);
            UIModuleLoader.Instance.removeEventListener("uiModuleError",__LoadCore2Error);
            initCheckCodeFrame();
         }
      }
      
      private function __LoadCore2Error(pEvent:UIModuleEvent) : void
      {
      }
      
      private function initCheckCodeFrame() : void
      {
         var n:int = 0;
         var input:* = null;
         var i:* = 0;
         var numView:* = null;
         var numViewBg:* = null;
         var numNOView:* = null;
         var numObj:* = null;
         var numSp:* = null;
         _bgI = ComponentFactory.Instance.creatBitmap("asset.core.checkCodeBgAsset");
         addToContent(_bgI);
         _bgII = ComponentFactory.Instance.creatComponentByStylename("store.checkCodeScale9BG");
         addToContent(_bgII);
         _inputArr = [];
         for(n = 0; n < 4; )
         {
            input = ComponentFactory.Instance.creatComponentByStylename("core.checkCodeInputTxt");
            input.type = "dynamic";
            input.text = "*";
            input.x = input.x + n * 39;
            _inputArr.push(input);
            input.visible = false;
            addToContent(input);
            n++;
         }
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.enthrallCheckFrame.checkCode"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("clear"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         okBtn = _submitButton;
         okBtn.addEventListener("click",__okBtnClick);
         okBtn.enable = false;
         clearBtn = _cancelButton;
         clearBtn.addEventListener("click",__clearBtnClick);
         clearBtn.enable = false;
         _countDownTxt = ComponentFactory.Instance.creatComponentByStylename("core.checkCodeCountDownTxt");
         addToContent(_countDownTxt);
         _secondTxt = ComponentFactory.Instance.creatComponentByStylename("core.checkCodeSecTxt");
         addToContent(_secondTxt);
         _secondTxt.text = LanguageMgr.GetTranslation("FPSView.as.InviteAlertPanel.second");
         _numberArr = [];
         _numViewArr = [];
         for(i = i; i < 10; )
         {
            numView = ComponentFactory.Instance.creatComponentByStylename("core.checkCodeNOBtn");
            numViewBg = ComponentFactory.Instance.creatComponentByStylename("core.checkCodeNOBtnBg");
            numView.backgound = numViewBg;
            numNOView = ComponentFactory.Instance.creatBitmap("asset.core.checkCodeNO" + String(i) + "Asset");
            numNOView.x = (numView.width - numNOView.width) / 2;
            numNOView.y = (numView.height - numNOView.height) / 2;
            numView.addChild(numNOView);
            numObj = {};
            numSp = new Sprite();
            numView.x = -numView.width / 2;
            numView.y = -numView.height / 2;
            numSp.addChild(numView);
            numObj.view = numSp;
            numObj.NOView = numNOView;
            numObj.id = i;
            numObj.angle = i * 0.628;
            numObj.axisZ = 100;
            _numberArr.push(numObj);
            _numViewArr.push(numSp);
            addToContent(numSp);
            numSp.addEventListener("click",clicknumSp);
            numSp.addEventListener("mouseOver",overnumSp);
            numSp.addEventListener("mouseOut",outnumSp);
            i++;
         }
         setnumViewCoord();
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function set time(value:int) : void
      {
         _time = value;
      }
      
      private function clicknumSp(e:MouseEvent) : void
      {
         if(_cheatTime == 0)
         {
            _cheatTime = getTimer();
         }
         SoundManager.instance.play("008");
         if(_input.length >= 4)
         {
            return;
         }
         _input = _input + String(_numViewArr.indexOf(e.currentTarget));
         textChange();
      }
      
      private function overnumSp(e:MouseEvent) : void
      {
         _NOBtnIsOver = true;
      }
      
      private function outnumSp(e:MouseEvent) : void
      {
         _NOBtnIsOver = false;
      }
      
      private function setnumViewCoord() : void
      {
      }
      
      private function math_z(obj:Object) : void
      {
      }
      
      private function inFrameStart(e:Event) : void
      {
         var i:int = 0;
         var axisMouse:int = Math.abs(Math.sqrt((mouseX - 356) * (mouseX - 356) + (mouseY - 166) * (mouseY - 166)) - 100);
         if(axisMouse <= 100)
         {
            speed = axisMouse / 200;
         }
         if(axisMouse > 100)
         {
            speed = 0.5;
         }
         if(_NOBtnIsOver == true)
         {
            speed = 0.02;
         }
         for(i = 0; i < _numberArr.length; )
         {
            _numberArr[i].NOView.visible = true;
            if(_NOBtnIsOver)
            {
               _numberArr[i].NOView.visible = false;
            }
            _numberArr[i].angle = _numberArr[i].angle + speed * 0.1;
            _numberArr[i].view.y = _numberArr[i].axisZ * Math.cos(_numberArr[i].angle) + 166;
            _numberArr[i].view.x = _numberArr[i].axisZ * Math.sin(_numberArr[i].angle) + 356;
            i++;
         }
      }
      
      public function set data(d:CheckCodeData) : void
      {
         if(currentPic && currentPic.parent)
         {
            removeChild(currentPic);
            currentPic.bitmapData.dispose();
            currentPic = null;
         }
         currentPic = d.pic;
         currentPic.width = 164;
         currentPic.height = 69;
         currentPic.x = 30 + Math.random() * 2 * 3;
         currentPic.y = 75 + Math.random() * 2 * 3;
         addChild(currentPic);
      }
      
      private function __onTimeComplete(e:TimerEvent) : void
      {
         _input = "";
         coutTimer.stop();
         coutTimer.reset();
         sendSelected();
      }
      
      private function __onTimeComplete_1(e:TimerEvent) : void
      {
         _countDownTxt.text = (int(_countDownTxt.text) - 1).toString();
      }
      
      private function textChange() : void
      {
         var i:int = 0;
         okBtn.enable = isValidText();
         clearBtn.enable = haveValidText();
         for(i = 0; i < _inputArr.length; )
         {
            _inputArr[i].visible = false;
            if(i < _input.length)
            {
               _inputArr[i].visible = true;
            }
            i++;
         }
      }
      
      private function haveValidText() : Boolean
      {
         if(_input.length == 0)
         {
            return false;
         }
         return true;
      }
      
      private function isValidText() : Boolean
      {
         if(FilterWordManager.IsNullorEmpty(_input))
         {
            return false;
         }
         if(_input.length != 4)
         {
            return false;
         }
         return true;
      }
      
      public function set tip(value:String) : void
      {
      }
      
      public function show() : void
      {
         count = time;
         _countDownTxt.text = (time - 1).toString();
         if(coutTimer)
         {
            coutTimer.stop();
            coutTimer.removeEventListener("timer",__onTimeComplete);
         }
         if(coutTimer_1)
         {
            coutTimer_1.stop();
            coutTimer_1.removeEventListener("timer",__onTimeComplete);
         }
         coutTimer = new Timer(time * 1000,1);
         coutTimer_1 = new Timer(1000,time);
         if(StateManager.currentStateType == "fighting")
         {
            _showTimer.addEventListener("timer",__show);
            _showTimer.start();
         }
         else
         {
            popup();
         }
      }
      
      private function __show(event:TimerEvent) : void
      {
         if(StateManager.currentStateType != "fighting")
         {
            _showTimer.removeEventListener("timer",__show);
            _showTimer.stop();
            popup();
         }
      }
      
      private function popup() : void
      {
         SoundManager.instance.play("057");
         isShowed = true;
         this.x = 220 + (Math.random() * 150 - 75);
         this.y = 110 + (Math.random() * 200 - 100);
         LayerManager.Instance.addToLayer(this,2,false,1);
         _input = "";
         restartTimer();
      }
      
      public function close() : void
      {
         if(coutTimer)
         {
            coutTimer.stop();
            coutTimer.removeEventListener("timer",__onTimeComplete);
         }
         if(coutTimer_1)
         {
            coutTimer_1.stop();
            coutTimer_1.removeEventListener("timer",__onTimeComplete);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         checkCount = 0;
         _input = "";
         addEventListener("keyDown",__resposeHandler);
         removeEventListener("enterFrame",inFrameStart);
         dispatchEvent(new Event("close"));
         textChange();
      }
      
      override protected function __onAddToStage(e:Event) : void
      {
         addEventListener("keyDown",__resposeHandler);
      }
      
      private function __okBtnClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(getTimer() - _cheatTime <= 500)
         {
            _input = "";
            SocketManager.Instance.out.sendCheckCode("cheat");
            return;
         }
         if(isValidText())
         {
            sendSelected();
         }
      }
      
      private function __clearBtnClick(evt:MouseEvent) : void
      {
         if(haveValidText())
         {
            SoundManager.instance.play("008");
            _input = "";
            textChange();
         }
      }
      
      private function __resposeHandler(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == 13)
         {
            __okBtnClick(null);
         }
      }
      
      private function sendSelected() : void
      {
         coutTimer.removeEventListener("timer",__onTimeComplete);
         if(!FilterWordManager.IsNullorEmpty(_input))
         {
            SocketManager.Instance.out.sendCheckCode(_input);
         }
         else
         {
            SocketManager.Instance.out.sendCheckCode("");
            restartTimer();
         }
         _input = "";
         checkCount = Number(checkCount) + 1;
         if(checkCount == 10)
         {
            checkCount = 0;
            coutTimer.removeEventListener("timer",__onTimeComplete);
            close();
         }
      }
      
      private function restartTimer() : void
      {
         _cheatTime = 0;
         coutTimer.stop();
         coutTimer.reset();
         coutTimer.addEventListener("timer",__onTimeComplete);
         coutTimer.start();
         coutTimer_1.stop();
         coutTimer_1.reset();
         coutTimer_1.addEventListener("timer",__onTimeComplete_1);
         coutTimer_1.start();
         _countDownTxt.text = (count - 1).toString();
         okBtn.enable = false;
         clearBtn.enable = false;
         removeEventListener("enterFrame",inFrameStart);
         addEventListener("enterFrame",inFrameStart);
         textChange();
      }
      
      public function get isShowed() : Boolean
      {
         return _isShowed;
      }
      
      public function set isShowed(value:Boolean) : void
      {
         _isShowed = value;
      }
   }
}
