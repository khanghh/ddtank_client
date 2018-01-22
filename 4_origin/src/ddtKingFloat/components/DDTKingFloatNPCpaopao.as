package ddtKingFloat.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.setTimeout;
   
   public class DDTKingFloatNPCpaopao extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _direction:int;
      
      public function DDTKingFloatNPCpaopao(param1:int = 0)
      {
         super();
         _direction = param1;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("ddtKing.paopaoTxt");
         switch(int(_direction))
         {
            case 0:
               this.x = 0;
               this.y = -180;
               _bg = ComponentFactory.Instance.creat("ddtKing.paopaoR");
               break;
            case 1:
               this.x = -380;
               this.y = -180;
               _bg = ComponentFactory.Instance.creat("ddtKing.paopaoL");
               PositionUtils.setPos(_txt,"ddtKing.paopaoPos");
         }
         addChild(_bg);
         addChild(_txt);
      }
      
      private function initEvents() : void
      {
      }
      
      public function setTxt(param1:String) : void
      {
         _txt.text = param1;
      }
      
      private function paopaoComplete() : void
      {
         dispatchEvent(new Event("complete"));
      }
      
      private function removeEvents() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
      }
   }
}
