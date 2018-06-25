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
      
      public function QuestCateView(cateID:int = -1, scrollPanel:ScrollPanel = null)
      {
         super();
         _itemArr = [];
         questType = cateID;
         _scrollPanel = scrollPanel;
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
         var titleHeight:int = _titleView.height;
         if(!_isExpanded)
         {
            return titleHeight;
         }
         if(_data.list.length <= QuestCateListView.MAX_LIST_LENGTH)
         {
            return titleHeight + QuestCateListView.MAX_LIST_LENGTH * 38;
         }
         return titleHeight + _listView.height;
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
      
      public function set taskStyle(style:int) : void
      {
         var i:int = 0;
         _titleView.taskStyle = style;
         for(i = 0; i < _itemArr.length; )
         {
            (_itemArr[i] as TaskPannelStripView).taskStyle = style;
            i++;
         }
      }
      
      override public function set y(value:Number) : void
      {
         .super.y = value;
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
      
      private function __onQuestData(e:TaskEvent) : void
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
      
      private function __onTitleClicked(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         TaskControl.instance.MainFrame.currentNewCateView = null;
         if(!_isExpanded)
         {
            active();
         }
      }
      
      private function __onListChange(e:Event) : void
      {
         updateView();
      }
      
      public function set dataProvider(value:Array) : void
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
         for each(var item in _itemArr)
         {
            item.onShow();
         }
         updateTitleView();
         dispatchEvent(new Event(EXPANDED));
      }
      
      private function set enable(value:Boolean) : void
      {
         if(value)
         {
            _titleView.enable = true;
         }
         else
         {
            _titleView.haveNoTag();
            _titleView.enable = false;
            collapse();
         }
         if(visible != value)
         {
            visible = value;
            dispatchEvent(new Event("enableChange"));
         }
      }
      
      private function updateData() : void
      {
         var needScrollBar:Boolean = false;
         var i:* = 0;
         var questItem:* = null;
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
            needScrollBar = true;
         }
         var _loc7_:int = 0;
         var _loc6_:* = _itemArr;
         for each(var item in _itemArr)
         {
            item.dispose();
         }
         _itemList.disposeAllChildren();
         _itemArr = [];
         var actived:Boolean = false;
         for(i = uint(0); i < _data.list.length; )
         {
            questItem = new TaskPannelStripView(_data.list[i]);
            questItem.addEventListener("changed",__onItemActived);
            if(needScrollBar)
            {
               questItem.x = 3;
            }
            else
            {
               questItem.x = 10;
            }
            if(TaskManager.instance.selectedQuest)
            {
               if(questItem.info.id == 363 || questItem.info.id == TaskManager.instance.selectedQuest.id)
               {
                  questItem.active();
                  actived = true;
               }
            }
            _itemArr.push(questItem);
            _itemList.addChild(questItem);
            i++;
         }
         if(!actived)
         {
            (_itemArr[0] as TaskPannelStripView).active();
         }
         _listView.invalidateViewport();
      }
      
      private function __onItemActived(e:TaskEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < _itemList.numChildren; )
         {
            if((_itemList.getChildAt(i) as TaskPannelStripView).info != e.info)
            {
               (_itemList.getChildAt(i) as TaskPannelStripView).status = "normal";
            }
            (_itemList.getChildAt(i) as TaskPannelStripView).update();
            i++;
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
         var item:* = null;
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
            item = _itemArr.pop();
            if(!_itemArr.pop())
            {
               break;
            }
            if(item)
            {
               item.removeEventListener("changed",__onItemActived);
               item.dispose();
            }
            item = null;
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
