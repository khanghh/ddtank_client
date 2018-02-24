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
      
      public function CardAchievementFrame(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      public function show() : void{}
      
      private function __onCardAchievementUpdate(param1:CardSystemEvent) : void{}
      
      private function update() : void{}
      
      private function updateProgress() : void{}
      
      public function updateList() : void{}
      
      private function sortInfo(param1:CardAchievementInfo, param2:CardAchievementInfo) : int{return 0;}
      
      private function __itemClick(param1:ListItemEvent) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
