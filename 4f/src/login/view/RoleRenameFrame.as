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
      
      public function RoleRenameFrame(){super();}
      
      protected function configUi() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __onTextChange(param1:Event) : void{}
      
      protected function __onModifyClick(param1:MouseEvent) : void{}
      
      protected function createCheckLoader(param1:String, param2:Function) : BaseLoader{return null;}
      
      protected function createModifyLoader(param1:String, param2:URLVariables, param3:String, param4:Function) : RequestLoader{return null;}
      
      protected function checkCallBack(param1:ReworkNameAnalyzer) : void{}
      
      protected function renameCallBack(param1:LoginRenameAnalyzer) : void{}
      
      protected function doRename() : void{}
      
      protected function renameComplete() : void{}
      
      public function get roleInfo() : Role{return null;}
      
      public function set roleInfo(param1:Role) : void{}
      
      public function get state() : String{return null;}
      
      public function set state(param1:String) : void{}
      
      override public function dispose() : void{}
   }
}
