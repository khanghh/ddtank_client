package AvatarCollection.view{   import AvatarCollection.AvatarCollectionManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SelectedTextButton;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;      public class AvatarCollectionLeftView extends Sprite implements Disposeable   {                   private var _rightView:AvatarCollectionRightView;            private var _decorateSelect:SelectedTextButton;            private var _weaponSelect:SelectedTextButton;            private var _btnGroup:SelectedButtonGroup;            private var _vbox:VBox;            private var _unitList:Vector.<AvatarCollectionUnitView>;            private var _costumeList:Vector.<AvatarCollectionUnitView>;            private var _weaponList:Vector.<AvatarCollectionUnitView>;            private var _weaponView:AvatarCollectionUnitWeaponView;            public function AvatarCollectionLeftView(view:AvatarCollectionRightView) { super(); }
            private function init() : void { }
            private function __changeHandler(event:Event) : void { }
            public function reset(property:String) : void { }
            public function canBuyChange(value:Boolean) : void { }
            public function canActivityChange(value:Boolean) : void { }
            private function clickRefreshView(event:Event) : void { }
            private function refreshView(view:AvatarCollectionUnitView) : void { }
            public function get unitList() : Vector.<AvatarCollectionUnitView> { return null; }
            public function dispose() : void { }
   }}