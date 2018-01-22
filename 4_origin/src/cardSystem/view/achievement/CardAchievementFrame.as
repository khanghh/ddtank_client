package cardSystem.view.achievement
{
   import cardSystem.CardManager;
   import cardSystem.CardSystemEvent;
   import cardSystem.data.CardAchievementInfo;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import newTitle.NewTitleManager;
   import road7th.data.DictionaryData;
   
   public class CardAchievementFrame extends Frame
   {
       
      
      private var _attackText:FilterFrameText;
      
      private var _defendText:FilterFrameText;
      
      private var _luckyText:FilterFrameText;
      
      private var _guardText:FilterFrameText;
      
      private var _bloodText:FilterFrameText;
      
      private var _damageText:FilterFrameText;
      
      private var _mAttackText:FilterFrameText;
      
      private var _mDefendText:FilterFrameText;
      
      private var _achievementNumTitle:FilterFrameText;
      
      private var _achievementAllTitle:FilterFrameText;
      
      private var _progressText:FilterFrameText;
      
      private var _achievementList:DictionaryData;
      
      private var _maskProgress:Sprite;
      
      private var _progress:ScaleLeftRightImage;
      
      private var _progressBg:ScaleLeftRightImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _listBg:Bitmap;
      
      private var _propertyBg:Bitmap;
      
      private var _allProgress:Bitmap;
      
      private var _list:ListPanel;
      
      public function CardAchievementFrame()
      {
         super();
         initEvent();
         update();
      }
      
      override protected function init() : void
      {
         _achievementList = new DictionaryData();
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.bg");
         _listBg = ComponentFactory.Instance.creatBitmap("asset.cardAchievement.listBg");
         _attackText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.propertyText");
         _defendText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.propertyText");
         _luckyText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.propertyText");
         _guardText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.propertyText");
         _bloodText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.propertyText");
         _damageText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.propertyText");
         _mAttackText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.propertyText");
         _mDefendText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.propertyText");
         _progressText = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.progressText");
         _achievementNumTitle = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.numText");
         _achievementAllTitle = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.numAllText");
         _progress = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.progress");
         _progressBg = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.progressBg");
         _maskProgress = new Sprite();
         PositionUtils.setPos(_maskProgress,_progress);
         _progress.mask = _maskProgress;
         _propertyBg = ComponentFactory.Instance.creatBitmap("asset.cardAchievement.propertyBG");
         _allProgress = ComponentFactory.Instance.creatBitmap("asset.cardAchievement.allProgress");
         _list = ComponentFactory.Instance.creatComponentByStylename("ddt.cardAchievement.list");
         PositionUtils.setPos(_attackText,"ddt.cardAchievement.propertyPos1");
         PositionUtils.setPos(_defendText,"ddt.cardAchievement.propertyPos2");
         PositionUtils.setPos(_luckyText,"ddt.cardAchievement.propertyPos3");
         PositionUtils.setPos(_guardText,"ddt.cardAchievement.propertyPos4");
         PositionUtils.setPos(_bloodText,"ddt.cardAchievement.propertyPos5");
         PositionUtils.setPos(_damageText,"ddt.cardAchievement.propertyPos6");
         PositionUtils.setPos(_mAttackText,"ddt.cardAchievement.propertyPos7");
         PositionUtils.setPos(_mDefendText,"ddt.cardAchievement.propertyPos8");
         super.init();
         titleText = LanguageMgr.GetTranslation("tank.card.achievement.title");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addToContent(_bg);
         }
         if(_listBg)
         {
            addToContent(_listBg);
         }
         if(_propertyBg)
         {
            addToContent(_propertyBg);
         }
         if(_allProgress)
         {
            addToContent(_allProgress);
         }
         if(_attackText)
         {
            addToContent(_attackText);
         }
         if(_defendText)
         {
            addToContent(_defendText);
         }
         if(_luckyText)
         {
            addToContent(_luckyText);
         }
         if(_guardText)
         {
            addToContent(_guardText);
         }
         if(_bloodText)
         {
            addToContent(_bloodText);
         }
         if(_damageText)
         {
            addToContent(_damageText);
         }
         if(_mAttackText)
         {
            addToContent(_mAttackText);
         }
         if(_mDefendText)
         {
            addToContent(_mDefendText);
         }
         if(_progressBg)
         {
            addToContent(_progressBg);
         }
         if(_progress)
         {
            addToContent(_progress);
         }
         if(_maskProgress)
         {
            addToContent(_maskProgress);
         }
         if(_progressText)
         {
            addToContent(_progressText);
         }
         if(_achievementNumTitle)
         {
            addToContent(_achievementNumTitle);
         }
         if(_achievementAllTitle)
         {
            addToContent(_achievementAllTitle);
         }
         if(_list)
         {
            addToContent(_list);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function __onCardAchievementUpdate(param1:CardSystemEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         _attackText.text = String(CardManager.Instance.model.achievementProperty[0]);
         _defendText.text = String(CardManager.Instance.model.achievementProperty[1]);
         _luckyText.text = String(CardManager.Instance.model.achievementProperty[2]);
         _guardText.text = String(CardManager.Instance.model.achievementProperty[3]);
         _bloodText.text = String(CardManager.Instance.model.achievementProperty[4]);
         _damageText.text = String(CardManager.Instance.model.achievementProperty[5]);
         _mAttackText.text = String(CardManager.Instance.model.achievementProperty[6]);
         _mDefendText.text = String(CardManager.Instance.model.achievementProperty[7]);
         updateProgress();
         updateList();
      }
      
      private function updateProgress() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = CardManager.Instance.model.achievementData;
         for each(var _loc5_ in CardManager.Instance.model.achievementData)
         {
            if(NewTitleManager.instance.titleInfo[_loc5_.Honor_id])
            {
               _loc4_++;
               if(CardManager.Instance.cardAchievementGet(_loc5_.AchievementID))
               {
                  _loc2_++;
               }
            }
            if(CardManager.Instance.cardAchievementGet(_loc5_.AchievementID))
            {
               _loc3_++;
            }
         }
         _achievementNumTitle.text = _loc2_.toString();
         _achievementAllTitle.text = "/" + _loc4_.toString();
         _progressText.text = Math.ceil(_loc3_ / CardManager.Instance.model.achievementData.length * 100) + "%";
         var _loc1_:int = Math.ceil(_loc3_ / CardManager.Instance.model.achievementData.length * _progress.width);
         _maskProgress.graphics.clear();
         _maskProgress.graphics.beginFill(0);
         _maskProgress.graphics.drawRect(0,0,_loc1_,_progress.height);
         _maskProgress.graphics.endFill();
      }
      
      public function updateList() : void
      {
         var _loc1_:DictionaryData = new DictionaryData();
         var _loc5_:int = 0;
         var _loc4_:* = CardManager.Instance.model.achievementData;
         for each(var _loc3_ in CardManager.Instance.model.achievementData)
         {
            if(_loc1_.hasKey(_loc3_.Type))
            {
               if(_loc1_[_loc3_.Type].AchievementID > _loc3_.AchievementID)
               {
                  if(!CardManager.Instance.cardAchievementGet(_loc3_.AchievementID))
                  {
                     _loc1_.add(_loc3_.Type,_loc3_);
                  }
               }
               else if(CardManager.Instance.cardAchievementGet(_loc1_[_loc3_.Type].AchievementID))
               {
                  _loc1_.add(_loc3_.Type,_loc3_);
               }
            }
            else
            {
               _loc1_.add(_loc3_.Type,_loc3_);
            }
         }
         var _loc2_:Array = _loc1_.list.concat();
         _loc1_.clear();
         _loc2_.sort(sortInfo);
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_loc2_);
         _list.list.updateListView();
      }
      
      private function sortInfo(param1:CardAchievementInfo, param2:CardAchievementInfo) : int
      {
         var _loc4_:Boolean = CardManager.Instance.cardAchievementComplete(param1.AchievementID);
         var _loc6_:Boolean = CardManager.Instance.cardAchievementComplete(param2.AchievementID);
         var _loc3_:Boolean = CardManager.Instance.cardAchievementGet(param1.AchievementID);
         var _loc5_:Boolean = CardManager.Instance.cardAchievementGet(param2.AchievementID);
         if(_loc4_ && !_loc6_ || !_loc3_ && _loc5_)
         {
            return -1;
         }
         if(!_loc4_ && _loc6_ || _loc3_ && !_loc5_)
         {
            return 1;
         }
         if(param1.AchievementID < param2.AchievementID)
         {
            return -1;
         }
         return 1;
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function initEvent() : void
      {
         CardManager.Instance.addEventListener("cardachievementupdate",__onCardAchievementUpdate);
         _list.list.addEventListener("listItemClick",__itemClick);
      }
      
      private function removeEvent() : void
      {
         CardManager.Instance.removeEventListener("cardachievementupdate",__onCardAchievementUpdate);
         _list.list.removeEventListener("listItemClick",__itemClick);
      }
      
      override public function dispose() : void
      {
         SoundManager.instance.playButtonSound();
         removeEvent();
         _achievementList.clear();
         CardManager.Instance.isOpenCardAchievementsView = false;
         super.dispose();
         _attackText = null;
         _defendText = null;
         _luckyText = null;
         _guardText = null;
         _bloodText = null;
         _damageText = null;
         _mAttackText = null;
         _mDefendText = null;
         _achievementList = null;
         _achievementNumTitle = null;
         _achievementAllTitle = null;
         _progressText = null;
         _progress = null;
         _progressBg = null;
         _propertyBg = null;
         _allProgress = null;
         _bg = null;
         _listBg = null;
         _maskProgress = null;
         _list = null;
      }
   }
}
