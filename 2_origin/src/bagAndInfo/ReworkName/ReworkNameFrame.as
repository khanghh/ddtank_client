package bagAndInfo.ReworkName
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.ReworkNameAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.RequestVairableCreater;
   import flash.display.Bitmap;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextFormat;
   import flash.utils.setTimeout;
   
   public class ReworkNameFrame extends Frame
   {
      
      public static const Close:String = "close";
      
      public static const ReworkDone:String = "ReworkDone";
      
      public static const Aviable:String = "aviable";
      
      public static const Unavialbe:String = "unaviable";
      
      public static const Input:String = "input";
       
      
      protected var _tittleField:FilterFrameText;
      
      protected var _nicknameInput:FilterFrameText;
      
      protected var _inputBackground:Bitmap;
      
      protected var _resultField:FilterFrameText;
      
      protected var _checkButton:BaseButton;
      
      protected var _submitButton:TextButton;
      
      protected var _available:Boolean = true;
      
      protected var _nicknameDetail:String;
      
      private var _resultDefaultFormat:TextFormat;
      
      private var _avialableFormat:TextFormat;
      
      private var _unAviableFormat:TextFormat;
      
      private var _disEnabledFilters:Array;
      
      private var _complete:Boolean = true;
      
      protected var _path:String = "NickNameCheck.ashx";
      
      protected var _bagType:int;
      
      protected var _place:int;
      
      protected var _maxChars:int;
      
      protected var _state:String;
      
      protected var _isCanRework:Boolean;
      
      private var checkCallBack:Function;
      
      private var nickNameShield:String;
      
      public function ReworkNameFrame()
      {
         _nicknameDetail = LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.check_txt");
         _disEnabledFilters = [ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ButtonDisenable")];
         super();
         escEnable = true;
         enterEnable = true;
         configUi();
         addEvent();
      }
      
      protected function configUi() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.view.ReworkNameView.reworkName");
         _resultDefaultFormat = ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ResultDefaultTF");
         _avialableFormat = ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ResultAvailableTF");
         _unAviableFormat = ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ResultUnAvailableTF");
         _inputBackground = ComponentFactory.Instance.creatBitmap("bagAndInfo.reworkname.backgound_input");
         addToContent(_inputBackground);
         _tittleField = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.reworkname.ReworkNameTittle");
         _tittleField.text = LanguageMgr.GetTranslation("tank.view.ReworkNameView.inputName");
         addToContent(_tittleField);
         _resultField = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.reworkname.ReworkNameCheckResult");
         _resultField.defaultTextFormat = _resultDefaultFormat;
         _resultField.text = _nicknameDetail;
         addToContent(_resultField);
         _nicknameInput = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.reworkname.NicknameInput");
         addToContent(_nicknameInput);
         _checkButton = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.reworkname.CheckButton");
         addToContent(_checkButton);
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.reworkname.SubmitButton");
         _submitButton.text = LanguageMgr.GetTranslation("tank.view.ReworkNameView.okLabel");
         addToContent(_submitButton);
         _submitButton.enable = false;
         _submitButton.filters = _disEnabledFilters;
      }
      
      private function addEvent() : void
      {
         _nicknameInput.addEventListener("change",__onInputChange);
         _checkButton.addEventListener("click",__onCheckClick);
         _submitButton.addEventListener("click",__onSubmitClick);
         addEventListener("response",__onResponse);
         addEventListener("addedToStage",__onToStage);
      }
      
      private function removeEvent() : void
      {
         _nicknameInput.removeEventListener("change",__onInputChange);
         _checkButton.removeEventListener("click",__onCheckClick);
         _submitButton.removeEventListener("click",__onSubmitClick);
         removeEventListener("response",__onResponse);
         removeEventListener("addedToStage",__onToStage);
      }
      
      private function __onToStage(evt:Event) : void
      {
         removeEventListener("addedToStage",__onToStage);
         StageReferance.stage.focus = _nicknameInput;
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               close();
               break;
            case 2:
            case 3:
            case 4:
               if(_submitButton.enable)
               {
                  __onSubmitClick(null);
                  break;
               }
         }
      }
      
      protected function __onInputChange(evt:Event) : void
      {
         state = "input";
         if(state != "input")
         {
            state = "input";
         }
         if(!_nicknameInput.text || _nicknameInput.text == "")
         {
            _submitButton.enable = false;
            _submitButton.filters = _disEnabledFilters;
         }
         else
         {
            _submitButton.enable = true;
            _submitButton.filters = null;
         }
      }
      
      protected function __onCheckClick(evt:MouseEvent) : void
      {
         var tempState:int = 0;
         if(complete)
         {
            SoundManager.instance.play("008");
            _isCanRework = false;
            if(nameInputCheck())
            {
               checkCallBack = checkNameCallBack;
               tempState = checkShieldNickName();
               if(tempState == 1)
               {
                  createCheckLoader(checkNameCallBack);
               }
            }
            else
            {
               visibleCheckText();
            }
         }
      }
      
      protected function visibleCheckText() : void
      {
         state = "input";
         _resultField.text = _nicknameDetail;
      }
      
      private function __onSubmitClick(evt:MouseEvent) : void
      {
         var tempState:int = 0;
         if(complete)
         {
            SoundManager.instance.play("008");
            _isCanRework = false;
            if(_nicknameInput.text == "")
            {
               setCheckTxt(LanguageMgr.GetTranslation("tank.view.ReworkNameView.inputName"));
            }
            if(nameInputCheck())
            {
               checkCallBack = submitCheckCallBack;
               tempState = checkShieldNickName();
               if(tempState == 1)
               {
                  createCheckLoader(submitCheckCallBack);
               }
            }
            else
            {
               visibleCheckText();
               return;
            }
         }
      }
      
      protected function setCheckTxt(m:String) : void
      {
         if(m == LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.setCheckTxt"))
         {
            state = "aviable";
            _isCanRework = true;
         }
         else
         {
            state = "unaviable";
         }
         _resultField.text = m;
      }
      
      private function __onLoadError(evt:LoaderEvent) : void
      {
         complete = true;
         state = "unaviable";
         evt.loader.removeEventListener("loadError",__onLoadError);
      }
      
      protected function createCheckLoader(callBack:Function) : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["id"] = PlayerManager.Instance.Self.ID;
         args["bagType"] = _bagType;
         args["place"] = _place;
         args["NickName"] = _nicknameInput.text;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(_path),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("choosecharacter.LoadCheckName.m");
         loader.analyzer = new ReworkNameAnalyzer(callBack);
         loader.addEventListener("loadError",__onLoadError);
         LoadResourceManager.Instance.startLoad(loader);
         complete = false;
         return loader;
      }
      
      protected function checkNameCallBack(analyzer:ReworkNameAnalyzer) : void
      {
         complete = true;
         var result:XML = analyzer.result;
         setCheckTxt(result.@message);
      }
      
      protected function reworkNameComplete() : void
      {
         complete = true;
         SoundManager.instance.play("047");
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.ReworkNameView.reworkNameComplete"),LanguageMgr.GetTranslation("ok"));
         alert.addEventListener("response",__onAlertResponse);
         close();
      }
      
      protected function __onAlertResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onAlertResponse);
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
               alert.dispose();
         }
         StageReferance.stage.focus = _nicknameInput;
      }
      
      protected function submitCheckCallBack(analyzer:ReworkNameAnalyzer) : void
      {
         var newName:* = null;
         complete = true;
         var result:XML = analyzer.result;
         setCheckTxt(result.@message);
         if(nameInputCheck() && _isCanRework)
         {
            newName = _nicknameInput.text;
            SocketManager.Instance.out.sendUseReworkName(_bagType,_place,newName);
            reworkNameComplete();
         }
      }
      
      protected function __onFrameResponse(evt:FrameEvent) : void
      {
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onFrameResponse);
         alert.dispose();
         state = "input";
      }
      
      protected function nameInputCheck() : Boolean
      {
         var alert:* = null;
         if(_nicknameInput.text != "")
         {
            if(FilterWordManager.isGotForbiddenWords(_nicknameInput.text,"name"))
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.name"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               alert.addEventListener("response",__onAlertResponse);
               return false;
            }
            if(FilterWordManager.IsNullorEmpty(_nicknameInput.text))
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.space"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               alert.addEventListener("response",__onAlertResponse);
               return false;
            }
            if(FilterWordManager.containUnableChar(_nicknameInput.text))
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.string"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               alert.addEventListener("response",__onAlertResponse);
               return false;
            }
            return true;
         }
         alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.input"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
         alert.addEventListener("response",__onAlertResponse);
         return false;
      }
      
      public function initialize(bagType:int, place:int) : void
      {
         _bagType = bagType;
         _place = place;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function set state(val:String) : void
      {
         if(_state != val)
         {
            _state = val;
            if(_state == "aviable")
            {
               _resultField.defaultTextFormat = _avialableFormat;
               _resultField.setTextFormat(_avialableFormat,0,_resultField.length);
            }
            else if(_state == "unaviable")
            {
               _resultField.defaultTextFormat = _unAviableFormat;
               _resultField.setTextFormat(_unAviableFormat,0,_resultField.length);
            }
            else
            {
               _resultField.defaultTextFormat = _resultDefaultFormat;
               _resultField.setTextFormat(_resultDefaultFormat,0,_resultField.length);
               _resultField.text = _nicknameDetail;
               _isCanRework = true;
            }
         }
      }
      
      public function get complete() : Boolean
      {
         return _complete;
      }
      
      public function set complete(val:Boolean) : void
      {
         if(_complete != val)
         {
            _complete = val;
            if(_complete)
            {
               if(!_nicknameInput.text || _nicknameInput.text == "")
               {
                  _submitButton.enable = false;
                  _submitButton.filters = _disEnabledFilters;
               }
               else
               {
                  _submitButton.enable = true;
                  _submitButton.filters = null;
               }
            }
            else
            {
               _submitButton.enable = false;
               _submitButton.filters = _disEnabledFilters;
            }
         }
      }
      
      private function checkShieldNickName() : int
      {
         var nickname:* = null;
         var findNum:int = 0;
         var i:int = 0;
         var index:int = 0;
         var alert:* = null;
         if(nickNameShield)
         {
            nickname = _nicknameInput.text;
            findNum = 0;
            while(i < nickname.length)
            {
               index = nickNameShield.indexOf(nickname.charAt(i));
               if(index != -1)
               {
                  findNum++;
               }
               i++;
            }
            if(findNum >= 7)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.string"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               alert.addEventListener("response",__onAlertResponse);
               return 0;
            }
            return 1;
         }
         loadNickNameShieldTxt();
         return 2;
      }
      
      private function loadNickNameShieldTxt() : void
      {
         var request:URLRequest = new URLRequest(PathManager.FLASHSITE + "registerNickNameShield.txt");
         var loader:URLLoader = new URLLoader();
         loader.addEventListener("complete",__onLoadNickNameShieldTxtComplete);
         loader.addEventListener("ioError",__onLoadNickNameShieldTxtError);
         loader.load(request);
      }
      
      private function __onLoadNickNameShieldTxtComplete(event:Event) : void
      {
         event.target.removeEventListener("complete",__onLoadNickNameShieldTxtComplete);
         event.target.removeEventListener("ioError",__onLoadNickNameShieldTxtError);
         nickNameShield = event.target.data;
         var tempState:int = checkShieldNickName();
         if(tempState == 1)
         {
            createCheckLoader(checkCallBack);
         }
      }
      
      private function __onLoadNickNameShieldTxtError(event:ErrorEvent) : void
      {
         event.target.removeEventListener("complete",__onLoadNickNameShieldTxtComplete);
         event.target.removeEventListener("ioError",__onLoadNickNameShieldTxtError);
         trace("onLoadNickNameShieldTxtError:" + event.text);
         createCheckLoader(checkCallBack);
      }
      
      public function close() : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_tittleField)
         {
            ObjectUtils.disposeObject(_tittleField);
            _tittleField = null;
         }
         if(_resultField)
         {
            ObjectUtils.disposeObject(_resultField);
            _resultField = null;
         }
         if(_nicknameInput)
         {
            ObjectUtils.disposeObject(_nicknameInput);
            _nicknameInput = null;
         }
         if(_checkButton)
         {
            ObjectUtils.disposeObject(_checkButton);
            _checkButton = null;
         }
         if(_submitButton)
         {
            ObjectUtils.disposeObject(_submitButton);
            _submitButton = null;
         }
         if(_inputBackground)
         {
            ObjectUtils.disposeObject(_inputBackground);
            _inputBackground = null;
         }
         _resultDefaultFormat = null;
         _avialableFormat = null;
         _disEnabledFilters = null;
         super.dispose();
      }
   }
}
