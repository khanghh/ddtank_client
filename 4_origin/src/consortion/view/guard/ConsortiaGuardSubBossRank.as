package consortion.view.guard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaBossDataVo;
   import consortion.guard.ConsortiaGuardControl;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import road7th.data.DictionaryData;
   import uiUtils.SelectPageUI;
   
   public class ConsortiaGuardSubBossRank extends Sprite implements Disposeable
   {
       
      
      private const _totlePage:int = 5;
      
      private var _bg:ScaleBitmapImage;
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _hurtText:FilterFrameText;
      
      private var _attacksNumText:FilterFrameText;
      
      private var _selectPage:SelectPageUI;
      
      private var _currentPage:int;
      
      private var _rankItemList:Vector.<ConsortiaGuardSubBossRankItem>;
      
      public function ConsortiaGuardSubBossRank()
      {
         super();
         _currentPage = 1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.boosRankViewBg");
         addChild(_bg);
         _rankText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.titleText");
         _rankText.text = LanguageMgr.GetTranslation("tanl.consortion.rankingText.text");
         PositionUtils.setPos(_rankText,"consortiaGuard.bossRank.rankTextPos");
         addChild(_rankText);
         _nameText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.titleText");
         _nameText.text = LanguageMgr.GetTranslation("worldboss.ranking.name");
         PositionUtils.setPos(_nameText,"consortiaGuard.bossRank.nameTextPos");
         addChild(_nameText);
         _hurtText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.titleText");
         _hurtText.text = LanguageMgr.GetTranslation("worldboss.ranking.socre");
         PositionUtils.setPos(_hurtText,"consortiaGuard.bossRank.hurtTextPos");
         addChild(_hurtText);
         _attacksNumText = ComponentFactory.Instance.creatComponentByStylename("consortiaGuard.rank.titleText");
         _attacksNumText.text = LanguageMgr.GetTranslation("tank.consortiaGurad.rankattacksNumText");
         PositionUtils.setPos(_attacksNumText,"consortiaGuard.bossRank.attacksNumTextPos");
         addChild(_attacksNumText);
         _selectPage = ComponentFactory.Instance.creatComponentByStylename("uiUtils.SimpleSelectPageUI");
         PositionUtils.setPos(_selectPage,"consortiaGuard.selectPagePos");
         _selectPage.maxPage = 5;
         addChild(_selectPage);
         _rankItemList = new Vector.<ConsortiaGuardSubBossRankItem>();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ConsortiaGuardSubBossRankItem(_loc2_);
            _loc1_.y = 21 + _loc2_ * (_loc1_.height + 11);
            _rankItemList[_loc2_] = _loc1_;
            addChild(_rankItemList[_loc2_]);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _selectPage.addEventListener("change",__pageChange);
      }
      
      protected function __pageChange(param1:Event) : void
      {
         SoundManager.instance.playButtonSound();
         _currentPage = _selectPage.currentPage;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc1_:int = (_currentPage - 1) * 8;
         var _loc4_:int = 40;
         var _loc3_:DictionaryData = ConsortiaGuardControl.Instance.model.rankBossList;
         _loc6_ = 0;
         while(_loc6_ < 8)
         {
            _loc2_ = _loc1_ + _loc6_ + 1;
            _loc5_ = _loc3_[_loc2_] as ConsortiaBossDataVo;
            if(_loc5_)
            {
               if(_loc2_ >= _loc4_)
               {
                  _rankItemList[_loc6_].visible = false;
               }
               else
               {
                  _rankItemList[_loc6_].visible = true;
                  _rankItemList[_loc6_].updata(_loc5_);
               }
            }
            else
            {
               _rankItemList[_loc6_].visible = false;
            }
            _loc6_++;
         }
      }
      
      public function uptaView() : void
      {
         _currentPage = 1;
         _selectPage.currentPage = 1;
         refreshView();
      }
      
      private function removeEvent() : void
      {
         _selectPage.removeEventListener("change",__pageChange);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _loc1_ = 0;
         while(_loc1_ < _rankItemList.length)
         {
            _rankItemList[_loc1_].dispose();
            _loc1_++;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_attacksNumText);
         _attacksNumText = null;
         ObjectUtils.disposeObject(_hurtText);
         _hurtText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_selectPage);
         _selectPage = null;
      }
   }
}
