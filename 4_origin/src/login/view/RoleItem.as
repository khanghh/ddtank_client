package login.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.Role;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class RoleItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _roleInfo:Role;
      
      private var _backImage:Bitmap;
      
      private var _levelIcon:LevelIcon;
      
      private var _nicknameField:FilterFrameText;
      
      private var _data:Object;
      
      private var _light:ScaleBitmapImage;
      
      private var _isSelected:Boolean;
      
      private var _deletedIcon:Bitmap;
      
      public function RoleItem()
      {
         super();
         mouseChildren = false;
         buttonMode = true;
         configUi();
         initEvent();
      }
      
      private function configUi() : void
      {
         _backImage = ComponentFactory.Instance.creatBitmap("login.chooserole.cell.bg");
         addChild(_backImage);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("login.ChooseRole.cell.LevelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _nicknameField = ComponentFactory.Instance.creatComponentByStylename("login.ChooseRole.Nickname");
         addChild(_nicknameField);
         _light = ComponentFactory.Instance.creatComponentByStylename("login.ChooseRoleListItem.light");
         addChild(_light);
         _deletedIcon = ComponentFactory.Instance.creatBitmap("asset.login.chooseRoleFrame.deletedIcon");
         addChild(_deletedIcon);
         _deletedIcon.visible = false;
         _light.visible = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(evt:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function __mouseOutHandler(evt:MouseEvent) : void
      {
         _light.visible = _isSelected;
      }
      
      public function get selected() : Boolean
      {
         return _isSelected;
      }
      
      public function set selected(val:Boolean) : void
      {
         _isSelected = val;
         _light.visible = val;
      }
      
      public function get roleInfo() : Role
      {
         return _roleInfo;
      }
      
      public function set roleInfo(val:Role) : void
      {
         _roleInfo = val;
         _levelIcon.setInfo(_roleInfo.Grade,0,0,_roleInfo.WinCount,_roleInfo.TotalCount,1,0);
         _nicknameField.text = _roleInfo.NickName;
         refreshDeleteIcon();
      }
      
      public function refreshDeleteIcon() : void
      {
         if(_roleInfo.LoginState == 1)
         {
            _deletedIcon.visible = true;
         }
         else
         {
            _deletedIcon.visible = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_backImage)
         {
            ObjectUtils.disposeObject(_backImage);
            _backImage.bitmapData.dispose();
            _backImage.bitmapData = null;
            _backImage = null;
         }
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
            _levelIcon = null;
         }
         if(_nicknameField)
         {
            ObjectUtils.disposeObject(_nicknameField);
            _nicknameField = null;
         }
         if(_deletedIcon)
         {
            ObjectUtils.disposeObject(_deletedIcon);
            _deletedIcon = null;
         }
         if(_light)
         {
            ObjectUtils.disposeObject(_light);
            _light = null;
         }
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(value:*) : void
      {
         _data = value;
         roleInfo = _data as Role;
      }
   }
}
