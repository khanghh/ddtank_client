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
      
      public function ConsortiaGuardSubBossRank(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __pageChange(param1:Event) : void{}
      
      private function refreshView() : void{}
      
      public function uptaView() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
