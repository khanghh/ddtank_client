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
      
      public function PlayerManualProTips()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override protected function init() : void
      {
         super.init();
         tipbackgound = ComponentFactory.Instance.creat("core.simpleSuitTipsBg");
         _tipbackgound.width = 140;
         _tipbackgound.height = 220;
         _title = ComponentFactory.Instance.creatComponentByStylename("explorerManual.playerManual.titleText");
         addChild(_title);
         _tipContainer = new VBox();
         _tipContainer.spacing = 4;
         _tipContainer.y = 37;
         _tipContainer.x = 10;
         addChild(_tipContainer);
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         if(_tipContainer)
         {
            _tipContainer.clearAllChild();
         }
         var _loc7_:PlayerManualProInfo = param1 as PlayerManualProInfo;
         var _loc3_:ManualItemInfo = ExplorerManualManager.instance.getManualInfoByManualLev(Math.max(_loc7_.manual_Level,1));
         _title.text = _loc3_.Name;
         var _loc2_:Array = LanguageMgr.GetTranslation("explorerManual.manualAllPro.name").split(",");
         var _loc6_:Array = ManualProType.proArr;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("explorerManual.playerManual.propertyText");
            _tipContainer.addChild(_loc4_);
            _loc4_.htmlText = _loc2_[_loc5_] + " <font color=\'#76ff80\'>+" + _loc7_[_loc6_[_loc5_]] + "</font>";
            _loc5_++;
         }
         _tipContainer.arrange();
      }
      
      override public function dispose() : void
      {
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         removeChildren();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
