package drgnBoat.views
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
   
   public class DrgnBoatNPCpaopao extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _direction:int;
      
      public function DrgnBoatNPCpaopao(direction:int = 0)
      {
         super();
         _direction = direction;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("drgnBoat.paopaoTxt");
         switch(int(_direction))
         {
            case 0:
               this.x = 0;
               this.y = -180;
               _bg = ComponentFactory.Instance.creat("drgnBoat.paopaoR");
               break;
            case 1:
               this.x = -380;
               this.y = -180;
               _bg = ComponentFactory.Instance.creat("drgnBoat.paopaoL");
               PositionUtils.setPos(_txt,"drgnBoat.paopaoPos");
         }
         addChild(_bg);
         addChild(_txt);
      }
      
      private function initEvents() : void
      {
      }
      
      public function setTxt(str:String) : void
      {
         _txt.text = str;
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
