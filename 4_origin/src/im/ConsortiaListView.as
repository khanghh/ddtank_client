package im
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import ddt.data.player.ConsortiaPlayerInfo;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   
   public class ConsortiaListView extends Sprite implements Disposeable
   {
       
      
      private var _list:ListPanel;
      
      private var _consortiaPlayerArray:Array;
      
      private var _consortiaInfoArray:Array;
      
      private var _currentItem:ConsortiaPlayerInfo;
      
      private var _currentTitle:ConsortiaPlayerInfo;
      
      private var _pos:int;
      
      public function ConsortiaListView()
      {
         super();
         init();
      }
      
      public function get consortiaInfoArray() : Array
      {
         return _consortiaInfoArray;
      }
      
      private function init() : void
      {
         _list = ComponentFactory.Instance.creat("IM.ConsortiaListPanel");
         _list.vScrollProxy = 1;
         addChild(_list);
         _list.list.updateListView();
         _list.list.addEventListener("listItemClick",__itemClick);
         update();
         ConsortionModelManager.Instance.model.addEventListener("addMember",__updateList);
         ConsortionModelManager.Instance.model.addEventListener("removeMember",__updateList);
         ConsortionModelManager.Instance.model.addEventListener("memberUpdata",__updateList);
      }
      
      private function __updateList(event:ConsortionEvent) : void
      {
         _pos = _list.list.viewPosition.y;
         update();
         var intPoint:IntPoint = new IntPoint(0,_pos);
         _list.list.viewPosition = intPoint;
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         if((event.cellValue as ConsortiaPlayerInfo).type == 1)
         {
            if(!_currentItem)
            {
               _currentItem = event.cellValue as ConsortiaPlayerInfo;
               _currentItem.isSelected = true;
            }
            else if(_currentItem != event.cellValue as ConsortiaPlayerInfo)
            {
               _currentItem.isSelected = false;
               _currentItem = event.cellValue as ConsortiaPlayerInfo;
               _currentItem.isSelected = true;
            }
         }
         else
         {
            if(!_currentTitle)
            {
               _currentTitle = event.cellValue as ConsortiaPlayerInfo;
               _currentTitle.isSelected = true;
            }
            if(_currentTitle != event.cellValue as ConsortiaPlayerInfo)
            {
               _currentTitle.isSelected = false;
               _currentTitle = event.cellValue as ConsortiaPlayerInfo;
               _currentTitle.isSelected = true;
            }
            else
            {
               _currentTitle.isSelected = !_currentTitle.isSelected;
            }
            updateList();
            SoundManager.instance.play("008");
         }
         _list.list.updateListView();
      }
      
      private function updateList() : void
      {
         var intPoint:* = null;
         _pos = _list.list.viewPosition.y;
         if(_currentTitle.type == 0 && _currentTitle.isSelected)
         {
            update();
            intPoint = new IntPoint(0,_pos);
            _list.list.viewPosition = intPoint;
         }
         else if(!_currentTitle.isSelected)
         {
            _list.vectorListModel.clear();
            _list.vectorListModel.appendAll(_consortiaInfoArray);
            _list.list.updateListView();
         }
      }
      
      private function update() : void
      {
         var i:int = 0;
         var info:* = null;
         _consortiaPlayerArray = [];
         _consortiaPlayerArray = ConsortionModelManager.Instance.model.onlineConsortiaMemberList;
         if(!_consortiaInfoArray || _consortiaInfoArray.length == 0)
         {
            _consortiaInfoArray = ConsortionModelManager.Instance.model.consortiaInfo;
         }
         var tempArr:Array = [];
         var tempArr1:Array = [];
         for(i = 0; i < _consortiaPlayerArray.length; )
         {
            info = _consortiaPlayerArray[i] as ConsortiaPlayerInfo;
            if(info.IsVIP)
            {
               tempArr.push(info);
            }
            else
            {
               tempArr1.push(info);
            }
            i++;
         }
         tempArr = tempArr.sortOn("Grade",16 | 2);
         tempArr1 = tempArr1.sortOn("Grade",16 | 2);
         _consortiaPlayerArray = tempArr.concat(tempArr1);
         var tempArray:Array = ConsortionModelManager.Instance.model.offlineConsortiaMemberList;
         tempArray = tempArray.sortOn("Grade",16 | 2);
         _consortiaPlayerArray = _consortiaPlayerArray.concat(tempArray);
         _consortiaPlayerArray = _consortiaInfoArray.concat(_consortiaPlayerArray);
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_consortiaPlayerArray);
         _list.list.updateListView();
      }
      
      public function dispose() : void
      {
         ConsortionModelManager.Instance.model.removeEventListener("addMember",__updateList);
         ConsortionModelManager.Instance.model.removeEventListener("removeMember",__updateList);
         ConsortionModelManager.Instance.model.removeEventListener("memberUpdata",__updateList);
         if(_list && _list.parent)
         {
            _list.parent.removeChild(_list);
            _list.dispose();
            _list = null;
         }
         if(_currentItem)
         {
            _currentItem.isSelected = false;
         }
         if(_currentTitle)
         {
            _currentTitle.isSelected = false;
         }
      }
   }
}
