package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelController;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import trainer.view.NewHandContainer;
   
   public class EstablishmentFrame extends Frame
   {
       
      
      private var _shop:BaseButton;
      
      private var _bank:BaseButton;
      
      private var _skill:BaseButton;
      
      private var _bg:Bitmap;
      
      public function EstablishmentFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("redpkg.frameTitle.select");
         escEnable = true;
         _titleText = LanguageMgr.GetTranslation("tank.consortia.establishmentFrame.title");
         _bg = ComponentFactory.Instance.creatBitmap("asset.building.establish.bg");
         _bg.x = 16;
         _bg.y = 42;
         _shop = ComponentFactory.Instance.creatComponentByStylename("buildingManager.shop");
         _bank = ComponentFactory.Instance.creatComponentByStylename("buildingManager.bank");
         _skill = ComponentFactory.Instance.creatComponentByStylename("buildingManager.skill");
         addToContent(_bg);
         addToContent(_shop);
         addToContent(_bank);
         addToContent(_skill);
         addEvents();
      }
      
      private function addEvents() : void
      {
         _shop.addEventListener("click",__onClickHandler);
         _bank.addEventListener("click",__onClickHandler);
         _skill.addEventListener("click",__onClickHandler);
         addEventListener("response",_response);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      private function __onClickHandler(event:MouseEvent) : void
      {
         var skillFrame:* = null;
         SoundManager.instance.play("008");
         var _loc3_:* = event.currentTarget;
         if(_shop !== _loc3_)
         {
            if(_bank !== _loc3_)
            {
               if(_skill !== _loc3_)
               {
                  return;
               }
               skillFrame = ComponentFactory.Instance.creatComponentByStylename("consortionSkillFrame");
               LayerManager.Instance.addToLayer(skillFrame,3,true,1);
            }
            else
            {
               ConsortionModelController.Instance.alertBankFrame();
            }
         }
         else
         {
            ConsortionModelManager.Instance.alertShopFrame();
            if(!PlayerManager.Instance.Self.isNewOnceFinish(129))
            {
               SocketManager.Instance.out.syncWeakStep(129);
            }
            NewHandContainer.Instance.clearArrowByID(143);
         }
         close();
      }
      
      private function removeEvent() : void
      {
         if(_shop)
         {
            _shop.removeEventListener("click",__onClickHandler);
         }
         if(_bank)
         {
            _bank.removeEventListener("click",__onClickHandler);
         }
         if(_skill)
         {
            _skill.removeEventListener("click",__onClickHandler);
         }
         removeEventListener("response",_response);
      }
      
      override public function set backgound(image:DisplayObject) : void
      {
         .super.backgound = image;
         (_backgound as MutipleImage).getChildAt(0)["getChildAt"](1)["alpha"] = 0;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_shop)
         {
            ObjectUtils.disposeObject(_shop);
         }
         _shop = null;
         if(_bank)
         {
            ObjectUtils.disposeObject(_bank);
         }
         _bank = null;
         if(_skill)
         {
            ObjectUtils.disposeObject(_skill);
         }
         _skill = null;
      }
   }
}
