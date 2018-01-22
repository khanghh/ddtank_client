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
      
      protected function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:SevenDayTargetHelpFrame = ComponentFactory.Instance.creat("sevenDayTarget.helpView");
         LayerManager.Instance.addToLayer(_loc2_,0,true,1);
      }
      
      private function initDayView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         grayFilter = ComponentFactory.Instance.model.getSet("grayFilter");
         lightFilter = ComponentFactory.Instance.model.getSet("lightFilter");
         dayArray = [];
         titleText = LanguageMgr.GetTranslation("ddt.sevenDayTarget.title");
         _topBg = ComponentFactory.Instance.creat("sevenDayTarget.topBg");
         addToContent(_topBg);
         _downBg = ComponentFactory.Instance.creat("sevenDayTarget.downBg");
         addToContent(_downBg);
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("sevenDayTarget.todayMC");
         _loc1_.mouseEnabled = false;
         _loc1_.mouseChildren = false;
         var _loc2_:int = SevenDayTargetManager.Instance.today;
         _loc4_ = 1;
         while(_loc4_ <= 7)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("sevenDayTarget.view.dayButton" + _loc4_);
            _loc3_.name = "day" + _loc4_;
            addToContent(_loc3_);
            if(_loc4_ == _loc2_)
            {
               PositionUtils.setPos(_loc1_,"sevenDayTarget.todayMCPos" + _loc4_);
            }
            dayArray.push(_loc3_);
            _loc3_.addEventListener("click",__dayClick);
            _loc4_++;
         }
         addToContent(_loc1_);
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
         var _loc2_:int = SevenDayTargetManager.Instance.today;
         var _loc1_:Boolean = _loc2_ >= _todayQuestInfo.Period?true:false;
         conditionSp1 = new SevenDayTargetConditionCell(_todayQuestInfo);
         conditionSp1.setView(_todayQuestInfo.condition1Title,_todayQuestInfo.condition1Complete,_loc1_);
         PositionUtils.setPos(conditionSp1,"sevenDayTarget.view.conditionPos1");
         addToContent(conditionSp1);
         conditionSp2 = new SevenDayTargetConditionCell(_todayQuestInfo);
         conditionSp2.setView(_todayQuestInfo.condition2Title,_todayQuestInfo.condition2Complete,_loc1_);
         PositionUtils.setPos(conditionSp2,"sevenDayTarget.view.conditionPos2");
         addToContent(conditionSp2);
         conditionSp3 = new SevenDayTargetConditionCell(_todayQuestInfo);
         conditionSp3.setView(_todayQuestInfo.condition3Title,_todayQuestInfo.condition3Complete,_loc1_);
         PositionUtils.setPos(conditionSp3,"sevenDayTarget.view.conditionPos3");
         addToContent(conditionSp3);
      }
      
      private function initRewardView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
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
         _loc4_ = 0;
         while(_loc4_ < _rewardArray.length)
         {
            _loc1_ = new SevenDayTargetRewardCell();
            _loc2_ = _rewardArray[_loc4_] as InventoryItemInfo;
            _loc3_ = ItemManager.Instance.getTemplateById(_loc2_.ItemID);
            _loc1_.info = _loc3_;
            _loc1_.itemName = _loc3_.Name;
            _loc1_.itemNum = _loc2_.Count + "";
            _rewardList.addChild(_loc1_);
            _loc4_++;
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
      
      private function __getReward(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _finishBnt.enable = false;
         var _loc2_:int = _todayQuestInfo.questId;
         SocketManager.Instance.out.sevenDayTarget_getReward(_loc2_);
      }
      
      private function createDayClicker() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 1;
         while(_loc2_ < 8)
         {
            _loc1_ = new Sprite();
            _loc1_.buttonMode = true;
            _loc1_.graphics.beginFill(255);
            _loc1_.graphics.drawRect(0,0,90,200);
            _loc1_.graphics.endFill();
            addToContent(_loc1_);
            _loc1_.name = "day" + _loc2_;
            PositionUtils.setPos(_loc1_,"sevenDayTarget.dayClicker" + _loc2_);
            _loc1_.addEventListener("click",__dayClick);
            _loc1_.alpha = 1;
            _loc2_++;
         }
      }
      
      private function __dayClick(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = param1.currentTarget as Sprite;
         if(_loc2_.name == "day1")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[0];
         }
         else if(_loc2_.name == "day2")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[1];
         }
         else if(_loc2_.name == "day3")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[2];
         }
         else if(_loc2_.name == "day4")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[3];
         }
         else if(_loc2_.name == "day5")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[4];
         }
         else if(_loc2_.name == "day6")
         {
            _todayQuestInfo = SevenDayTargetManager.Instance.model.sevenDayQuestionInfoArr[5];
         }
         else if(_loc2_.name == "day7")
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
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = 0;
         var _loc1_:int = SevenDayTargetManager.Instance.today;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = dayArray[_loc4_];
            _loc3_.enable = true;
            _loc4_++;
         }
         _loc2_ = _loc1_;
         while(_loc2_ < dayArray.length)
         {
            _loc3_ = dayArray[_loc2_];
            _loc3_.enable = false;
            _loc2_++;
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
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
