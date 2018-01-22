package gameStick.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import gameStick.GameStickManager;
   
   public class GameStickShareFrame extends BaseAlerFrame
   {
       
      
      private var _bg:Bitmap;
      
      private var _inputLabel:FilterFrameText;
      
      private var _inputText:FilterFrameText;
      
      private var _alertLabel:FilterFrameText;
      
      public function GameStickShareFrame()
      {
         super();
         escEnable = true;
         addEventListener("response",responseHandler,false,0,true);
         _bg = ComponentFactory.Instance.creat("");
         addChild(_bg);
         _inputLabel = ComponentFactory.Instance.creat("");
         addChild(_inputLabel);
         _inputText = ComponentFactory.Instance.creat("");
         _alertLabel = ComponentFactory.Instance.creat("");
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               GameStickManager.getInstance().share();
         }
      }
   }
}
