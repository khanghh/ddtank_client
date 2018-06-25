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
      
      public function AvatarCollectionUnitView(index:int, rightView:AvatarCollectionRightView)
      {
         super();
         _index = index;
         _rightView = rightView;
         initView();
         initEvent();
         initData();
         initStatus();
      }
      
      public function set isBuyFilter(value:Boolean) : void
      {
         _isBuyFilter = value;
         if(_isBuyFilter)
         {
            _isFilter = false;
         }
         refreshList();
      }
      
      public function set isFilter(value:Boolean) : void
      {
         _isFilter = value;
         if(_isFilter)
         {
            _isBuyFilter = false;
         }
         refreshList();
      }
      
      private function initStatus() : void
      {
         var i:int = 0;
         if(AvatarCollectionManager.instance.isSkipFromHall)
         {
            for(i = 0; i < _dataList.length; )
            {
               if((_dataList[i] as AvatarCollectionUnitVo).id == AvatarCollectionManager.instance.skipId)
               {
                  extendSelecteTheFirst();
                  break;
               }
               i++;
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
      
      private function toDoRefresh(event:Event) : void
      {
         refreshList();
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedValue = event.cellValue as AvatarCollectionUnitVo;
         if(_rightView)
         {
            _rightView.refreshView(_selectedValue);
         }
      }
      
      private function clickHandler(event:MouseEvent) : void
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
         var i:int = 0;
         var tmpSelectedIndex:int = 0;
         var intPoint:* = null;
         var _model:IListModel = _list.list.model;
         var len:int = _model.getSize();
         if(len > 0)
         {
            if(!_selectedValue)
            {
               if(AvatarCollectionManager.instance.isSkipFromHall)
               {
                  for(i = 0; i < len; )
                  {
                     if((_model.getElementAt(i) as AvatarCollectionUnitVo).id == AvatarCollectionManager.instance.skipId)
                     {
                        _selectedValue = _model.getElementAt(i);
                        AvatarCollectionManager.instance.isSkipFromHall = false;
                        break;
                     }
                     i++;
                  }
               }
               else
               {
                  _selectedValue = _model.getElementAt(0) as AvatarCollectionUnitVo;
               }
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
         var len:int = 0;
         var i:int = 0;
         var len2:int = 0;
         var k:int = 0;
         var tmpArray:Array = [];
         if(_isFilter)
         {
            len = _dataList.length;
            for(i = 0; i < len; )
            {
               if((_dataList[i] as AvatarCollectionUnitVo).canActivityCount > 0)
               {
                  tmpArray.push(_dataList[i]);
               }
               i++;
            }
         }
         else if(_isBuyFilter)
         {
            len2 = _dataList.length;
            for(k = 0; k < len2; )
            {
               if((_dataList[k] as AvatarCollectionUnitVo).canBuyCount > 0)
               {
                  tmpArray.push(_dataList[k]);
               }
               k++;
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
      
      private function getDataList() : Array
      {
         var tmp:* = null;
         switch(int(_index) - 1)
         {
            case 0:
               tmp = AvatarCollectionManager.instance.maleUnitList;
               break;
            case 1:
               tmp = AvatarCollectionManager.instance.femaleUnitList;
               break;
            case 2:
               tmp = AvatarCollectionManager.instance.weaponUnitList;
         }
         return !!tmp?tmp:[];
      }
      
      private function getSelectedBtn() : SelectedButton
      {
         var tmp:* = null;
         switch(int(_index) - 1)
         {
            case 0:
               tmp = ComponentFactory.Instance.creatComponentByStylename("avatarColl.maleBtn");
               break;
            case 1:
               tmp = ComponentFactory.Instance.creatComponentByStylename("avatarColl.femaleBtn");
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
