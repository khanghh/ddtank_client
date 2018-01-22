package oldPlayerRegress.view
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.quest.QuestCategory;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import oldPlayerRegress.view.itemView.TaskItemView;
   import oldPlayerRegress.view.itemView.WelcomeView;
   import oldPlayerRegress.view.itemView.call.CallView;
   import oldPlayerRegress.view.itemView.packs.PacksView;
   import oldPlayerRegress.view.itemView.task.RegressTaskView;
   import quest.QuestInfoPanelView;
   import quest.TaskManager;
   
   public class RegressMenuView extends Frame
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
       
      
      private const LIST_SPACE:int = -5;
      
      private const TASK_TYPE:int = 4;
      
      private var _bgArray:Array;
      
      private var _menuItemBgSelect:ScaleFrameImage;
      
      private var _textArray:Array;
      
      private var _textNameArray:Array;
      
      private var _btnArray:Array;
      
      private var _viewArray:Array;
      
      private var _taskInfoView:QuestInfoPanelView;
      
      private var _itemList:VBox;
      
      private var _listView:ScrollPanel;
      
      private var _taskData:QuestCategory;
      
      private var _expandBg:DisplayObject;
      
      private var _taskMenuItem:Vector.<TaskItemView>;
      
      public function RegressMenuView()
      {
         super();
         loadTaskUI();
      }
      
      private function loadTaskUI() : void
      {
         if(loadComplete)
         {
            _init();
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onTaskLoadProgress);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onTaskLoadComplete);
            UIModuleLoader.Instance.addUIModuleImp("quest");
         }
      }
      
      private function __onTaskLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "quest")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onTaskLoadProgress);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onTaskLoadComplete);
         UIModuleSmallLoading.Instance.hide();
      }
      
      private function __onTaskLoadComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "quest")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onTaskLoadComplete);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onTaskLoadProgress);
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            useFirst = false;
            _init();
         }
      }
      
      private function _init() : void
      {
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _bgArray = new Array(new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage());
         _textArray = new Array(new FilterFrameText(),new FilterFrameText(),new FilterFrameText(),new FilterFrameText());
         _textNameArray = new Array("ddt.regress.menuView.Welcome","ddt.regress.menuView.Packs","ddt.regress.menuView.Call","ddt.regress.menuView.Task");
         _btnArray = new Array(new BaseButton(),new BaseButton(),new BaseButton(),new BaseButton());
         _viewArray = new Array(new WelcomeView(),new PacksView(),new CallView(),new RegressTaskView());
         _taskData = TaskManager.instance.getAvailableQuests(4);
         _taskMenuItem = new Vector.<TaskItemView>();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         setItemView(_bgArray,"regress.ActivityCellBgUnSelected");
         _menuItemBgSelect = ComponentFactory.Instance.creatComponentByStylename("regress.ActivityCellBgSelected");
         addChild(_menuItemBgSelect);
         _loc1_ = 0;
         while(_loc1_ < _textArray.length)
         {
            _textArray[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("regress.view.menuItemName.Text");
            _textArray[_loc1_].text = LanguageMgr.GetTranslation(_textNameArray[_loc1_]);
            if(_loc1_ > 0)
            {
               _textArray[_loc1_].y = _textArray[_loc1_ - 1].y + _textArray[_loc1_].height + 7;
            }
            addChild(_textArray[_loc1_]);
            _loc1_++;
         }
         setItemView(_btnArray,"regress.button");
         if(_taskData.list.length > 0)
         {
            addTaskListView();
         }
         else
         {
            _bgArray[3].visible = false;
            _btnArray[3].visible = false;
            _textArray[3].visible = false;
         }
         _taskInfoView = new QuestInfoPanelView();
         PositionUtils.setPos(_taskInfoView,"regress.task.view.pos");
         addChild(_taskInfoView);
         _loc2_ = 0;
         while(_loc2_ < _viewArray.length)
         {
            addChild(_viewArray[_loc2_]);
            if(_loc2_ > 0)
            {
               _viewArray[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      private function addTaskListView() : void
      {
         _expandBg = ComponentFactory.Instance.creatCustomObject("regress.taskExpandBg");
         addChild(_expandBg);
         _itemList = new VBox();
         _itemList.spacing = -5;
         _listView = ComponentFactory.Instance.creat("regress.taskItemList");
         _listView.setView(_itemList);
         _listView.vScrollProxy = 1;
         _listView.hScrollProxy = 2;
         addChild(_listView);
         addListItem();
      }
      
      private function addListItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _taskData.list.length)
         {
            _loc1_ = new TaskItemView(taskMenuItemClick);
            _loc1_.titleField.text = _taskData.list[_loc2_].Title;
            _loc1_.clickID = _loc2_;
            if(_taskData.list[_loc2_].isCompleted)
            {
               _loc1_.bmpOK.visible = true;
            }
            _loc1_.width = _loc1_.displayWidth;
            _loc1_.height = _loc1_.displayHeight;
            _itemList.addChild(_loc1_);
            _taskMenuItem.push(_loc1_);
            _loc2_++;
         }
         _itemList.arrange();
         _listView.invalidateViewport();
      }
      
      protected function __onUpdateTaskMenuItem(param1:Event) : void
      {
         var _loc2_:int = 0;
         _taskData = TaskManager.instance.getAvailableQuests(4);
         _loc2_ = 0;
         while(_loc2_ < _taskMenuItem.length)
         {
            _itemList.removeChild(_taskMenuItem[_loc2_]);
            _loc2_++;
         }
         _taskMenuItem.length = 0;
         if(_taskData.list.length > 0)
         {
            addListItem();
            taskMenuItemClick(0);
         }
         else
         {
            _expandBg.visible = false;
            _listView.visible = false;
            _bgArray[3].visible = false;
            _btnArray[3].visible = false;
            _textArray[3].visible = false;
            menuItemClick(0);
         }
      }
      
      private function taskMenuItemClick(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         _menuItemBgSelect.y = _btnArray[3].y - 2;
         setViewVisible();
         setTaskMenuBgFrame();
         if(_taskMenuItem.length == 0)
         {
            return;
         }
         _taskMenuItem[param1].itemBg.setFrame(2);
         _taskInfoView.visible = true;
         _taskInfoView.regressFlag = true;
         _taskInfoView.info = _taskData.list[param1];
         _viewArray[3].visible = true;
         _viewArray[3].taskInfo = _taskData.list[param1];
         _viewArray[3].show();
      }
      
      private function setTaskMenuBgFrame() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _taskMenuItem.length)
         {
            _taskMenuItem[_loc1_].itemBg.setFrame(1);
            _loc1_++;
         }
      }
      
      private function setItemView(param1:Array, param2:String) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            param1[_loc3_] = ComponentFactory.Instance.creatComponentByStylename(param2);
            if(_loc3_ > 0)
            {
               param1[_loc3_].y = param1[_loc3_ - 1].y + param1[_loc3_].height + 4;
            }
            addChild(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _btnArray.length)
         {
            _btnArray[_loc1_].addEventListener("click",__onMenuItemClick);
            _loc1_++;
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(178),TaskManager.instance.__updateAcceptedTask);
         TaskManager.instance.addEventListener("update_taskMenuItem",__onUpdateTaskMenuItem);
      }
      
      private function __onMenuItemClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _btnArray.length)
         {
            if(_btnArray[_loc2_] == param1.currentTarget)
            {
               SoundManager.instance.playButtonSound();
               menuItemClick(_loc2_);
               break;
            }
            _loc2_++;
         }
      }
      
      private function menuItemClick(param1:int) : void
      {
         _menuItemBgSelect.y = _btnArray[param1].y - 2;
         setViewVisible();
         _taskInfoView.visible = false;
         param1 == 3?taskMenuItemClick(0):_viewArray[param1].show();
      }
      
      private function setViewVisible() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _viewArray.length)
         {
            _viewArray[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _btnArray.length)
         {
            _btnArray[_loc1_].removeEventListener("click",__onMenuItemClick);
            _loc1_++;
         }
         TaskManager.instance.removeEventListener("update_taskMenuItem",__onUpdateTaskMenuItem);
      }
      
      private function removeArray(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_])
            {
               param1[_loc2_].dispose();
               param1[_loc2_] = null;
            }
            _loc2_++;
         }
         param1.length = 0;
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.dispose();
         removeEvent();
         removeArray(_bgArray);
         removeArray(_textArray);
         removeArray(_btnArray);
         removeArray(_viewArray);
         _loc2_ = 0;
         while(_loc2_ < _taskMenuItem.length)
         {
            if(_taskMenuItem[_loc2_])
            {
               _taskMenuItem[_loc2_].dispose();
               _taskMenuItem[_loc2_] = null;
            }
            _loc2_++;
         }
         _taskMenuItem.length = 0;
         if(_menuItemBgSelect)
         {
            _menuItemBgSelect.dispose();
            _menuItemBgSelect = null;
         }
         if(_taskInfoView)
         {
            _taskInfoView.dispose();
            _taskInfoView = null;
         }
         _loc1_ = 0;
         while(_loc1_ < _textNameArray.length)
         {
            _textNameArray[_loc1_] = null;
            _loc1_++;
         }
         _textNameArray.length = 0;
         if(_itemList)
         {
            _itemList.dispose();
            _itemList = null;
         }
         if(_listView)
         {
            _listView.dispose();
            _listView = null;
         }
         if(_taskData)
         {
            _taskData = null;
         }
         if(_expandBg)
         {
            _expandBg = null;
         }
      }
   }
}
