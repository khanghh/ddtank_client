package consortion.view.boss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortiaBossLevelView extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _levelShowBtn:SimpleBitmapButton;
      
      private var _showSprite:Sprite;
      
      private var _selectedBg:Bitmap;
      
      private var _selectedSprite:Sprite;
      
      private var _selectedLevel:int;
      
      private var _cellList:Vector.<ConsortiaBossLevelCell>;
      
      public var currentFrame:int;
      
      public function ConsortiaBossLevelView()
      {
         super();
         _selectedLevel = ConsortionModelManager.Instance.getCanCallBossMaxLevel();
         initView();
         initEvent();
      }
      
      public function set selectedLevel(param1:int) : void
      {
         param1 = currentFrame == 0?param1:Math.min(param1,12);
         _selectedLevel = param1;
         _txt.text = getcurrentFrameText();
      }
      
      public function get selectedLevel() : int
      {
         return _selectedLevel;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortionBossFrame.levelBg");
         _levelShowBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.levelShowBtn");
         _txt = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.levelShowTxt");
         _txt.text = getcurrentFrameText();
         _showSprite = new Sprite();
         _showSprite.addChild(_bg);
         _showSprite.addChild(_txt);
         _showSprite.addChild(_levelShowBtn);
         _showSprite.buttonMode = true;
         _showSprite.mouseChildren = false;
         addChild(_showSprite);
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.consortionBossFrame.levelSelectedBg");
         _selectedSprite = new Sprite();
         PositionUtils.setPos(_selectedSprite,"consortiaBoss.levelView.selectedSpritePos");
         _selectedSprite.addChild(_selectedBg);
         _cellList = new Vector.<ConsortiaBossLevelCell>();
         _loc2_ = 0;
         while(_loc2_ < ConsortionModelManager.Instance.bossMaxLv)
         {
            _loc1_ = new ConsortiaBossLevelCell(_loc2_ + 1);
            _loc1_.x = 3 + _loc2_ % 2 * 136;
            _loc1_.y = 3 + int(_loc2_ / 2) * 34.5;
            _loc1_.judgeMaxLevel(_selectedLevel);
            _loc1_.addEventListener("click",selecteLevelHandler,false,0,true);
            _selectedSprite.addChild(_loc1_);
            _cellList.push(_loc1_);
            _loc2_++;
         }
         addChild(_selectedSprite);
         _selectedSprite.visible = false;
      }
      
      private function initEvent() : void
      {
         _showSprite.addEventListener("click",showOrHideSelectedSprite,false,0,true);
      }
      
      private function selecteLevelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedLevel = (param1.target as ConsortiaBossLevelCell).level;
         _txt.text = getcurrentFrameText();
         _selectedSprite.visible = false;
      }
      
      public function reset() : void
      {
         var _loc2_:int = 0;
         selectedLevel = ConsortionModelManager.Instance.getCanCallBossMaxLevel();
         _selectedSprite.visible = false;
         var _loc1_:int = currentFrame == 0?_cellList.length:12;
         _loc2_ = 0;
         while(_loc2_ < _cellList.length)
         {
            _selectedSprite.removeChild(_cellList[_loc2_]);
            _cellList[_loc2_].update("consortiaBossFrame.levelSelected.levelTxt" + currentFrame);
            if(currentFrame == 1 && _loc2_ >= 12)
            {
               _cellList[_loc2_].visible = false;
            }
            else
            {
               _cellList[_loc2_].visible = true;
            }
            _selectedSprite.addChild(_cellList[_loc2_]);
            _loc2_++;
         }
      }
      
      private function showOrHideSelectedSprite(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedSprite.visible = !_selectedSprite.visible;
      }
      
      private function getcurrentFrameText() : String
      {
         return LanguageMgr.GetTranslation("consortiaBossFrame.levelSelected.levelTxt" + currentFrame,_selectedLevel);
      }
      
      public function dispose() : void
      {
         _showSprite.removeEventListener("click",showOrHideSelectedSprite);
         var _loc3_:int = 0;
         var _loc2_:* = _cellList;
         for each(var _loc1_ in _cellList)
         {
            _loc1_.removeEventListener("click",selecteLevelHandler);
         }
         ObjectUtils.disposeAllChildren(_showSprite);
         ObjectUtils.disposeAllChildren(_selectedSprite);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _cellList.splice(0,_cellList.length);
         _cellList = null;
         _txt = null;
         _bg = null;
         _levelShowBtn = null;
         _showSprite = null;
         _selectedBg = null;
         _selectedSprite = null;
      }
   }
}
