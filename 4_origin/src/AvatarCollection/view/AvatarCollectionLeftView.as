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
      
      public function AvatarCollectionLeftView(view:AvatarCollectionRightView)
      {
         _rightView = view;
         super();
         init();
      }
      
      private function init() : void
      {
         var unitView:* = null;
         var i:int = 0;
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
         for(i = 1; i <= 2; )
         {
            unitView = new AvatarCollectionUnitView(i,_rightView);
            unitView.addEventListener("avatarCollectionUnitView_selected_change",clickRefreshView,false,0,true);
            _vbox.addChild(unitView);
            _unitList.push(unitView);
            _costumeList.push(unitView);
            i++;
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
      
      private function __changeHandler(event:Event) : void
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
      
      public function reset(property:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var tmp in _unitList)
         {
            tmp[property] = false;
         }
      }
      
      public function canBuyChange(value:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var tmp in _unitList)
         {
            tmp.isBuyFilter = value;
         }
      }
      
      public function canActivityChange(value:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var tmp in _unitList)
         {
            tmp.isFilter = value;
         }
      }
      
      private function clickRefreshView(event:Event) : void
      {
         var tmpTargetUnit:AvatarCollectionUnitView = event.target as AvatarCollectionUnitView;
         refreshView(tmpTargetUnit);
      }
      
      private function refreshView(view:AvatarCollectionUnitView) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _unitList;
         for each(var tmp in _unitList)
         {
            if(tmp != view)
            {
               tmp.unextendHandler();
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
         for each(var tmp in _unitList)
         {
            tmp.removeEventListener("avatarCollectionUnitView_selected_change",clickRefreshView);
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
