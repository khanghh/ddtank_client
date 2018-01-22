package horse.amulet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import horse.HorseAmuletManager;
   
   public class HorseAmuletMainView extends Frame
   {
       
      
      private var _mainBg:ScaleBitmapImage;
      
      private var _bgView:HorseAmuletBagView;
      
      private var _equipView:HorseAmuletEquipView;
      
      private var _activateView:HorseAmuletActivateView;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function HorseAmuletMainView()
      {
         super();
         HorseAmuletManager.instance.viewType = 1;
         __onUpdateLeftView(null);
         initEvent();
      }
      
      override protected function init() : void
      {
         _mainBg = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.mainViewBg");
         _equipView = new HorseAmuletEquipView();
         PositionUtils.setPos(_equipView,"horseAmulet.equipViewPos");
         addChild(_equipView);
         _activateView = new HorseAmuletActivateView();
         PositionUtils.setPos(_activateView,"horseAmulet.activateViewPos");
         addChild(_activateView);
         _bgView = new HorseAmuletBagView();
         PositionUtils.setPos(_bgView,"horseAmulet.bagViewPos");
         super.init();
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall","horseAmulet.helpPos",LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.horseAmulet.help",450,540) as SimpleBitmapButton;
         titleText = LanguageMgr.GetTranslation("tank.horseAmulet.title");
      }
      
      private function __onUpdateLeftView(param1:Event) : void
      {
         var _loc2_:int = HorseAmuletManager.instance.viewType;
         if(_loc2_ == 1)
         {
            _equipView.visible = true;
            _activateView.visible = false;
         }
         else if(_loc2_ == 2)
         {
            _equipView.visible = false;
            _activateView.visible = true;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_mainBg)
         {
            addToContent(_mainBg);
         }
         if(_equipView)
         {
            addToContent(_equipView);
         }
         if(_activateView)
         {
            addToContent(_activateView);
         }
         if(_bgView)
         {
            addToContent(_bgView);
         }
      }
      
      override protected function onResponse(param1:int) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      private function initEvent() : void
      {
         HorseAmuletManager.instance.addEventListener("change",__onUpdateLeftView);
      }
      
      private function removeEvent() : void
      {
         HorseAmuletManager.instance.removeEventListener("change",__onUpdateLeftView);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         _bgView = null;
         _mainBg = null;
         _equipView = null;
         _activateView = null;
      }
   }
}
