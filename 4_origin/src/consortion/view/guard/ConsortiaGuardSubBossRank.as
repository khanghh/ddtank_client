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
         var i:int = 0;
         var tmpItem:* = null;
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
         for(i = 0; i < 8; )
         {
            tmpItem = new ConsortiaGuardSubBossRankItem(i);
            tmpItem.y = 21 + i * (tmpItem.height + 11);
            _rankItemList[i] = tmpItem;
            addChild(_rankItemList[i]);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _selectPage.addEventListener("change",__pageChange);
      }
      
      protected function __pageChange(event:Event) : void
      {
         SoundManager.instance.playButtonSound();
         _currentPage = _selectPage.currentPage;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var i:int = 0;
         var tmpTag:int = 0;
         var vo:* = null;
         var startIndex:int = (_currentPage - 1) * 8;
         var tmpCount:int = 40;
         var list:DictionaryData = ConsortiaGuardControl.Instance.model.rankBossList;
         for(i = 0; i < 8; )
         {
            tmpTag = startIndex + i + 1;
            vo = list[tmpTag] as ConsortiaBossDataVo;
            if(vo)
            {
               if(tmpTag >= tmpCount)
               {
                  _rankItemList[i].visible = false;
               }
               else
               {
                  _rankItemList[i].visible = true;
                  _rankItemList[i].updata(vo);
               }
            }
            else
            {
               _rankItemList[i].visible = false;
            }
            i++;
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
         var i:int = 0;
         removeEvent();
         for(i = 0; i < _rankItemList.length; )
         {
            _rankItemList[i].dispose();
            i++;
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
