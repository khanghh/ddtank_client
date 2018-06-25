package horse.amulet
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import horse.HorseAmuletManager;
   
   public class HorseAmuletMainView extends Sprite implements Disposeable
   {
       
      
      private var _mainBg:ScaleBitmapImage;
      
      private var _bgView:HorseAmuletBagView;
      
      private var _equipView:HorseAmuletEquipView;
      
      private var _activateView:HorseAmuletActivateView;
      
      public function HorseAmuletMainView()
      {
         super();
         HorseAmuletManager.instance.viewType = 1;
         initView();
         __onUpdateLeftView(null);
         initEvent();
      }
      
      protected function initView() : void
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
         if(_mainBg)
         {
            addChild(_mainBg);
         }
         if(_equipView)
         {
            addChild(_equipView);
         }
         if(_activateView)
         {
            addChild(_activateView);
         }
         if(_bgView)
         {
            addChild(_bgView);
         }
      }
      
      private function __onUpdateLeftView(e:Event) : void
      {
         var type:int = HorseAmuletManager.instance.viewType;
         if(type == 1)
         {
            _equipView.visible = true;
            _activateView.visible = false;
         }
         else if(type == 2)
         {
            _equipView.visible = false;
            _activateView.visible = true;
         }
      }
      
      private function initEvent() : void
      {
         HorseAmuletManager.instance.addEventListener("change",__onUpdateLeftView);
      }
      
      private function removeEvent() : void
      {
         HorseAmuletManager.instance.removeEventListener("change",__onUpdateLeftView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bgView = null;
         _mainBg = null;
         _equipView = null;
         _activateView = null;
      }
   }
}
