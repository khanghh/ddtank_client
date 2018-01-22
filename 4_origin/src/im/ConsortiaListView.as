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
      
      private function __updateList(param1:ConsortionEvent) : void
      {
         _pos = _list.list.viewPosition.y;
         update();
         var _loc2_:IntPoint = new IntPoint(0,_pos);
         _list.list.viewPosition = _loc2_;
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         if((param1.cellValue as ConsortiaPlayerInfo).type == 1)
         {
            if(!_currentItem)
            {
               _currentItem = param1.cellValue as ConsortiaPlayerInfo;
               _currentItem.isSelected = true;
            }
            else if(_currentItem != param1.cellValue as ConsortiaPlayerInfo)
            {
               _currentItem.isSelected = false;
               _currentItem = param1.cellValue as ConsortiaPlayerInfo;
               _currentItem.isSelected = true;
            }
         }
         else
         {
            if(!_currentTitle)
            {
               _currentTitle = param1.cellValue as ConsortiaPlayerInfo;
               _currentTitle.isSelected = true;
            }
            if(_currentTitle != param1.cellValue as ConsortiaPlayerInfo)
            {
               _currentTitle.isSelected = false;
               _currentTitle = param1.cellValue as ConsortiaPlayerInfo;
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
         var _loc1_:* = null;
         _pos = _list.list.viewPosition.y;
         if(_currentTitle.type == 0 && _currentTitle.isSelected)
         {
            update();
            _loc1_ = new IntPoint(0,_pos);
            _list.list.viewPosition = _loc1_;
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
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _consortiaPlayerArray = [];
         _consortiaPlayerArray = ConsortionModelManager.Instance.model.onlineConsortiaMemberList;
         if(!_consortiaInfoArray || _consortiaInfoArray.length == 0)
         {
            _consortiaInfoArray = ConsortionModelManager.Instance.model.consortiaInfo;
         }
         var _loc3_:Array = [];
         var _loc1_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _consortiaPlayerArray.length)
         {
            _loc4_ = _consortiaPlayerArray[_loc5_] as ConsortiaPlayerInfo;
            if(_loc4_.IsVIP)
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc1_.push(_loc4_);
            }
            _loc5_++;
         }
         _loc3_ = _loc3_.sortOn("Grade",16 | 2);
         _loc1_ = _loc1_.sortOn("Grade",16 | 2);
         _consortiaPlayerArray = _loc3_.concat(_loc1_);
         var _loc2_:Array = ConsortionModelManager.Instance.model.offlineConsortiaMemberList;
         _loc2_ = _loc2_.sortOn("Grade",16 | 2);
         _consortiaPlayerArray = _consortiaPlayerArray.concat(_loc2_);
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
