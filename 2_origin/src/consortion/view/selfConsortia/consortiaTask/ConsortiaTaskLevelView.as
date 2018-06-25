package consortion.view.selfConsortia.consortiaTask
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.view.boss.ConsortiaBossLevelCell;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortiaTaskLevelView extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _levelShowBtn:SimpleBitmapButton;
      
      private var _showSprite:Sprite;
      
      private var _selectedBg:Bitmap;
      
      private var _selectedCellList:Vector.<ConsortiaBossLevelCell>;
      
      private var _selectedSprite:Sprite;
      
      private var _selectedLevel:int;
      
      public function ConsortiaTaskLevelView()
      {
         super();
         _selectedLevel = Math.ceil(PlayerManager.Instance.Self.consortiaInfo.Level / 2);
         initView();
         initEvent();
      }
      
      public function get selectedLevel() : int
      {
         return _selectedLevel;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.conortion.taskLevelBg");
         _levelShowBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.bossFrame.levelShowBtn");
         PositionUtils.setPos(_levelShowBtn,"consortiaTask.levelShowBtnPos");
         _txt = ComponentFactory.Instance.creatComponentByStylename("consortion.taskFrame.levelShowTxt");
         _txt.text = LanguageMgr.GetTranslation("consortiaTaskFrame.levelSelected.levelTxt",_selectedLevel);
         _showSprite = new Sprite();
         _showSprite.addChild(_bg);
         _showSprite.addChild(_txt);
         _showSprite.addChild(_levelShowBtn);
         _showSprite.buttonMode = true;
         _showSprite.mouseChildren = false;
         addChild(_showSprite);
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.conortion.taskLevelSelectedBg");
         _selectedSprite = new Sprite();
         PositionUtils.setPos(_selectedSprite,"consortiaTask.levelSelectedSpritePos");
         _selectedSprite.addChild(_selectedBg);
         _selectedCellList = new Vector.<ConsortiaBossLevelCell>();
         for(i = 0; i < 5; )
         {
            tmp = new ConsortiaBossLevelCell(i + 1);
            tmp.update("consortiaTaskFrame.levelSelected.levelTxt");
            tmp.x = 3;
            tmp.y = 3 + i * 28;
            tmp.changeLightSizePos(115,29,1,5);
            tmp.judgeMaxLevel(_selectedLevel);
            tmp.addEventListener("click",selecteLevelHandler,false,0,true);
            _selectedSprite.addChild(tmp);
            i++;
         }
         addChild(_selectedSprite);
         _selectedSprite.visible = false;
      }
      
      private function initEvent() : void
      {
         _showSprite.addEventListener("click",showOrHideSelectedSprite,false,0,true);
      }
      
      private function selecteLevelHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedLevel = (event.target as ConsortiaBossLevelCell).level;
         _txt.text = LanguageMgr.GetTranslation("consortiaTaskFrame.levelSelected.levelTxt",_selectedLevel);
         _selectedSprite.visible = false;
      }
      
      private function showOrHideSelectedSprite(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectedSprite.visible = !_selectedSprite.visible;
      }
      
      public function dispose() : void
      {
         _showSprite.removeEventListener("click",showOrHideSelectedSprite);
         var _loc3_:int = 0;
         var _loc2_:* = _selectedCellList;
         for each(var tmp in _selectedCellList)
         {
            tmp.removeEventListener("click",selecteLevelHandler);
         }
         ObjectUtils.disposeAllChildren(_showSprite);
         ObjectUtils.disposeAllChildren(_selectedSprite);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _txt = null;
         _bg = null;
         _levelShowBtn = null;
         _showSprite = null;
         _selectedBg = null;
         _selectedCellList = null;
         _selectedSprite = null;
      }
   }
}
