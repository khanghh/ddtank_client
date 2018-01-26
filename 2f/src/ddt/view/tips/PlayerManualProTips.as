package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import explorerManual.ExplorerManualManager;
   import explorerManual.data.ManualProType;
   import explorerManual.data.model.ManualItemInfo;
   import explorerManual.data.model.PlayerManualProInfo;
   
   public class PlayerManualProTips extends BaseTip
   {
       
      
      private var _title:FilterFrameText;
      
      private var _tipContainer:VBox;
      
      public function PlayerManualProTips(){super();}
      
      override protected function init() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      override public function dispose() : void{}
   }
}
