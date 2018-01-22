package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.display.BitmapLoaderProxy;
   import ddt.manager.PathManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class PetTip extends BaseTip
   {
      
      private static const PET_ICON_SIZE:int = 35;
       
      
      private var _petName:FilterFrameText;
      
      private var _petIcon:BitmapLoaderProxy;
      
      private var _petIconContainer:Sprite;
      
      private var _petLevel:FilterFrameText;
      
      private var _bg:Image;
      
      public function PetTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _petName = ComponentFactory.Instance.creatComponentByStylename("petTip.PetName");
         _petLevel = ComponentFactory.Instance.creatComponentByStylename("petTip.PetLevel");
         _petIconContainer = new Sprite();
         PositionUtils.setPos(_petIconContainer,"petTip.PetIconPos");
         super.init();
         .super.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_petName);
         addChild(_petLevel);
         addChild(_petIconContainer);
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1)
         {
            if(_petIcon)
            {
               ObjectUtils.disposeObject(_petIcon);
            }
            _tipData = param1;
            _petName.text = String(param1["petName"]);
            _petLevel.text = "Lv." + String(param1["petLevel"]);
            _petIcon = new BitmapLoaderProxy(PathManager.solvePetIconUrl(String(param1["petIconUrl"])),new Rectangle(0,0,35,35),true);
            _petIconContainer.addChild(_petIcon);
            updateWH();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_petName);
         _petName = null;
         ObjectUtils.disposeObject(_petLevel);
         _petLevel = null;
         ObjectUtils.disposeObject(_petIcon);
         _petIcon = null;
         ObjectUtils.disposeObject(_petIconContainer);
         _petIconContainer = null;
      }
      
      private function updateWH() : void
      {
         width = 114;
         _bg.width = 114;
         height = 70;
         _bg.height = 70;
      }
   }
}
