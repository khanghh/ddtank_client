package fightLib.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import fightLib.FightLibControl;
   import fightLib.FightLibManager;
   import fightLib.script.FightLibGuideScripit;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class LessonsView extends Sprite implements Disposeable
   {
       
      
      private var _background:Bitmap;
      
      private var _defaultImg:Bitmap;
      
      private var _difficultyImg:Bitmap;
      
      private var _background2:MutipleImage;
      
      private var _background3:MutipleImage;
      
      private var _background4:MovieClip;
      
      private var _measureButton:LessonButton;
      
      private var _twentyButton:LessonButton;
      
      private var _sixtyFiveButton:LessonButton;
      
      private var _highThrowButton:LessonButton;
      
      private var _highGapButton:LessonButton;
      
      private var _lassButton:LessonButton;
      
      private var _levelGroup:SelectedButtonGroup;
      
      private var _lowButton:LevelButton;
      
      private var _mediumButton:LevelButton;
      
      private var _highButton:LevelButton;
      
      private var _startButton:MovieClip;
      
      private var _cancelButton:SimpleBitmapButton;
      
      private var _lessonType:int;
      
      private var _selectedLesson:LessonButton;
      
      private var _selectedLevel:LevelButton;
      
      private var _lessonButtons:Vector.<LessonButton>;
      
      private var _levelButtons:Vector.<LevelButton>;
      
      private var _sencondType:int = 3;
      
      private var _guildMovie:MovieClip;
      
      private var _awardView:FightLibAwardView;
      
      public function LessonsView()
      {
         _lessonButtons = new Vector.<LessonButton>();
         _levelButtons = new Vector.<LevelButton>();
         super();
         configUI();
         addEvent();
         updateLessonButtonState();
         updateLevelButtonState();
      }
      
      private function configUI() : void
      {
         _background = ComponentFactory.Instance.creatBitmap("fightLib.lesson.background");
         addChild(_background);
         _background2 = ComponentFactory.Instance.creatComponentByStylename("fightlib.lesson.awardBg");
         addChild(_background2);
         _background4 = ClassUtils.CreatInstance("fightLib.Award.bg");
         PositionUtils.setPos(_background4,"fightLib.Award.bgPos");
         addChild(_background4);
         _defaultImg = ComponentFactory.Instance.creatBitmap("asset.fightlib.charecaterPng");
         addChild(_defaultImg);
         _background3 = ComponentFactory.Instance.creatComponentByStylename("fightLib.levelBtnAreaBg");
         addChild(_background3);
         _difficultyImg = ComponentFactory.Instance.creatBitmap("fightlib.asset.difficultyTitle");
         addChild(_difficultyImg);
         _measureButton = ComponentFactory.Instance.creatCustomObject("fightLib.Lesson.MeasureButton");
         _measureButton.type = 1000;
         _lessonButtons.push(_measureButton);
         addChild(_measureButton);
         _twentyButton = ComponentFactory.Instance.creatCustomObject("fightLib.Lesson.TwentyButton");
         _twentyButton.type = 1001;
         _lessonButtons.push(_twentyButton);
         addChild(_twentyButton);
         _sixtyFiveButton = ComponentFactory.Instance.creatCustomObject("fightLib.Lesson.SixtyFiveButton");
         _sixtyFiveButton.type = 1002;
         _lessonButtons.push(_sixtyFiveButton);
         addChild(_sixtyFiveButton);
         _highThrowButton = ComponentFactory.Instance.creatCustomObject("fightLib.Lesson.HighThrowButton");
         _highThrowButton.type = 1003;
         _lessonButtons.push(_highThrowButton);
         addChild(_highThrowButton);
         _highGapButton = ComponentFactory.Instance.creatCustomObject("fightLib.Lesson.HighGapButton");
         _highGapButton.type = 1004;
         _lessonButtons.push(_highGapButton);
         addChild(_highGapButton);
         _lassButton = ComponentFactory.Instance.creatCustomObject("fightLib.Lesson.LassButton");
         addChild(_lassButton);
         _lowButton = ComponentFactory.Instance.creatCustomObject("fightLib.lesson.LowButton");
         addChild(_lowButton);
         _mediumButton = ComponentFactory.Instance.creatCustomObject("fightLib.lesson.MediumButton");
         addChild(_mediumButton);
         _highButton = ComponentFactory.Instance.creatCustomObject("fightLib.lesson.HighButton");
         addChild(_highButton);
         _levelButtons.push(_lowButton);
         _levelButtons.push(_mediumButton);
         _levelButtons.push(_highButton);
         _startButton = ClassUtils.CreatInstance("asset.ddtroom.startMovie");
         _startButton.buttonMode = true;
         addChild(_startButton);
         PositionUtils.setPos(_startButton,"fightlib.startbtn.pos");
         _cancelButton = ComponentFactory.Instance.creatComponentByStylename("fightLib.Lessons.CancelButton");
         addChild(_cancelButton);
         _awardView = ComponentFactory.Instance.creatCustomObject("fightLib.view.FightLibAwardView");
         addChild(_awardView);
         _guildMovie = ComponentFactory.Instance.creatCustomObject("fightLib.Lessons.GuildMovie");
         addChild(_guildMovie);
         updateLessonButtonState();
         updateLevelButtonState();
      }
      
      private function updateLast() : void
      {
         unSelectedAllLesson();
         unselectedAllLevel();
         if(FightLibManager.Instance.lastInfo != null)
         {
            switch(int(FightLibManager.Instance.lastInfo.id) - 1000)
            {
               case 0:
                  selectedLesson = _measureButton;
                  break;
               case 1:
                  selectedLesson = _twentyButton;
                  break;
               case 2:
                  selectedLesson = _sixtyFiveButton;
                  break;
               case 3:
                  selectedLesson = _highThrowButton;
                  break;
               case 4:
                  selectedLesson = _highGapButton;
            }
            switch(int(FightLibManager.Instance.lastInfo.difficulty))
            {
               case 0:
                  selectedLevel = _lowButton;
                  break;
               case 1:
                  selectedLevel = _mediumButton;
                  break;
               case 2:
                  selectedLevel = _highButton;
            }
            updateModel();
            updateModelII();
            updateLevelButtonState();
            updateAward();
            return;
         }
      }
      
      private function updateSencondType() : void
      {
         if(FightLibManager.Instance.currentInfo && (FightLibManager.Instance.currentInfo.id == 1001 || FightLibManager.Instance.currentInfo.id == 1002 || FightLibManager.Instance.currentInfo.id == 1003))
         {
            if(FightLibManager.Instance.currentInfo.difficulty == 0)
            {
               _sencondType = 6;
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 1)
            {
               _sencondType = 5;
            }
            else
            {
               _sencondType = 3;
            }
         }
         else if(FightLibManager.Instance.currentInfo && FightLibManager.Instance.currentInfo.id == 1004)
         {
            if(FightLibManager.Instance.currentInfo.difficulty == 0)
            {
               _sencondType = 5;
            }
            else if(FightLibManager.Instance.currentInfo.difficulty == 1)
            {
               _sencondType = 4;
            }
            else
            {
               _sencondType = 3;
            }
         }
      }
      
      private function updateLessonButtonState() : void
      {
         if(FightLibManager.Instance.getFightLibInfoByID(1000))
         {
            _measureButton.enabled = FightLibManager.Instance.getFightLibInfoByID(1000).InfoCanPlay;
         }
         else
         {
            _measureButton.enabled = false;
         }
         if(FightLibManager.Instance.getFightLibInfoByID(1001))
         {
            _twentyButton.enabled = FightLibManager.Instance.getFightLibInfoByID(1001).InfoCanPlay;
         }
         else
         {
            _twentyButton.enabled = false;
         }
         if(FightLibManager.Instance.getFightLibInfoByID(1002))
         {
            _sixtyFiveButton.enabled = FightLibManager.Instance.getFightLibInfoByID(1002).InfoCanPlay;
         }
         else
         {
            _sixtyFiveButton.enabled = false;
         }
         if(FightLibManager.Instance.getFightLibInfoByID(1003))
         {
            _highThrowButton.enabled = FightLibManager.Instance.getFightLibInfoByID(1003).InfoCanPlay;
         }
         else
         {
            _highThrowButton.enabled = false;
         }
         if(FightLibManager.Instance.getFightLibInfoByID(1004))
         {
            _highGapButton.enabled = FightLibManager.Instance.getFightLibInfoByID(1004).InfoCanPlay;
         }
         else
         {
            _highGapButton.enabled = false;
         }
      }
      
      private function updateLevelButtonState() : void
      {
         if(FightLibManager.Instance.currentInfo != null)
         {
            _lowButton.enable = FightLibManager.Instance.currentInfo.easyCanPlay;
            _mediumButton.enable = FightLibManager.Instance.currentInfo.normalCanPlay;
            _highButton.enable = FightLibManager.Instance.currentInfo.difficultCanPlay;
         }
         else
         {
            var _loc1_:* = false;
            _highButton.enable = _loc1_;
            _loc1_ = _loc1_;
            _mediumButton.enable = _loc1_;
            _lowButton.enable = _loc1_;
         }
      }
      
      private function updateAward() : void
      {
         if(FightLibManager.Instance.currentInfo != null && FightLibManager.Instance.currentInfo.difficulty > -1)
         {
            _awardView.visible = true;
            _awardView.setGiftAndExpNum(FightLibManager.Instance.currentInfo.getAwardGiftsNum(),FightLibManager.Instance.currentInfo.getAwardEXPNum(),FightLibManager.Instance.currentInfo.getAwardMedal());
            _awardView.setAwardItems(FightLibManager.Instance.currentInfo.getAwardItems());
            _awardView.geted = false;
            _defaultImg.visible = false;
            updateAwardGainedState();
         }
         else
         {
            _awardView.visible = false;
            _defaultImg.visible = true;
         }
      }
      
      private function updateAwardGainedState() : void
      {
         if(FightLibManager.Instance.currentInfo.difficulty == 0)
         {
            if(FightLibManager.Instance.currentInfo.easyAwardGained)
            {
               _awardView.geted = true;
            }
         }
         else if(FightLibManager.Instance.currentInfo.difficulty == 1)
         {
            if(FightLibManager.Instance.currentInfo.normalAwardGained)
            {
               _awardView.geted = true;
            }
         }
         else if(FightLibManager.Instance.currentInfo.difficultAwardGained)
         {
            _awardView.geted = true;
         }
      }
      
      private function addEvent() : void
      {
         _measureButton.addEventListener("SelectedLesson",__selectLesson);
         _twentyButton.addEventListener("SelectedLesson",__selectLesson);
         _sixtyFiveButton.addEventListener("SelectedLesson",__selectLesson);
         _highThrowButton.addEventListener("SelectedLesson",__selectLesson);
         _highGapButton.addEventListener("SelectedLesson",__selectLesson);
         _startButton.addEventListener("click",__start);
         _cancelButton.addEventListener("click",__cancel);
         _lowButton.addEventListener("click",__levelClick);
         _mediumButton.addEventListener("click",__levelClick);
         _highButton.addEventListener("click",__levelClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",__update);
         FightLibManager.Instance.addEventListener("gainAward",__gainAward);
      }
      
      private function __gainAward(param1:Event) : void
      {
      }
      
      private function __update(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["fightLibMission"])
         {
            updateLessonButtonState();
            updateLevelButtonState();
            updateAward();
         }
      }
      
      private function removeEvent() : void
      {
         _measureButton.removeEventListener("SelectedLesson",__selectLesson);
         _twentyButton.removeEventListener("SelectedLesson",__selectLesson);
         _sixtyFiveButton.removeEventListener("SelectedLesson",__selectLesson);
         _highThrowButton.removeEventListener("SelectedLesson",__selectLesson);
         _highGapButton.removeEventListener("SelectedLesson",__selectLesson);
         _startButton.removeEventListener("click",__start);
         _cancelButton.removeEventListener("click",__cancel);
         _lowButton.removeEventListener("click",__levelClick);
         _mediumButton.removeEventListener("click",__levelClick);
         _highButton.removeEventListener("click",__levelClick);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__update);
         FightLibManager.Instance.removeEventListener("gainAward",__gainAward);
      }
      
      private function __levelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(FightLibManager.Instance.currentInfo == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.fightLib.ChooseFightLibTypeView.selectFightLibInfo"));
            var _loc5_:int = 0;
            var _loc4_:* = _lessonButtons;
            for each(var _loc2_ in _lessonButtons)
            {
               _loc2_.shine = _loc2_.enabled == true;
            }
            return;
         }
         var _loc7_:int = 0;
         var _loc6_:* = _levelButtons;
         for each(var _loc3_ in _levelButtons)
         {
            if(_loc3_.enable)
            {
               _loc3_.shine = false;
            }
         }
         unselectedAllLevel();
         this.selectedLevel = param1.currentTarget as LevelButton;
         updateModelII();
         updateAward();
         updateSencondType();
         GameInSocketOut.sendGameRoomSetUp(FightLibManager.Instance.currentInfo.id,5,false,"","",_sencondType,FightLibManager.Instance.currentInfo.difficulty,0,false,0);
         if(param1.currentTarget == _lowButton && FightLibControl.Instance.script && FightLibControl.Instance.script is FightLibGuideScripit)
         {
            FightLibControl.Instance.script.continueScript();
            FightLibControl.Instance.script.dispose();
            FightLibControl.Instance.script = null;
         }
      }
      
      private function updateModelII() : void
      {
         if(_lowButton.selected)
         {
            FightLibManager.Instance.currentInfo.difficulty = 0;
         }
         else if(_mediumButton.selected)
         {
            FightLibManager.Instance.currentInfo.difficulty = 1;
         }
         else if(_highButton.selected)
         {
            FightLibManager.Instance.currentInfo.difficulty = 2;
         }
      }
      
      private function __selectLesson(param1:Event) : void
      {
         var _loc4_:LessonButton = param1.currentTarget as LessonButton;
         var _loc5_:int = _loc4_.type;
         SoundManager.instance.play("008");
         if(_selectedLesson && _selectedLesson.type == _loc5_)
         {
            return;
         }
         var _loc7_:int = 0;
         var _loc6_:* = _lessonButtons;
         for each(var _loc2_ in _lessonButtons)
         {
            if(_loc2_.enabled)
            {
               _loc2_.shine = false;
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = _levelButtons;
         for each(var _loc3_ in _levelButtons)
         {
            if(_loc3_.enable)
            {
               _loc3_.shine = false;
            }
         }
         unSelectedAllLesson();
         unselectedAllLevel();
         this.selectedLesson = _loc4_;
         updateModel();
         updateLevelButtonState();
         if(_loc5_ == 1000 && FightLibControl.Instance.script && FightLibControl.Instance.script is FightLibGuideScripit)
         {
            FightLibControl.Instance.script.continueScript();
         }
      }
      
      private function unSelectedAllLesson() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _lessonButtons;
         for each(var _loc1_ in _lessonButtons)
         {
            _loc1_.selected = false;
         }
      }
      
      private function unselectedAllLevel() : void
      {
         var _loc1_:* = false;
         _highButton.selected = _loc1_;
         _loc1_ = _loc1_;
         _mediumButton.selected = _loc1_;
         _lowButton.selected = _loc1_;
      }
      
      private function updateModel() : void
      {
         FightLibManager.Instance.currentInfoID = selectedLesson.type;
         FightLibManager.Instance.currentInfo.difficulty = -1;
         updateAward();
      }
      
      private function __start(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(FightLibManager.Instance.currentInfo == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.fightLib.ChooseFightLibTypeView.selectFightLibInfo"));
            var _loc5_:int = 0;
            var _loc4_:* = _lessonButtons;
            for each(var _loc2_ in _lessonButtons)
            {
               _loc2_.shine = _loc2_.enabled == true;
            }
            return;
         }
         if(FightLibManager.Instance.currentInfo.difficulty < 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.fightLib.ChooseFightLibTypeView.selectDifficulty"));
            var _loc7_:int = 0;
            var _loc6_:* = _levelButtons;
            for each(var _loc3_ in _levelButtons)
            {
               _loc3_.shine = _loc3_.enable == true;
            }
            return;
         }
         CheckWeaponManager.instance.setFunction(this,__start,[param1]);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         _startButton.visible = false;
         _cancelButton.visible = true;
         GameInSocketOut.sendGameStart();
      }
      
      private function __cancel(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         GameInSocketOut.sendCancelWait();
         _cancelButton.visible = false;
         _startButton.visible = true;
      }
      
      public function hideShine() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _lessonButtons;
         for each(var _loc1_ in _lessonButtons)
         {
            if(_loc1_.enabled)
            {
               _loc1_.shine = false;
            }
         }
         var _loc6_:int = 0;
         var _loc5_:* = _levelButtons;
         for each(var _loc2_ in _levelButtons)
         {
            if(_loc2_.enable)
            {
               _loc2_.shine = false;
            }
         }
      }
      
      public function showShine(param1:int) : void
      {
         if(param1 == 1)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _lessonButtons;
            for each(var _loc2_ in _lessonButtons)
            {
               if(_loc2_.enabled)
               {
                  _loc2_.shine = true;
               }
            }
         }
         else if(param1 == 2)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _levelButtons;
            for each(var _loc3_ in _levelButtons)
            {
               if(_loc3_.enable)
               {
                  _loc3_.shine = true;
               }
            }
         }
      }
      
      public function getGuild() : MovieClip
      {
         return _guildMovie;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
            _background = null;
         }
         ObjectUtils.disposeObject(_defaultImg);
         _defaultImg = null;
         ObjectUtils.disposeObject(_background2);
         _background2 = null;
         if(_difficultyImg)
         {
            ObjectUtils.disposeObject(_difficultyImg);
            _difficultyImg = null;
         }
         ObjectUtils.disposeObject(_background3);
         _background3 = null;
         if(_background4)
         {
            ObjectUtils.disposeObject(_background4);
            _background4 = null;
         }
         if(_awardView)
         {
            ObjectUtils.disposeObject(_awardView);
            _awardView = null;
         }
         if(_cancelButton)
         {
            ObjectUtils.disposeObject(_cancelButton);
            _cancelButton = null;
         }
         if(_guildMovie)
         {
            ObjectUtils.disposeObject(_guildMovie);
            _guildMovie = null;
         }
         if(_highButton)
         {
            ObjectUtils.disposeObject(_highButton);
            _highButton = null;
         }
         if(_highGapButton)
         {
            ObjectUtils.disposeObject(_highGapButton);
            _highGapButton = null;
         }
         if(_highThrowButton)
         {
            ObjectUtils.disposeObject(_highThrowButton);
            _highThrowButton = null;
         }
         if(_lassButton)
         {
            ObjectUtils.disposeObject(_lassButton);
            _lassButton = null;
         }
         if(_lowButton)
         {
            ObjectUtils.disposeObject(_lowButton);
            _lowButton = null;
         }
         if(_measureButton)
         {
            ObjectUtils.disposeObject(_measureButton);
            _measureButton = null;
         }
         if(_mediumButton)
         {
            ObjectUtils.disposeObject(_mediumButton);
            _mediumButton = null;
         }
         if(_sixtyFiveButton)
         {
            ObjectUtils.disposeObject(_sixtyFiveButton);
            _sixtyFiveButton = null;
         }
         if(_startButton)
         {
            ObjectUtils.disposeObject(_startButton);
            _startButton = null;
         }
         if(_twentyButton)
         {
            ObjectUtils.disposeObject(_twentyButton);
            _twentyButton = null;
         }
         _selectedLesson = null;
         _selectedLevel = null;
      }
      
      public function set selectedLesson(param1:LessonButton) : void
      {
         var _loc2_:LessonButton = _selectedLesson;
         _selectedLesson = param1;
         _selectedLesson.selected = true;
         if(_loc2_ && _loc2_ != _selectedLesson)
         {
            _loc2_.selected = false;
         }
      }
      
      public function get selectedLesson() : LessonButton
      {
         return _selectedLesson;
      }
      
      public function set selectedLevel(param1:LevelButton) : void
      {
         var _loc2_:LevelButton = _selectedLevel;
         _selectedLevel = param1;
         _selectedLevel.selected = true;
         if(_loc2_ && _loc2_ != _selectedLevel)
         {
            _loc2_.selected = false;
         }
      }
      
      public function get selectedLevel() : LevelButton
      {
         return _selectedLevel;
      }
   }
}
