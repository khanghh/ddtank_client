package carnivalActivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class CarnivalActivityGift extends Component
   {
       
      
      private var _bg:Bitmap;
      
      public function CarnivalActivityGift()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("carnicalAct.gift");
         addChild(_bg);
         _bg.width = 43;
         _bg.height = 43;
         width = _bg.width + 5;
         height = _bg.height + 5;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         super.dispose();
      }
   }
}
