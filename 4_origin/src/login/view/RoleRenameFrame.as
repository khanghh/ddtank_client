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
      
      private function __onTextChange(param1:Event) : void
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
      
      protected function __onModifyClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_modifyButton.enable)
         {
            _modifyButton.enable = false;
            _modifyButton.filters = [_disenabelFilter];
         }
         _newName = _nicknameField.text;
         var _loc2_:BaseLoader = createCheckLoader(_checkPath,checkCallBack);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      protected function createCheckLoader(param1:String, param2:Function) : BaseLoader
      {
         var _loc4_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc4_["id"] = PlayerManager.Instance.Self.ID;
         _loc4_["NickName"] = _newName;
         var _loc3_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(param1),6,_loc4_);
         _loc3_.analyzer = new ReworkNameAnalyzer(param2);
         LoadResourceManager.Instance.startLoad(_loc3_);
         return _loc3_;
      }
      
      protected function createModifyLoader(param1:String, param2:URLVariables, param3:String, param4:Function) : RequestLoader
      {
         var _loc5_:RequestLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(param1),6,param2);
         var _loc6_:LoginRenameAnalyzer = new LoginRenameAnalyzer(param4);
         _loc6_.tempPassword = param3;
         _loc5_.analyzer = _loc6_;
         return _loc5_;
      }
      
      protected function checkCallBack(param1:ReworkNameAnalyzer) : void
      {
         var _loc2_:XML = param1.result;
         if(_loc2_.@value == "true")
         {
            state = "aviable";
            _resultField.text = _loc2_.@message;
            doRename();
         }
         else
         {
            _resultField.text = _loc2_.@message;
            state = "unaviable";
         }
      }
      
      protected function renameCallBack(param1:LoginRenameAnalyzer) : void
      {
         var _loc2_:XML = param1.result;
         if(_loc2_.@value == "true")
         {
            state = "aviable";
            renameComplete();
         }
         else
         {
            _resultField.text = _loc2_.@message;
            state = "unaviable";
         }
      }
      
      protected function doRename() : void
      {
         var _loc8_:int = 0;
         if(_modifyButton.enable)
         {
            _modifyButton.enable = false;
            _modifyButton.filters = [_disenabelFilter];
         }
         var _loc6_:AccountInfo = PlayerManager.Instance.Account;
         var _loc5_:Date = new Date();
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeShort(_loc5_.fullYearUTC);
         _loc4_.writeByte(_loc5_.monthUTC + 1);
         _loc4_.writeByte(_loc5_.dateUTC);
         _loc4_.writeByte(_loc5_.hoursUTC);
         _loc4_.writeByte(_loc5_.minutesUTC);
         _loc4_.writeByte(_loc5_.secondsUTC);
         var _loc3_:String = "";
         _loc8_ = 0;
         while(_loc8_ < 6)
         {
            _loc3_ = _loc3_ + w.charAt(int(Math.random() * 26));
            _loc8_++;
         }
         _loc4_.writeUTFBytes(_loc6_.Account + "," + _loc6_.Password + "," + _loc3_ + "," + _roleInfo.NickName + "," + _newName);
         var _loc2_:String = CrytoUtils.rsaEncry4(_loc6_.Key,_loc4_);
         var _loc7_:URLVariables = RequestVairableCreater.creatWidthKey(false);
         _loc7_["p"] = _loc2_;
         _loc7_["v"] = 5498628;
         _loc7_["site"] = PathManager.solveConfigSite();
         var _loc1_:RequestLoader = createModifyLoader(_path,_loc7_,_loc3_,renameCallBack);
         LoadResourceManager.Instance.startLoad(_loc1_);
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
      
      public function set roleInfo(param1:Role) : void
      {
         _roleInfo = param1;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function set state(param1:String) : void
      {
         var _loc2_:* = null;
         if(_state != param1)
         {
            _state = param1;
            if(_state == "aviable")
            {
               _loc2_ = ComponentFactory.Instance.model.getSet("login.Rename.ResultAvailableTF");
               _resultField.defaultTextFormat = _loc2_;
               if(_resultField.length > 0)
               {
                  _resultField.setTextFormat(_loc2_,0,_resultField.length);
               }
            }
            else if(_state == "unaviable")
            {
               if(_modifyButton.enable)
               {
                  _modifyButton.enable = false;
                  _modifyButton.filters = [_disenabelFilter];
               }
               _loc2_ = ComponentFactory.Instance.model.getSet("login.Rename.ResultUnAvailableTF");
               _resultField.defaultTextFormat = _loc2_;
               if(_resultField.length > 0)
               {
                  _resultField.setTextFormat(_loc2_,0,_resultField.length);
               }
            }
            else
            {
               _resultField.text = _resultString;
               _loc2_ = ComponentFactory.Instance.model.getSet("login.Rename.ResultDefaultTF");
               _resultField.defaultTextFormat = _loc2_;
               if(_resultField.length > 0)
               {
                  _resultField.setTextFormat(_loc2_,0,_resultField.length);
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
