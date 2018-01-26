package growthPackage.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import growthPackage.GrowthPackageManager;
   import growthPackage.event.GrowthPackageEvent;
   
   public class GrowthPackageFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _explainTxt:FilterFrameText;
      
      private var _itemsSprite:Sprite;
      
      private var _items:Vector.<GrowthPackageItem>;
      
      public function GrowthPackageFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __dataChange(param1:GrowthPackageEvent) : void{}
      
      private function updateItems() : void{}
      
      private function updateItem(param1:int) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
