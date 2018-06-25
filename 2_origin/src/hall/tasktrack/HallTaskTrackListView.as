package hall.tasktrack
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestCategory;
   import ddt.data.quest.QuestInfo;
   import ddt.events.CEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import quest.TaskManager;
   import road7th.data.DictionaryData;
   import trainer.view.NewHandContainer;
   
   public class HallTaskTrackListView extends Sprite implements Disposeable
   {
       
      
      private var _list:ListPanel;
      
      private var _questData:DictionaryData;
      
      private var _pointDownArrow:MovieClip;
      
      public function HallTaskTrackListView()
      {
         super();
         initData();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var tmp:* = null;
         _questData = new DictionaryData();
         var index:int = -1;
         for(i = 0; i < 9; )
         {
            if(i != 4)
            {
               tmp = new QuestInfo();
               if(i == 0)
               {
                  tmp.Type = 2;
               }
               else
               {
                  tmp.Type = 1;
               }
               tmp.QuestID = index;
               _questData.add(i,tmp);
               index--;
            }
            i++;
         }
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("hall.taskTrack.list");
         addChild(_list);
      }
      
      private function initEvent() : void
      {
         _list.list.addEventListener("listItemClick",__itemClick);
         TaskManager.instance.addEventListener("taskRefreshHallTaskTrackView",refreshView);
         PlayerManager.Instance.addEventListener("updatePet",refreshViewPet);
      }
      
      protected function refreshViewPet(e:CEvent) : void
      {
         refreshView(null);
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         var questInfo:QuestInfo = event.cellValue as QuestInfo;
         if(questInfo.QuestID > 0)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc5_:int = 0;
         var _loc4_:* = _questData;
         for each(var tmp in _questData)
         {
            if(questInfo.QuestID == tmp.QuestID)
            {
               tmp.Type = tmp.Type == 1?2:1;
               break;
            }
         }
         refreshView(new Event("taskRefreshHallTaskTrackView"));
      }
      
      private function refreshView(event:Event = null) : void
      {
         var i:int = 0;
         var cate:* = null;
         var tmpList:* = null;
         var typeQuest:* = null;
         var tempInfo:* = null;
         if(_list == null)
         {
            return;
         }
         var tmpPosY:int = _list.list.viewPosition.y;
         var tmp:Array = [];
         var isNeedDefault:Boolean = false;
         if(!event)
         {
            isNeedDefault = true;
         }
         i = 0;
         while(i < 9)
         {
            if(i != 4)
            {
               cate = TaskManager.instance.getAvailableQuests(i);
               tmpList = cate.list;
               if(tmpList.length > 0)
               {
                  typeQuest = _questData[i] as QuestInfo;
                  tmp.push(typeQuest);
                  if(isNeedDefault)
                  {
                     typeQuest.Type = 2;
                     isNeedDefault = false;
                  }
                  if(typeQuest.Type == 2)
                  {
                     tmp = tmp.concat(tmpList);
                  }
               }
            }
            i++;
         }
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(tmp);
         _list.list.updateListView();
         var intPoint:IntPoint = new IntPoint(0,tmpPosY);
         _list.list.viewPosition = intPoint;
         dispatchEvent(new Event("change"));
         var _loc17_:int = 0;
         var _loc16_:* = tmp;
         for each(var questInf in tmp)
         {
            if(questInf.QuestID == 560)
            {
               tempInfo = questInf;
               break;
            }
         }
         if(tempInfo != null)
         {
            if(!_pointDownArrow)
            {
               _pointDownArrow = ComponentFactory.Instance.creat("asset.newHandGuide.newArrowPointDown");
               _pointDownArrow.mouseChildren = false;
               _pointDownArrow.mouseEnabled = false;
               addChild(_pointDownArrow);
            }
            if(tempInfo.isCompleted)
            {
               _pointDownArrow.x = -7;
               _pointDownArrow.y = -39;
            }
            else
            {
               _pointDownArrow.x = 57;
               _pointDownArrow.y = -19;
            }
         }
         else if(_pointDownArrow)
         {
            _pointDownArrow.gotoAndStop(1);
            removeChild(_pointDownArrow);
            _pointDownArrow = null;
         }
         if((PlayerManager.Instance.Self.Grade == 12 || PlayerManager.Instance.Self.Grade == 13) && !PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            var _loc19_:int = 0;
            var _loc18_:* = tmp;
            for each(var questInfo2 in tmp)
            {
               if(questInfo2.QuestID == 7)
               {
                  NewHandContainer.Instance.showArrow(140,0,new Point(846,201),"","");
                  break;
               }
            }
         }
         if(PlayerManager.Instance.Self.Grade >= 10 && !PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            var _loc21_:int = 0;
            var _loc20_:* = tmp;
            for each(var questInfo5 in tmp)
            {
               if(questInfo5.QuestID == 327)
               {
                  NewHandContainer.Instance.showArrow(201,-90,new Point(-47,76),"","",this);
                  break;
               }
            }
         }
         if((PlayerManager.Instance.Self.Grade == 13 || PlayerManager.Instance.Self.Grade == 14) && !PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            var _loc23_:int = 0;
            var _loc22_:* = tmp;
            for each(var questInfo3 in tmp)
            {
               if(questInfo3.QuestID == 25)
               {
                  NewHandContainer.Instance.showArrow(141,0,new Point(49,-51),"","",this);
                  break;
               }
            }
         }
         if((PlayerManager.Instance.Self.Grade == 15 || PlayerManager.Instance.Self.Grade == 16) && !PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            var _loc25_:int = 0;
            var _loc24_:* = tmp;
            for each(var questInfo4 in tmp)
            {
               if(questInfo4.QuestID == 29)
               {
                  NewHandContainer.Instance.showArrow(142,0,new Point(49,-51),"","",this);
                  break;
               }
            }
         }
      }
      
      public function isNoMainTask() : Boolean
      {
         var k:int = 0;
         var cellList:* = _list.list.cell;
         var len:int = cellList.length;
         var isNoMainTask:Boolean = true;
         k = 0;
         if(k < len)
         {
            if(cellList[k].typeMc.currentFrame == 1)
            {
               isNoMainTask = false;
            }
         }
         return isNoMainTask;
      }
      
      public function isEmpty() : Boolean
      {
         return _list.vectorListModel.isEmpty();
      }
      
      private function removeEvent() : void
      {
         _list.list.removeEventListener("listItemClick",__itemClick);
         TaskManager.instance.removeEventListener("taskRefreshHallTaskTrackView",refreshView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_pointDownArrow)
         {
            _pointDownArrow.gotoAndStop(1);
            removeChild(_pointDownArrow);
            _pointDownArrow = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _list = null;
         _questData = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
