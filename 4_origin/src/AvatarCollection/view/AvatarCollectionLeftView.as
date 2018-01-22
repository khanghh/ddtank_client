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
      
      public function AvatarCollectionLeftView(param1:AvatarCollectionRightView)
      {
         _rightView = param1;
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         _decorateSelect = ComponentFactory.Instance.creatComponentByStylename("avatarColl.menuSelectBtn");
         _decorateSelect.text = LanguageMgr.GetTranslation("avatarCollection.select.decorate");
         PositionUtils.setPos(_decorateSelect,"avatarColl.decorateSelectPos");
         _weaponSelect = ComponentFactory.Instance.creatComponentByStylename("avatarColl.menuSelectBtn");
         _weaponSelect.text = LanguageMgr.GetTranslation("avatarCollection.select.weapon");
         PositionUtils.setPos(_weaponSelect,"avatarColl.weaponSelectPos");
         addChild(_decorateSelect);
         addChild(_weaponSelect);
         _vbox = new VBox();
         PositionUtils.setPos(_vbox,"avatarColl.mainView.vboxPos");
         _vbox.spacing = 2;
         _unitList = new Vector.<AvatarCollectionUnitView>();
         _costumeList = new Vector.<AvatarCollectionUnitView>();
         _loc2_ = 1;
         while(_loc2_ <= 2)
         {
            _loc1_ = new AvatarCollectionUnitView(_loc2_,_rightView);
            _loc1_.addEventListener("avatarCollectionUnitView_selected_change",clickRefreshView,false,0,true);
            _vbox.addChild(_loc1_);
            _unitList.push(_loc1_);
            _costumeList.push(_loc1_);
            _loc2_++;
         }
         addChild(_vbox);
         _weaponList = new Vector.<AvatarCollectionUnitView>();
         _weaponView = new AvatarCollectionUnitWeaponView(3,_rightView);
         addChild(_weaponView);
         PositionUtils.setPos(_weaponView,"avatarColl.leftUnitViewPos");
         _unitList.push(_weaponView);
         _weaponList.push(_weaponView);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_decorateSelect);
         _btnGroup.addSelectItem(_weaponSelect);
         _btnGroup.addEventListener("change",__changeHandler);
         _btnGroup.selectIndex = 0;
      }
      
      private function __changeHandler(param1:Event) : void
      {
         AvatarCollectionManager.instance.resetListCellData();
         AvatarCollectionManager.instance.pageType = _btnGroup.selectIndex;
         _rightView.selectedAllBtn = false;
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _weaponView.visible = false;
               _vbox.visible = true;
               _unitList[0].extendSelecteTheFirst();
               refreshView(_unitList[0]);
               break;
            case 1:
               _vbox.visible = false;
               _weaponView.extendSelecteTheFirst();
               _weaponView.visible = true;
         }
      }
      
      public function reset(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var _loc2_ in _unitList)
         {
            _loc2_[param1] = false;
         }
      }
      
      public function canBuyChange(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var _loc2_ in _unitList)
         {
            _loc2_.isBuyFilter = param1;
         }
      }
      
      public function canActivityChange(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var _loc2_ in _unitList)
         {
            _loc2_.isFilter = param1;
         }
      }
      
      private function clickRefreshView(param1:Event) : void
      {
         var _loc2_:AvatarCollectionUnitView = param1.target as AvatarCollectionUnitView;
         refreshView(_loc2_);
      }
      
      private function refreshView(param1:AvatarCollectionUnitView) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var _loc2_ in _unitList)
         {
            if(_loc2_ != param1)
            {
               _loc2_.unextendHandler();
            }
         }
         _vbox.arrange();
      }
      
      public function get unitList() : Vector.<AvatarCollectionUnitView>
      {
         if(AvatarCollectionManager.instance.pageType == 0)
         {
            return _costumeList;
         }
         return _weaponList;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _unitList;
         for each(var _loc1_ in _unitList)
         {
            _loc1_.removeEventListener("avatarCollectionUnitView_selected_change",clickRefreshView);
         }
         _btnGroup.removeEventListener("change",__changeHandler);
         ObjectUtils.disposeObject(_btnGroup);
         ObjectUtils.disposeAllChildren(this);
         _weaponList = null;
         _costumeList = null;
         _rightView = null;
         _vbox = null;
         _unitList = null;
         _decorateSelect = null;
         _weaponSelect = null;
         _btnGroup = null;
      }
   }
}
