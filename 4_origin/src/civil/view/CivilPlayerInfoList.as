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
      
      public function MemberList(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         clearList();
         if(!param1 || param1.length == 0)
         {
            return;
         }
         var _loc3_:int = param1.length > 9?9:param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new CivilPlayerItemFrame(_loc4_);
            _loc2_.info = param1[_loc4_];
            _loc2_.addEventListener("click",__onItemClick);
            _list.addChild(_loc2_);
            _items.push(_loc2_);
            if(_loc4_ == 0)
            {
               selectedItem = _loc2_;
            }
            _loc4_++;
         }
      }
      
      public function clearList() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].removeEventListener("click",__onItemClick);
            ObjectUtils.disposeObject(_items[_loc1_]);
            _items[_loc1_] = null;
            _loc1_++;
         }
         _items = new Vector.<CivilPlayerItemFrame>();
         _selectedItem = null;
         _currentItem = null;
         _infoItems = [];
      }
      
      public function upItem(param1:CivilPlayerInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _items.length)
         {
            _loc2_ = _items[_loc3_] as CivilPlayerItemFrame;
            if(_loc2_.info.info.ID == param1.info.ID)
            {
               _loc2_.info = param1;
               break;
            }
            _loc3_++;
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
      
      private function __civilListHandle(param1:CivilEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         if(_model.civilPlayers == null)
         {
            return;
         }
         clearList();
         var _loc4_:Array = _model.civilPlayers;
         var _loc3_:int = _loc4_.length > 9?9:_loc4_.length;
         if(_loc3_ <= 0)
         {
            selectedItem = null;
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc2_ = new CivilPlayerItemFrame(_loc5_);
               _loc2_.info = _loc4_[_loc5_];
               _list.addChild(_loc2_);
               _items.push(_loc2_);
               if(_loc5_ == 0)
               {
                  selectedItem = _loc2_;
               }
               _loc2_.addEventListener("click",__onItemClick);
               _loc5_++;
            }
         }
      }
      
      private function __onItemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:CivilPlayerItemFrame = param1.currentTarget as CivilPlayerItemFrame;
         if(!_loc2_.selected)
         {
            selectedItem = _loc2_;
         }
      }
      
      public function get selectedItem() : CivilPlayerItemFrame
      {
         return _selectedItem;
      }
      
      public function set selectedItem(param1:CivilPlayerItemFrame) : void
      {
         var _loc2_:* = null;
         if(_selectedItem != param1)
         {
            _loc2_ = _selectedItem;
            _selectedItem = param1;
            if(_selectedItem)
            {
               _selectedItem.selected = true;
               _model.currentcivilItemInfo = _selectedItem.info;
            }
            else
            {
               _model.currentcivilItemInfo = null;
            }
            if(_loc2_)
            {
               _loc2_.selected = false;
            }
            dispatchEvent(new CivilEvent("selected_change",param1));
         }
      }
      
      public function get model() : CivilModel
      {
         return _model;
      }
      
      public function set model(param1:CivilModel) : void
      {
         if(_model != param1)
         {
            if(_model)
            {
               _model.removeEventListener("civilplayerinfoarraychange",__civilListHandle);
            }
            _model = param1;
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
