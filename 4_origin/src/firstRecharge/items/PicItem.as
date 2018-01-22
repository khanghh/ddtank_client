package firstRecharge.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PicItem extends Sprite
   {
       
      
      private var _back:Bitmap;
      
      private var _btn:SimpleBitmapButton;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public var id:int;
      
      public function PicItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("fristRecharge.wupin.back");
         addChild(_back);
         _txt = ComponentFactory.Instance.creatComponentByStylename("firstrecharge.picTxt");
         addChild(_txt);
         _btn = ComponentFactory.Instance.creatComponentByStylename("accumulationView.btn");
         addChild(_btn);
         _btn.addEventListener("click",mouseClickHander);
      }
      
      public function setTxtStr(param1:String) : void
      {
         _txt.text = param1;
         _txt.x = _back.width / 2 - _txt.width / 2;
      }
      
      protected function mouseClickHander(param1:MouseEvent) : void
      {
      }
      
      public function addIcon(param1:String) : void
      {
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = ComponentFactory.Instance.creatBitmap(param1);
         _icon.x = _back.width / 2 - _icon.width / 2;
         _icon.y = _back.height / 2 - _icon.height / 2;
         addChild(_icon);
      }
      
      public function dispose() : void
      {
         _btn.removeEventListener("click",mouseClickHander);
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
            _back = null;
         }
         if(_btn)
         {
            ObjectUtils.disposeObject(_btn);
            _btn = null;
         }
      }
   }
}
