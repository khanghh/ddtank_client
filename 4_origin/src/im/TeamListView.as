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
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         if((param1.cellValue as TeamMemberInfo).type == 1)
         {
            if(!_currentItem)
            {
               _currentItem = param1.cellValue as TeamMemberInfo;
               _currentItem.isSelected = true;
            }
            else if(_currentItem != param1.cellValue as TeamMemberInfo)
            {
               _currentItem.isSelected = false;
               _currentItem = param1.cellValue as TeamMemberInfo;
               _currentItem.isSelected = true;
            }
         }
         else
         {
            if(!_currentTitle)
            {
               _currentTitle = param1.cellValue as TeamMemberInfo;
               _currentTitle.isSelected = true;
            }
            if(_currentTitle != param1.cellValue as TeamMemberInfo)
            {
               _currentTitle.isSelected = false;
               _currentTitle = param1.cellValue as TeamMemberInfo;
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
            _list.vectorListModel.appendAll(_teamIMInfoArray);
            _list.list.updateListView();
         }
      }
      
      private function update() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _teamPlayerArray = [];
         _teamPlayerArray = TeamManager.instance.model.onlineTeamMemberList;
         if(!_teamIMInfoArray || _teamIMInfoArray.length == 0)
         {
            _teamIMInfoArray = TeamManager.instance.model.teamIMInfo;
         }
         var _loc3_:Array = [];
         var _loc1_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _teamPlayerArray.length)
         {
            _loc4_ = _teamPlayerArray[_loc5_] as TeamMemberInfo;
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
         _teamPlayerArray = _loc3_.concat(_loc1_);
         var _loc2_:Array = TeamManager.instance.model.offlineTeamMemberList;
         _loc2_ = _loc2_.sortOn("Grade",16 | 2);
         _teamPlayerArray = _teamPlayerArray.concat(_loc2_);
         _teamPlayerArray = _teamIMInfoArray.concat(_teamPlayerArray);
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_teamPlayerArray);
         _list.list.updateListView();
      }
      
      private function showTeamChatFrame() : void
      {
         IMManager.Instance.alertTeamChatFrame(PlayerManager.Instance.Self.teamID);
      }
      
      private function __showTeamChat(param1:MouseEvent) : void
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
