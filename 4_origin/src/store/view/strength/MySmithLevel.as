package store.view.strength
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import store.view.ConsortiaRateManager;
   
   public class MySmithLevel extends Component
   {
       
      
      private var _bg:Image;
      
      private var _smithTxt:FilterFrameText;
      
      public function MySmithLevel()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBG.MySmithLevelBg");
         addChild(_bg);
         _smithTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBG.MySmithLevelBgText");
         addChild(_smithTxt);
         _change(null);
         tipData = LanguageMgr.GetTranslation("store.StoreIIComposeBG.consortiaSimthLevel");
         if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            visible = false;
         }
      }
      
      private function initEvents() : void
      {
         ConsortiaRateManager.instance.addEventListener("loadComplete_consortia",_change);
         ConsortiaDomainManager.instance.addEventListener("event_get_consortia_info_res",_change);
         SocketManager.Instance.out.getConsortiaDomainConsortiaInfo();
      }
      
      private function removeEvents() : void
      {
         ConsortiaRateManager.instance.removeEventListener("loadComplete_consortia",_change);
         ConsortiaDomainManager.instance.removeEventListener("event_get_consortia_info_res",_change);
      }
      
      private function _change(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         _smithTxt.text = "LV." + ConsortiaRateManager.instance.smithLevel;
         if(ConsortiaDomainManager.instance.activeState == 1)
         {
            _smithTxt.htmlText = LanguageMgr.GetTranslation("consortiadomain.buildState.fight");
         }
         else if(ConsortiaDomainManager.instance.activeState == 0 || ConsortiaDomainManager.instance.activeState == 100)
         {
            _loc3_ = ConsortiaDomainManager.instance.model.allBuildInfo;
            if(_loc3_)
            {
               _loc2_ = _loc3_[4];
            }
            if(_loc2_ && _loc2_.Repair > 0)
            {
               _smithTxt.htmlText = LanguageMgr.GetTranslation("consortiadomain.buildState.waitRepair");
            }
         }
         visible = PlayerManager.Instance.Self.ConsortiaID == 0?false:true;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_smithTxt)
         {
            ObjectUtils.disposeObject(_smithTxt);
         }
         _smithTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
