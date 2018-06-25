package exitPrompt
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class ExitButtonItem extends Component
   {
       
      
      private var _bt:BaseButton;
      
      private var _fontBg:Bitmap;
      
      public var fontBgBgUrl:String;
      
      public var coord:String;
      
      private var _light:ScaleBitmapImage;
      
      public function ExitButtonItem()
      {
         super();
         mouseChildren = false;
         buttonMode = true;
         initEvent();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         var coordArr:Array = coord.split(/,/g);
         if(!_bt)
         {
            _bt = ComponentFactory.Instance.creat("ExitPromptFrame.MissionBt");
         }
         if(!_fontBg)
         {
            _fontBg = ComponentFactory.Instance.creat(fontBgBgUrl);
         }
         _light = ComponentFactory.Instance.creatComponentByStylename("exit.ExitPromptFrame.light");
         addChild(_bt);
         addChild(_fontBg);
         addChild(_light);
         _light.visible = false;
         _fontBg.x = coordArr[0];
         _fontBg.y = coordArr[1];
         height = _bt.height;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(evt:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function __mouseOutHandler(evt:MouseEvent) : void
      {
         _light.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_bt);
         ObjectUtils.disposeObject(_fontBg);
         if(_light)
         {
            ObjectUtils.disposeObject(_light);
            _light = null;
         }
         _bt = null;
         _fontBg = null;
      }
   }
}
