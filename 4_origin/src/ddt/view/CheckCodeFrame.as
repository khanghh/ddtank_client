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
      
      private function __LoadCore2Complete(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtcoreii")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__LoadCore2Complete);
            UIModuleLoader.Instance.removeEventListener("uiModuleError",__LoadCore2Error);
            initCheckCodeFrame();
         }
      }
      
      private function __LoadCore2Error(param1:UIModuleEvent) : void
      {
      }
      
      private function initCheckCodeFrame() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc8_:* = 0;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc1_:* = null;
         _bgI = ComponentFactory.Instance.creatBitmap("asset.core.checkCodeBgAsset");
         addToContent(_bgI);
         _bgII = ComponentFactory.Instance.creatComponentByStylename("store.checkCodeScale9BG");
         addToContent(_bgII);
         _inputArr = [];
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("core.checkCodeInputTxt");
            _loc3_.type = "dynamic";
            _loc3_.text = "*";
            _loc3_.x = _loc3_.x + _loc4_ * 39;
            _inputArr.push(_loc3_);
            _loc3_.visible = false;
            addToContent(_loc3_);
            _loc4_++;
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
         _loc8_ = _loc8_;
         while(_loc8_ < 10)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("core.checkCodeNOBtn");
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.checkCodeNOBtnBg");
            _loc7_.backgound = _loc2_;
            _loc6_ = ComponentFactory.Instance.creatBitmap("asset.core.checkCodeNO" + String(_loc8_) + "Asset");
            _loc6_.x = (_loc7_.width - _loc6_.width) / 2;
            _loc6_.y = (_loc7_.height - _loc6_.height) / 2;
            _loc7_.addChild(_loc6_);
            _loc5_ = {};
            _loc1_ = new Sprite();
            _loc7_.x = -_loc7_.width / 2;
            _loc7_.y = -_loc7_.height / 2;
            _loc1_.addChild(_loc7_);
            _loc5_.view = _loc1_;
            _loc5_.NOView = _loc6_;
            _loc5_.id = _loc8_;
            _loc5_.angle = _loc8_ * 0.628;
            _loc5_.axisZ = 100;
            _numberArr.push(_loc5_);
            _numViewArr.push(_loc1_);
            addToContent(_loc1_);
            _loc1_.addEventListener("click",clicknumSp);
            _loc1_.addEventListener("mouseOver",overnumSp);
            _loc1_.addEventListener("mouseOut",outnumSp);
            _loc8_++;
         }
         setnumViewCoord();
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function set time(param1:int) : void
      {
         _time = param1;
      }
      
      private function clicknumSp(param1:MouseEvent) : void
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
         _input = _input + String(_numViewArr.indexOf(param1.currentTarget));
         textChange();
      }
      
      private function overnumSp(param1:MouseEvent) : void
      {
         _NOBtnIsOver = true;
      }
      
      private function outnumSp(param1:MouseEvent) : void
      {
         _NOBtnIsOver = false;
      }
      
      private function setnumViewCoord() : void
      {
      }
      
      private function math_z(param1:Object) : void
      {
      }
      
      private function inFrameStart(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = Math.abs(Math.sqrt((mouseX - 356) * (mouseX - 356) + (mouseY - 166) * (mouseY - 166)) - 100);
         if(_loc2_ <= 100)
         {
            speed = _loc2_ / 200;
         }
         if(_loc2_ > 100)
         {
            speed = 0.5;
         }
         if(_NOBtnIsOver == true)
         {
            speed = 0.02;
         }
         _loc3_ = 0;
         while(_loc3_ < _numberArr.length)
         {
            _numberArr[_loc3_].NOView.visible = true;
            if(_NOBtnIsOver)
            {
               _numberArr[_loc3_].NOView.visible = false;
            }
            _numberArr[_loc3_].angle = _numberArr[_loc3_].angle + speed * 0.1;
            _numberArr[_loc3_].view.y = _numberArr[_loc3_].axisZ * Math.cos(_numberArr[_loc3_].angle) + 166;
            _numberArr[_loc3_].view.x = _numberArr[_loc3_].axisZ * Math.sin(_numberArr[_loc3_].angle) + 356;
            _loc3_++;
         }
      }
      
      public function set data(param1:CheckCodeData) : void
      {
         if(currentPic && currentPic.parent)
         {
            removeChild(currentPic);
            currentPic.bitmapData.dispose();
            currentPic = null;
         }
         currentPic = param1.pic;
         currentPic.width = 164;
         currentPic.height = 69;
         currentPic.x = 30 + Math.random() * 2 * 3;
         currentPic.y = 75 + Math.random() * 2 * 3;
         addChild(currentPic);
      }
      
      private function __onTimeComplete(param1:TimerEvent) : void
      {
         _input = "";
         coutTimer.stop();
         coutTimer.reset();
         sendSelected();
      }
      
      private function __onTimeComplete_1(param1:TimerEvent) : void
      {
         _countDownTxt.text = (int(_countDownTxt.text) - 1).toString();
      }
      
      private function textChange() : void
      {
         var _loc1_:int = 0;
         okBtn.enable = isValidText();
         clearBtn.enable = haveValidText();
         _loc1_ = 0;
         while(_loc1_ < _inputArr.length)
         {
            _inputArr[_loc1_].visible = false;
            if(_loc1_ < _input.length)
            {
               _inputArr[_loc1_].visible = true;
            }
            _loc1_++;
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
      
      public function set tip(param1:String) : void
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
      
      private function __show(param1:TimerEvent) : void
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
      
      override protected function __onAddToStage(param1:Event) : void
      {
         addEventListener("keyDown",__resposeHandler);
      }
      
      private function __okBtnClick(param1:MouseEvent) : void
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
      
      private function __clearBtnClick(param1:MouseEvent) : void
      {
         if(haveValidText())
         {
            SoundManager.instance.play("008");
            _input = "";
            textChange();
         }
      }
      
      private function __resposeHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
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
      
      public function set isShowed(param1:Boolean) : void
      {
         _isShowed = param1;
      }
   }
}
