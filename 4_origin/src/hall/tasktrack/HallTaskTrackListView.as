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
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _questData = new DictionaryData();
         var _loc1_:int = -1;
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            if(_loc3_ != 4)
            {
               _loc2_ = new QuestInfo();
               if(_loc3_ == 0)
               {
                  _loc2_.Type = 2;
               }
               else
               {
                  _loc2_.Type = 1;
               }
               _loc2_.QuestID = _loc1_;
               _questData.add(_loc3_,_loc2_);
               _loc1_--;
            }
            _loc3_++;
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
      
      protected function refreshViewPet(param1:CEvent) : void
      {
         refreshView(null);
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         var _loc3_:QuestInfo = param1.cellValue as QuestInfo;
         if(_loc3_.QuestID > 0)
         {
            return;
         }
         SoundManager.instance.play("008");
         var _loc5_:int = 0;
         var _loc4_:* = _questData;
         for each(var _loc2_ in _questData)
         {
            if(_loc3_.QuestID == _loc2_.QuestID)
            {
               _loc2_.Type = _loc2_.Type == 1?2:1;
               break;
            }
         }
         refreshView(new Event("taskRefreshHallTaskTrackView"));
      }
      
      private function refreshView(param1:Event = null) : void
      {
         var _loc12_:int = 0;
         var _loc2_:* = null;
         var _loc16_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(_list == null)
         {
            return;
         }
         var _loc11_:int = _list.list.viewPosition.y;
         var _loc14_:Array = [];
         var _loc8_:Boolean = false;
         if(!param1)
         {
            _loc8_ = true;
         }
         _loc12_ = 0;
         while(_loc12_ < 9)
         {
            if(_loc12_ != 4)
            {
               _loc2_ = TaskManager.instance.getAvailableQuests(_loc12_);
               _loc16_ = _loc2_.list;
               if(_loc16_.length > 0)
               {
                  _loc3_ = _questData[_loc12_] as QuestInfo;
                  _loc14_.push(_loc3_);
                  if(_loc8_)
                  {
                     _loc3_.Type = 2;
                     _loc8_ = false;
                  }
                  if(_loc3_.Type == 2)
                  {
                     _loc14_ = _loc14_.concat(_loc16_);
                  }
               }
            }
            _loc12_++;
         }
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_loc14_);
         _list.list.updateListView();
         var _loc15_:IntPoint = new IntPoint(0,_loc11_);
         _list.list.viewPosition = _loc15_;
         dispatchEvent(new Event("change"));
         var _loc18_:int = 0;
         var _loc17_:* = _loc14_;
         for each(var _loc7_ in _loc14_)
         {
            if(_loc7_.QuestID == 560)
            {
               _loc4_ = _loc7_;
               break;
            }
         }
         if(_loc4_ != null)
         {
            if(!_pointDownArrow)
            {
               _pointDownArrow = ComponentFactory.Instance.creat("asset.newHandGuide.newArrowPointDown");
               _pointDownArrow.mouseChildren = false;
               _pointDownArrow.mouseEnabled = false;
               addChild(_pointDownArrow);
            }
            if(_loc4_.isCompleted)
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
         if(!PlayerManager.Instance.Self.isNewOnceFinish(110))
         {
            var _loc20_:int = 0;
            var _loc19_:* = _loc14_;
            for each(var _loc9_ in _loc14_)
            {
               if(_loc9_.QuestID == 568)
               {
                  NewHandContainer.Instance.showArrow(128,0,new Point(49,-51),"","",this);
                  break;
               }
            }
         }
         if((PlayerManager.Instance.Self.Grade == 12 || PlayerManager.Instance.Self.Grade == 13) && !PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            var _loc22_:int = 0;
            var _loc21_:* = _loc14_;
            for each(var _loc13_ in _loc14_)
            {
               if(_loc13_.QuestID == 7)
               {
                  NewHandContainer.Instance.showArrow(140,0,new Point(846,201),"","");
                  break;
               }
            }
         }
         if(PlayerManager.Instance.Self.Grade >= 10 && !PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            var _loc24_:int = 0;
            var _loc23_:* = _loc14_;
            for each(var _loc5_ in _loc14_)
            {
               if(_loc5_.QuestID == 327)
               {
                  NewHandContainer.Instance.showArrow(201,-90,new Point(-47,76),"","",this);
                  break;
               }
            }
         }
         if((PlayerManager.Instance.Self.Grade == 13 || PlayerManager.Instance.Self.Grade == 14) && !PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            var _loc26_:int = 0;
            var _loc25_:* = _loc14_;
            for each(var _loc10_ in _loc14_)
            {
               if(_loc10_.QuestID == 25)
               {
                  NewHandContainer.Instance.showArrow(141,0,new Point(49,-51),"","",this);
                  break;
               }
            }
         }
         if((PlayerManager.Instance.Self.Grade == 15 || PlayerManager.Instance.Self.Grade == 16) && !PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            var _loc28_:int = 0;
            var _loc27_:* = _loc14_;
            for each(var _loc6_ in _loc14_)
            {
               if(_loc6_.QuestID == 29)
               {
                  NewHandContainer.Instance.showArrow(142,0,new Point(49,-51),"","",this);
                  break;
               }
            }
         }
      }
      
      public function isNoMainTask() : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _list.list.cell;
         var _loc2_:int = _loc3_.length;
         var _loc1_:Boolean = true;
         _loc4_ = 0;
         if(_loc4_ < _loc2_)
         {
            if(_loc3_[_loc4_].typeMc.currentFrame == 1)
            {
               _loc1_ = false;
            }
         }
         return _loc1_;
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
