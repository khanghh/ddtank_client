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
      
      public function ChooseRoleFrame(){super();}
      
      private function configUi() : void{}
      
      private function addEvent() : void{}
      
      private function overHandler(param1:MouseEvent) : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      private function recoverOrDeleteHandler(param1:MouseEvent) : void{}
      
      private function __confirm(param1:FrameEvent) : void{}
      
      private function __onRequestRecoverDeleteError(param1:LoaderEvent) : void{}
      
      private function __onRequestRecoverDeleteComplete(param1:LoaderEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __onEnterClick(param1:MouseEvent) : void{}
      
      private function __onRoleClick(param1:ListItemEvent) : void{}
      
      private function startRenameConsortia(param1:Role) : void{}
      
      private function startRename(param1:Role) : void{}
      
      private function __onRenameComplete(param1:Event) : void{}
      
      private function __consortiaRenameComplete(param1:Event) : void{}
      
      public function addRole(param1:Role) : void{}
      
      override public function dispose() : void{}
      
      public function get selectedRole() : Role{return null;}
      
      public function get selectedItem() : RoleItem{return null;}
      
      public function set selectedItem(param1:RoleItem) : void{}
      
      private function judgeSelecteRoleState() : void{}
   }
}
