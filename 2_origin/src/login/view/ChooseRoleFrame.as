package login.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.RequestLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.StripTip;
   import ddt.data.Role;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SelectListManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.OneLineTip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.net.URLVariables;
   
   public class ChooseRoleFrame extends Frame
   {
       
      
      private var _visible:Boolean = true;
      
      private var _listBack:MutipleImage;
      
      private var _enterButton:BaseButton;
      
      private var _list:VBox;
      
      private var _selectedItem:RoleItem;
      
      private var _disenabelFilter:ColorMatrixFilter;
      
      private var _rename:Boolean = false;
      
      private var _renameFrame:RoleRenameFrame;
      
      private var _consortiaRenameFrame:ConsortiaRenameFrame;
      
      private var _roleList:ListPanel;
      
      private var _gradeText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _recoverBtn:TextButton;
      
      private var _deleteBtn:TextButton;
      
      private var _recoverBtnStrip:StripTip;
      
      private var _deleteBtnStrip:StripTip;
      
      private var _oneLineTip:OneLineTip;
      
      private var _ReOrDeOperate:int;
      
      private var _recordOperateRoleItem:RoleItem;
      
      public function ChooseRoleFrame()
      {
         super();
         configUi();
      }
      
      private function configUi() : void
      {
         var _loc1_:int = 0;
         _disenabelFilter = ComponentFactory.Instance.model.getSet("login.ChooseRole.DisenableGF");
         titleStyle = "login.Title";
         titleText = LanguageMgr.GetTranslation("tank.loginstate.chooseCharacter");
         _listBack = ComponentFactory.Instance.creatComponentByStylename("login.chooseRoleFrame.bg");
         addToContent(_listBack);
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("login.chooseRoleFrame.gradeText");
         addToContent(_gradeText);
         _nameText = ComponentFactory.Instance.creatComponentByStylename("login.chooseRoleFrame.nameText");
         addToContent(_nameText);
         _roleList = ComponentFactory.Instance.creatComponentByStylename("login.ChooseRole.RoleList");
         addToContent(_roleList);
         _recoverBtn = ComponentFactory.Instance.creatComponentByStylename("login.choooseRoleFrame.recoverBtn");
         _recoverBtn.text = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.recoverBtnTxt");
         addToContent(_recoverBtn);
         _recoverBtnStrip = ComponentFactory.Instance.creatComponentByStylename("login.chooseRoleFrame.textBtnStrip");
         _recoverBtnStrip.x = _recoverBtn.x;
         _recoverBtnStrip.y = _recoverBtn.y;
         addToContent(_recoverBtnStrip);
         _recoverBtnStrip.visible = false;
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("login.choooseRoleFrame.deleteBtn");
         _deleteBtn.text = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.deleteBtnTxt");
         addToContent(_deleteBtn);
         _deleteBtnStrip = ComponentFactory.Instance.creatComponentByStylename("login.chooseRoleFrame.textBtnStrip");
         _deleteBtnStrip.x = _deleteBtn.x;
         _deleteBtnStrip.y = _deleteBtn.y;
         addToContent(_deleteBtnStrip);
         _deleteBtnStrip.visible = false;
         _enterButton = ComponentFactory.Instance.creatComponentByStylename("login.ChooseRole.EnterButton");
         addToContent(_enterButton);
         _oneLineTip = new OneLineTip();
         addToContent(_oneLineTip);
         _oneLineTip.visible = false;
         addEvent();
         _loc1_ = 0;
         while(_loc1_ < SelectListManager.Instance.list.length)
         {
            addRole(SelectListManager.Instance.list[_loc1_] as Role);
            _loc1_++;
         }
         AlertManager.Instance.layerType = 0;
      }
      
      private function addEvent() : void
      {
         _enterButton.addEventListener("click",__onEnterClick);
         _roleList.list.addEventListener("listItemClick",__onRoleClick);
         _recoverBtn.addEventListener("click",recoverOrDeleteHandler,false,0,true);
         _deleteBtn.addEventListener("click",recoverOrDeleteHandler,false,0,true);
         _recoverBtn.addEventListener("mouseOver",overHandler,false,0,true);
         _recoverBtn.addEventListener("mouseOut",outHandler,false,0,true);
         _deleteBtn.addEventListener("mouseOver",overHandler,false,0,true);
         _deleteBtn.addEventListener("mouseOut",outHandler,false,0,true);
         _recoverBtnStrip.addEventListener("mouseOver",overHandler,false,0,true);
         _recoverBtnStrip.addEventListener("mouseOut",outHandler,false,0,true);
         _deleteBtnStrip.addEventListener("mouseOver",overHandler,false,0,true);
         _deleteBtnStrip.addEventListener("mouseOut",outHandler,false,0,true);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = param1.target as Sprite;
         var _loc3_:String = "";
         var _loc4_:* = _loc2_;
         if(_recoverBtn !== _loc4_)
         {
            if(_recoverBtnStrip !== _loc4_)
            {
               if(_deleteBtn !== _loc4_)
               {
                  if(_deleteBtnStrip !== _loc4_)
                  {
                  }
               }
               _loc3_ = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.deleteBtnTipTxt");
            }
            addr45:
            _oneLineTip.tipData = _loc3_;
            _oneLineTip.x = _loc2_.x - (_oneLineTip.width - _loc2_.width) / 2;
            _oneLineTip.y = _loc2_.y + _loc2_.height;
            _oneLineTip.visible = true;
            return;
         }
         _loc3_ = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.recoverBtnTipTxt");
         §§goto(addr45);
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         _oneLineTip.visible = false;
      }
      
      private function recoverOrDeleteHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         if(!_selectedItem)
         {
            return;
         }
         if(param1.target == _deleteBtn)
         {
            _loc3_ = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.deleteTipTxt");
            _ReOrDeOperate = 1;
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.recoverTipTxt");
            _ReOrDeOperate = 2;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc3_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,1);
         _loc2_.moveEnable = false;
         _loc2_.addEventListener("response",__confirm);
      }
      
      private function __confirm(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc4_.removeEventListener("response",__confirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _recordOperateRoleItem = _selectedItem;
            _loc3_ = new URLVariables();
            _loc3_["username"] = PlayerManager.Instance.Account.Account;
            _loc3_["nickname"] = _selectedItem.roleInfo.NickName;
            _loc3_["operation"] = _ReOrDeOperate;
            _loc2_ = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoginRemoveSmallAccount.ashx"),6,_loc3_);
            _loc2_.addEventListener("loadError",__onRequestRecoverDeleteError,false,0,true);
            _loc2_.addEventListener("complete",__onRequestRecoverDeleteComplete,false,0,true);
            LoadResourceManager.Instance.startLoad(_loc2_);
         }
      }
      
      private function __onRequestRecoverDeleteError(param1:LoaderEvent) : void
      {
         trace("RequestRecoverDeleteError");
         _recordOperateRoleItem = null;
         var _loc2_:RequestLoader = param1.target as RequestLoader;
         _loc2_.removeEventListener("loadError",__onRequestRecoverDeleteError);
         _loc2_.removeEventListener("complete",__onRequestRecoverDeleteComplete);
      }
      
      private function __onRequestRecoverDeleteComplete(param1:LoaderEvent) : void
      {
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc7_:* = undefined;
         var _loc3_:RequestLoader = param1.target as RequestLoader;
         _loc3_.removeEventListener("loadError",__onRequestRecoverDeleteError);
         _loc3_.removeEventListener("complete",__onRequestRecoverDeleteComplete);
         var _loc4_:XML = new XML(param1.loader.content);
         if(_loc4_.@value == "true")
         {
            _loc6_ = _loc4_.@NickName;
            _loc2_ = _loc4_.@LoginState;
            _loc7_ = SelectListManager.Instance.list;
            var _loc9_:int = 0;
            var _loc8_:* = _loc7_;
            for each(var _loc5_ in _loc7_)
            {
               if(_loc5_.NickName == _loc6_)
               {
                  _loc5_.LoginState = _loc2_;
                  break;
               }
            }
            if(_recordOperateRoleItem)
            {
               _recordOperateRoleItem.refreshDeleteIcon();
            }
            judgeSelecteRoleState();
         }
         _recordOperateRoleItem = null;
      }
      
      private function removeEvent() : void
      {
         if(_enterButton)
         {
            _enterButton.removeEventListener("click",__onEnterClick);
         }
         _roleList.list.removeEventListener("listItemClick",__onRoleClick);
         if(_recoverBtn)
         {
            _recoverBtn.removeEventListener("click",recoverOrDeleteHandler);
            _recoverBtn.removeEventListener("mouseOver",overHandler);
            _recoverBtn.removeEventListener("mouseOut",outHandler);
         }
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",recoverOrDeleteHandler);
            _deleteBtn.removeEventListener("mouseOver",overHandler);
            _deleteBtn.removeEventListener("mouseOut",outHandler);
         }
         if(_recoverBtnStrip)
         {
            _recoverBtnStrip.removeEventListener("mouseOver",overHandler);
            _recoverBtnStrip.removeEventListener("mouseOut",outHandler);
         }
         if(_deleteBtnStrip)
         {
            _deleteBtnStrip.removeEventListener("mouseOver",overHandler);
            _deleteBtnStrip.removeEventListener("mouseOut",outHandler);
         }
      }
      
      private function __onEnterClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_selectedItem == null)
         {
            return;
         }
         if(_selectedItem.roleInfo.Rename || _selectedItem.roleInfo.ConsortiaRename)
         {
            if(_selectedItem.roleInfo.Rename && !_selectedItem.roleInfo.NameChanged)
            {
               startRename(_selectedItem.roleInfo);
               return;
            }
            if(_selectedItem.roleInfo.ConsortiaRename && !_selectedItem.roleInfo.ConsortiaNameChanged)
            {
               startRenameConsortia(_selectedItem.roleInfo);
               return;
            }
            dispatchEvent(new Event("complete"));
         }
         else
         {
            dispatchEvent(new Event("complete"));
         }
      }
      
      private function __onRoleClick(param1:ListItemEvent) : void
      {
         var _loc2_:RoleItem = param1.cell as RoleItem;
         selectedItem = _loc2_;
      }
      
      private function startRenameConsortia(param1:Role) : void
      {
         _consortiaRenameFrame = ComponentFactory.Instance.creatComponentByStylename("ConsortiaRenameFrame");
         _consortiaRenameFrame.roleInfo = param1;
         _consortiaRenameFrame.addEventListener("complete",__consortiaRenameComplete);
         LayerManager.Instance.addToLayer(_consortiaRenameFrame,0,true,2);
      }
      
      private function startRename(param1:Role) : void
      {
         _renameFrame = ComponentFactory.Instance.creatComponentByStylename("RoleRenameFrame");
         _renameFrame.roleInfo = param1;
         _renameFrame.addEventListener("complete",__onRenameComplete);
         LayerManager.Instance.addToLayer(_renameFrame,0,true,2);
      }
      
      private function __onRenameComplete(param1:Event) : void
      {
         _renameFrame.removeEventListener("complete",__onRenameComplete);
         ObjectUtils.disposeObject(_renameFrame);
         _renameFrame = null;
         __onEnterClick(null);
      }
      
      private function __consortiaRenameComplete(param1:Event) : void
      {
         _consortiaRenameFrame.removeEventListener("complete",__onRenameComplete);
         ObjectUtils.disposeObject(_consortiaRenameFrame);
         _consortiaRenameFrame = null;
         __onEnterClick(null);
      }
      
      public function addRole(param1:Role) : void
      {
         _roleList.vectorListModel.insertElementAt(param1,_roleList.vectorListModel.elements.length);
      }
      
      override public function dispose() : void
      {
         AlertManager.Instance.layerType = 1;
         _visible = false;
         removeEvent();
         if(_listBack)
         {
            ObjectUtils.disposeObject(_listBack);
            _listBack = null;
         }
         if(_gradeText)
         {
            ObjectUtils.disposeObject(_gradeText);
            _gradeText = null;
         }
         if(_nameText)
         {
            ObjectUtils.disposeObject(_nameText);
            _nameText = null;
         }
         if(_roleList)
         {
            ObjectUtils.disposeObject(_roleList);
            _roleList = null;
         }
         if(_recoverBtn)
         {
            ObjectUtils.disposeObject(_recoverBtn);
            _recoverBtn = null;
         }
         if(_deleteBtn)
         {
            ObjectUtils.disposeObject(_deleteBtn);
            _deleteBtn = null;
         }
         if(_recoverBtnStrip)
         {
            ObjectUtils.disposeObject(_recoverBtnStrip);
            _recoverBtnStrip = null;
         }
         if(_deleteBtnStrip)
         {
            ObjectUtils.disposeObject(_deleteBtnStrip);
            _deleteBtnStrip = null;
         }
         _recordOperateRoleItem = null;
         if(_enterButton)
         {
            ObjectUtils.disposeObject(_enterButton);
            _enterButton = null;
         }
         super.dispose();
      }
      
      public function get selectedRole() : Role
      {
         return _selectedItem.roleInfo;
      }
      
      public function get selectedItem() : RoleItem
      {
         return _selectedItem;
      }
      
      public function set selectedItem(param1:RoleItem) : void
      {
         var _loc2_:* = null;
         if(_selectedItem != param1)
         {
            _loc2_ = _selectedItem;
            _selectedItem = param1;
            if(_selectedItem != null)
            {
               _selectedItem.selected = true;
               SelectListManager.Instance.currentLoginRole = _selectedItem.roleInfo;
               judgeSelecteRoleState();
            }
            if(_loc2_)
            {
               _loc2_.selected = false;
               _loc2_ = null;
            }
         }
      }
      
      private function judgeSelecteRoleState() : void
      {
         if(_selectedItem.roleInfo.LoginState == 1)
         {
            _enterButton.enable = false;
            _recoverBtn.enable = true;
            _deleteBtn.enable = false;
            _recoverBtnStrip.visible = false;
            _deleteBtnStrip.visible = true;
         }
         else
         {
            _enterButton.enable = true;
            _recoverBtn.enable = false;
            _recoverBtnStrip.visible = true;
            if(_selectedItem.roleInfo.Grade >= 40 || SelectListManager.Instance.haveNotDeleteRoleNum == 1)
            {
               _deleteBtn.enable = false;
               _deleteBtnStrip.visible = true;
            }
            else
            {
               _deleteBtn.enable = true;
               _deleteBtnStrip.visible = false;
            }
         }
      }
   }
}
