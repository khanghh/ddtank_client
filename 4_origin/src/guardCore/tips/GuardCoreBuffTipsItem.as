package guardCore.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreBuffTipsItem extends Sprite implements Disposeable
   {
       
      
      private var _info:GuardCoreInfo;
      
      private var _icon:Bitmap;
      
      private var _name:FilterFrameText;
      
      public function GuardCoreBuffTipsItem(param1:GuardCoreInfo)
      {
         _info = param1;
         super();
         init();
      }
      
      private function init() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.ddtcorei.guardCoreIcon" + _info.Type);
         addChild(_icon);
         _name = ComponentFactory.Instance.creatComponentByStylename("guardCore.gameTips.text");
         _name.text = _info.Name + ":" + _info.TipsDescription;
         addChild(_name);
      }
      
      public function get info() : GuardCoreInfo
      {
         return _info;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         ObjectUtils.disposeObject(_name);
         _info = null;
         _icon = null;
         _name = null;
      }
   }
}
