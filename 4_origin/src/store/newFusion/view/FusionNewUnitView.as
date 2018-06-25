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
      
      public function FusionNewUnitView(index:int, rightView:FusionNewRightView)
      {
         super();
         _index = index;
         _rightView = rightView;
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
         var tmpSelectedIndex:int = 0;
         var intPoint:* = null;
         var _model:IListModel = _list.list.model;
         var len:int = _model.getSize();
         if(len > 0)
         {
            if(!_selectedValue)
            {
               _selectedValue = _model.getElementAt(0) as FusionNewVo;
            }
            tmpSelectedIndex = _model.indexOf(_selectedValue);
            intPoint = new IntPoint(0,_model.getCellPosFromIndex(tmpSelectedIndex));
            _list.list.viewPosition = intPoint;
            _list.list.currentSelectedIndex = tmpSelectedIndex;
         }
         else
         {
            _selectedValue = null;
         }
         _rightView.refreshView(_selectedValue);
      }
      
      public function set isFilter(value:Boolean) : void
      {
         _isFilter = value;
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
         var len:int = 0;
         var i:int = 0;
         var tmpArray:Array = [];
         if(_isFilter)
         {
            len = _dataList.length;
            for(i = 0; i < len; )
            {
               if((_dataList[i] as FusionNewVo).canFusionCount > 0)
               {
                  tmpArray.push(_dataList[i]);
               }
               i++;
            }
         }
         else
         {
            tmpArray = _dataList;
         }
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(tmpArray);
         _list.list.updateListView();
         if(_selectedValue && tmpArray.indexOf(_selectedValue) == -1)
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
      
      private function updateBag(evt:BagEvent) : void
      {
         refreshList();
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedValue = event.cellValue as FusionNewVo;
         if(_rightView)
         {
            _rightView.refreshView(_selectedValue);
         }
      }
      
      private function clickHandler(event:MouseEvent) : void
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
         var tmp:* = null;
         switch(int(_index) - 1)
         {
            case 0:
               tmp = FusionNewManager.instance.getDataListByType(1);
               break;
            case 1:
               tmp = FusionNewManager.instance.getDataListByType(2);
               break;
            case 2:
               tmp = FusionNewManager.instance.getDataListByType(3);
               break;
            case 3:
               tmp = FusionNewManager.instance.getDataListByType(4);
               break;
            case 4:
               tmp = FusionNewManager.instance.getDataListByType(5);
               break;
            case 5:
               tmp = FusionNewManager.instance.getDataListByType(6);
         }
         return !!tmp?tmp:[];
      }
      
      private function getSelectedBtn() : SelectedButton
      {
         var tmp:* = null;
         switch(int(_index) - 1)
         {
            case 0:
               tmp = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.weaponBtn");
               break;
            case 1:
               tmp = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.jewellryBtn");
               break;
            case 2:
               tmp = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.avatarBtn");
               break;
            case 3:
               tmp = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.drillBtn");
               break;
            case 4:
               tmp = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.combineBtn");
               break;
            case 5:
               tmp = ComponentFactory.Instance.creatComponentByStylename("store.newFusion.otherBtn");
         }
         return tmp;
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
