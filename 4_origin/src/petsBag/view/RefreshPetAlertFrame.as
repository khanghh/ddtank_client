package petsBag.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class RefreshPetAlertFrame extends BaseAlerFrame
   {
       
      
      private var _bgTitle:DisplayObject;
      
      private var _alertTips:FilterFrameText;
      
      private var _alertTips2:FilterFrameText;
      
      private var _refreshSelBtn:SelectedCheckButton;
      
      private var _selecedItem:DoubleSelectedItem;
      
      public function RefreshPetAlertFrame()
      {
         super();
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.title = LanguageMgr.GetTranslation("ddt.farms.refreshPetsAlert");
         _loc1_.bottomGap = 37;
         _loc1_.buttonGape = 65;
         _loc1_.customPos = ComponentFactory.Instance.creat("farm.refreshPetAlertBtnPos");
         this.info = _loc1_;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgTitle = ComponentFactory.Instance.creat("assets.farm.titleSmall");
         addChild(_bgTitle);
         PositionUtils.setPos(_bgTitle,PositionUtils.creatPoint("farm.refreshPetAlertTitlePos"));
         _alertTips = ComponentFactory.Instance.creatComponentByStylename("farm.text.refreshPetAlertTips");
         addToContent(_alertTips);
         _alertTips2 = ComponentFactory.Instance.creatComponentByStylename("farm.text.refreshPetAlertTips2");
         addToContent(_alertTips2);
         _alertTips.text = LanguageMgr.GetTranslation("ddt.farms.refreshPetsAlertContonet");
         _alertTips2.text = String(PetconfigAnalyzer.PetCofnig.AdoptRefereshCost) + LanguageMgr.GetTranslation("money");
         _refreshSelBtn = ComponentFactory.Instance.creatComponentByStylename("farm.refreshPet.selectBtn");
         addToContent(_refreshSelBtn);
         _refreshSelBtn.text = LanguageMgr.GetTranslation("ddt.farms.refreshPetsNOAlert");
         _selecedItem = new DoubleSelectedItem();
         _selecedItem.x = 171;
         _selecedItem.y = 105;
         addToContent(_selecedItem);
      }
      
      public function getBind() : Boolean
      {
         return _selecedItem.isBind;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__framePesponse);
         _refreshSelBtn.addEventListener("select",__noAlertTip);
      }
      
      private function __noAlertTip(param1:Event) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.isRefreshPet = _refreshSelBtn.selected;
         SharedManager.Instance.isRefreshBand = _selecedItem.isBind;
      }
      
      protected function __framePesponse(param1:FrameEvent) : void
      {
         removeEventListener("response",__framePesponse);
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
            case 2:
            case 3:
               return;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__framePesponse);
      }
      
      override public function dispose() : void
      {
         if(_bgTitle)
         {
            ObjectUtils.disposeObject(_bgTitle);
            _bgTitle = null;
         }
         if(_refreshSelBtn)
         {
            ObjectUtils.disposeObject(_refreshSelBtn);
            _refreshSelBtn = null;
         }
         if(_alertTips2)
         {
            ObjectUtils.disposeObject(_alertTips2);
            _alertTips2 = null;
         }
         if(_alertTips)
         {
            ObjectUtils.disposeObject(_alertTips);
            _alertTips = null;
         }
         ObjectUtils.disposeObject(_selecedItem);
         super.dispose();
      }
   }
}
