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
      
      override public function set tipData(data:Object) : void
      {
         var totalPro:* = null;
         var i:int = 0;
         if(_tipContainer)
         {
            _tipContainer.clearAllChild();
         }
         var info:PlayerManualProInfo = data as PlayerManualProInfo;
         var itemInfo:ManualItemInfo = ExplorerManualManager.instance.getManualInfoByManualLev(Math.max(info.manual_Level,1));
         _title.text = itemInfo.Name;
         var lan:Array = LanguageMgr.GetTranslation("explorerManual.manualAllPro.name").split(",");
         var proArr:Array = ManualProType.proArr;
         for(i = 0; i < proArr.length; )
         {
            totalPro = ComponentFactory.Instance.creatComponentByStylename("explorerManual.playerManual.propertyText");
            _tipContainer.addChild(totalPro);
            totalPro.htmlText = lan[i] + " <font color=\'#76ff80\'>+" + info[proArr[i]] + "</font>";
            i++;
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
