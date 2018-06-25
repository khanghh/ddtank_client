package civil.view
{
   import civil.CivilEvent;
   import civil.CivilModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CivilPlayerInfoList extends Sprite implements Disposeable
   {
      
      private static const MAXITEM:int = 9;
       
      
      private var _currentItem:CivilPlayerItemFrame;
      
      private var _items:Vector.<CivilPlayerItemFrame>;
      
      private var _infoItems:Array;
      
      private var _list:VBox;
      
      private var _model:CivilModel;
      
      private var _selectedItem:CivilPlayerItemFrame;
      
      public function CivilPlayerInfoList()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _infoItems = [];
         _list = ComponentFactory.Instance.creatComponentByStylename("civil.memberList");
         addChild(_list);
         _items = new Vector.<CivilPlayerItemFrame>();
      }
      
      public function MemberList($list:Array) : void
      {
         var i:int = 0;
         var item:* = null;
         clearList();
         if(!$list || $list.length == 0)
         {
            return;
         }
         var length:int = $list.length > 9?9:$list.length;
         for(i = 0; i < length; )
         {
            item = new CivilPlayerItemFrame(i);
            item.info = $list[i];
            item.addEventListener("click",__onItemClick);
            _list.addChild(item);
            _items.push(item);
            if(i == 0)
            {
               selectedItem = item;
            }
            i++;
         }
      }
      
      public function clearList() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            _items[i].removeEventListener("click",__onItemClick);
            ObjectUtils.disposeObject(_items[i]);
            _items[i] = null;
            i++;
         }
         _items = new Vector.<CivilPlayerItemFrame>();
         _selectedItem = null;
         _currentItem = null;
         _infoItems = [];
      }
      
      public function upItem($info:CivilPlayerInfo) : void
      {
         var i:int = 0;
         var item:* = null;
         for(i = 0; i < _items.length; )
         {
            item = _items[i] as CivilPlayerItemFrame;
            if(item.info.info.ID == $info.info.ID)
            {
               item.info = $info;
               break;
            }
            i++;
         }
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            if(_model.hasEventListener("civilplayerinfoarraychange"))
            {
               _model.removeEventListener("civilplayerinfoarraychange",__civilListHandle);
            }
         }
      }
      
      private function __civilListHandle(e:CivilEvent) : void
      {
         var i:int = 0;
         var item:* = null;
         if(_model.civilPlayers == null)
         {
            return;
         }
         clearList();
         var data:Array = _model.civilPlayers;
         var length:int = data.length > 9?9:data.length;
         if(length <= 0)
         {
            selectedItem = null;
         }
         else
         {
            i = 0;
            while(i < length)
            {
               item = new CivilPlayerItemFrame(i);
               item.info = data[i];
               _list.addChild(item);
               _items.push(item);
               if(i == 0)
               {
                  selectedItem = item;
               }
               item.addEventListener("click",__onItemClick);
               i++;
            }
         }
      }
      
      private function __onItemClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var item:CivilPlayerItemFrame = evt.currentTarget as CivilPlayerItemFrame;
         if(!item.selected)
         {
            selectedItem = item;
         }
      }
      
      public function get selectedItem() : CivilPlayerItemFrame
      {
         return _selectedItem;
      }
      
      public function set selectedItem(val:CivilPlayerItemFrame) : void
      {
         var item:* = null;
         if(_selectedItem != val)
         {
            item = _selectedItem;
            _selectedItem = val;
            if(_selectedItem)
            {
               _selectedItem.selected = true;
               _model.currentcivilItemInfo = _selectedItem.info;
            }
            else
            {
               _model.currentcivilItemInfo = null;
            }
            if(item)
            {
               item.selected = false;
            }
            dispatchEvent(new CivilEvent("selected_change",val));
         }
      }
      
      public function get model() : CivilModel
      {
         return _model;
      }
      
      public function set model(val:CivilModel) : void
      {
         if(_model != val)
         {
            if(_model)
            {
               _model.removeEventListener("civilplayerinfoarraychange",__civilListHandle);
            }
            _model = val;
            if(_model)
            {
               _model.addEventListener("civilplayerinfoarraychange",__civilListHandle);
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearList();
         if(_list)
         {
            _list.dispose();
            _list = null;
         }
         if(_currentItem)
         {
            _currentItem.dispose();
         }
         _currentItem = null;
         model = null;
         _infoItems = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
