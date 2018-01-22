package login.view
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.AccountInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.CrytoUtils;
   import ddt.utils.RequestVairableCreater;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class ConsortiaRenameFrame extends RoleRenameFrame
   {
       
      
      public function ConsortiaRenameFrame()
      {
         super();
         _path = "RenameConsortiaName.ashx";
         _checkPath = "ConsortiaNameCheck.ashx";
         _resultString = LanguageMgr.GetTranslation("tank.view.ConsortiaReworkNameView.consortiaNameAlert");
         _resultField.text = _resultString;
      }
      
      override protected function configUi() : void
      {
         super.configUi();
         titleText = LanguageMgr.GetTranslation("tank.loginstate.guildNameModify");
         _nicknameLabel.text = LanguageMgr.GetTranslation("tank.loginstate.guildNameModify");
         if(_nicknameField)
         {
            _nicknameField = ComponentFactory.Instance.creatComponentByStylename("login.Rename.ConsortianameInput");
            addToContent(_nicknameField);
         }
      }
      
      override protected function __onModifyClick(param1:MouseEvent) : void
      {
         super.__onModifyClick(param1);
      }
      
      override protected function doRename() : void
      {
         var _loc8_:int = 0;
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
      
      override protected function createModifyLoader(param1:String, param2:URLVariables, param3:String, param4:Function) : RequestLoader
      {
         return super.createModifyLoader(param1,param2,param3,param4);
      }
      
      override protected function renameComplete() : void
      {
         _roleInfo.ConsortiaNameChanged = true;
         dispatchEvent(new Event("complete"));
      }
   }
}
