package gameCommon.view.effects
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StarlingObjectUtils;
   import flash.display.Bitmap;
   import gameCommon.model.Living;
   import road7th.StarlingMain;
   import starling.display.Image;
   
   public class BaseMirariEffectIcon
   {
      
      public static const MIRARI_TYPE:int = 0;
       
      
      protected var _icon:Bitmap;
      
      protected var _iconImage:Image;
      
      protected var _iconClass:String;
      
      protected var _iconImageClass:String;
      
      protected var _executed:Boolean = true;
      
      public var src:int = -1;
      
      public function BaseMirariEffectIcon()
      {
         super();
      }
      
      public function get single() : Boolean
      {
         return false;
      }
      
      public function get mirariType() : int
      {
         return 0;
      }
      
      public function getEffectIcon() : Bitmap
      {
         _icon = ComponentFactory.Instance.creatBitmap(_iconClass) as Bitmap;
         return _icon;
      }
      
      public function getEffectIconImage() : Image
      {
         _iconImage = StarlingMain.instance.createImage(_iconClass);
         return _iconImage;
      }
      
      public function excuteEffect(live:Living) : void
      {
         excuteEffectImp(live);
      }
      
      protected function excuteEffectImp(live:Living) : void
      {
         _executed = true;
      }
      
      public function unExcuteEffect(live:Living) : void
      {
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         StarlingObjectUtils.disposeObject(_iconImage);
         _icon = null;
         _iconImage = null;
      }
   }
}
