package im
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.loader.LoaderCreate;
   import ddt.manager.IMManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import team.TeamManager;
   import team.model.TeamMemberInfo;
   
   public class TeamListView extends Sprite implements Disposeable
   {
       
      
      private var _teamChatBtn:SimpleBitmapButton;
      
      private var _list:ListPanel;
      
      private var _teamPlayerArray:Array;
      
      private var _teamIMInfoArray:Array;
      
      private var _currentItem:TeamMemberInfo;
      
      private var _currentTitle:TeamMemberInfo;
      
      private var _pos:int;
      
      public function TeamListView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function addEvent() : void
      {
         _teamChatBtn.addEventListener("click",__showTeamChat);
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creat("IM.TeamListPanel");
         _list.vScrollProxy = 1;
         addChild(_list);
         _list.list.updateListView();
         _list.list.addEventListener("listItemClick",__itemClick);
         update();
         _teamChatBtn = ComponentFactory.Instance.creatComponentByStylename("ddtIM.teamChatBtn");
         addChild(_teamChatBtn);
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         if((event.cellValue as TeamMemberInfo).type == 1)
         {
            if(!_currentItem)
            {
               _currentItem = event.cellValue as TeamMemberInfo;
               _currentItem.isSelected = true;
            }
            else if(_currentItem != event.cellValue as TeamMemberInfo)
            {
               _currentItem.isSelected = false;
               _currentItem = event.cellValue as TeamMemberInfo;
               _currentItem.isSelected = true;
            }
         }
         else
         {
            if(!_currentTitle)
            {
               _currentTitle = event.cellValue as TeamMemberInfo;
               _currentTitle.isSelected = true;
            }
            if(_currentTitle != event.cellValue as TeamMemberInfo)
            {
               _currentTitle.isSelected = false;
               _currentTitle = event.cellValue as TeamMemberInfo;
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
            _list.vectorListModel.appendAll(_teamIMInfoArray);
            _list.list.updateListView();
         }
      }
      
      private function update() : void
      {
         var i:int = 0;
         var info:* = null;
         _teamPlayerArray = [];
         _teamPlayerArray = TeamManager.instance.model.onlineTeamMemberList;
         if(!_teamIMInfoArray || _teamIMInfoArray.length == 0)
         {
            _teamIMInfoArray = TeamManager.instance.model.teamIMInfo;
         }
         var tempArr:Array = [];
         var tempArr1:Array = [];
         for(i = 0; i < _teamPlayerArray.length; )
         {
            info = _teamPlayerArray[i] as TeamMemberInfo;
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
         _teamPlayerArray = tempArr.concat(tempArr1);
         var tempArray:Array = TeamManager.instance.model.offlineTeamMemberList;
         tempArray = tempArray.sortOn("Grade",16 | 2);
         _teamPlayerArray = _teamPlayerArray.concat(tempArray);
         _teamPlayerArray = _teamIMInfoArray.concat(_teamPlayerArray);
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_teamPlayerArray);
         _list.list.updateListView();
      }
      
      private function showTeamChatFrame() : void
      {
         IMManager.Instance.alertTeamChatFrame(PlayerManager.Instance.Self.teamID);
      }
      
      private function __showTeamChat(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamMemeberLoader(),true);
         AssetModuleLoader.addModelLoader("team",7);
         AssetModuleLoader.startCodeLoader(showTeamChatFrame);
      }
      
      private function removeEvent() : void
      {
         _teamChatBtn.removeEventListener("click",__showTeamChat);
      }
      
      public function get teamIMInfoArray() : Array
      {
         return _teamIMInfoArray;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_teamChatBtn)
         {
            ObjectUtils.disposeObject(_teamChatBtn);
         }
         if(_list && _list.parent)
         {
            _list.parent.removeChild(_list);
            _list.dispose();
            _list = null;
         }
         _teamChatBtn = null;
      }
   }
}
