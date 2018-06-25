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
         var i:int = 0;
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
         for(i = 0; i < SelectListManager.Instance.list.length; )
         {
            addRole(SelectListManager.Instance.list[i] as Role);
            i++;
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
      
      private function overHandler(event:MouseEvent) : void
      {
         var tmpTarget:Sprite = event.target as Sprite;
         var tmpTipStr:String = "";
         var _loc4_:* = tmpTarget;
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
               tmpTipStr = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.deleteBtnTipTxt");
            }
            addr54:
            _oneLineTip.tipData = tmpTipStr;
            _oneLineTip.x = tmpTarget.x - (_oneLineTip.width - tmpTarget.width) / 2;
            _oneLineTip.y = tmpTarget.y + tmpTarget.height;
            _oneLineTip.visible = true;
            return;
         }
         tmpTipStr = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.recoverBtnTipTxt");
         §§goto(addr54);
      }
      
      private function outHandler(event:MouseEvent) : void
      {
         _oneLineTip.visible = false;
      }
      
      private function recoverOrDeleteHandler(event:MouseEvent) : void
      {
         var msg:* = null;
         SoundManager.instance.play("008");
         if(!_selectedItem)
         {
            return;
         }
         if(event.target == _deleteBtn)
         {
            msg = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.deleteTipTxt");
            _ReOrDeOperate = 1;
         }
         else
         {
            msg = LanguageMgr.GetTranslation("ddt.chooseRoleFrame.recoverTipTxt");
            _ReOrDeOperate = 2;
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __confirm(evt:FrameEvent) : void
      {
         var args:* = null;
         var loader:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__confirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            _recordOperateRoleItem = _selectedItem;
            args = new URLVariables();
            args["username"] = PlayerManager.Instance.Account.Account;
            args["nickname"] = _selectedItem.roleInfo.NickName;
            args["operation"] = _ReOrDeOperate;
            loader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoginRemoveSmallAccount.ashx"),6,args);
            loader.addEventListener("loadError",__onRequestRecoverDeleteError,false,0,true);
            loader.addEventListener("complete",__onRequestRecoverDeleteComplete,false,0,true);
            LoadResourceManager.Instance.startLoad(loader);
         }
      }
      
      private function __onRequestRecoverDeleteError(evt:LoaderEvent) : void
      {
         trace("RequestRecoverDeleteError");
         _recordOperateRoleItem = null;
         var tmpLoader:RequestLoader = evt.target as RequestLoader;
         tmpLoader.removeEventListener("loadError",__onRequestRecoverDeleteError);
         tmpLoader.removeEventListener("complete",__onRequestRecoverDeleteComplete);
      }
      
      private function __onRequestRecoverDeleteComplete(evt:LoaderEvent) : void
      {
         var tmpNickName:* = null;
         var loginState:int = 0;
         var tmpRoleList:* = undefined;
         var tmpLoader:RequestLoader = evt.target as RequestLoader;
         tmpLoader.removeEventListener("loadError",__onRequestRecoverDeleteError);
         tmpLoader.removeEventListener("complete",__onRequestRecoverDeleteComplete);
         var xml:XML = new XML(evt.loader.content);
         if(xml.@value == "true")
         {
            tmpNickName = xml.@NickName;
            loginState = xml.@LoginState;
            tmpRoleList = SelectListManager.Instance.list;
            var _loc9_:int = 0;
            var _loc8_:* = tmpRoleList;
            for each(var tmpRole in tmpRoleList)
            {
               if(tmpRole.NickName == tmpNickName)
               {
                  tmpRole.LoginState = loginState;
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
      
      private function __onEnterClick(evt:MouseEvent) : void
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
      
      private function __onRoleClick(evt:ListItemEvent) : void
      {
         var role:RoleItem = evt.cell as RoleItem;
         selectedItem = role;
      }
      
      private function startRenameConsortia(roleInfo:Role) : void
      {
         _consortiaRenameFrame = ComponentFactory.Instance.creatComponentByStylename("ConsortiaRenameFrame");
         _consortiaRenameFrame.roleInfo = roleInfo;
         _consortiaRenameFrame.addEventListener("complete",__consortiaRenameComplete);
         LayerManager.Instance.addToLayer(_consortiaRenameFrame,0,true,2);
      }
      
      private function startRename(roleInfo:Role) : void
      {
         _renameFrame = ComponentFactory.Instance.creatComponentByStylename("RoleRenameFrame");
         _renameFrame.roleInfo = roleInfo;
         _renameFrame.addEventListener("complete",__onRenameComplete);
         LayerManager.Instance.addToLayer(_renameFrame,0,true,2);
      }
      
      private function __onRenameComplete(evt:Event) : void
      {
         _renameFrame.removeEventListener("complete",__onRenameComplete);
         ObjectUtils.disposeObject(_renameFrame);
         _renameFrame = null;
         __onEnterClick(null);
      }
      
      private function __consortiaRenameComplete(evt:Event) : void
      {
         _consortiaRenameFrame.removeEventListener("complete",__onRenameComplete);
         ObjectUtils.disposeObject(_consortiaRenameFrame);
         _consortiaRenameFrame = null;
         __onEnterClick(null);
      }
      
      public function addRole(info:Role) : void
      {
         _roleList.vectorListModel.insertElementAt(info,_roleList.vectorListModel.elements.length);
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
      
      public function set selectedItem(val:RoleItem) : void
      {
         var sel:* = null;
         if(_selectedItem != val)
         {
            sel = _selectedItem;
            _selectedItem = val;
            if(_selectedItem != null)
            {
               _selectedItem.selected = true;
               SelectListManager.Instance.currentLoginRole = _selectedItem.roleInfo;
               judgeSelecteRoleState();
            }
            if(sel)
            {
               sel.selected = false;
               sel = null;
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
