package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestCategory;
   import ddt.events.TaskEvent;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestCateView extends Sprite implements Disposeable
   {
      
      public static var TITLECLICKED:String = "titleClicked";
      
      public static var EXPANDED:String = "expanded";
      
      public static var COLLAPSED:String = "collapsed";
      
      public static const ENABLE_CHANGE:String = "enableChange";
       
      
      private const ITEM_HEIGHT:int = 38;
      
      private const LIST_SPACE:int = 0;
      
      private const LIST_PADDING:int = 10;
      
      private var _data:QuestCategory;
      
      private var _titleView:QuestCateTitleView;
      
      private var _listView:ScrollPanel;
      
      private var _itemList:VBox;
      
      private var _itemArr:Array;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _isExpanded:Boolean;
      
      public var questType:int;
      
      public function QuestCateView(param1:int = -1, param2:ScrollPanel = null)
      {
         super();
         _itemArr = [];
         questType = param1;
         _scrollPanel = param2;
         initView();
         initEvent();
         collapse();
      }
      
      override public function get height() : Number
      {
         if(_isExpanded)
         {
            return 210;
         }
         return 57;
      }
      
      public function get contentHeight() : int
      {
         var _loc1_:int = _titleView.height;
         if(!_isExpanded)
         {
            return _loc1_;
         }
         if(_data.list.length <= QuestCateListView.MAX_LIST_LENGTH)
         {
            return _loc1_ + QuestCateListView.MAX_LIST_LENGTH * 38;
         }
         return _loc1_ + _listView.height;
      }
      
      public function get length() : int
      {
         if(data && data.list)
         {
            return data.list.length;
         }
         return 0;
      }
      
      public function get data() : QuestCategory
      {
         return _data;
      }
      
      private function initView() : void
      {
         _titleView = new QuestCateTitleView(questType);
         _titleView.x = 0;
         _titleView.y = 0;
         addChild(_titleView);
         _itemList = new VBox();
         _itemList.spacing = 0;
         _listView = ComponentFactory.Instance.creat("core.quest.QuestItemList");
         _listView.setView(_itemList);
         _listView.vScrollProxy = 1;
         _listView.hScrollProxy = 2;
         addChild(_listView);
         updateData();
      }
      
      public function set taskStyle(param1:int) : void
      {
         var _loc2_:int = 0;
         _titleView.taskStyle = param1;
         _loc2_ = 0;
         while(_loc2_ < _itemArr.length)
         {
            (_itemArr[_loc2_] as TaskPannelStripView).taskStyle = param1;
            _loc2_++;
         }
      }
      
      override public function set y(param1:Number) : void
      {
         .super.y = param1;
      }
      
      private function initEvent() : void
      {
         _titleView.addEventListener("click",__onTitleClicked);
         _listView.addEventListener("change",__onListChange);
         TaskManager.instance.addEventListener("changed",__onQuestData);
      }
      
      private function removeEvent() : void
      {
         _titleView.removeEventListener("click",__onTitleClicked);
         _listView.removeEventListener("change",__onListChange);
         TaskManager.instance.removeEventListener("changed",__onQuestData);
      }
      
      public function initData() : void
      {
         updateData();
      }
      
      public function active() : Boolean
      {
         if(_data.list.length == 0)
         {
            return false;
         }
         TaskManager.instance.currentCategory = questType;
         updateView();
         expand();
         dispatchEvent(new Event(TITLECLICKED));
         return true;
      }
      
      private function __onQuestData(param1:TaskEvent) : void
      {
         if(!TaskControl.instance.MainFrame)
         {
            return;
         }
         updateData();
         if(isExpanded)
         {
            dispatchEvent(new Event(TITLECLICKED));
         }
      }
      
      private function __onTitleClicked(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         TaskControl.instance.MainFrame.currentNewCateView = null;
         if(!_isExpanded)
         {
            active();
         }
      }
      
      private function __onListChange(param1:Event) : void
      {
         updateView();
      }
      
      public function set dataProvider(param1:Array) : void
      {
      }
      
      private function updateView() : void
      {
         updateTitleView();
         dispatchEvent(new Event("change"));
      }
      
      public function get isExpanded() : Boolean
      {
         return _isExpanded;
      }
      
      public function collapse() : void
      {
         if(_isExpanded == false)
         {
            return;
         }
         _isExpanded = false;
         _titleView.isExpanded = _isExpanded;
         _listView.visible = false;
         if(_listView.parent == this)
         {
            removeChild(_listView);
         }
         updateTitleView();
         dispatchEvent(new Event(COLLAPSED));
      }
      
      public function expand() : void
      {
         _isExpanded = true;
         updateData();
         _titleView.isExpanded = _isExpanded;
         _listView.visible = true;
         addChild(_listView);
         var _loc3_:int = 0;
         var _loc2_:* = _itemArr;
         for each(var _loc1_ in _itemArr)
         {
            _loc1_.onShow();
         }
         updateTitleView();
         dispatchEvent(new Event(EXPANDED));
      }
      
      private function set enable(param1:Boolean) : void
      {
         if(param1)
         {
            _titleView.enable = true;
         }
         else
         {
            _titleView.haveNoTag();
            _titleView.enable = false;
            collapse();
         }
         if(visible != param1)
         {
            visible = param1;
            dispatchEvent(new Event("enableChange"));
         }
      }
      
      private function updateData() : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:* = 0;
         var _loc3_:* = null;
         _data = TaskManager.instance.getAvailableQuests(questType);
         if(_data.list.length == 0 || questType == 4)
         {
            enable = false;
            return;
         }
         enable = true;
         updateTitleView();
         if(!isExpanded)
         {
            return;
         }
         if(_data.list.length > QuestCateListView.MAX_LIST_LENGTH)
         {
            _loc4_ = true;
         }
         var _loc7_:int = 0;
         var _loc6_:* = _itemArr;
         for each(var _loc2_ in _itemArr)
         {
            _loc2_.dispose();
         }
         _itemList.disposeAllChildren();
         _itemArr = [];
         var _loc1_:Boolean = false;
         _loc5_ = uint(0);
         while(_loc5_ < _data.list.length)
         {
            _loc3_ = new TaskPannelStripView(_data.list[_loc5_]);
            _loc3_.addEventListener("changed",__onItemActived);
            if(_loc4_)
            {
               _loc3_.x = 3;
            }
            else
            {
               _loc3_.x = 10;
            }
            if(TaskManager.instance.selectedQuest)
            {
               if(_loc3_.info.id == 363 || _loc3_.info.id == TaskManager.instance.selectedQuest.id)
               {
                  _loc3_.active();
                  _loc1_ = true;
               }
            }
            _itemArr.push(_loc3_);
            _itemList.addChild(_loc3_);
            _loc5_++;
         }
         if(!_loc1_)
         {
            (_itemArr[0] as TaskPannelStripView).active();
         }
         _listView.invalidateViewport();
      }
      
      private function __onItemActived(param1:TaskEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.numChildren)
         {
            if((_itemList.getChildAt(_loc2_) as TaskPannelStripView).info != param1.info)
            {
               (_itemList.getChildAt(_loc2_) as TaskPannelStripView).status = "normal";
            }
            (_itemList.getChildAt(_loc2_) as TaskPannelStripView).update();
            _loc2_++;
         }
      }
      
      private function updateTitleView() : void
      {
         if(_isExpanded)
         {
            _titleView.haveNoTag();
            return;
         }
         if(_data.haveCompleted)
         {
            _titleView.haveCompleted();
         }
         else if(_data.haveRecommend)
         {
            _titleView.haveRecommond();
         }
         else if(_data.haveNew)
         {
            _titleView.haveNew();
         }
         else
         {
            _titleView.haveNoTag();
         }
         if(!_isExpanded)
         {
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         removeEvent();
         _data = null;
         if(_titleView)
         {
            ObjectUtils.disposeObject(_titleView);
         }
         _titleView = null;
         if(_itemList)
         {
            _itemList.disposeAllChildren();
            ObjectUtils.disposeObject(_itemList);
            _itemList = null;
         }
         if(_listView)
         {
            ObjectUtils.disposeObject(_listView);
         }
         _listView = null;
         while(true)
         {
            _loc1_ = _itemArr.pop();
            if(!_itemArr.pop())
            {
               break;
            }
            if(_loc1_)
            {
               _loc1_.removeEventListener("changed",__onItemActived);
               _loc1_.dispose();
            }
            _loc1_ = null;
         }
         _itemArr = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get itemArr() : Array
      {
         return _itemArr;
      }
   }
}
