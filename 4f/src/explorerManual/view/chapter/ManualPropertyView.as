package explorerManual.view.chapter
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import explorerManual.data.ManualLevelProInfo;
   import flash.display.Sprite;
   
   public class ManualPropertyView extends Sprite implements Disposeable
   {
       
      
      private var _titleTxt:FilterFrameText;
      
      private var _magicAttack:FilterFrameText;
      
      private var _magicResistance:FilterFrameText;
      
      private var _boost:FilterFrameText;
      
      private var _proInfo:ManualLevelProInfo;
      
      public function ManualPropertyView(){super();}
      
      private function initView() : void{}
      
      public function set info(param1:ManualLevelProInfo) : void{}
      
      private function update() : void{}
      
      public function dispose() : void{}
   }
}
