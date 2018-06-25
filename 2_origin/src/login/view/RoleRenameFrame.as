package login.view
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.AccountInfo;
   import ddt.data.Role;
   import ddt.data.analyze.LoginRenameAnalyzer;
   import ddt.data.analyze.ReworkNameAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CrytoUtils;
   import ddt.utils.RequestVairableCreater;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.net.URLVariables;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class RoleRenameFrame extends Frame
   {
      
      protected static var w:String = "abcdefghijklmnopqrstuvwxyz";
      
      protected static const Aviable:String = "aviable";
      
      protected static const UnAviable:String = "unaviable";
      
      protected static const Input:String = "input";
       
      
      private var _nicknameBack:Scale9CornerImage;
      
      protected var _nicknameField:FilterFrameText;
      
      protected var _nicknameLabel:FilterFrameText;
      
      protected var _modifyButton:BaseButton;
      
      protected var _resultString:String;
      
      protected var _resultField:FilterFrameText;
      
      protected var _disenabelFilter:ColorMatrixFilter;
      
      protected var _tempPass:String;
      
      protected var _roleInfo:Role;
      
      protected var _path:String = "RenameNick.ashx";
      
      protected var _checkPath:String = "NickNameCheck.ashx";
      
      protected var _complete:Boolean = false;
      
      protected var _isCanRework:Boolean = false;
      
      protected var _state:String;
      
      protected var _newName:String;
      
      public function RoleRenameFrame()
      {
         _resultString = LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.check_txt");
         super();
         configUi();
         addEvent();
      }
      
      protected function configUi() : void
      {
         _disenabelFilter = ComponentFactory.Instance.model.getSet("login.ChooseRole.DisenableGF");
         titleStyle = "login.Title";
         titleText = LanguageMgr.GetTranslation("tank.loginstate.characterModify");
         _nicknameBack = ComponentFactory.Instance.creatComponentByStylename("login.Rename.NicknameBackground");
         addToContent(_nicknameBack);
         _nicknameLabel = ComponentFactory.Instance.creatComponentByStylename("login.Rename.NicknameLabel");
         _nicknameLabel.text = LanguageMgr.GetTranslation("tank.loginstate.characterModify");
         addToContent(_nicknameLabel);
         _nicknameField = ComponentFactory.Instance.creatComponentByStylename("login.Rename.NicknameInput");
         addToContent(_nicknameField);
         _resultField = ComponentFactory.Instance.creatComponentByStylename("login.Rename.RenameResult");
         addToContent(_resultField);
         _modifyButton = ComponentFactory.Instance.creatComponentByStylename("login.Rename.ModifyButton");
         addToContent(_modifyButton);
         _modifyButton.enable = false;
         _modifyButton.filters = [_disenabelFilter];
         state = "input";
      }
      
      private function addEvent() : void
      {
         _modifyButton.addEventListener("click",__onModifyClick);
         _nicknameField.addEventListener("change",__onTextChange);
      }
      
      private function removeEvent() : void
      {
         if(_modifyButton)
         {
            _modifyButton.removeEventListener("click",__onModifyClick);
         }
         if(_nicknameField)
         {
            _nicknameField.removeEventListener("change",__onTextChange);
         }
      }
      
      private function __onTextChange(evt:Event) : void
      {
         state = "input";
         if(_nicknameField.text == "" || !_nicknameField.text)
         {
            if(_modifyButton.enable)
            {
               _modifyButton.enable = false;
               _modifyButton.filters = [_disenabelFilter];
            }
         }
         else if(!_modifyButton.enable)
         {
            _modifyButton.enable = true;
            _modifyButton.filters = null;
         }
      }
      
      protected function __onModifyClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_modifyButton.enable)
         {
            _modifyButton.enable = false;
            _modifyButton.filters = [_disenabelFilter];
         }
         _newName = _nicknameField.text;
         var loader:BaseLoader = createCheckLoader(_checkPath,checkCallBack);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      protected function createCheckLoader(path:String, callBack:Function) : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["id"] = PlayerManager.Instance.Self.ID;
         args["NickName"] = _newName;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(path),6,args);
         loader.analyzer = new ReworkNameAnalyzer(callBack);
         LoadResourceManager.Instance.startLoad(loader);
         return loader;
      }
      
      protected function createModifyLoader(path:String, variables:URLVariables, tempPassword:String, callBack:Function) : RequestLoader
      {
         var loader:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(path),6,variables);
         var analyzer:LoginRenameAnalyzer = new LoginRenameAnalyzer(callBack);
         analyzer.tempPassword = tempPassword;
         loader.analyzer = analyzer;
         return loader;
      }
      
      protected function checkCallBack(analyzer:ReworkNameAnalyzer) : void
      {
         var result:XML = analyzer.result;
         if(result.@value == "true")
         {
            state = "aviable";
            _resultField.text = result.@message;
            doRename();
         }
         else
         {
            _resultField.text = result.@message;
            state = "unaviable";
         }
      }
      
      protected function renameCallBack(analyzer:LoginRenameAnalyzer) : void
      {
         var result:XML = analyzer.result;
         if(result.@value == "true")
         {
            state = "aviable";
            renameComplete();
         }
         else
         {
            _resultField.text = result.@message;
            state = "unaviable";
         }
      }
      
      protected function doRename() : void
      {
         var i:int = 0;
         if(_modifyButton.enable)
         {
            _modifyButton.enable = false;
            _modifyButton.filters = [_disenabelFilter];
         }
         var acc:AccountInfo = PlayerManager.Instance.Account;
         var date:Date = new Date();
         var temp:ByteArray = new ByteArray();
         temp.writeShort(date.fullYearUTC);
         temp.writeByte(date.monthUTC + 1);
         temp.writeByte(date.dateUTC);
         temp.writeByte(date.hoursUTC);
         temp.writeByte(date.minutesUTC);
         temp.writeByte(date.secondsUTC);
         var tempPassword:String = "";
         for(i = 0; i < 6; )
         {
            tempPassword = tempPassword + w.charAt(int(Math.random() * 26));
            i++;
         }
         temp.writeUTFBytes(acc.Account + "," + acc.Password + "," + tempPassword + "," + _roleInfo.NickName + "," + _newName);
         var p:String = CrytoUtils.rsaEncry4(acc.Key,temp);
         var variables:URLVariables = RequestVairableCreater.creatWidthKey(false);
         variables["p"] = p;
         variables["v"] = 5498628;
         variables["site"] = PathManager.solveConfigSite();
         var loader:RequestLoader = createModifyLoader(_path,variables,tempPassword,renameCallBack);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      protected function renameComplete() : void
      {
         if(!_modifyButton.enable)
         {
            _modifyButton.enable = true;
            _modifyButton.filters = null;
         }
         _roleInfo.NameChanged = true;
         dispatchEvent(new Event("complete"));
      }
      
      public function get roleInfo() : Role
      {
         return _roleInfo;
      }
      
      public function set roleInfo(val:Role) : void
      {
         _roleInfo = val;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function set state(val:String) : void
      {
         var tf:* = null;
         if(_state != val)
         {
            _state = val;
            if(_state == "aviable")
            {
               tf = ComponentFactory.Instance.model.getSet("login.Rename.ResultAvailableTF");
               _resultField.defaultTextFormat = tf;
               if(_resultField.length > 0)
               {
                  _resultField.setTextFormat(tf,0,_resultField.length);
               }
            }
            else if(_state == "unaviable")
            {
               if(_modifyButton.enable)
               {
                  _modifyButton.enable = false;
                  _modifyButton.filters = [_disenabelFilter];
               }
               tf = ComponentFactory.Instance.model.getSet("login.Rename.ResultUnAvailableTF");
               _resultField.defaultTextFormat = tf;
               if(_resultField.length > 0)
               {
                  _resultField.setTextFormat(tf,0,_resultField.length);
               }
            }
            else
            {
               _resultField.text = _resultString;
               tf = ComponentFactory.Instance.model.getSet("login.Rename.ResultDefaultTF");
               _resultField.defaultTextFormat = tf;
               if(_resultField.length > 0)
               {
                  _resultField.setTextFormat(tf,0,_resultField.length);
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         if(_nicknameBack)
         {
            ObjectUtils.disposeObject(_nicknameBack);
            _nicknameBack = null;
         }
         if(_nicknameLabel)
         {
            ObjectUtils.disposeObject(_nicknameLabel);
            _nicknameLabel = null;
         }
         if(_nicknameField)
         {
            ObjectUtils.disposeObject(_nicknameField);
            _nicknameField = null;
         }
         if(_modifyButton)
         {
            ObjectUtils.disposeObject(_modifyButton);
            _modifyButton = null;
         }
         _roleInfo = null;
         super.dispose();
      }
   }
}
