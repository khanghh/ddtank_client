package store.newFusion.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.list.IListModel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import store.newFusion.FusionNewManager;
   import store.newFusion.data.FusionNewVo;
   
   public class FusionNewUnitView extends Sprite implements Disposeable
   {
      
      public static const SELECTED_CHANGE:String = "fusionNewUnitView_selected_change";
       
      
      private var _index:int;
      
      private var _rightView:FusionNewRightView;
      
      private var _selectedBtn:SelectedButton;
      
      private var _bg:Bitmap;
      
      private var _list:ListPanel;
      
      private var _isFilter:Boolean = false;
      
      private var _dataList:Array;
      
      private var _selectedValue:FusionNewVo;
      
      public function FusionNewUnitView(param1:int, param2:FusionNewRightView)
      {
         super();
         _index = param1;
         _rightView = param2;
         initView();
         initEvent();
         initData();
         initStatus();
      }
      
      private function initStatus() : void
      {
         if(_index == 1)
         {
            extendSelecteTheFirst();
         }
      }
      
      private function extendSelecteTheFirst() : void
      {
         extendHandler();
         autoSelect();
      }
      
      private function autoSelect() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:IListModel = _list.list.model;
         var _loc3_:int = _loc1_.getSize();
         if(_loc3_ > 0)
         {
            if(!_selectedValue)
            {
               _selectedValue = _loc1_.getElementAt(0) as FusionNewVo;
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
      
      public function set isFilter(param1:Boolean) : void
      {
         _isFilter = param1;
         refreshList();
      }
      
      private function initData() : void
      {
         _dataList = getDataList();
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_dataList);
         _list.list.updateListView();
      }
      
      private function refreshList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         if(_isFilter)
         {
            _loc1_ = _dataList.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if((_dataList[_loc2_] as FusionNewVo).canFusionCount > 0)
               {
                  _loc3_.push(_dataList[_loc2_]);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = _dataList;
         }
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_loc3_);
         _list.list.updateListView();
         if(_selectedValue && _loc3_.indexOf(_selectedValue) == -1)
         {
            _selectedValue = null;
         }
         if(_list.visible)
         {
            autoSelect();
         }
      }
      
      private function initView() : void
      {
         _selectedBtn = getSelectedBtn();
         _bg = ComponentFactory.Instance.creatBitmap("asset.newFusion.selectedUnitBg");
         _bg.visible = false;
         _list = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.unitCellList");
         _list.visible = false;
         addChild(_selectedBtn);
         addChild(_bg);
         addChild(_list);
      }
      
      private function initEvent() : void
      {
         _selectedBtn.addEventListener("click",clickHandler,false,0,true);
         _list.list.addEventListener("listItemClick",__itemClick);
         PlayerManager.Instance.Self.Bag.addEventListener("update",updateBag);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",updateBag);
      }
      
      private function updateBag(param1:BagEvent) : void
      {
         refreshList();
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedValue = param1.cellValue as FusionNewVo;
         if(_rightView)
         {
            _rightView.refreshView(_selectedValue);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         extendSelecteTheFirst();
         dispatchEvent(new Event("fusionNewUnitView_selected_change"));
      }
      
      private function extendHandler() : void
      {
         _bg.visible = true;
         _list.visible = true;
         _selectedBtn.enable = false;
      }
      
      public function unextendHandler() : void
      {
         _selectedBtn.selected = false;
         _selectedBtn.enable = true;
         _bg.visible = false;
         _list.visible = false;
         _selectedValue = null;
      }
      
      private function getDataList() : Array
      {
         var _loc1_:* = null;
         switch(int(_index) - 1)
         {
            case 0:
               _loc1_ = FusionNewManager.instance.getDataListByType(1);
               break;
            case 1:
               _loc1_ = FusionNewManager.instance.getDataListByType(2);
               break;
            case 2:
               _loc1_ = FusionNewManager.instance.getDataListByType(3);
               break;
            case 3:
               _loc1_ = FusionNewManager.instance.getDataListByType(4);
               break;
            case 4:
               _loc1_ = FusionNewManager.instance.getDataListByType(5);
               break;
            case 5:
               _loc1_ = FusionNewManager.instance.getDataListByType(6);
         }
         return !!_loc1_?_loc1_:[];
      }
      
      private function getSelectedBtn() : SelectedButton
      {
         var _loc1_:* = null;
         switch(int(_index) - 1)
         {
            case 0:
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.weaponBtn");
               break;
            case 1:
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.jewellryBtn");
               break;
            case 2:
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.avatarBtn");
               break;
            case 3:
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.drillBtn");
               break;
            case 4:
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.combineBtn");
               break;
            case 5:
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.otherBtn");
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
         if(_list)
         {
            _list.list.removeEventListener("listItemClick",__itemClick);
         }
         PlayerManager.Instance.Self.Bag.removeEventListener("update",updateBag);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",updateBag);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _selectedBtn = null;
         _bg = null;
         _list = null;
         _rightView = null;
         _selectedValue = null;
         _dataList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
