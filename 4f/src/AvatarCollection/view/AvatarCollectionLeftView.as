package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class AvatarCollectionLeftView extends Sprite implements Disposeable
   {
       
      
      private var _rightView:AvatarCollectionRightView;
      
      private var _decorateSelect:SelectedTextButton;
      
      private var _weaponSelect:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _vbox:VBox;
      
      private var _unitList:Vector.<AvatarCollectionUnitView>;
      
      private var _costumeList:Vector.<AvatarCollectionUnitView>;
      
      private var _weaponList:Vector.<AvatarCollectionUnitView>;
      
      private var _weaponView:AvatarCollectionUnitWeaponView;
      
      public function AvatarCollectionLeftView(param1:AvatarCollectionRightView){super();}
      
      private function init() : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      public function reset(param1:String) : void{}
      
      public function canBuyChange(param1:Boolean) : void{}
      
      public function canActivityChange(param1:Boolean) : void{}
      
      private function clickRefreshView(param1:Event) : void{}
      
      private function refreshView(param1:AvatarCollectionUnitView) : void{}
      
      public function get unitList() : Vector.<AvatarCollectionUnitView>{return null;}
      
      public function dispose() : void{}
   }
}
