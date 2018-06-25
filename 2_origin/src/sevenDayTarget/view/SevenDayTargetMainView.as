package sevenDayTarget.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import sevenDayTarget.controller.SevenDayTargetManager;
   import sevenDayTarget.model.NewTargetQuestionInfo;
   
   public class SevenDayTargetMainView extends Frame
   {
       
      
      private var _topBg:Bitmap;
      
      private var _downBg:Bitmap;
      
      private var grayFilter:ColorMatrixFilter;
      
      private var lightFilter:ColorMatrixFilter;
      
      private var dayArray:Array;
      
      private var _rewardList:SimpleTileList;
      
      private var _rewardArray:Array;
      
      private var _finishBnt:BaseButton;
      
      private var _todayQuestInfo:NewTargetQuestionInfo;
      
      private var conditionSp1:SevenDayTargetConditionCell;
      
      private var conditionSp2:SevenDayTargetConditionCell;
      
      private var conditionSp3:SevenDayTargetConditionCell;
      
      private var _helpBnt:BaseButton;
      
      private var _downBack:ScaleBitmapImage;
      
      public function SevenDayTargetMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get todayQuestInfo() : NewTargetQuestionInfo
      {
         return _todayQuestInfo;
      }
      
      private function initView() : void
      {
         _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[SevenDayTargetManager.Instance.today - 1];
         _downBack = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.scale9cornerImageTree");
         addChild(_downBack);
         createDayClicker();
         initDayView();
         initTargetView();
         initRewardView();
         changeDaysText();
         addHelpBnt();
      }
      
      private function addHelpBnt() : void
      {
         _helpBnt = ComponentFactory.Instance.creatComponentByStylename("sevenDayTarget.helpBnt");
         addToContent(_helpBnt);
         _helpBnt.addEventListener("click",__onHelpClick);
      }
      
      protected function __onHelpClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var helpView:SevenDayTargetHelpFrame = ComponentFactory.Instance.creat("sevenDayTarget.helpView");
         LayerManager.Instance.addToLayer(helpView,0,true,1);
      }
      
      private function initDayView() : void
      {
         var i:int = 0;
         var dayBg:* = null;
         grayFilter = ComponentFactory.Instance.model.getSet("grayFilter");
         lightFilter = ComponentFactory.Instance.model.getSet("lightFilter");
         dayArray = [];
         titleText = LanguageMgr.GetTranslation("ddt.sevenDayTarget.title");
         _topBg = ComponentFactory.Instance.creat("sevenDayTarget.topBg");
         addToContent(_topBg);
         _downBg = ComponentFactory.Instance.creat("sevenDayTarget.downBg");
         addToContent(_downBg);
         var todayMC:MovieClip = ComponentFactory.Instance.creat("sevenDayTarget.todayMC");
         todayMC.mouseEnabled = false;
         todayMC.mouseChildren = false;
         var today:int = SevenDayTargetManager.Instance.today;
         for(i = 1; i <= 7; )
         {
            dayBg = ComponentFactory.Instance.creatComponentByStylename("sevenDayTarget.view.dayButton" + i);
            dayBg.name = "day" + i;
            addToContent(dayBg);
            if(i == today)
            {
               PositionUtils.setPos(todayMC,"sevenDayTarget.todayMCPos" + i);
            }
            dayArray.push(dayBg);
            dayBg.addEventListener("click",__dayClick);
            i++;
         }
         addToContent(todayMC);
      }
      
      private function initTargetView() : void
      {
         if(conditionSp1)
         {
            conditionSp1.dispose();
            conditionSp1 = null;
         }
         if(conditionSp2)
         {
            conditionSp2.dispose();
            conditionSp2 = null;
         }
         if(conditionSp3)
         {
            conditionSp3.dispose();
            conditionSp3 = null;
         }
         var today:int = SevenDayTargetManager.Instance.today;
         var canClickLink:Boolean = today >= _todayQuestInfo.Period?true:false;
         conditionSp1 = new SevenDayTargetConditionCell(_todayQuestInfo);
         conditionSp1.setView(_todayQuestInfo.condition1Title,_todayQuestInfo.condition1Complete,canClickLink);
         PositionUtils.setPos(conditionSp1,"sevenDayTarget.view.conditionPos1");
         addToContent(conditionSp1);
         conditionSp2 = new SevenDayTargetConditionCell(_todayQuestInfo);
         conditionSp2.setView(_todayQuestInfo.condition2Title,_todayQuestInfo.condition2Complete,canClickLink);
         PositionUtils.setPos(conditionSp2,"sevenDayTarget.view.conditionPos2");
         addToContent(conditionSp2);
         conditionSp3 = new SevenDayTargetConditionCell(_todayQuestInfo);
         conditionSp3.setView(_todayQuestInfo.condition3Title,_todayQuestInfo.condition3Complete,canClickLink);
         PositionUtils.setPos(conditionSp3,"sevenDayTarget.view.conditionPos3");
         addToContent(conditionSp3);
      }
      
      private function initRewardView() : void
      {
         var i:int = 0;
         var cell:* = null;
         var temp:* = null;
         var info:* = null;
         if(_rewardList)
         {
            _rewardList.dispose();
            _rewardList = null;
         }
         if(_finishBnt)
         {
            _finishBnt.dispose();
            _finishBnt = null;
         }
         _rewardList = ComponentFactory.Instance.creat("sevenDayTarget.simpleTileList.rewardList",[2]);
         addToContent(_rewardList);
         _rewardArray = _todayQuestInfo.rewardList;
         for(i = 0; i < _rewardArray.length; )
         {
            cell = new SevenDayTargetRewardCell();
            temp = _rewardArray[i] as InventoryItemInfo;
            info = ItemManager.Instance.getTemplateById(temp.ItemID);
            cell.info = info;
            cell.itemName = info.Name;
            cell.itemNum = temp.Count + "";
            _rewardList.addChild(cell);
            i++;
         }
         _finishBnt = ComponentFactory.Instance.creat("sevenDayTarget.view.getAwardBtn");
         addToContent(_finishBnt);
         _finishBnt.addEventListener("click",__getReward);
         if(_todayQuestInfo.iscomplete && _todayQuestInfo.getedReward)
         {
            _finishBnt.enable = false;
         }
         if(_todayQuestInfo.iscomplete && !_todayQuestInfo.getedReward)
         {
            _finishBnt.enable = true;
         }
         if(!_todayQuestInfo.iscomplete)
         {
            _finishBnt.enable = false;
         }
      }
      
      private function __getReward(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _finishBnt.enable = false;
         var questionId:int = _todayQuestInfo.questId;
         SocketManager.Instance.out.sevenDayTarget_getReward(questionId);
      }
      
      private function createDayClicker() : void
      {
         var i:int = 0;
         var sp:* = null;
         for(i = 1; i < 8; )
         {
            sp = new Sprite();
            sp.buttonMode = true;
            sp.graphics.beginFill(255);
            sp.graphics.drawRect(0,0,90,200);
            sp.graphics.endFill();
            addToContent(sp);
            sp.name = "day" + i;
            PositionUtils.setPos(sp,"sevenDayTarget.dayClicker" + i);
            sp.addEventListener("click",__dayClick);
            sp.alpha = 1;
            i++;
         }
      }
      
      private function __dayClick(e:MouseEvent) : void
      {
         var sp:Sprite = e.currentTarget as Sprite;
         if(sp.name == "day1")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[0];
         }
         else if(sp.name == "day2")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[1];
         }
         else if(sp.name == "day3")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[2];
         }
         else if(sp.name == "day4")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[3];
         }
         else if(sp.name == "day5")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[4];
         }
         else if(sp.name == "day6")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[5];
         }
         else if(sp.name == "day7")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[6];
         }
         updateTargetView();
         updateRewardView();
      }
      
      public function updateTargetView() : void
      {
         initTargetView();
      }
      
      public function updateRewardView() : void
      {
         initRewardView();
      }
      
      private function changeDaysText() : void
      {
         var dayBitmap:* = null;
         var i:int = 0;
         var j:* = 0;
         var today:int = SevenDayTargetManager.Instance.today;
         for(i = 0; i < today; )
         {
            dayBitmap = dayArray[i];
            dayBitmap.enable = true;
            i++;
         }
         for(j = today; j < dayArray.length; )
         {
            dayBitmap = dayArray[j];
            dayBitmap.enable = false;
            j++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _finishBnt.removeEventListener("click",__getReward);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SevenDayTargetManager.Instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_topBg)
         {
            _topBg.bitmapData.dispose();
            _topBg = null;
         }
         if(_downBack)
         {
            _downBack.dispose();
            _downBack = null;
         }
         if(conditionSp1)
         {
            conditionSp1.dispose();
            conditionSp1 = null;
         }
         if(conditionSp2)
         {
            conditionSp2.dispose();
            conditionSp2 = null;
         }
         if(conditionSp3)
         {
            conditionSp3.dispose();
            conditionSp3 = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
   }
}
