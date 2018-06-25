package petsBag.view
{
   import bagAndInfo.bag.BagView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import petsBag.PetsBagControl;
   import petsBag.PetsBagManager;
   
   public class PetsView extends Frame
   {
       
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _bottom:ScaleBitmapImage;
      
      private var _petsBagOutView:PetsBagOutView;
      
      private var _bagView:BagView;
      
      public function PetsView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("petBag.view.titleText");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"petsBag.button.helpBtn",null,LanguageMgr.GetTranslation("ddt.petsBag.readme"),"petsBag.helpFrame.petText",404,484) as SimpleBitmapButton;
         _bottom = ComponentFactory.Instance.creatComponentByStylename("petsBag.petsView.frameBottom");
         addToContent(_bottom);
         _petsBagOutView = ComponentFactory.Instance.creatCustomObject("petsBagOutPnl");
         addToContent(_petsBagOutView);
         _petsBagOutView.infoPlayer = PlayerManager.Instance.Self;
         PetsBagManager.instance().view = _petsBagOutView;
         _bagView = new BagView();
         _bagView.breakBtnEnable = false;
         _bagView.breakBtnFilter = ComponentFactory.Instance.creatFilters("grayFilter");
         _bagView.isScreenFood = true;
         _bagView.setBagType(5);
         _bagView.info = PlayerManager.Instance.Self;
         _bagView.enableOrdisableSB(true);
         _bagView.showOrHideSB(true);
         _bagView.enableDressSelectedBtn(false);
         _bagView.deleteButtonForPet();
         _bagView.doubleClickEnabled = true;
         PlayerManager.Instance.Self.PropBag.sortBag(5,PlayerManager.Instance.Self.getBag(5),0,48,false);
         PositionUtils.setPos(_bagView,"petsBagView.bagView.pos");
         addToContent(_bagView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _bagView.addEventListener("dragStart",__startShine);
         _bagView.addEventListener("dragStop",__stopShine);
         _bagView.addEventListener("tabChange",__changeHandler);
         PetsBagManager.instance().petBreakInfoRequire();
      }
      
      private function __startShine(event:CellEvent) : void
      {
         if(event.data is ItemTemplateInfo)
         {
            if((event.data as ItemTemplateInfo).CategoryID == 34)
            {
               if(_petsBagOutView)
               {
                  _petsBagOutView.startShine();
               }
            }
            else if((event.data as ItemTemplateInfo).CategoryID == 50)
            {
               if(_petsBagOutView)
               {
                  _petsBagOutView.playShined(0);
               }
            }
            else if((event.data as ItemTemplateInfo).CategoryID == 52)
            {
               if(_petsBagOutView)
               {
                  _petsBagOutView.playShined(2);
               }
            }
            else if((event.data as ItemTemplateInfo).CategoryID == 51)
            {
               if(_petsBagOutView)
               {
                  _petsBagOutView.playShined(1);
               }
            }
         }
      }
      
      private function __stopShine(event:CellEvent) : void
      {
         if(_petsBagOutView)
         {
            _petsBagOutView.stopShine();
         }
         if(_petsBagOutView)
         {
            _petsBagOutView.stopShined(0);
         }
         if(_petsBagOutView)
         {
            _petsBagOutView.stopShined(1);
         }
         if(_petsBagOutView)
         {
            _petsBagOutView.stopShined(2);
         }
      }
      
      private function __changeHandler(event:Event) : void
      {
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _bagView.removeEventListener("dragStart",__startShine);
         _bagView.removeEventListener("dragStop",__stopShine);
         _bagView.removeEventListener("tabChange",__changeHandler);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               PetsBagControl.instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         PetsBagManager.instance().isShow = false;
         removeEvent();
         if(_petsBagOutView)
         {
            ObjectUtils.disposeObject(_petsBagOutView);
         }
         _petsBagOutView = null;
         PetsBagManager.instance().view = null;
         if(_bottom)
         {
            ObjectUtils.disposeObject(_bottom);
         }
         _bottom = null;
         if(_bagView)
         {
            ObjectUtils.disposeObject(_bagView);
         }
         _bagView = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
