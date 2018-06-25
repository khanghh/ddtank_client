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
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import oldPlayerRegress.view.itemView.AreaView;
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
      
      private var _ind:int;
      
      public function RegressMenuView()
      {
         _ind = PathManager.OldPlayerTransferEnable == true?4:3;
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
      
      private function __onTaskLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "quest")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onTaskLoadProgress);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onTaskLoadComplete);
         UIModuleSmallLoading.Instance.hide();
      }
      
      private function __onTaskLoadComplete(event:UIModuleEvent) : void
      {
         if(event.module == "quest")
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
         if(PathManager.OldPlayerTransferEnable == true)
         {
            _bgArray = new Array(new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage());
            _textArray = new Array(new FilterFrameText(),new FilterFrameText(),new FilterFrameText(),new FilterFrameText(),new FilterFrameText());
            _textNameArray = new Array("ddt.regress.menuView.Welcome","ddt.regress.menuView.Packs","ddt.regress.menuView.Call","ddt.regress.menuView.Area","ddt.regress.menuView.Task");
            _btnArray = new Array(new BaseButton(),new BaseButton(),new BaseButton(),new BaseButton(),new BaseButton());
            _viewArray = new Array(new WelcomeView(),new PacksView(),new CallView(),new AreaView(),new RegressTaskView());
         }
         else
         {
            _bgArray = new Array(new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage(),new ScaleFrameImage());
            _textArray = new Array(new FilterFrameText(),new FilterFrameText(),new FilterFrameText(),new FilterFrameText());
            _textNameArray = new Array("ddt.regress.menuView.Welcome","ddt.regress.menuView.Packs","ddt.regress.menuView.Call","ddt.regress.menuView.Task");
            _btnArray = new Array(new BaseButton(),new BaseButton(),new BaseButton(),new BaseButton());
            _viewArray = new Array(new WelcomeView(),new PacksView(),new CallView(),new RegressTaskView());
         }
         _taskData = TaskManager.instance.getAvailableQuests(4);
         _taskMenuItem = new Vector.<TaskItemView>();
      }
      
      private function initView() : void
      {
         var j:int = 0;
         var k:int = 0;
         setItemView(_bgArray,"regress.ActivityCellBgUnSelected");
         _menuItemBgSelect = ComponentFactory.Instance.creatComponentByStylename("regress.ActivityCellBgSelected");
         addChild(_menuItemBgSelect);
         for(j = 0; j < _textArray.length; )
         {
            _textArray[j] = ComponentFactory.Instance.creatComponentByStylename("regress.view.menuItemName.Text");
            _textArray[j].text = LanguageMgr.GetTranslation(_textNameArray[j]);
            if(j > 0)
            {
               _textArray[j].y = _textArray[j - 1].y + _textArray[j].height + 7;
            }
            addChild(_textArray[j]);
            j++;
         }
         setItemView(_btnArray,"regress.button");
         if(_taskData.list.length > 0)
         {
            addTaskListView();
         }
         else
         {
            _bgArray[_ind].visible = false;
            _btnArray[_ind].visible = false;
            _textArray[_ind].visible = false;
         }
         _taskInfoView = new QuestInfoPanelView();
         PositionUtils.setPos(_taskInfoView,"regress.task.view.pos");
         addChild(_taskInfoView);
         for(k = 0; k < _viewArray.length; )
         {
            addChild(_viewArray[k]);
            if(k > 0)
            {
               _viewArray[k].visible = false;
            }
            k++;
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
         if(PathManager.OldPlayerTransferEnable == false)
         {
            PositionUtils.setPos(_listView,"regress.leftMenu.titleV.pos");
            PositionUtils.setPos(_expandBg,"regress.leftMenu.taskExpandBgV.pos");
         }
         addListItem();
      }
      
      private function addListItem() : void
      {
         var i:int = 0;
         var taskItem:* = null;
         for(i = 0; i < _taskData.list.length; )
         {
            taskItem = new TaskItemView(taskMenuItemClick);
            taskItem.titleField.text = _taskData.list[i].Title;
            taskItem.clickID = i;
            if(_taskData.list[i].isCompleted)
            {
               taskItem.bmpOK.visible = true;
            }
            taskItem.width = taskItem.displayWidth;
            taskItem.height = taskItem.displayHeight;
            _itemList.addChild(taskItem);
            _taskMenuItem.push(taskItem);
            i++;
         }
         _itemList.arrange();
         _listView.invalidateViewport();
      }
      
      protected function __onUpdateTaskMenuItem(event:Event) : void
      {
         var i:int = 0;
         _taskData = TaskManager.instance.getAvailableQuests(4);
         for(i = 0; i < _taskMenuItem.length; )
         {
            _itemList.removeChild(_taskMenuItem[i]);
            i++;
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
            _bgArray[_ind].visible = false;
            _btnArray[_ind].visible = false;
            _textArray[_ind].visible = false;
            menuItemClick(0);
         }
      }
      
      private function taskMenuItemClick(clickID:int) : void
      {
         SoundManager.instance.playButtonSound();
         _menuItemBgSelect.y = _btnArray[_ind].y - 2;
         setViewVisible();
         setTaskMenuBgFrame();
         if(_taskMenuItem.length == 0)
         {
            return;
         }
         _taskMenuItem[clickID].itemBg.setFrame(2);
         _taskInfoView.visible = true;
         _taskInfoView.regressFlag = true;
         _taskInfoView.info = _taskData.list[clickID];
         _viewArray[_ind].visible = true;
         _viewArray[_ind].taskInfo = _taskData.list[clickID];
         _viewArray[_ind].show();
      }
      
      private function setTaskMenuBgFrame() : void
      {
         var i:int = 0;
         for(i = 0; i < _taskMenuItem.length; )
         {
            _taskMenuItem[i].itemBg.setFrame(1);
            i++;
         }
      }
      
      private function setItemView(array:Array, styleName:String) : void
      {
         var i:int = 0;
         for(i = 0; i < array.length; )
         {
            array[i] = ComponentFactory.Instance.creatComponentByStylename(styleName);
            if(i > 0)
            {
               array[i].y = array[i - 1].y + array[i].height + 4;
            }
            addChild(array[i]);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _btnArray.length; )
         {
            _btnArray[i].addEventListener("click",__onMenuItemClick);
            i++;
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(178),TaskManager.instance.__updateAcceptedTask);
         TaskManager.instance.addEventListener("update_taskMenuItem",__onUpdateTaskMenuItem);
      }
      
      private function __onMenuItemClick(event:MouseEvent) : void
      {
         var i:int = 0;
         for(i = 0; i < _btnArray.length; )
         {
            if(_btnArray[i] == event.currentTarget)
            {
               SoundManager.instance.playButtonSound();
               menuItemClick(i);
               break;
            }
            i++;
         }
      }
      
      private function menuItemClick(id:int) : void
      {
         _menuItemBgSelect.y = _btnArray[id].y - 2;
         setViewVisible();
         _taskInfoView.visible = false;
         id == _ind?taskMenuItemClick(0):_viewArray[id].show();
         if(id == 3)
         {
            SocketManager.Instance.out.sendRegressApplyEnable();
         }
      }
      
      private function setViewVisible() : void
      {
         var i:int = 0;
         for(i = 0; i < _viewArray.length; )
         {
            _viewArray[i].visible = false;
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _btnArray.length; )
         {
            _btnArray[i].removeEventListener("click",__onMenuItemClick);
            i++;
         }
         TaskManager.instance.removeEventListener("update_taskMenuItem",__onUpdateTaskMenuItem);
      }
      
      private function removeArray(array:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < array.length; )
         {
            if(array[i])
            {
               array[i].dispose();
               array[i] = null;
            }
            i++;
         }
         array.length = 0;
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.dispose();
         removeEvent();
         removeArray(_bgArray);
         removeArray(_textArray);
         removeArray(_btnArray);
         removeArray(_viewArray);
         for(i = 0; i < _taskMenuItem.length; )
         {
            if(_taskMenuItem[i])
            {
               _taskMenuItem[i].dispose();
               _taskMenuItem[i] = null;
            }
            i++;
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
         j = 0;
         while(j < _textNameArray.length)
         {
            _textNameArray[j] = null;
            j++;
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
