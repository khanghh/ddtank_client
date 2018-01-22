package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.list.IListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AvatarCollectionUnitView extends Sprite implements Disposeable
   {
      
      public static const SELECTED_CHANGE:String = "avatarCollectionUnitView_selected_change";
       
      
      protected var _index:int;
      
      protected var _rightView:AvatarCollectionRightView;
      
      protected var _selectedBtn:SelectedButton;
      
      protected var _bg:DisplayObject;
      
      protected var _list:ListPanel;
      
      private var _dataList:Array;
      
      private var _selectedValue:AvatarCollectionUnitVo;
      
      private var _isFilter:Boolean = false;
      
      private var _isBuyFilter:Boolean = false;
      
      public function AvatarCollectionUnitView(param1:int, param2:AvatarCollectionRightView)
      {
         super();
         _index = param1;
         _rightView = param2;
         initView();
         initEvent();
         initData();
         initStatus();
      }
      
      public function set isBuyFilter(param1:Boolean) : void
      {
         _isBuyFilter = param1;
         if(_isBuyFilter)
         {
            _isFilter = false;
         }
         refreshList();
      }
      
      public function set isFilter(param1:Boolean) : void
      {
         _isFilter = param1;
         if(_isFilter)
         {
            _isBuyFilter = false;
         }
         refreshList();
      }
      
      private function initStatus() : void
      {
         var _loc1_:int = 0;
         if(AvatarCollectionManager.instance.isSkipFromHall)
         {
            _loc1_ = 0;
            while(_loc1_ < _dataList.length)
            {
               if((_dataList[_loc1_] as AvatarCollectionUnitVo).id == AvatarCollectionManager.instance.skipId)
               {
                  extendSelecteTheFirst();
                  break;
               }
               _loc1_++;
            }
         }
         else if(_index == 1)
         {
            extendSelecteTheFirst();
         }
      }
      
      protected function initView() : void
      {
         _selectedBtn = getSelectedBtn();
         _bg = ComponentFactory.Instance.creatBitmap("asset.avatarColl.selectUnitBg");
         _bg.visible = false;
         _list = ComponentFactory.Instance.creatComponentByStylename("avatarColl.unitCellList");
         _list.visible = false;
         if(_selectedBtn)
         {
            addChild(_selectedBtn);
         }
         addChild(_bg);
         addChild(_list);
      }
      
      private function initEvent() : void
      {
         if(_selectedBtn)
         {
            _selectedBtn.addEventListener("click",clickHandler,false,0,true);
         }
         _list.list.addEventListener("listItemClick",__itemClick);
         AvatarCollectionManager.instance.addEventListener("avatar_collection_refresh_view",toDoRefresh);
      }
      
      private function initData() : void
      {
         _dataList = getDataList();
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_dataList);
         _list.list.updateListView();
      }
      
      private function toDoRefresh(param1:Event) : void
      {
         refreshList();
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedValue = param1.cellValue as AvatarCollectionUnitVo;
         if(_rightView)
         {
            _rightView.refreshView(_selectedValue);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         extendSelecteTheFirst();
         dispatchEvent(new Event("avatarCollectionUnitView_selected_change"));
      }
      
      public function extendSelecteTheFirst() : void
      {
         if(_selectedBtn)
         {
            _selectedBtn.selected = true;
         }
         extendHandler();
         autoSelect();
      }
      
      private function extendHandler() : void
      {
         _bg.visible = true;
         _list.visible = true;
         if(_selectedBtn)
         {
            _selectedBtn.enable = false;
         }
      }
      
      private function autoSelect() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:IListModel = _list.list.model;
         var _loc3_:int = _loc1_.getSize();
         if(_loc3_ > 0)
         {
            if(!_selectedValue)
            {
               if(AvatarCollectionManager.instance.isSkipFromHall)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_)
                  {
                     if((_loc1_.getElementAt(_loc5_) as AvatarCollectionUnitVo).id == AvatarCollectionManager.instance.skipId)
                     {
                        _selectedValue = _loc1_.getElementAt(_loc5_);
                        AvatarCollectionManager.instance.isSkipFromHall = false;
                        break;
                     }
                     _loc5_++;
                  }
               }
               else
               {
                  _selectedValue = _loc1_.getElementAt(0) as AvatarCollectionUnitVo;
               }
            }
            _loc4_ = _loc1_.indexOf(_selectedValue);
            _loc2_ = new IntPoint(0,_loc1_.getCellPosFromIndex(_loc4_));
            _list.list.viewPosition = _loc2_;
            _list.list.currentSelectedIndex = _loc4_;
         }
         else
         {
            _selectedValue = null;
         }
         _rightView.refreshView(_selectedValue);
      }
      
      public function unextendHandler() : void
      {
         if(_selectedBtn)
         {
            _selectedBtn.selected = false;
            _selectedBtn.enable = true;
         }
         _bg.visible = false;
         _list.visible = false;
      }
      
      private function refreshList() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Array = [];
         if(_isFilter)
         {
            _loc2_ = _dataList.length;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               if((_dataList[_loc4_] as AvatarCollectionUnitVo).canActivityCount > 0)
               {
                  _loc5_.push(_dataList[_loc4_]);
               }
               _loc4_++;
            }
         }
         else if(_isBuyFilter)
         {
            _loc1_ = _dataList.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if((_dataList[_loc3_] as AvatarCollectionUnitVo).canBuyCount > 0)
               {
                  _loc5_.push(_dataList[_loc3_]);
               }
               _loc3_++;
            }
         }
         else
         {
            _loc5_ = _dataList;
         }
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_loc5_);
         _list.list.updateListView();
         if(_selectedValue && _loc5_.indexOf(_selectedValue) == -1)
         {
            _selectedValue = null;
         }
         if(_list.visible)
         {
            autoSelect();
         }
      }
      
      private function getDataList() : Array
      {
         var _loc1_:* = null;
         switch(int(_index) - 1)
         {
            case 0:
               _loc1_ = AvatarCollectionManager.instance.maleUnitList;
               break;
            case 1:
               _loc1_ = AvatarCollectionManager.instance.femaleUnitList;
               break;
            case 2:
               _loc1_ = AvatarCollectionManager.instance.weaponUnitList;
         }
         return !!_loc1_?_loc1_:[];
      }
      
      private function getSelectedBtn() : SelectedButton
      {
         var _loc1_:* = null;
         switch(int(_index) - 1)
         {
            case 0:
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("avatarColl.maleBtn");
               break;
            case 1:
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("avatarColl.femaleBtn");
         }
         return _loc1_;
      }
      
      override public function get height() : Number
      {
         if(_selectedBtn && _bg)
         {
            if(_bg.visible)
            {
               return _bg.y + _bg.height;
            }
            return _selectedBtn.height;
         }
         return super.height;
      }
      
      private function removeEvent() : void
      {
         if(_selectedBtn)
         {
            _selectedBtn.removeEventListener("click",clickHandler);
         }
         _list.list.removeEventListener("listItemClick",__itemClick);
         AvatarCollectionManager.instance.removeEventListener("avatar_collection_refresh_view",toDoRefresh);
      }
      
      public function dispose() : void
      {
         AvatarCollectionManager.instance.isSkipFromHall = false;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _rightView = null;
         _selectedBtn = null;
         _bg = null;
         _list = null;
         _dataList = null;
         _selectedValue = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get list() : ListPanel
      {
         return _list;
      }
   }
}
